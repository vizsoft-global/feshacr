import { DurableObject } from "cloudflare:workers";
import {
  adaptiveClientDriftBound,
  adaptiveHumanTagTolerance,
  applyPass,
  botTuning,
  defaultRingPosition,
  integrateHuman,
  isGhostAt,
  isShielded,
  rewindToServerTime,
  tickBots,
  type BotDifficulty,
  type PositionSnapshot,
  type SimParticipant,
  type SimPickup,
} from "./bot-sim";

/** How long the per-participant position ring buffer keeps history (ms).
 *  Caps "shoot around corners" by limiting how far back we'll rewind. */
const REWIND_HISTORY_MS = 500;
/** Extra delay added on top of RTT/2 when rewinding for the client's
 *  interpolation render buffer (matches client `kHotPotatoEdgeBufferDelayMs`). */
const CLIENT_RENDER_BUFFER_MS = 110;
/** Per-client RTT clamps and EMA factor. */
const RTT_MIN_MS = 20;
const RTT_MAX_MS = 400;
const RTT_EMA_ALPHA = 0.25;
const DEFAULT_RTT_MS = 100;

export interface Env {
  HOT_POTATO_ROOM: DurableObjectNamespace<HotPotatoRoom>;
  HOT_POTATO_JWT_SECRET: string;
}

interface ClientInput {
  dirX: number;
  dirY: number;
  throttle: number;
}

interface WsClient {
  socket: WebSocket;
  path: string;
  input: ClientInput;
  /** Smoothed RTT in ms for this client, measured via `echoT` round-trips. */
  rttMs: number;
  /** Last server-time stamp this client echoed back (anti-replay sanity). */
  lastEchoT: number;
}

const VALID_POWER_KINDS = new Set(["Speed", "Shield", "Ghost", "Banana"]);

export class HotPotatoRoom extends DurableObject<Env> {
  private participants = new Map<string, SimParticipant>();
  private clients = new Map<WebSocket, WsClient>();
  private paths: string[] = [];
  private holderPath = "";
  private round = 1;
  private passImmuneUntil = new Map<string, number>();
  private lastTagAttemptByHolder = new Map<string, number>();
  private lastBotPowerUseMs = new Map<string, number>();
  private pickups: SimPickup[] = [];
  private inventory = new Map<string, Map<string, number>>();
  private simRunning = false;
  private paused = false;
  private lastBroadcast = 0;
  private botDifficulty: BotDifficulty = "easy";
  /** Per-participant position ring buffer (server time → x,y). Used to
   *  rewind targets to the moment the client *saw* the contact when
   *  validating tag/pass attempts under latency. */
  private positionHistory = new Map<string, PositionSnapshot[]>();

  constructor(ctx: DurableObjectState, env: Env) {
    super(ctx, env);
  }

  async fetch(request: Request): Promise<Response> {
    const upgrade = request.headers.get("Upgrade")?.toLowerCase();
    if (upgrade !== "websocket") {
      return new Response("Expected WebSocket", { status: 426 });
    }
    if (request.method !== "GET") {
      return new Response("Expected GET", { status: 405 });
    }

    const pair = new WebSocketPair();
    const [client, server] = Object.values(pair);
    // Web Standard API (server.accept) matches Cloudflare SQLite + WS examples.
    // Hibernation (ctx.acceptWebSocket) was failing the upgrade with 502 in production.
    server.accept();

    server.addEventListener("message", (event: MessageEvent) => {
      void this.handleSocketMessage(server, event.data as string | ArrayBuffer);
    });
    server.addEventListener("close", () => {
      this.clients.delete(server);
    });
    server.addEventListener("error", () => {
      this.clients.delete(server);
    });

    return new Response(null, { status: 101, webSocket: client });
  }

