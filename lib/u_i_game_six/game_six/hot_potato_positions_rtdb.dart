import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '/u_i_game_six/game_six/hot_potato_live.dart';
import '/u_i_game_six/game_six/hot_potato_rtdb_routing.dart';

/// Realtime Database position layer for Hot Potato.
///
/// The hot path of the game (per-frame normalized positions) used to be written to
/// Firestore inside `hot_potato_live.positions`. That field changes 10–40 times per
/// second per match, well above Firestore's ~1 sustained write/sec per-document soft
/// limit, which caused commit retries to pile up at scale. Realtime Database tolerates
/// these write rates natively, so we host **positions only** in RTDB and keep the rest
/// of the match state (holder, rounds, inventory, pickups, results) in Firestore.
///
/// Storage layout under the project's default RTDB instance:
///
///   hot_potato/{roomId}/positions/{encodedPath} = {
///     x: double, y: double, vx: double, vy: double,
///     speed_until_ms?: int (millisSinceEpoch),
///     shield_until_ms?: int (millisSinceEpoch),
///     t: ServerValue.timestamp,
///   }
///
/// [encodedPath] uses `Uri.encodeComponent` so user-ref paths like `users/abc` (with `/`
/// — disallowed in RTDB keys) and bot ids like `bot:42` round-trip safely.
///
/// **Setup required (one-time):**
/// 1. In the Firebase console for project `feshah-thbit`, enable **Realtime Database**
///    and pick a region.
/// 2. Deploy `firebase/database.rules.json` (allows authenticated users to read/write
///    `hot_potato/*`).
///
/// Until the database is provisioned, every call here fails silently — the arena
/// falls back to default ring positions and the rest of the game keeps working.
class HotPotatoRtdbPositions {
  HotPotatoRtdbPositions._();

