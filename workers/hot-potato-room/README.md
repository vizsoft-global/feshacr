# Hot Potato — Cloudflare Durable Object room

Authoritative realtime for Game Six (bots + humans).

## Deploy

```bash
cd workers/hot-potato-room
npm install
wrangler secret put HOT_POTATO_JWT_SECRET   # same value as Firebase functions config
wrangler deploy
```

Update `kHotPotatoEdgeWorkerBaseUrl` in `lib/u_i_game_six/game_six/hot_potato_edge_config.dart` with your `*.workers.dev` URL.

## Routes

- `GET /health` — liveness
- `GET /latency-probe?hint=apac` — RTT probe (all hints in `hot_potato_edge_routing.dart`)
- `WebSocket /room/{roomId}?token={jwt}` — game room

## JWT

Minted by Firebase Callable `getHotPotatoEdgeToken`. Payload: `roomId`, `uid`, `path`, `edgeLocationHint`, `exp`.

## Voice (LiveKit Cloud)

Arena voice chat uses callable `getLiveKitVoiceToken` (not this Worker). Configure Firebase Functions, for example:

`firebase functions:config:set livekit.url="wss://YOUR-PROJECT.livekit.cloud" livekit.api_key="APIxxxxx" livekit.api_secret="xxxxxxxx"`

Or set `LIVEKIT_URL`, `LIVEKIT_API_KEY`, `LIVEKIT_API_SECRET` in the functions environment.
