/** Port of core HotPotatoBotAutoplay logic (Dart) for Durable Object sim. */

export type BotDifficulty = "easy" | "medium" | "hard";

export interface BotDifficultyTuning {
  /** Multiplier on chase/flee throttle (1.0 = current Easy baseline). */
  throttleMul: number;
  /** Per-frame chance the holder picks a fresh chase target (re-acquires). */
  focusRoll: number;
  /** How far ahead the holder "leads" prey velocity (in seconds). */
  leadSec: number;
  /** Probability rolling that bots use stocked powerups each tick. */
  powerupUseChance: { holder: number; nonHolder: number };
  /** Minimum ms between consecutive bot powerup uses. */
  powerupCooldownMs: number;
  /** Bot panic radius (smaller = bots only flee when very close). */
  dangerRadius: number;
}

export function botTuning(d: BotDifficulty): BotDifficultyTuning {
  switch (d) {
    case "medium":
      return {
        throttleMul: 1.15,
        focusRoll: 0.06,
        leadSec: 0.18,
        powerupUseChance: { holder: 0.70, nonHolder: 0.50 },
        powerupCooldownMs: 600,
        dangerRadius: 0.30,
      };
    case "hard":
      return {
        throttleMul: 1.32,
        focusRoll: 0.10,
        leadSec: 0.30,
        powerupUseChance: { holder: 0.88, nonHolder: 0.70 },
        powerupCooldownMs: 420,
        dangerRadius: 0.38,
      };
    case "easy":
    default:
      return {
        throttleMul: 1.0,
        focusRoll: 0.03,
        leadSec: 0.0,
        powerupUseChance: { holder: 0.52, nonHolder: 0.34 },
        powerupCooldownMs: 780,
        dangerRadius: 0.24,
      };
  }
}

/** Bot tag detection radius (server simulation only). Larger than the
 *  client's local gate because bots check distance against the *server*
 *  position of human targets, which lags the human's visible position by
 *  ~RTT/2 × maxSpeed (typically 0.05–0.08 normalized units on mobile).
 *  Without this margin, walking through a bot-holder simply never tags. */
export const PASS_CONTACT_DIST = 0.09;

/** Base human-tag tolerance before adaptive lag compensation. Real
 *  tolerance is computed per-client as `adaptiveHumanTagTolerance(rtt)`
 *  below: a low-RTT player gets near-base, a high-RTT player gets enough
 *  margin to account for one RTT of target motion. Kept exported for
 *  callers that still want the "easy" fixed constant. */
export const HUMAN_TAG_TOLERANCE_BASE = 0.06;
export const HUMAN_TAG_TOLERANCE_MAX = 0.18;
/** Deprecated alias — prefer [adaptiveHumanTagTolerance] for new code. */
export const HUMAN_TAG_TOLERANCE = HUMAN_TAG_TOLERANCE_BASE;

/** Returns the server-side acceptance window for a tag, scaled by the
 *  sender's measured one-way latency. `rttMs` should be clamped by the
 *  caller (we already clamp on ingest). Math:
 *   - assume target can travel at most `maxV` (with Speed powerup);
 *   - in `rtt/2` ms it can shift by `maxV * rtt/2/1000`;
 *   - tolerance = base + that shift, capped at MAX.
 */
export function adaptiveHumanTagTolerance(rttMs: number): number {
  const oneWaySec = Math.max(0, rttMs) / 2 / 1000;
  const margin = ARENA_MAX_V * ARENA_SPEED_POWER_MULT * oneWaySec;
  return Math.min(
    HUMAN_TAG_TOLERANCE_MAX,
    Math.max(HUMAN_TAG_TOLERANCE_BASE, HUMAN_TAG_TOLERANCE_BASE + margin),
  );
}

/** RTT-scaled anti-cheat bound used when validating client-confirmed
 *  positions (tag/pickup). At base 0.18 it absorbs the steady-state
 *  drift between client prediction and the server snapshot; at higher
 *  RTT the legitimate drift grows by `rtt × maxV`, so we let the bound
 *  grow with it (with a 1.5× safety multiplier). Anything above this
 *  is a teleport attempt and gets thrown out. */
export function adaptiveClientDriftBound(rttMs: number): number {
  const oneWaySec = Math.max(0, rttMs) / 1000;
  const legit = ARENA_MAX_V * ARENA_SPEED_POWER_MULT * oneWaySec;
  return Math.max(0.18, legit * 1.5);
}

