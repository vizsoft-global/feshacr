import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/u_i_game_six/game_six/hot_potato_edge_config.dart';

const String _kPrefAutoHint = 'hp_auto_edge_hint_v1';
const String _kPrefAutoHintPickedAtMs = 'hp_auto_edge_hint_at_v1';

/// How long an auto-picked hint stays valid before we re-probe. 24h is long
/// enough that the same player on the same network keeps the same region
/// across many matches, and short enough that travel / ISP changes are picked
/// up the next day.
const Duration _kAutoHintTtl = Duration(hours: 24);

/// All Cloudflare Durable Object [locationHint] values (dynamic probe pool).
const List<HotPotatoEdgeHint> kHotPotatoEdgeHints = [
  HotPotatoEdgeHint(id: 'apac', label: 'Asia-Pacific'),
  HotPotatoEdgeHint(id: 'me', label: 'Middle East'),
  HotPotatoEdgeHint(id: 'weur', label: 'Western Europe'),
  HotPotatoEdgeHint(id: 'eeur', label: 'Eastern Europe'),
  HotPotatoEdgeHint(id: 'wnam', label: 'Western N. America'),
  HotPotatoEdgeHint(id: 'enam', label: 'Eastern N. America'),
  HotPotatoEdgeHint(id: 'oc', label: 'Oceania'),
  HotPotatoEdgeHint(id: 'sam', label: 'South America'),
  HotPotatoEdgeHint(id: 'afr', label: 'Africa'),
];

class HotPotatoEdgeHint {
  const HotPotatoEdgeHint({required this.id, required this.label});

  final String id;
  final String label;
}

/// Parallel RTT probe from the **host device** to every hint endpoint.
Future<Map<String, int>> probeHotPotatoEdgeLatencyMs() async {
  if (!hotPotatoEdgeAvailable()) return {};
  final base = hotPotatoEdgeWorkerHttpBase();
  final out = <String, int>{};

  final samples = await Future.wait(
    kHotPotatoEdgeHints.map((h) async {
      final ms = await _measureHintMs(base, h.id);
      return (h.id, ms);
    }),
  );

  for (final e in samples) {
    out[e.$1] = e.$2;
  }
  return out;
}

/// Lowest-latency hint for Auto mode. Result is cached in shared_preferences
/// for [_kAutoHintTtl] so two consecutive matches from the same network land
/// on the same region — small RTT fluctuations no longer flip the pick.
///
/// Pass [forceRefresh] = true (e.g. from the refresh button in the lobby
/// chip row) to bypass the cache and probe fresh.
Future<String> probeBestHotPotatoEdgeHint({bool forceRefresh = false}) async {
  if (!forceRefresh) {
    final cached = await _readCachedAutoHint();
    if (cached != null) return cached;
  }
  final lat = await probeHotPotatoEdgeLatencyMs();
  if (lat.isEmpty) {
    // Don't poison the cache with the fallback — keep trying next time.
    return 'apac';
  }

  HotPotatoEdgeHint? best;
  var bestMs = 1 << 30;
  for (final h in kHotPotatoEdgeHints) {
    final ms = lat[h.id];
    if (ms == null || ms >= (1 << 30)) continue;
    if (ms < bestMs) {
      bestMs = ms;
      best = h;
    }
  }

  if (kDebugMode && best != null) {
    debugPrint(
      'HotPotato edge pick: ${best.id} (${bestMs}ms) '
      'all=${lat.entries.map((e) => '${e.key}:${e.value}ms').join(', ')}',
    );
  }
  final picked = best?.id ?? 'apac';
  await _writeCachedAutoHint(picked);
  return picked;
}

Future<String?> _readCachedAutoHint() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_kPrefAutoHint);
    final at = prefs.getInt(_kPrefAutoHintPickedAtMs) ?? 0;
    if (id == null || id.isEmpty) return null;
    final age = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(at));
    if (age > _kAutoHintTtl) return null;
    // Defensive: only return if the cached id is still in our valid set.
    final valid = kHotPotatoEdgeHints.any((h) => h.id == id);
    return valid ? id : null;
  } catch (_) {
    return null;
  }
}

