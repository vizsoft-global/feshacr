import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

/// Default Realtime Database URL (EU, matches `google-services` / web config).
const String kHotPotatoDefaultRtdbDatabaseUrl =
    'https://feshah-thbit-default-rtdb.europe-west1.firebasedatabase.app';

/// Configured Hot Potato RTDB instances (same Firebase project / Auth).
const List<HotPotatoRtdbInfo> kHotPotatoRtdbCandidates = [
  HotPotatoRtdbInfo(
    id: 'eu',
    displayName: 'EU (default)',
    databaseUrl: kHotPotatoDefaultRtdbDatabaseUrl,
  ),
  HotPotatoRtdbInfo(
    id: 'asia',
    displayName: 'Singapore',
    databaseUrl: 'https://feshah-thbit.asia-southeast1.firebasedatabase.app',
  ),
  HotPotatoRtdbInfo(
    id: 'us',
    displayName: 'US',
    databaseUrl: 'https://feshah-thbit-127db.firebaseio.com',
  ),
];

class HotPotatoRtdbInfo {
  const HotPotatoRtdbInfo({
    required this.id,
    required this.displayName,
    required this.databaseUrl,
  });

  final String id;
  final String displayName;
  final String databaseUrl;
}

/// Trims and strips a trailing `/` so Firestore-stored values compare consistently.
String normalizeHotPotatoDatabaseUrl(String url) {
  var u = url.trim();
  if (u.endsWith('/')) {
    u = u.substring(0, u.length - 1);
  }
  return u;
}

/// Resolves which RTDB URL to use for Hot Potato positions for this room.
String hotPotatoEffectiveDatabaseUrl(String? fromFirestoreOrLive) {
  if (fromFirestoreOrLive == null || fromFirestoreOrLive.trim().isEmpty) {
    return kHotPotatoDefaultRtdbDatabaseUrl;
  }
  return normalizeHotPotatoDatabaseUrl(fromFirestoreOrLive);
}

/// Short region tag for HUD next to ping (matches [kHotPotatoRtdbCandidates]).
String hotPotatoRtdbHudRegionLabel(String databaseUrl) {
  final n = normalizeHotPotatoDatabaseUrl(databaseUrl);
  for (final c in kHotPotatoRtdbCandidates) {
    if (normalizeHotPotatoDatabaseUrl(c.databaseUrl) == n) {
      switch (c.id) {
        case 'eu':
          return 'EU';
        case 'asia':
          return 'SG';
        case 'us':
          return 'US';
        default:
          return c.id.toUpperCase();
      }
    }
  }
  return '···';
}

/// Future: Middle East WebSocket relay URLs for positions (Gulf SLO). Not wired yet.
const List<String> kHotPotatoMenaRelayWssCandidates = <String>[];

/// Host-side probe: measure RTT to every [kHotPotatoRtdbCandidates] in **parallel**,
/// each with two quick reads; per-candidate score is the **better** of the two RTTs;
/// lowest score wins (stable tie-break: first in [kHotPotatoRtdbCandidates] on ties).
Future<String> probeBestHotPotatoRtdbUrl() async {
  Future<int> measureMs(String url) => _measureRtdbMs(url);

  final samples = await Future.wait(
    kHotPotatoRtdbCandidates.map((c) async {
      final ms = await measureMs(c.databaseUrl);
      return (c, ms);
    }),
  );

  HotPotatoRtdbInfo? best;
  var bestMs = 1 << 30;
  for (final (c, ms) in samples) {
    if (ms < bestMs) {
      bestMs = ms;
      best = c;
    }
  }

  if (kDebugMode && best != null) {
    debugPrint(
      'HotPotato RTDB pick: ${best.id} (${bestMs}ms) '
      'candidates=${samples.map((e) => '${e.$1.id}:${e.$2}ms').join(', ')}',
    );
  }

  return best?.databaseUrl ?? kHotPotatoDefaultRtdbDatabaseUrl;
}

/// Per-candidate RTT samples for lobby server chooser chips.
Future<Map<String, int>> probeHotPotatoRtdbLatencyMs() async {
  Future<int> measureMs(String url) => _measureRtdbMs(url);

  final out = <String, int>{};
  final samples = await Future.wait(
    kHotPotatoRtdbCandidates.map((c) async {
      final ms = await measureMs(c.databaseUrl);
      return (c.databaseUrl, ms);
    }),
  );
  for (final e in samples) {
    out[normalizeHotPotatoDatabaseUrl(e.$1)] = e.$2;
  }
  return out;
}

Future<int> _measureRtdbMs(String url) async {
  final db = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: url,
  );
  var best = 1 << 30;
  try {
    // Use a normal Hot Potato subtree instead of `.info/*` because web builds
    // can reject `.info/serverTimeOffset` with "Invalid token in path".
    final probeBase = db.ref('hot_potato/__latency_probe__');
    for (var i = 0; i < 2; i++) {
      final key = 'p_${DateTime.now().microsecondsSinceEpoch}_$i';
      final sw = Stopwatch()..start();
      await probeBase.child(key).get();
      sw.stop();
      final ms = sw.elapsedMilliseconds;
      if (ms < best) best = ms;
    }
    return best;
  } catch (e, st) {
    if (kDebugMode) {
      debugPrint('HotPotato RTDB probe failed ($url): $e\n$st');
    }
    return 1 << 30;
  }
}