/** Single recorded position frame for server-side lag compensation. */
export interface PositionSnapshot {
  t: number;
  x: number;
  y: number;
}

/** Walk a per-participant ring buffer of [PositionSnapshot]s and return the
 *  position at server time [targetT]. Linear-interpolates between the two
 *  bracketing snapshots when possible, falls back to nearest end if the
 *  target time is outside the buffered window.
 */
export function rewindToServerTime(
  history: PositionSnapshot[] | undefined,
  targetT: number,
  fallback: { x: number; y: number },
): { x: number; y: number } {
  if (!history || history.length === 0) return fallback;
  if (targetT >= history[history.length - 1].t) {
    const last = history[history.length - 1];
    return { x: last.x, y: last.y };
  }
  if (targetT <= history[0].t) {
    return { x: history[0].x, y: history[0].y };
  }
  for (let i = history.length - 1; i >= 0; i--) {
    if (history[i].t <= targetT) {
      const a = history[i];
      const b = history[i + 1];
      if (!b) return { x: a.x, y: a.y };
      const span = b.t - a.t;
      if (span <= 0) return { x: a.x, y: a.y };
      const f = Math.max(0, Math.min(1, (targetT - a.t) / span));
      return {
        x: a.x + (b.x - a.x) * f,
        y: a.y + (b.y - a.y) * f,
      };
    }
  }
  return { x: history[0].x, y: history[0].y };
}
export const PASS_IMMUNITY_MS = 3000;
export const TICK_SEC = 0.05;

/** Keep aligned with `lib/.../hot_potato_latency_config.dart` arena constants. */
export const ARENA_BASE_ACCEL = 2.4;
export const ARENA_FRICTION = 0.9;
export const ARENA_MAX_V = 0.42;
export const ARENA_GHOST_V_FACTOR = 0.82;
export const ARENA_SPEED_POWER_MULT = 1.5;
export const ARENA_DIR_DEADZONE = 0.02;

export interface SimParticipant {
  path: string;
  x: number;
  y: number;
  vx: number;
  vy: number;
  isBot: boolean;
  speedUntil?: number;
  shieldUntil?: number;
  ghostUntil?: number;
  slowUntil?: number;
  slowMultiplier?: number;
}

export function defaultRingPosition(index: number, total: number): { x: number; y: number } {
  if (total <= 0) return { x: 0.5, y: 0.5 };
  const angle = -Math.PI / 2 + (index * 2 * Math.PI) / total;
  return { x: 0.5 + 0.32 * Math.cos(angle), y: 0.5 + 0.28 * Math.sin(angle) };
}

function wallRepel(x: number, y: number): { dx: number; dy: number } {
  const edge = 0.16;
  let fx = 0;
  let fy = 0;
  if (x < edge) fx += (edge - x) / edge;
  if (x > 1 - edge) fx -= (x - (1 - edge)) / edge;
  if (y < edge) fy += (edge - y) / edge;
  if (y > 1 - edge) fy -= (y - (1 - edge)) / edge;
  return { dx: Math.max(-1, Math.min(1, fx)), dy: Math.max(-1, Math.min(1, fy)) };
}

function botAnchor(path: string): { x: number; y: number } {
  let h = 0;
  for (let i = 0; i < path.length; i++) h = (h * 31 + path.charCodeAt(i)) | 0;
  const angle = ((h % 360) * Math.PI) / 180;
  const r = 0.32;
  return { x: 0.5 + r * Math.cos(angle), y: 0.5 + r * Math.sin(angle) };
}

function speedMul(p: SimParticipant, now: number): number {
  let m = 1;
  if (p.speedUntil && now < p.speedUntil) m *= ARENA_SPEED_POWER_MULT;
  if (p.slowUntil && now < p.slowUntil) {
    m *= Math.max(0.05, Math.min(1, p.slowMultiplier ?? 0.25));
  }
  return m;
}

export function isShielded(p: SimParticipant, now: number): boolean {
  return !!(p.shieldUntil && now < p.shieldUntil);
}

export function isGhostAt(p: SimParticipant, now: number): boolean {
  return !!(p.ghostUntil && now < p.ghostUntil);
}

export function hasPassContact(ax: number, ay: number, bx: number, by: number): boolean {
  const dx = ax - bx;
  const dy = ay - by;
  return Math.sqrt(dx * dx + dy * dy) <= PASS_CONTACT_DIST;
}