  private async handleSocketMessage(ws: WebSocket, message: string | ArrayBuffer): Promise<void> {
    let data: Record<string, unknown>;
    try {
      data = JSON.parse(typeof message === "string" ? message : new TextDecoder().decode(message));
    } catch {
      return;
    }
    try {
    const type = data.type as string;

    if (type === "hello") {
      const path = String(data.path ?? "");
      if (!path) return;
      this.clients.set(ws, {
        socket: ws,
        path,
        input: { dirX: 0, dirY: 0, throttle: 0.3 },
        rttMs: DEFAULT_RTT_MS,
        lastEchoT: 0,
      });
      ws.send(JSON.stringify({ type: "welcome", t: Date.now() }));
      if (this.paths.length > 0) {
        ws.send(JSON.stringify(this.buildStateMessage()));
      }
      return;
    }

    // Every inbound message can carry `echoT` — the last `serverT` the
    // client received in a `state` frame. We use it to keep a smoothed
    // RTT estimate per connection (#2). Anti-spoof: clamp to a sane range
    // and reject monotonic regressions to prevent replay-based RTT lying.
    const client = this.clients.get(ws);
    if (client) {
      const echoT = Number(data.echoT ?? 0);
      if (Number.isFinite(echoT) && echoT > client.lastEchoT) {
        const sampled = Math.max(RTT_MIN_MS,
            Math.min(RTT_MAX_MS, Date.now() - echoT));
        client.rttMs =
            client.rttMs * (1 - RTT_EMA_ALPHA) + sampled * RTT_EMA_ALPHA;
        client.lastEchoT = echoT;
      }
    }

    if (type === "configure") {
      const paths = data.participantPaths as string[] | undefined;
      const holder = String(data.holderPath ?? "");
      if (!paths?.length || !holder) return;
      const diff = String(data.botDifficulty ?? "easy");
      this.botDifficulty =
        diff === "medium" || diff === "hard" ? diff : "easy";
      this.applyRoomConfig(paths, holder, true);
      if (!this.simRunning) {
        this.simRunning = true;
        await this.ctx.storage.setAlarm(Date.now() + 50);
      }
      this.broadcastState();
      return;
    }

    if (type === "sync_room") {
      const paths = data.participantPaths as string[] | undefined;
      if (!paths?.length) return;
      const round = Number(data.round ?? this.round);
      this.round = Number.isFinite(round) ? round : this.round;
      const holderField = data.holderPath;
      if (holderField != null && String(holderField).length > 0) {
        this.holderPath = String(holderField);
      }
      if (typeof data.botDifficulty === "string") {
        const d = data.botDifficulty;
        this.botDifficulty = d === "medium" || d === "hard" ? d : "easy";
      }
      if (!this.holderPath || !paths.includes(this.holderPath)) {
        this.holderPath = paths[0] ?? this.holderPath;
      }
      this.applyRoomConfig(paths, this.holderPath, false);
      // First configure can race before the host has participant_paths; sync_room
      // must still boot the sim so bots and physics run.
      if (!this.simRunning) {
        this.simRunning = true;
        await this.ctx.storage.setAlarm(Date.now() + 50);
      }
      this.broadcastState();
      return;
    }

    if (type === "pickups_update") {
      const raw = data.pickups;
      if (!Array.isArray(raw)) return;
      this.pickups = raw
        .map((p): SimPickup | null => {
          if (!p || typeof p !== "object") return null;
          const m = p as Record<string, unknown>;
          const id = String(m.id ?? "");
          if (!id) return null;
          return {
            id,
            kind: String(m.kind ?? "Speed"),
            x: Number(m.x ?? 0.5),
            y: Number(m.y ?? 0.5),
            trap: m.trap === true || String(m.kind ?? "") === "BananaTrap",
            expiresAt: typeof m.expires_at_ms === "number" ? m.expires_at_ms : undefined,
            armedAt: typeof m.armed_at_ms === "number" ? m.armed_at_ms : undefined,
          };
        })
        .filter((p): p is SimPickup => p != null);
      return;
    }

    if (type === "sync_inventory") {
      const raw = data.inventory;
      if (!raw || typeof raw !== "object") return;
      this.inventory.clear();
      for (const [path, counts] of Object.entries(raw as Record<string, unknown>)) {
        if (!counts || typeof counts !== "object") continue;
        const inner = new Map<string, number>();
        for (const [kind, n] of Object.entries(counts as Record<string, unknown>)) {
          const v = Number(n ?? 0);
          if (v > 0) inner.set(kind, Math.floor(v));
        }
        if (inner.size > 0) this.inventory.set(path, inner);
      }
      return;
    }

    if (type === "input") {
      const client = this.clients.get(ws);
      if (!client) return;
      client.input = {
        dirX: Number(data.dirX ?? 0),
        dirY: Number(data.dirY ?? 0),
        throttle: Number(data.throttle ?? 0.3),
      };
      this.reconcileClientPosition(client.path, data, client.rttMs);
      return;
    }

    if (type === "tag") {
      const client = this.clients.get(ws);
      const fromPath = String(data.fromPath ?? "");
      const targetPath = String(data.targetPath ?? "");
      if (!client || fromPath !== client.path) return;
      const clientHint = this.readClientHint(data);
      const targetHint = this.readClientHint(data, "targetClientX", "targetClientY");
      await this.tryPass(fromPath, targetPath, clientHint, targetHint, client.rttMs);
      return;
    }

    if (type === "round_pause") {
      this.paused = data.paused === true;
      return;
    }

    if (type === "use_power" || type === "apply_power") {
      const client = this.clients.get(ws);
      const path = String(data.path ?? "");
      const kind = String(data.kind ?? "");
      if (!client || path !== client.path) return;
      this.usePower(path, kind);
      return;
    }

    if (type === "claim_pickup") {
      const client = this.clients.get(ws);
      const pickupId = String(data.pickupId ?? "");
      if (!client || !pickupId) return;
      if (client.path.startsWith("bot:")) return;
      const hint = this.readClientHint(data);
      this.claimPickupAtPath(client.path, pickupId, hint);
      return;
    }
    } catch (e) {
      console.error("HotPotatoRoom handleSocketMessage:", e);
    }
  }