Future<void> _writeCachedAutoHint(String id) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPrefAutoHint, id);
    await prefs.setInt(
      _kPrefAutoHintPickedAtMs,
      DateTime.now().millisecondsSinceEpoch,
    );
  } catch (_) {}
}

/// Drop the cached auto pick so the next Auto start probes fresh. Wired to
/// the lobby's "refresh" button in [_SettingsCard.onRefreshLatencyProbe].
Future<void> clearCachedAutoEdgeHint() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kPrefAutoHint);
    await prefs.remove(_kPrefAutoHintPickedAtMs);
  } catch (_) {}
}

/// Top [n] hints by measured RTT (for manual lobby chips).
Future<List<HotPotatoEdgeHintRanked>> topHotPotatoEdgeHintsByLatency({
  int n = 3,
  Map<String, int>? precomputedLatency,
}) async {
  final lat = precomputedLatency ?? await probeHotPotatoEdgeLatencyMs();
  final ranked = <HotPotatoEdgeHintRanked>[];
  for (final h in kHotPotatoEdgeHints) {
    final ms = lat[h.id];
    if (ms == null || ms >= (1 << 30)) continue;
    ranked.add(HotPotatoEdgeHintRanked(hint: h, latencyMs: ms));
  }
  ranked.sort((a, b) => a.latencyMs.compareTo(b.latencyMs));
  if (ranked.length <= n) return ranked;
  return ranked.sublist(0, n);
}

class HotPotatoEdgeHintRanked {
  const HotPotatoEdgeHintRanked({
    required this.hint,
    required this.latencyMs,
  });

  final HotPotatoEdgeHint hint;
  final int latencyMs;

  /// Short 3-letter region code (EU1 / NA2 / AP1) shown on the lobby chip.
  String get shortLabel => hotPotatoEdgeShortLabel(hint.id);

  /// Single-line chip label kept for non-stacked uses (arena HUDs, debug
  /// rows). The lobby chips use [shortLabel] + ms on two lines instead.
  String get chipLabel => '$shortLabel · ${latencyMs}ms';
}

/// One HTTP RTT sample to [hotPotatoEdgeWorkerHttpBase]/latency-probe for [hintId]
/// (same endpoint as lobby probes). Used for in-arena ping so it matches settings.
Future<int> measureHotPotatoEdgeLatencyForHint(String hintId) async {
  if (!hotPotatoEdgeAvailable()) return 1 << 30;
  return _measureHintMs(hotPotatoEdgeWorkerHttpBase(), hintId);
}

Future<int> _measureHintMs(String base, String hint) async {
  var best = 1 << 30;
  final uri = Uri.parse('$base/latency-probe').replace(
    queryParameters: {'hint': hint, 't': '${DateTime.now().microsecondsSinceEpoch}'},
  );
  for (var i = 0; i < 2; i++) {
    final sw = Stopwatch()..start();
    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 8));
      sw.stop();
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final ms = sw.elapsedMilliseconds;
        if (ms < best) best = ms;
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('HotPotato edge probe failed ($hint): $e\n$st');
      }
    }
  }
  return best;
}

String hotPotatoEdgeHudLabel(String hintId) {
  return hotPotatoEdgeShortLabel(hintId);
}

/// Compact 3-character region code used in lobby chips and arena HUDs.
/// Convention: 2-letter region + 1-digit slot, e.g. `EU1`, `EU2`, `NA1`.
/// Keeps chip widths uniform so 4–5 fit on one row on phones.
String hotPotatoEdgeShortLabel(String hintId) {
  switch (hintId) {
    case 'weur':
      return 'EU1';
    case 'eeur':
      return 'EU2';
    case 'me':
      return 'ME1';
    case 'enam':
      return 'NA1';
    case 'wnam':
      return 'NA2';
    case 'apac':
      return 'AP1';
    case 'oc':
      return 'OC1';
    case 'afr':
      return 'AF1';
    case 'sam':
      return 'SA1';
    default:
      return hintId.toUpperCase();
  }
}