/** Same physics for humans (WS input) and bots (AI direction + throttle). */
export function integrateHuman(
  p: SimParticipant,
  dirX: number,
  dirY: number,
  throttle: number,
  dt: number,
  now: number,
): void {
  const sm = speedMul(p, now);
  const mag = Math.sqrt(dirX * dirX + dirY * dirY);
  const inputMag = Math.min(1, mag);
  const ez = ARENA_DIR_DEADZONE;
  const ux = inputMag > ez ? dirX / Math.max(0.001, mag) : 0;
  const uy = inputMag > ez ? dirY / Math.max(0.001, mag) : 0;
  const accelScale = (0.3 + 0.7 * throttle) * inputMag;
  p.vx += ux * ARENA_BASE_ACCEL * dt * sm * accelScale;
  p.vy += uy * ARENA_BASE_ACCEL * dt * sm * accelScale;
  const f = Math.pow(ARENA_FRICTION, dt * 60);
  p.vx *= f;
  p.vy *= f;
  const maxBase = isGhostAt(p, now) ? ARENA_MAX_V * ARENA_GHOST_V_FACTOR : ARENA_MAX_V;
  p.vx = Math.max(-maxBase * sm, Math.min(maxBase * sm, p.vx));
  p.vy = Math.max(-maxBase * sm, Math.min(maxBase * sm, p.vy));
  p.x = Math.max(0.04, Math.min(0.96, p.x + p.vx * dt));
  p.y = Math.max(0.04, Math.min(0.96, p.y + p.vy * dt));
  const eps = 0.003;
  if (p.x <= 0.04 + eps && p.vx < 0) p.vx = 0;
  if (p.x >= 0.96 - eps && p.vx > 0) p.vx = 0;
  if (p.y <= 0.04 + eps && p.vy < 0) p.vy = 0;
  if (p.y >= 0.96 - eps && p.vy > 0) p.vy = 0;
}

function pickupSteerDelta(
  bx: number,
  by: number,
  pickups: SimPickup[],
  strength: number,
): { dx: number; dy: number } {
  if (pickups.length === 0) return { dx: 0, dy: 0 };
  let nearest: SimPickup | null = null;
  let best = Infinity;
  for (const pu of pickups) {
    const d = Math.hypot(pu.x - bx, pu.y - by);
    if (d < best) {
      best = d;
      nearest = pu;
    }
  }
  if (!nearest || best < 1e-8 || best > 0.44) return { dx: 0, dy: 0 };
  const t = 1 - best / 0.44;
  const w = 0.22 * strength * t * t;
  return {
    dx: ((nearest.x - bx) / best) * w,
    dy: ((nearest.y - by) / best) * w,
  };
}

const holderFocus = new Map<string, { until: number; target: string }>();
const holderChaos = new Map<string, { until: number; target: string }>();