  async alarm(): Promise<void> {
    if (!this.simRunning || this.paused || this.paths.length === 0) {
      await this.ctx.storage.setAlarm(Date.now() + 50);
      return;
    }

    const now = Date.now();
    const dt = 0.05;
    this.pickups = this.pickups.filter(
      (pu) => !(pu.trap || pu.kind === "BananaTrap") || !pu.expiresAt || now < pu.expiresAt,
    );

    for (const [path, p] of this.participants) {
      if (p.isBot) continue;
      let input: ClientInput = { dirX: 0, dirY: 0, throttle: 0.3 };
      for (const c of this.clients.values()) {
        if (c.path === path) {
          input = c.input;
          break;
        }
      }
      integrateHuman(p, input.dirX, input.dirY, input.throttle, dt, now);
      this.participants.set(path, p);
    }

    this.maybeBotsUseInventory(now);

    const botResult = tickBots(
      this.participants,
      this.paths,
      this.holderPath,
      this.passImmuneUntil,
      now,
      dt,
      this.pickups,
      this.botDifficulty,
    );

    if (botResult.tagFrom && botResult.tagTo) {
      await this.tryPass(botResult.tagFrom, botResult.tagTo);
    }

    this.maybeBotsClaimPickups();

    // #1 lag-comp: record a position snapshot for every participant on every
    // tick. Trim entries older than [REWIND_HISTORY_MS] so the buffer stays
    // tiny (~10 entries per participant).
    const cutoff = now - REWIND_HISTORY_MS;
    for (const [path, p] of this.participants) {
      let hist = this.positionHistory.get(path);
      if (!hist) {
        hist = [];
        this.positionHistory.set(path, hist);
      }
      hist.push({ t: now, x: p.x, y: p.y });
      while (hist.length > 0 && hist[0].t < cutoff) hist.shift();
    }
    // Drop history for participants who left the room entirely.
    for (const path of [...this.positionHistory.keys()]) {
      if (!this.participants.has(path)) this.positionHistory.delete(path);
    }

    if (now - this.lastBroadcast >= 40) {
      this.lastBroadcast = now;
      this.broadcastState();
    }

    await this.ctx.storage.setAlarm(Date.now() + 50);
  }

