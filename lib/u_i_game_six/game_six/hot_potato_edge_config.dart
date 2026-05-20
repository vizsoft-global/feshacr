/// Cloudflare Durable Object edge realtime for Hot Potato.
library hot_potato_edge_config;

/// Master switch: when true and [kHotPotatoEdgeWorkerBaseUrl] is set, matches use DO
/// instead of RTDB for positions / pass / bot sim.
const bool kHotPotatoEdgeRealtimeEnabled = true;

/// Deploy `workers/hot-potato-room` and set this to your workers.dev or custom domain.
/// Example: https://hot-potato-room.<account>.workers.dev
const String kHotPotatoEdgeWorkerBaseUrl =
    'https://hot-potato-room.domain-772.workers.dev';

String hotPotatoEdgeWorkerHttpBase() {
  var u = kHotPotatoEdgeWorkerBaseUrl.trim();
  if (u.endsWith('/')) u = u.substring(0, u.length - 1);
  return u;
}

String hotPotatoEdgeWorkerWsBase() {
  final u = hotPotatoEdgeWorkerHttpBase();
  if (u.startsWith('https://')) return 'wss://${u.substring(8)}';
  if (u.startsWith('http://')) return 'ws://${u.substring(7)}';
  return 'wss://$u';
}

bool hotPotatoEdgeAvailable() =>
    kHotPotatoEdgeRealtimeEnabled && kHotPotatoEdgeWorkerBaseUrl.trim().isNotEmpty;