export function tickBots(
  participants: Map<string, SimParticipant>,
  paths: string[],
  holderPath: string,
  passImmuneUntil: Map<string, number>,
  now: number,
  dt: number,
  pickups: SimPickup[] = [],
  difficulty: BotDifficulty = "easy",
): { tagFrom?: string; tagTo?: string } {
  const tuning = botTuning(difficulty);
  const holder = participants.get(holderPath);
  let hx = 0.5;
  let hy = 0.5;
  if (holder) {
    hx = holder.x;
    hy = holder.y;
  } else {
    const hi = paths.indexOf(holderPath);
    if (hi >= 0) {
      const ring = defaultRingPosition(hi, paths.length);
      hx = ring.x;
      hy = ring.y;
    }
  }

  let tagFrom: string | undefined;
  let tagTo: string | undefined;

  const pos = (o: string) => {
    const op = participants.get(o);
    let ox = 0.5;
    let oy = 0.5;
    if (op) {
      ox = op.x;
      oy = op.y;
    } else {
      const oi = paths.indexOf(o);
      const ring = defaultRingPosition(oi, paths.length);
      ox = ring.x;
      oy = ring.y;
    }
    return { ox, oy, op };
  };

  const immune = (o: string) => {
    const t = passImmuneUntil.get(o);
    return t != null && now < t;
  };

  const canTag = (o: string, op: SimParticipant | undefined) => {
    if (op && isShielded(op, now)) return false;
    if (op && isGhostAt(op, now)) return false;
    if (immune(o)) return false;
    return true;
  };

  for (const path of paths) {
    if (!path.startsWith("bot:")) continue;
    let p = participants.get(path);
    if (!p) {
      const i = paths.indexOf(path);
      const ring = defaultRingPosition(i, paths.length);
      p = {
        path,
        x: ring.x,
        y: ring.y,
        vx: 0,
        vy: 0,
        isBot: true,
      };
      participants.set(path, p);
    }

    const bx = p.x;
    const by = p.y;
    const rngSeed = path.length ^ (now >> 11);
    const rng = () => {
      const x = Math.sin(rngSeed * 9999) * 10000;
      return x - Math.floor(x);
    };

    if (path === holderPath) {
      let bxT: number | null = null;
      let byT: number | null = null;
      let preyPath: string | null = null;
      let bestD = Infinity;
      for (const o of paths) {
        if (o === path) continue;
        const { ox, oy, op } = pos(o);
        if (!canTag(o, op)) continue;
        const d = Math.hypot(bx - ox, by - oy);
        if (d < bestD) {
          bestD = d;
          bxT = ox;
          byT = oy;
          preyPath = o;
        }
      }

      const humans = paths.filter((q) => !q.startsWith("bot:") && q !== path);
      const hasBotPrey = preyPath != null && preyPath.startsWith("bot:");
      if (humans.length > 0 && hasBotPrey) {
        const focus = holderFocus.get(path);
        const focusAlive = focus != null && now < focus.until;
        // Higher difficulty re-acquires human prey more often instead of
        // committing to nearby bot targets.
        const shouldStartFocus = !focusAlive && rng() < tuning.focusRoll;
        if (shouldStartFocus) {
          holderFocus.set(path, {
            until: now + 620,
            target: humans[Math.floor(rng() * humans.length)],
          });
        }
      }
      const focus = holderFocus.get(path);
      if (
        focus != null &&
        now < focus.until &&
        humans.includes(focus.target)
      ) {
        const { ox, oy } = pos(focus.target);
        bxT = ox;
        byT = oy;
        preyPath = focus.target;
        bestD = Math.hypot(bx - ox, by - oy);
      }

      const chaos = holderChaos.get(path);
      const chaosAlive = chaos != null && now < chaos.until;
      if (!chaosAlive && paths.length > 2 && rng() < 0.05) {
        let choice: string | null = null;
        let farD = -1;
        for (const o of paths) {
          if (o === path) continue;
          const { ox, oy, op } = pos(o);
          if (!canTag(o, op)) continue;
          const d = Math.hypot(bx - ox, by - oy);
          if (d > farD) {
            farD = d;
            choice = o;
          }
        }
        if (choice != null) {
          holderChaos.set(path, { until: now + 650, target: choice });
        }
      }
      const chaosNow = holderChaos.get(path);
      if (
        chaosNow != null &&
        now < chaosNow.until &&
        chaosNow.target !== path &&
        canTag(chaosNow.target, participants.get(chaosNow.target))
      ) {
        const { ox, oy } = pos(chaosNow.target);
        bxT = ox;
        byT = oy;
        preyPath = chaosNow.target;
        bestD = Math.hypot(bx - ox, by - oy);
      }

      let sx = 0;
      let sy = 0;
      if (bxT != null && byT != null) {
        // Lead the prey: on harder difficulties the holder aims at where the
        // target will be `leadSec` from now, not where it is right now.
        let aimX = bxT;
        let aimY = byT;
        if (tuning.leadSec > 0 && preyPath != null) {
          const op = participants.get(preyPath);
          if (op) {
            aimX = bxT + op.vx * tuning.leadSec;
            aimY = byT + op.vy * tuning.leadSec;
          }
        }
        const dx = aimX - bx;
        const dy = aimY - by;
        const len = Math.max(0.001, Math.hypot(dx, dy));
        sx += dx / len;
        sy += dy / len;
      } else {
        const dx = 0.5 - bx;
        const dy = 0.5 - by;
        const len = Math.max(0.001, Math.hypot(dx, dy));
        sx += (dx / len) * 0.35;
        sy += (dy / len) * 0.35;
      }
      const wall = wallRepel(bx, by);
      sx += wall.dx * 0.42;
      sy += wall.dy * 0.42;
      sx += (0.5 - bx) * 0.12;
      sy += (0.5 - by) * 0.12;
      const pu = pickupSteerDelta(bx, by, pickups, 1);
      sx += pu.dx;
      sy += pu.dy;
      const sl = Math.hypot(sx, sy);
      const dirX = sl > 1e-6 ? sx / sl : 0;
      const dirY = sl > 1e-6 ? sy / sl : 0;
      const baseThrottle =
        bxT != null && byT != null
          ? 0.36 + 0.34 * Math.min(1, bestD / 0.48)
          : 0.32;
      const throttle = Math.min(1, baseThrottle * tuning.throttleMul);
      integrateHuman(p, dirX, dirY, throttle, dt, now);

      for (const o of paths) {
        if (o === path) continue;
        const { ox, oy, op } = pos(o);
        if (!canTag(o, op)) continue;
        if (hasPassContact(p.x, p.y, ox, oy)) {
          tagFrom = path;
          tagTo = o;
          break;
        }
      }
    } else {
      const fx = bx - hx;
      const fy = by - hy;
      const distH = Math.max(0.001, Math.hypot(fx, fy));
      // Bigger panic radius on harder difficulty: bots avoid the holder more
      // aggressively, requiring tighter human play to land a pass on them.
      const danger = Math.max(
        0,
        Math.min(1, (tuning.dangerRadius - distH) / tuning.dangerRadius),
      );
      const ux0 = fx / distH;
      const uy0 = fy / distH;
      const strafeSign = (path.charCodeAt(0) & 1) === 0 ? 1 : -1;
      const px = -uy0 * strafeSign;
      const py = ux0 * strafeSign;
      let sepX = 0;
      let sepY = 0;
      for (const o of paths) {
        if (o === path || o === holderPath) continue;
        const { ox, oy } = pos(o);
        const ddx = bx - ox;
        const ddy = by - oy;
        const d = Math.hypot(ddx, ddy);
        if (d < 0.001 || d > 0.2) continue;
        sepX += ddx / d;
        sepY += ddy / d;
      }
      const slSep = Math.hypot(sepX, sepY);
      if (slSep > 0.001) {
        sepX /= slSep;
        sepY /= slSep;
      }
      const anchor = botAnchor(path);
      const axIn = anchor.x - bx;
      const ayIn = anchor.y - by;
      const al = Math.max(0.001, Math.hypot(axIn, ayIn));
      const wall = wallRepel(bx, by);
      const flee = 0.24 + 0.18 * danger;
      const strafe = 0.055 + 0.065 * danger;
      let sx =
        ux0 * flee +
        px * strafe +
        sepX * 0.13 +
        (axIn / al) * (0.1 - 0.06 * danger) +
        wall.dx * 0.32 +
        (0.5 - bx) * 0.08;
      let sy =
        uy0 * flee +
        py * strafe +
        sepY * 0.13 +
        (ayIn / al) * (0.1 - 0.06 * danger) +
        wall.dy * 0.32 +
        (0.5 - by) * 0.08;
      const pu = pickupSteerDelta(bx, by, pickups, 0.85);
      sx += pu.dx;
      sy += pu.dy;
      const sl = Math.hypot(sx, sy);
      const dirX = sl > 1e-6 ? sx / sl : 0;
      const dirY = sl > 1e-6 ? sy / sl : 0;
      const baseThrottle = 0.34 + 0.34 * danger;
      const throttle = Math.min(1, baseThrottle * tuning.throttleMul);
      integrateHuman(p, dirX, dirY, throttle, dt, now);
    }

    participants.set(path, {
      ...p,
      path,
      x: Math.max(0, Math.min(1, p.x)),
      y: Math.max(0, Math.min(1, p.y)),
      vx: p.vx,
      vy: p.vy,
      isBot: true,
      speedUntil: p.speedUntil,
      shieldUntil: p.shieldUntil,
      ghostUntil: p.ghostUntil,
      slowUntil: p.slowUntil,
      slowMultiplier: p.slowMultiplier,
    });
  }

  return { tagFrom, tagTo };
}

export function applyPass(
  holderPath: string,
  targetPath: string,
  passImmuneUntil: Map<string, number>,
  now: number,
): string {
  passImmuneUntil.set(holderPath, now + PASS_IMMUNITY_MS);
  return targetPath;
}

export interface SimPickup {
  id: string;
  kind: string;
  x: number;
  y: number;
  trap?: boolean;
  expiresAt?: number;
  armedAt?: number;
}

/** @deprecated Prefer [pickupSteerDelta] inside bot tick; kept for API compatibility. */
export function applyPickupLure(
  bx: number,
  by: number,
  pickups: SimPickup[],
  add: (dvx: number, dvy: number) => void,
  strength = 1,
): void {
  const d = pickupSteerDelta(bx, by, pickups, strength);
  add(d.dx * 0.55, d.dy * 0.55);
}