  static FirebaseDatabase _dbFor(String databaseUrl) =>
      FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: hotPotatoEffectiveDatabaseUrl(databaseUrl),
      );

  /// RTDB-safe key for an arbitrary participant path (user ref path or `bot:id`).
  static String encodePath(String path) => Uri.encodeComponent(path);

  /// Inverse of [encodePath].
  static String decodePath(String key) {
    try {
      return Uri.decodeComponent(key);
    } catch (_) {
      return key;
    }
  }

  static DatabaseReference _positionsRef(String roomId, String databaseUrl) =>
      _dbFor(databaseUrl).ref('hot_potato/$roomId/positions');

  /// Pass authority (holder + per-path immunity expiry) lives in its own RTDB
  /// subtree so the per-position `.validate` rule doesn't reject it.
  static DatabaseReference _metaRef(String roomId, String databaseUrl) =>
      _dbFor(databaseUrl).ref('hot_potato/$roomId/pass_state');

  /// Live stream of `{ participantPath -> HotPotatoPositionData }` for the room.
  /// Emits an empty map if RTDB is unreachable so the arena can still render fallbacks.
  static Stream<Map<String, HotPotatoPositionData>> subscribe(
    String roomId,
    String databaseUrl,
  ) {
    try {
      return _positionsRef(roomId, databaseUrl).onValue.map((event) {
        final snap = event.snapshot;
        final val = snap.value;
        if (val is! Map) return <String, HotPotatoPositionData>{};
        final out = <String, HotPotatoPositionData>{};
        for (final e in val.entries) {
          final keyRaw = e.key;
          final key = keyRaw is String ? keyRaw : keyRaw?.toString();
          if (key == null || key.isEmpty) continue;
          final path = decodePath(key);
          final pos = _readPosition(e.value);
          if (pos != null) out[path] = pos;
        }
        return out;
      }).handleError((Object _) => <String, HotPotatoPositionData>{});
    } catch (_) {
      return Stream<Map<String, HotPotatoPositionData>>.value(const {});
    }
  }

  /// Holder + pass-immunity state kept in RTDB so pass actions never need Firestore.
  static Stream<RtdbPassState> subscribePassState(
    String roomId,
    String databaseUrl,
  ) {
    try {
      return _metaRef(roomId, databaseUrl).onValue.map((event) {
        final raw = event.snapshot.value;
        if (raw is! Map) return const RtdbPassState();
        return RtdbPassState.fromRaw(raw);
      }).handleError((Object _) => const RtdbPassState());
    } catch (_) {
      return Stream<RtdbPassState>.value(const RtdbPassState());
    }
  }

  static Future<RtdbPassState> readPassState(
    String roomId,
    String databaseUrl,
  ) async {
    try {
      final snap = await _metaRef(roomId, databaseUrl).get();
      final raw = snap.value;
      if (raw is! Map) return const RtdbPassState();
      return RtdbPassState.fromRaw(raw);
    } catch (_) {
      return const RtdbPassState();
    }
  }

  static Future<void> initializePassState({
    required String databaseUrl,
    required String roomId,
    required String holderPath,
  }) async {
    try {
      await _metaRef(roomId, databaseUrl).set({
        'holder_path': holderPath,
        'pass_immune_until_ms': <String, Object?>{},
        't': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[HotPotato] initializePassState error: $e\n$st');
      }
    }
  }

  static Future<void> setHolderPath({
    required String databaseUrl,
    required String roomId,
    required String holderPath,
  }) async {
    try {
      await _metaRef(roomId, databaseUrl).update({
        'holder_path': holderPath,
        't': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (_) {
      // No-op.
    }
  }

  /// Returns true if holder changed from [holderPath] to [targetPath].
  static Future<bool> attemptPass({
    required String databaseUrl,
    required String roomId,
    required String holderPath,
    required String targetPath,
  }) async {
    try {
      final now = DateTime.now();
      final res = await _metaRef(roomId, databaseUrl).runTransaction((raw) {
        final map =
            (raw is Map) ? Map<String, Object?>.from(raw) : <String, Object?>{};
        final curHolderRaw = map['holder_path']?.toString() ?? '';
        final curHolder = curHolderRaw.isEmpty ? holderPath : curHolderRaw;
        if (targetPath.isEmpty) {
          return Transaction.abort();
        }
        if (curHolder != holderPath) {
          return Transaction.abort();
        }
        map['holder_path'] = curHolder;

        // Immunity map keys are URL-encoded participant paths because RTDB
        // child keys may not contain `/` (used in `users/<id>` paths).
        final immunity = <String, Object?>{};
        final rawImm = map['pass_immune_until_ms'];
        if (rawImm is Map) {
          for (final e in rawImm.entries) {
            final k = e.key?.toString();
            if (k == null || k.isEmpty) continue;
            final exp = _readMillis(e.value);
            if (exp == null || !exp.isAfter(now)) continue;
            immunity[k] = exp.millisecondsSinceEpoch;
          }
        }
        final targetKey = encodePath(targetPath);
        final targetImm = _readMillis(immunity[targetKey]);
        if (targetImm != null && targetImm.isAfter(now)) {
          return Transaction.abort();
        }
        immunity[encodePath(holderPath)] = now
            .add(HotPotatoLiveState.passImmunityWindow)
            .millisecondsSinceEpoch;

        map['holder_path'] = targetPath;
        map['pass_immune_until_ms'] = immunity;
        map['t'] = now.millisecondsSinceEpoch;
        return Transaction.success(map);
      });
      return res.committed;
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[HotPotato] attemptPass error: $e\n$st');
      }
      return false;
    }
  }

  /// Write a single player's position. Idempotent / last-write-wins.
  static Future<void> writePosition({
    required String databaseUrl,
    required String roomId,
    required String path,
    required double x,
    required double y,
    required double vx,
    required double vy,
    DateTime? speedUntil,
    DateTime? shieldUntil,
    bool clearSpeed = false,
    bool clearShield = false,
  }) async {
    try {
      final payload = _buildPayload(
        x: x,
        y: y,
        vx: vx,
        vy: vy,
        speedUntil: speedUntil,
        shieldUntil: shieldUntil,
        clearSpeed: clearSpeed,
        clearShield: clearShield,
      );
      await _positionsRef(roomId, databaseUrl)
          .child(encodePath(path))
          .set(payload);
    } catch (_) {
      // RTDB not provisioned yet, or transient network error — caller renders fallback.
    }
  }

  /// Write multiple positions in a single RTDB call (used by the host's bot tick).
  static Future<void> batchWrite({
    required String databaseUrl,
    required String roomId,
    required Map<String, RtdbPositionWrite> positions,
  }) async {
    if (positions.isEmpty) return;
    try {
      final updates = <String, Object?>{};
      for (final e in positions.entries) {
        updates[encodePath(e.key)] = _buildPayload(
          x: e.value.x,
          y: e.value.y,
          vx: e.value.vx,
          vy: e.value.vy,
          speedUntil: e.value.speedUntil,
          shieldUntil: e.value.shieldUntil,
        );
      }
      await _positionsRef(roomId, databaseUrl).update(updates);
    } catch (_) {
      // Swallow so the bot tick stays cheap and silent.
    }
  }

  /// Clear all positions for the room (host call on match end / abandon).
  static Future<void> clearRoom(String roomId, String databaseUrl) async {
    try {
      await _dbFor(databaseUrl).ref('hot_potato/$roomId').remove();
    } catch (_) {
      // No-op; eventual GC via TTL or next match start.
    }
  }

  /// Remove a single participant (used when a player is eliminated mid-match).
  static Future<void> removeParticipant({
    required String databaseUrl,
    required String roomId,
    required String path,
  }) async {
    try {
      await _positionsRef(roomId, databaseUrl).child(encodePath(path)).remove();
    } catch (_) {
      // No-op.
    }
  }

  static Map<String, Object?> _buildPayload({
    required double x,
    required double y,
    required double vx,
    required double vy,
    DateTime? speedUntil,
    DateTime? shieldUntil,
    bool clearSpeed = false,
    bool clearShield = false,
  }) {
    final out = <String, Object?>{
      'x': x,
      'y': y,
      'vx': vx,
      'vy': vy,
      't': ServerValue.timestamp,
    };
    if (clearSpeed) {
      out['speed_until_ms'] = null;
    } else if (speedUntil != null) {
      out['speed_until_ms'] = speedUntil.millisecondsSinceEpoch;
    }
    if (clearShield) {
      out['shield_until_ms'] = null;
    } else if (shieldUntil != null) {
      out['shield_until_ms'] = shieldUntil.millisecondsSinceEpoch;
    }
    return out;
  }

  static HotPotatoPositionData? _readPosition(Object? raw) {
    if (raw is! Map) return null;
    final m = raw;
    final x = _readDouble(m['x'], 0.5);
    final y = _readDouble(m['y'], 0.5);
    final vx = _readDouble(m['vx'], 0);
    final vy = _readDouble(m['vy'], 0);
    final su = _readMillis(m['speed_until_ms']);
    final sh = _readMillis(m['shield_until_ms']);
    return HotPotatoPositionData(
      x: x,
      y: y,
      vx: vx,
      vy: vy,
      speedUntil: su,
      shieldUntil: sh,
    );
  }

  static double _readDouble(Object? v, double fb) {
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is num) return v.toDouble();
    return fb;
  }

  static DateTime? _readMillis(Object? v) {
    if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
    if (v is double) return DateTime.fromMillisecondsSinceEpoch(v.round());
    return null;
  }
}

/// One row of input for [HotPotatoRtdbPositions.batchWrite].
class RtdbPositionWrite {
  const RtdbPositionWrite({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    this.speedUntil,
    this.shieldUntil,
  });

  final double x;
  final double y;
  final double vx;
  final double vy;
  final DateTime? speedUntil;
  final DateTime? shieldUntil;
}

class RtdbPassState {
  const RtdbPassState({
    this.holderPath,
    this.passImmuneUntil = const {},
  });

  final String? holderPath;
  final Map<String, DateTime> passImmuneUntil;

  static RtdbPassState fromRaw(Map raw) {
    final holder = raw['holder_path']?.toString();
    final imm = <String, DateTime>{};
    final rawImm = raw['pass_immune_until_ms'];
    if (rawImm is Map) {
      for (final e in rawImm.entries) {
        final k = e.key?.toString();
        if (k == null || k.isEmpty) continue;
        final exp = HotPotatoRtdbPositions._readMillis(e.value);
        if (exp == null) continue;
        // Stored keys are URL-encoded participant paths (see [attemptPass]).
        imm[HotPotatoRtdbPositions.decodePath(k)] = exp;
      }
    }
    return RtdbPassState(
      holderPath: (holder != null && holder.isNotEmpty) ? holder : null,
      passImmuneUntil: imm,
    );
  }
}