  private applyRoomConfig(paths: string[], holder: string, resetPositions: boolean): void {
    this.paths = [...paths];
    this.holderPath = holder;

    if (resetPositions) {
      this.participants.clear();
      this.passImmuneUntil.clear();
      this.positionHistory.clear();
      for (let i = 0; i < paths.length; i++) {
        const p = paths[i];
        const ring = defaultRingPosition(i, paths.length);
        this.participants.set(p, {
          path: p,
          x: ring.x,
          y: ring.y,
          vx: 0,
          vy: 0,
          isBot: p.startsWith("bot:"),
        });
      }
      return;
    }

    const keep = new Set(paths);
    for (const path of this.participants.keys()) {
      if (!keep.has(path)) this.participants.delete(path);
    }
    for (const path of this.passImmuneUntil.keys()) {
      if (!keep.has(path)) this.passImmuneUntil.delete(path);
    }

    for (let i = 0; i < paths.length; i++) {
      const p = paths[i];
      if (this.participants.has(p)) continue;
      const ring = defaultRingPosition(i, paths.length);
      this.participants.set(p, {
        path: p,
        x: ring.x,
        y: ring.y,
        vx: 0,
        vy: 0,
        isBot: p.startsWith("bot:"),
      });
    }
  }

  private inventoryCount(path: string, kind: string): number {
    return this.inventory.get(path)?.get(kind) ?? 0;
  }

  private incrementInventory(path: string, kindRaw: string): void {
    let kind = kindRaw === "Unseen" ? "Ghost" : kindRaw;
    if (!VALID_POWER_KINDS.has(kind)) kind = "Speed";
    let mine = this.inventory.get(path);
    if (!mine) {
      mine = new Map();
      this.inventory.set(path, mine);
    }
    mine.set(kind, (mine.get(kind) ?? 0) + 1);
  }

  /** Look up the smoothed RTT for whichever WS connection owns [path].
   *  Returns [DEFAULT_RTT_MS] if no live socket is found (e.g., bot path). */
  private rttForPath(path: string): number {
    for (const c of this.clients.values()) {
      if (c.path === path) return c.rttMs;
    }
    return DEFAULT_RTT_MS;
  }

  private readClientHint(
    data: Record<string, unknown>,
    xKey: string = "clientX",
    yKey: string = "clientY",
  ): { x: number; y: number } | null {
    const x = data[xKey];
    const y = data[yKey];
    if (typeof x !== "number" || typeof y !== "number") return null;
    if (!Number.isFinite(x) || !Number.isFinite(y)) return null;
    return { x, y };
  }

  /** Keep the server's human position close to the client's local prediction.
   *
   * Movement is still integrated authoritatively from joystick input, but due
   * to RTT + mobile frame timing + throttled input, the server can drift far
   * away from the local predicted position. That drift is exactly what caused
   * pass/pickup rejects like `server=0.286,client=n/a`.
   *
   * We accept a client position only within an RTT-scaled anti-cheat envelope,
   * then blend/snap toward it. This is not a teleport: the allowed correction
   * is bounded by how far a Speed-boosted player could plausibly have moved
   * during the connection's RTT plus a small frame-budget cushion.
   */
  private reconcileClientPosition(
    path: string,
    data: Record<string, unknown>,
    rttMs: number,
  ): void {
    if (path.startsWith("bot:")) return;
    const p = this.participants.get(path);
    if (!p) return;
    const hint = this.readClientHint(data);
    if (!hint) return;
    const cvx = Number(data.clientVx ?? p.vx);
    const cvy = Number(data.clientVy ?? p.vy);
    if (!Number.isFinite(cvx) || !Number.isFinite(cvy)) return;

    const drift = Math.hypot(hint.x - p.x, hint.y - p.y);
    const allowed = Math.max(
      0.12,
      adaptiveClientDriftBound(rttMs) + 0.04,
    );
    if (drift > allowed) {
      console.warn(
        `HotPotatoRoom ignored client position path=${path} drift=${drift.toFixed(3)}/${allowed.toFixed(3)}`,
      );
      return;
    }

    // Blend small normal corrections, snap medium corrections. The snap is
    // safe because we've already validated the correction is plausible.
    if (drift < 0.08) {
      p.x += (hint.x - p.x) * 0.35;
      p.y += (hint.y - p.y) * 0.35;
      p.vx += (cvx - p.vx) * 0.35;
      p.vy += (cvy - p.vy) * 0.35;
    } else {
      p.x = hint.x;
      p.y = hint.y;
      p.vx = cvx;
      p.vy = cvy;
    }
    this.participants.set(path, p);
  }

