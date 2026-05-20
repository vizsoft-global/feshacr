import { HotPotatoRoom } from "./hot-potato-room";
import { resolveLocationHint, verifyHotPotatoJwt } from "./jwt";

export { HotPotatoRoom };

export interface Env {
  HOT_POTATO_ROOM: DurableObjectNamespace<HotPotatoRoom>;
  HOT_POTATO_JWT_SECRET: string;
}

/** Lets Flutter web / localhost probe RTT without browser CORS blocks. */
const CORS_JSON: HeadersInit = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, HEAD, OPTIONS",
  "Access-Control-Allow-Headers": "Authorization, Content-Type",
};

function mergeHeaders(base: HeadersInit, extra?: HeadersInit): Headers {
  const h = new Headers(base);
  if (extra) {
    new Headers(extra).forEach((v, k) => h.set(k, v));
  }
  return h;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);

    if (request.method === "OPTIONS") {
      return new Response(null, { status: 204, headers: CORS_JSON });
    }

    if (url.pathname === "/health") {
      const hasJwt = Boolean(
        env.HOT_POTATO_JWT_SECRET && env.HOT_POTATO_JWT_SECRET.trim().length > 0,
      );
      return Response.json(
        { ok: true, t: Date.now(), jwtSecretConfigured: hasJwt },
        { headers: CORS_JSON },
      );
    }

    if (url.pathname === "/latency-probe") {
      const hint = url.searchParams.get("hint") ?? "apac";
      return Response.json(
        {
          ok: true,
          hint,
          t: Date.now(),
          colo: request.cf?.colo ?? null,
        },
        { headers: CORS_JSON },
      );
    }

    if (url.pathname.startsWith("/room/")) {
      const roomId = url.pathname.split("/")[2];
      if (!roomId) {
        return new Response("Missing roomId", {
          status: 400,
          headers: mergeHeaders(CORS_JSON, {
            "Content-Type": "text/plain; charset=utf-8",
          }),
        });
      }

      const token =
        url.searchParams.get("token") ??
        request.headers.get("Authorization")?.replace(/^Bearer\s+/i, "") ??
        "";
      const secret = env.HOT_POTATO_JWT_SECRET;
      if (!secret || secret.trim().length === 0) {
        return new Response(
          "Worker misconfigured: set secret HOT_POTATO_JWT_SECRET (wrangler secret put HOT_POTATO_JWT_SECRET) to match Firebase hot_potato.jwt_secret.",
          {
            status: 503,
            headers: mergeHeaders(CORS_JSON, {
              "Content-Type": "text/plain; charset=utf-8",
            }),
          },
        );
      }

      let payload: Awaited<ReturnType<typeof verifyHotPotatoJwt>>;
      try {
        payload = await verifyHotPotatoJwt(token, secret);
      } catch {
        payload = null;
      }
      if (!payload || payload.roomId !== roomId) {
        return new Response("Unauthorized", {
          status: 401,
          headers: mergeHeaders(CORS_JSON, {
            "Content-Type": "text/plain; charset=utf-8",
          }),
        });
      }

      const hint = resolveLocationHint(payload.edgeLocationHint);
      const id = env.HOT_POTATO_ROOM.idFromName(roomId);
      const stub = env.HOT_POTATO_ROOM.get(id, { locationHint: hint });

      const upgrade = request.headers.get("Upgrade")?.toLowerCase();
      if (upgrade === "websocket") {
        if (request.method !== "GET") {
          return new Response("WebSocket upgrade requires GET", {
            status: 405,
            headers: mergeHeaders(CORS_JSON, {
              "Content-Type": "text/plain; charset=utf-8",
            }),
          });
        }
        try {
          return await stub.fetch(request);
        } catch (e) {
          const msg = e instanceof Error ? e.message : String(e);
          console.error("room websocket proxy failed", {
            roomId,
            hint,
            message: msg,
            stack: e instanceof Error ? e.stack : undefined,
          });
          return new Response(`Durable Object error: ${msg}`, {
            status: 502,
            headers: mergeHeaders(CORS_JSON, {
              "Content-Type": "text/plain; charset=utf-8",
            }),
          });
        }
      }
      return Response.json(
        { roomId, hint, path: payload.path },
        { headers: CORS_JSON },
      );
    }

    if (url.pathname === "/" || url.pathname === "") {
      return new Response("Hot Potato Room Worker", {
        status: 200,
        headers: mergeHeaders(CORS_JSON, {
          "Content-Type": "text/plain; charset=utf-8",
        }),
      });
    }

    return new Response("Not found", {
      status: 404,
      headers: mergeHeaders(CORS_JSON, {
        "Content-Type": "text/plain; charset=utf-8",
      }),
    });
  },
};