  /** Human (WS) or bot (sim): remove floor pickup + grant inventory if in range. */
  private claimPickupAtPath(
    path: string,
    pickupId: string,
    clientHint: { x: number; y: number } | null = null,
  ): void {
    if (!this.paths.includes(path)) {
      this.sendRejection(path, "pickup", pickupId, "unknown_path");
      return;
    }
    const participant = this.participants.get(path);
    if (!participant) {
      this.sendRejection(path, "pickup", pickupId, "no_participant");
      return;
    }
    const idx = this.pickups.findIndex((pu) => pu.id === pickupId);
    if (idx < 0) {
      this.sendRejection(path, "pickup", pickupId, "not_found");
      return;
    }
    const pu = this.pickups[idx];
    if ((pu.trap || pu.kind === "BananaTrap") && pu.armedAt && Date.now() < pu.armedAt) {
      this.sendRejection(path, "pickup", pickupId, "not_armed");
      return;
    }
    const dxServer = participant.x - pu.x;
    const dyServer = participant.y - pu.y;
    const dServer = Math.hypot(dxServer, dyServer);
    let dClient = Number.POSITIVE_INFINITY;
    if (clientHint) {
      const driftFromServer = Math.hypot(
        clientHint.x - participant.x,
        clientHint.y - participant.y,
      );
      // RTT-scaled drift bound (same logic as tag validation): legitimate
      // prediction-vs-snapshot drift grows with RTT, so the cap does too.
      const driftBound = adaptiveClientDriftBound(this.rttForPath(path));
      if (driftFromServer < driftBound) {
        dClient = Math.hypot(clientHint.x - pu.x, clientHint.y - pu.y);
      }
    }
    const d = Math.min(dServer, dClient);
    if (d > 0.075) {
      this.sendRejection(
        path,
        "pickup",
        pickupId,
        `too_far:server=${dServer.toFixed(3)},client=${
          Number.isFinite(dClient) ? dClient.toFixed(3) : "n/a"
        }`,
      );
      return;
    }
    this.pickups.splice(idx, 1);
    if (pu.trap || pu.kind === "BananaTrap") {
      participant.slowUntil = Date.now() + 5000;
      participant.slowMultiplier = 0.5;
      this.participants.set(path, participant);
    } else {
      this.incrementInventory(path, pu.kind);
    }
    const now = Date.now();
    this.broadcast(
      JSON.stringify({
        type: "pickup_claimed",
        path,
        pickupId,
        kind: pu.kind,
        t: now,
      }),
    );
    this.broadcastState();
  }

  private maybeBotsClaimPickups(): void {
    for (const path of this.paths) {
      const p = this.participants.get(path);
      if (!p) continue;
      for (const pu of [...this.pickups]) {
        if (Math.hypot(p.x - pu.x, p.y - pu.y) <= 0.06) {
          this.claimPickupAtPath(path, pu.id);
          break;
        }
      }
    }
  }

  private decrementInventory(path: string, kind: string): boolean {
    const mine = this.inventory.get(path);
    if (!mine) return false;
    const n = mine.get(kind) ?? 0;
    if (n < 1) return false;
    if (n === 1) mine.delete(kind);
    else mine.set(kind, n - 1);
    if (mine.size === 0) this.inventory.delete(path);
    return true;
  }

  private usePower(path: string, kind: string): boolean {
    if (!VALID_POWER_KINDS.has(kind)) {
      this.sendRejection(path, "power", kind, "invalid_kind");
      return false;
    }
    if (!this.paths.includes(path)) {
      this.sendRejection(path, "power", kind, "unknown_path");
      return false;
    }
    if (!this.decrementInventory(path, kind)) {
      this.sendRejection(path, "power", kind, "no_inventory");
      return false;
    }

    const p = this.participants.get(path);
    if (!p) return false;
    const now = Date.now();
    if (kind === "Speed") p.speedUntil = now + 5000;
    if (kind === "Shield") p.shieldUntil = now + 5000;
    if (kind === "Ghost") p.ghostUntil = now + 5000;
    if (kind === "Banana") {
      // Instant AoE slow: every other participant inside the radius gets 50%
      // speed for 5s. No floor trap, no pickup id race.
      const bananaRadius = 0.18;
      for (const [otherPath, other] of this.participants) {
        if (otherPath === path) continue;
        const dx = other.x - p.x;
        const dy = other.y - p.y;
        if (Math.hypot(dx, dy) <= bananaRadius) {
          other.slowUntil = now + 5000;
          other.slowMultiplier = 0.5;
          this.participants.set(otherPath, other);
        }
      }
    }
    this.participants.set(path, p);
    this.broadcast(
      JSON.stringify({
        type: "power_used",
        path,
        kind,
        t: now,
      }),
    );
    this.broadcastState();
    return true;
  }

  private maybeBotsUseInventory(now: number): void {
    const tuning = botTuning(this.botDifficulty);
    const rng = () => Math.random();
    for (const path of this.paths) {
      if (!path.startsWith("bot:")) continue;
      const prev = this.lastBotPowerUseMs.get(path) ?? 0;
      if (now - prev < tuning.powerupCooldownMs) continue;

      const options: string[] = [];
      for (const k of ["Shield", "Speed", "Ghost", "Banana"]) {
        if (this.inventoryCount(path, k) > 0) options.push(k);
      }
      if (options.length === 0) continue;

      const isHolder = path === this.holderPath;
      const roll = rng();
      const chance = isHolder
        ? tuning.powerupUseChance.holder
        : tuning.powerupUseChance.nonHolder;
      if (roll > chance) continue;

      this.lastBotPowerUseMs.set(path, now);
      const kind = options[Math.floor(rng() * options.length)];
      this.usePower(path, kind);
    }
  }

  private async tryPass(
    holderPath: string,
    targetPath: string,
    holderHint: { x: number; y: number } | null = null,
    targetHint: { x: number; y: number } | null = null,
    senderRttMs: number = DEFAULT_RTT_MS,
  ): Promise<void> {
    if (this.holderPath !== holderPath) {
      this.sendRejection(holderPath, "tag", targetPath, "not_holder");
      return;
    }
    const now = Date.now();
    const lastAttempt = this.lastTagAttemptByHolder.get(holderPath) ?? 0;
    if (now - lastAttempt < 120) {
      // rate-limited; silent on purpose
      return;
    }
    this.lastTagAttemptByHolder.set(holderPath, now);

    const immune = this.passImmuneUntil.get(targetPath);
    if (immune != null && now < immune) {
      this.sendRejection(holderPath, "tag", targetPath, "target_pass_immune");
      return;
    }
    const target = this.participants.get(targetPath);
    if (target && isShielded(target, now)) {
      this.sendRejection(holderPath, "tag", targetPath, "target_shielded");
      return;
    }
    if (target && isGhostAt(target, now)) {
      this.sendRejection(holderPath, "tag", targetPath, "target_ghost");
      return;
    }
    const holder = this.participants.get(holderPath);
    if (!holder) {
      this.sendRejection(holderPath, "tag", targetPath, "no_holder_state");
      return;
    }
    const tx = target?.x ?? 0.5;
    const ty = target?.y ?? 0.5;
    const isHumanInitiated = !holderPath.startsWith("bot:");
    const distServer = Math.hypot(holder.x - tx, holder.y - ty);

    // #1 Lag compensation: rewind the target to where it was on the
    // sender's screen at the moment they tapped. The sender's render time
    // is roughly serverNow - (rtt/2 + render_buffer). Capped by the
    // history buffer so we never rewind further than REWIND_HISTORY_MS.
    let distRewind = Number.POSITIVE_INFINITY;
    if (isHumanInitiated) {
      const rewindMs = Math.min(
        REWIND_HISTORY_MS,
        senderRttMs / 2 + CLIENT_RENDER_BUFFER_MS,
      );
      const targetT = now - rewindMs;
      const rewound = rewindToServerTime(
        this.positionHistory.get(targetPath),
        targetT,
        { x: tx, y: ty },
      );
      distRewind = Math.hypot(holder.x - rewound.x, holder.y - rewound.y);
    }

    // Client-confirmed contact. Anti-cheat drift bound scales with the
    // sender's RTT so a high-latency player's legitimate
    // prediction-vs-snapshot gap doesn't get thrown out as "spoof".
    const driftBound = adaptiveClientDriftBound(senderRttMs);
    let distClient = Number.POSITIVE_INFINITY;
    if (isHumanInitiated && holderHint) {
      const holderDrift = Math.hypot(
        holderHint.x - holder.x,
        holderHint.y - holder.y,
      );
      const targetDrift = targetHint
        ? Math.hypot(targetHint.x - tx, targetHint.y - ty)
        : 0;
      if (holderDrift < driftBound && targetDrift < driftBound) {
        const ttx = targetHint?.x ?? tx;
        const tty = targetHint?.y ?? ty;
        distClient = Math.hypot(holderHint.x - ttx, holderHint.y - tty);
      }
    }

    // Best-of: whichever of (server-now, server-rewound, client-confirmed)
    // is closest wins. All three are anti-cheat clamped above.
    const dist = Math.min(distServer, distRewind, distClient);

    // #3 Adaptive tolerance scales with the sender's measured RTT so a
    // 30ms player gets ~base and a 250ms player gets enough margin for
    // the target's motion in that RTT.
    const allowed = isHumanInitiated
      ? adaptiveHumanTagTolerance(senderRttMs)
      : 0.06;
    if (dist > allowed) {
      this.sendRejection(
        holderPath,
        "tag",
        targetPath,
        `too_far:server=${distServer.toFixed(3)},rewind=${
          Number.isFinite(distRewind) ? distRewind.toFixed(3) : "n/a"
        },client=${
          Number.isFinite(distClient) ? distClient.toFixed(3) : "n/a"
        }/${allowed.toFixed(3)} rtt=${Math.round(senderRttMs)}`,
      );
      return;
    }

    this.holderPath = applyPass(holderPath, targetPath, this.passImmuneUntil, now);
    this.broadcast(
      JSON.stringify({
        type: "pass_ok",
        holderPath: this.holderPath,
        fromPath: holderPath,
        toPath: targetPath,
        t: now,
      }),
    );
    this.broadcastState();
  }

  private buildStateMessage(): Record<string, unknown> {
    const positions: Record<string, unknown> = {};
    for (const [path, p] of this.participants) {
      positions[path] = {
        x: p.x,
        y: p.y,
        vx: p.vx,
        vy: p.vy,
        speed_until_ms: p.speedUntil ?? null,
        shield_until_ms: p.shieldUntil ?? null,
        ghost_until_ms: p.ghostUntil ?? null,
        slow_until_ms: p.slowUntil ?? null,
        slow_mult: p.slowMultiplier ?? 1,
      };
    }
    const immunity: Record<string, number> = {};
    const now = Date.now();
    for (const [k, v] of this.passImmuneUntil) {
      if (v > now) immunity[k] = v;
    }
    const invOut: Record<string, Record<string, number>> = {};
    for (const [path, counts] of this.inventory) {
      invOut[path] = Object.fromEntries(counts);
    }
    return {
      type: "state",
      // `t` and `serverT` are the same number — `serverT` is the explicit
      // name the client echoes back (`echoT`) so we can measure RTT (#2).
      t: now,
      serverT: now,
      holderPath: this.holderPath,
      round: this.round,
      positions,
      passImmuneUntilMs: immunity,
      pickups: this.pickups.map((pu) => ({
        id: pu.id,
        kind: pu.kind,
        x: pu.x,
        y: pu.y,
        ...(pu.trap ? { trap: true } : {}),
        ...(pu.expiresAt ? { expires_at_ms: pu.expiresAt } : {}),
        ...(pu.armedAt ? { armed_at_ms: pu.armedAt } : {}),
      })),
      inventory: invOut,
    };
  }

  private broadcastState(): void {
    this.broadcast(JSON.stringify(this.buildStateMessage()));
  }

  private broadcast(text: string): void {
    for (const c of this.clients.values()) {
      try {
        c.socket.send(text);
      } catch {
        // closed
      }
    }
  }

  /** Send a targeted rejection to the originating client so the UI can
   *  surface a one-line reason. Also logs to Workers observability for triage. */
  private sendRejection(
    path: string,
    action: "tag" | "pickup" | "power",
    target: string,
    reason: string,
  ): void {
    console.warn(
      `HotPotatoRoom reject ${action} path=${path} target=${target} reason=${reason}`,
    );
    const payload = JSON.stringify({
      type: `${action}_rejected`,
      path,
      target,
      reason,
      t: Date.now(),
    });
    for (const c of this.clients.values()) {
      if (c.path !== path) continue;
      try {
        c.socket.send(payload);
      } catch {
        // closed
      }
    }
  }
}
