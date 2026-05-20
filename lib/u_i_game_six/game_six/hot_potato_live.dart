import 'dart:async';
import 'dart:math';

import '/backend/backend.dart';
import '/u_i_game_six/game_six/hot_potato_latency_config.dart';
import '/u_i_game_six/game_six/hot_potato_positions_rtdb.dart';
import '/u_i_game_six/game_six/hot_potato_rtdb_routing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Master switch for the Hot Potato powerup system. Flip this back to `true`
/// once bot motion is buttery. While `false`:
///   * the inventory bar in the arena is hidden
///   * field pickups never spawn
///   * the settings screen hides the powerup chooser
///   * `_startGame` writes an empty powerups list to Firestore
///
/// We deliberately keep the parsing / transactions intact so any in-flight
/// matches (or older docs in the room collection) keep deserializing.
const bool kHotPotatoPowerupsEnabled = true;

DateTime? _readTs(Object? v) {
  if (v is Timestamp) return v.toDate();
  if (v is DateTime) return v;
  return null;
}

/// cloud_firestore 5.x has asymmetric APIs:
///   * `DocumentReference.update` accepts `Map<Object, Object?>` (string + [FieldPath] keys).
///   * `Transaction.update` only accepts `Map<String, dynamic>` and processes nested values
///     only — it does NOT support [FieldPath] keys.
///
/// The earlier `as Map<String, dynamic>` cast was a no-op for the analyzer but DDC failed
/// the runtime check (literal maps are `LinkedMap<Object, Object?>`), which broke every
/// write (bot positions, pickup spawn, round advance). Now we pass each map through to
/// the API shape it expects.
void _hpTxnUpdate(
    Transaction txn, DocumentReference roomRef, Map<String, dynamic> data) {
  txn.update(roomRef, data);
}

Future<void> _hpDocUpdate(
    DocumentReference roomRef, Map<Object, Object?> data) {
  return roomRef.update(data);
}

/// Normalized arena position + velocity and timed effects (Speed / Shield).
class HotPotatoPositionData {
  const HotPotatoPositionData({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    this.speedUntil,
    this.shieldUntil,
    this.ghostUntil,
    this.slowUntil,
    this.slowMultiplier = 1.0,
  });

  final double x;
  final double y;
  final double vx;
  final double vy;
  final DateTime? speedUntil;
  final DateTime? shieldUntil;
  final DateTime? ghostUntil;
  final DateTime? slowUntil;
  final double slowMultiplier;

  bool isShieldedAt(DateTime now) {
    final s = shieldUntil;
    return s != null && now.isBefore(s);
  }

  bool isGhostAt(DateTime now) {
    final g = ghostUntil;
    return g != null && now.isBefore(g);
  }

  double speedMultiplierAt(DateTime now) {
    var mult = 1.0;
    final u = speedUntil;
    if (u != null && now.isBefore(u)) {
      mult *= kHotPotatoArenaSpeedPowerMult;
    }
    final su = slowUntil;
    if (su != null && now.isBefore(su)) {
      mult *= slowMultiplier.clamp(0.05, 1.0);
    }
    return mult;
  }

  static HotPotatoPositionData? fromMap(Object? raw) {
    if (raw is! Map) return null;
    final m = Map<String, dynamic>.from(raw);
    return HotPotatoPositionData(
      x: _readDouble(m['x'], 0.5),
      y: _readDouble(m['y'], 0.5),
      vx: _readDouble(m['vx'], 0),
      vy: _readDouble(m['vy'], 0),
      speedUntil: _readTs(m['speed_until']),
      shieldUntil: _readTs(m['shield_until']),
      ghostUntil: _readTs(m['ghost_until']),
      slowUntil: _readTs(m['slow_until']),
      slowMultiplier: _readDouble(m['slow_mult'], 1.0).clamp(0.05, 1.0),
    );
  }

  static Map<String, dynamic> buildFirestoreWrite({
    required double x,
    required double y,
    required double vx,
    required double vy,
    DateTime? speedUntil,
    DateTime? shieldUntil,
    DateTime? ghostUntil,
    DateTime? slowUntil,
    double? slowMultiplier,
    bool clearSpeed = false,
    bool clearShield = false,
    bool clearGhost = false,
    bool clearSlow = false,
    DateTime? now,
  }) {
    final t = now ?? DateTime.now();
    final out = <String, dynamic>{
      'x': x,
      'y': y,
      'vx': vx,
      'vy': vy,
      't': FieldValue.serverTimestamp(),
    };
    if (clearSpeed) {
      out['speed_until'] = FieldValue.delete();
    } else if (speedUntil != null && t.isBefore(speedUntil)) {
      out['speed_until'] = Timestamp.fromDate(speedUntil);
    }
    if (clearShield) {
      out['shield_until'] = FieldValue.delete();
    } else if (shieldUntil != null && t.isBefore(shieldUntil)) {
      out['shield_until'] = Timestamp.fromDate(shieldUntil);
    }
    if (clearGhost) {
      out['ghost_until'] = FieldValue.delete();
    } else if (ghostUntil != null && t.isBefore(ghostUntil)) {
      out['ghost_until'] = Timestamp.fromDate(ghostUntil);
    }
    if (clearSlow) {
      out['slow_until'] = FieldValue.delete();
      out['slow_mult'] = FieldValue.delete();
    } else if (slowUntil != null && t.isBefore(slowUntil)) {
      out['slow_until'] = Timestamp.fromDate(slowUntil);
      out['slow_mult'] = (slowMultiplier ?? 0.25).clamp(0.05, 1.0);
    }
    return out;
  }

  static double _readDouble(Object? v, double fallback) {
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return fallback;
  }
}

/// Floor pickup (normalized x,y). [claimedBy] non-null when taken.
class HotPotatoPickupItem {
  const HotPotatoPickupItem({
    required this.id,
    required this.kind,
    required this.x,
    required this.y,
    this.claimedBy,
    this.spawnedAt,
    this.trap = false,
    this.expiresAt,
    this.armedAt,
  });

  final String id;
  final String kind;
  final double x;
  final double y;
  final String? claimedBy;
  final DateTime? spawnedAt;
  final bool trap;
  final DateTime? expiresAt;
  final DateTime? armedAt;

  bool get isAvailable => claimedBy == null || claimedBy!.isEmpty;
  bool get isBananaTrap => trap || kind == 'BananaTrap';

  static HotPotatoPickupItem? fromMap(Object? raw) {
    if (raw is! Map) return null;
    final m = Map<String, dynamic>.from(raw);
    final id = m['id']?.toString() ?? '';
    if (id.isEmpty) return null;
    return HotPotatoPickupItem(
      id: id,
      kind: m['kind']?.toString() ?? 'Speed',
      x: _readD(m['x'], 0.5),
      y: _readD(m['y'], 0.5),
      claimedBy: m['claimed_by'] is String ? m['claimed_by'] as String : null,
      spawnedAt: _readTs(m['spawned_at']),
      trap: m['trap'] == true || m['kind'] == 'BananaTrap',
      expiresAt: _readTs(m['expires_at']),
      armedAt: _readTs(m['armed_at']),
    );
  }

  static double _readD(Object? v, double d) {
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return d;
  }

  Map<String, dynamic> toFirestoreSpawn() => {
        'id': id,
        'kind': kind,
        'x': x,
        'y': y,
        if (trap) 'trap': true,
        if (expiresAt != null) 'expires_at': Timestamp.fromDate(expiresAt!),
        if (armedAt != null) 'armed_at': Timestamp.fromDate(armedAt!),
        // Firestore forbids FieldValue.serverTimestamp() inside an array
        // element. Web SDK surfaces this as the cryptic
        // "Attempting to box non-Dart object". Use a client Timestamp; the
        // pickup TTL (~40s) makes the client/server clock drift irrelevant.
        'spawned_at': Timestamp.now(),
      };
}

/// Round-end: the [holderPath] when the buzzer fires is eliminated. Play continues
/// until one survivor wins, or [totalRounds] of expiries have passed (first remaining
/// path wins). Results are stored on `hot_potato_live`: `winner_path`, `results_rank`,
/// `elimination_order`.
class HotPotatoLiveState {
  const HotPotatoLiveState({
    required this.round,
    required this.totalRounds,
    required this.roundDurationSec,
    required this.roundStartedAt,
    required this.participantPaths,
    required this.holderIndex,
    required this.matchComplete,
    this.lastPowerup,
    this.lastPowerupAt,
    this.lastPowerupActor,
    this.lastPowerupX,
    this.lastPowerupY,
    this.walletCharged = false,
    this.eliminationOrder = const [],
    this.winnerPath,
    this.resultsRank = const [],
    this.positions = const {},
    this.pickups = const [],
    this.inventory = const {},
    this.passImmuneUntil = const {},
    this.rtdbDatabaseUrl,
    this.ghostPaths = const [],
  });

  /// Window in which a player who just passed the bomb cannot be re-targeted
  /// by another pass. Stops "tag back" loops so the passer has real time to
  /// move away — set to 3s based on playtesting (1.2s was too short and let
  /// two players ping-pong the bomb forever).
  static const Duration passImmunityWindow = Duration(milliseconds: 3000);
  // Tuned for quicker pacing between rounds.
  static const int roundStartCountdownSec = 3;
  static const int roundEliminationBannerSec = 1;
  // Equal-sized token overlap gate for pass contact checks.
  // Tightened back from 0.068 → 0.052 so a pass only fires when the two
  // tokens are visually overlapping (each token has ~0.03 normalized radius,
  // so 0.052 ≈ small overlap rather than "near miss").
  static const double passContactDistanceNorm = 0.052;

  static bool hasPassContact({
    required double ax,
    required double ay,
    required double bx,
    required double by,
  }) {
    final dx = ax - bx;
    final dy = ay - by;
    return sqrt(dx * dx + dy * dy) <= passContactDistanceNorm;
  }

  final int round;
  final int totalRounds;
  final int roundDurationSec;
  final DateTime? roundStartedAt;
  final List<String> participantPaths;
  final int holderIndex;
  final bool matchComplete;
  final String? lastPowerup;
  final DateTime? lastPowerupAt;
  final String? lastPowerupActor;
  final double? lastPowerupX;
  final double? lastPowerupY;
  final bool walletCharged;
  final List<String> eliminationOrder;
  final String? winnerPath;
  final List<String> resultsRank;
  final Map<String, HotPotatoPositionData> positions;
  final List<HotPotatoPickupItem> pickups;

  /// Participant path -> power-up id -> count in inventory.
  final Map<String, Map<String, int>> inventory;

  /// Participant path -> timestamp until which they cannot become the holder
  /// via a pass (briefly granted to whoever just passed it).
  final Map<String, DateTime> passImmuneUntil;

  /// Realtime Database URL used for `hot_potato/{roomId}/positions` for this match.
  final String? rtdbDatabaseUrl;

  /// Eliminated holders (round buzzer) still rendered as spectators; can move in RTDB.
  final List<String> ghostPaths;

  /// True iff [path] currently can't receive the bomb because they just
  /// passed it.
  bool isPassImmune(String path, DateTime now) {
    final t = passImmuneUntil[path];
    return t != null && now.isBefore(t);
  }

  String get holderPath {
    if (participantPaths.isEmpty) return '';
    final i = holderIndex.clamp(0, participantPaths.length - 1);
    return participantPaths[i];
  }

  bool get isHolderBot => holderPath.startsWith('bot:');

  int get roundPreludeSec {
    final hasElimBanner = round > 1 && eliminationOrder.isNotEmpty;
    return roundStartCountdownSec +
        (hasElimBanner ? roundEliminationBannerSec : 0);
  }

  DateTime? get preludeUnlockAt {
    final s = roundStartedAt;
    if (s == null) return null;
    return s.add(Duration(seconds: roundPreludeSec));
  }

  DateTime? get effectiveRoundEnd {
    if (roundStartedAt == null) return null;
    return roundStartedAt!.add(
      Duration(seconds: roundDurationSec.clamp(1, 3600) + roundPreludeSec),
    );
  }

  bool isCurrentUserHolder(DocumentReference? userRef) {
    if (userRef == null) return false;
    return holderPath == userRef.path;
  }

  int indexOfParticipant(String path) => participantPaths.indexOf(path);

  int inventoryCount(String path, String kind) {
    final m = inventory[path];
    if (m == null) return 0;
    return m[kind] ?? 0;
  }

  HotPotatoPositionData? positionFor(String path) => positions[path];

  static Map<String, HotPotatoPositionData> _parsePositions(Object? raw) {
    final out = <String, HotPotatoPositionData>{};
    if (raw is Map) {
      for (final e in raw.entries) {
        final k = e.key?.toString();
        if (k == null || k.isEmpty) continue;
        final p = HotPotatoPositionData.fromMap(e.value);
        if (p != null) out[k] = p;
      }
    }
    return out;
  }

  static List<HotPotatoPickupItem> _parsePickups(Object? raw) {
    final out = <HotPotatoPickupItem>[];
    if (raw is List) {
      for (final e in raw) {
        final p = HotPotatoPickupItem.fromMap(e);
        if (p != null) out.add(p);
      }
    }
    return out;
  }

  static Map<String, DateTime> _parsePassImmunity(Object? raw) {
    final out = <String, DateTime>{};
    if (raw is Map) {
      for (final e in raw.entries) {
        final k = e.key?.toString();
        if (k == null || k.isEmpty) continue;
        final t = _readTs(e.value);
        if (t != null) out[k] = t;
      }
    }
    return out;
  }

  static Map<String, Map<String, int>> _parseInventory(Object? raw) {
    final out = <String, Map<String, int>>{};
    if (raw is Map) {
      for (final e in raw.entries) {
        final path = e.key?.toString();
        if (path == null || path.isEmpty) continue;
        final inner = e.value;
        if (inner is! Map) continue;
        final counts = <String, int>{};
        for (final ie in inner.entries) {
          var kind = ie.key?.toString();
          if (kind == null || kind.isEmpty) continue;
          if (kind == 'Unseen') kind = 'Ghost';
          counts[kind] = (counts[kind] ?? 0) +
              _readInt(ie.value, fallback: 0).clamp(0, 999);
        }
        if (counts.isNotEmpty) out[path] = counts;
      }
    }
    return out;
  }

  static HotPotatoLiveState? fromRoomSnapshotData(
      Map<String, dynamic> snapshotData) {
    final raw = snapshotData['hot_potato_live'];
    if (raw is! Map) return null;
    final map = Map<String, dynamic>.from(raw);

    final pathsRaw = map['participant_paths'];
    final paths = <String>[];
    if (pathsRaw is List) {
      for (final e in pathsRaw) {
        if (e is String && e.isNotEmpty) paths.add(e);
      }
    }

    final eliminationOrder = _parseStringList(map['elimination_order']);
    final resultsRank = _parseStringList(map['results_rank']);
    final winnerPath =
        map['winner_path'] is String ? map['winner_path'] as String : null;
    final rtdbUrl = _readRtdbDatabaseUrl(map);
    final ghostPaths = _parseStringList(map['ghost_paths']);

    if (paths.isEmpty) {
      if (map['match_complete'] == true &&
          (winnerPath != null || resultsRank.isNotEmpty)) {
        return HotPotatoLiveState(
          round: _readInt(map['round'], fallback: 1),
          totalRounds: _readInt(map['total_rounds'], fallback: 3),
          roundDurationSec: _readInt(map['round_duration_sec'], fallback: 120),
          roundStartedAt: _readTs(map['round_started_at']),
          participantPaths: const [],
          holderIndex: 0,
          matchComplete: true,
          lastPowerup: map['last_powerup'] as String?,
          lastPowerupAt: _readTs(map['last_powerup_at']),
          lastPowerupActor: map['last_powerup_actor'] as String?,
          lastPowerupX: (map['last_powerup_x'] is num)
              ? (map['last_powerup_x'] as num).toDouble()
              : null,
          lastPowerupY: (map['last_powerup_y'] is num)
              ? (map['last_powerup_y'] as num).toDouble()
              : null,
          walletCharged: map['wallet_charged'] == true,
          eliminationOrder: eliminationOrder,
          winnerPath: winnerPath,
          resultsRank: resultsRank,
          positions: const {},
          pickups: const [],
          inventory: const {},
          rtdbDatabaseUrl: rtdbUrl,
          ghostPaths: ghostPaths,
        );
      }
      return null;
    }

    final hiRaw = _readInt(map['holder_index'], fallback: 0);
    final hi = hiRaw.clamp(0, paths.length - 1);

    return HotPotatoLiveState(
      round: _readInt(map['round'], fallback: 1),
      totalRounds: _readInt(map['total_rounds'], fallback: 3),
      roundDurationSec: _readInt(map['round_duration_sec'], fallback: 120),
      roundStartedAt: _readTs(map['round_started_at']),
      participantPaths: paths,
      holderIndex: hi,
      matchComplete: map['match_complete'] == true,
      lastPowerup: map['last_powerup'] as String?,
      lastPowerupAt: _readTs(map['last_powerup_at']),
      lastPowerupActor: map['last_powerup_actor'] as String?,
      lastPowerupX: (map['last_powerup_x'] is num)
          ? (map['last_powerup_x'] as num).toDouble()
          : null,
      lastPowerupY: (map['last_powerup_y'] is num)
          ? (map['last_powerup_y'] as num).toDouble()
          : null,
      walletCharged: map['wallet_charged'] == true,
      eliminationOrder: eliminationOrder,
      winnerPath: winnerPath,
      resultsRank: resultsRank,
      positions: _parsePositions(map['positions']),
      pickups: _parsePickups(map['pickups']),
      inventory: _parseInventory(map['inventory']),
      passImmuneUntil: _parsePassImmunity(map['pass_immune_until']),
      rtdbDatabaseUrl: rtdbUrl,
      ghostPaths: ghostPaths,
    );
  }

  static String? _readRtdbDatabaseUrl(Map<String, dynamic> map) {
    final v = map['rtdb_database_url'];
    if (v is String && v.trim().isNotEmpty) return v.trim();
    return null;
  }

  static List<String> _parseStringList(Object? raw) {
    final out = <String>[];
    if (raw is List) {
      for (final e in raw) {
        if (e is String && e.isNotEmpty) out.add(e);
      }
    }
    return out;
  }

  static int _readInt(Object? v, {required int fallback}) {
    if (v is int) return v;
    if (v is double) return v.round();
    return fallback;
  }
}

class HotPotatoLiveFirestore {
  HotPotatoLiveFirestore._();

  static final Random _rng = Random();

  /// Per-room transaction queue.
  ///
  /// On Firestore Web, every `runTransaction` reads the doc, then commits with
  /// `currentDocument.updateTime` set to that read's timestamp. If two
  /// transactions on the same client (e.g. pickup-spawner + player-tag) read at
  /// the same instant and try to commit, exactly one wins and the rest fail
  /// with `failed-precondition`. The SDK retries each up to 5 times, which on
  /// a single iPhone-sized DevTools window can produce 30-50 red 400 entries
  /// per second and eventually freeze the browser tab.
  ///
  /// Serializing all `room/{id}` transactions on this client eliminates the
  /// intra-client race entirely. Real cross-client races (host vs. another
  /// player) still exist, but they are rare and the SDK's retry handles them
  /// without storm-level volume.
  static final Map<String, Future<void>> _txnQueues = {};

  static Future<T> _serialized<T>(
    DocumentReference roomRef,
    Future<T> Function() task,
  ) {
    final key = roomRef.path;
    final prev = _txnQueues[key] ?? Future<void>.value();
    final next = prev
        // ignore: avoid_types_on_closure_parameters
        .catchError((Object _, StackTrace __) {})
        .then((_) => task());
    _txnQueues[key] = next.then((_) {}, onError: (Object _, StackTrace __) {});
    return next;
  }

  /// Drop-in replacement for `FirebaseFirestore.instance.runTransaction(handler)`
  /// that serializes all transactions for the same `room/{id}` doc on this client.
  static Future<T> _serializedTxn<T>(
    DocumentReference roomRef,
    Future<T> Function(Transaction txn) handler,
  ) {
    return _serialized(
      roomRef,
      () => FirebaseFirestore.instance.runTransaction(handler),
    );
  }

  /// Round fuse in seconds: random between **80% and 100%** of [configuredCapSec]
  /// (inclusive). Used so the buzzer does not always fire at the same fraction of the round.
  static int roundFuseSeconds80To100Percent(int configuredCapSec) {
    final cap = configuredCapSec.clamp(15, 3600);
    final low = max(1, (cap * 0.8).ceil());
    final high = cap;
    if (low >= high) return high;
    return low + _rng.nextInt(high - low + 1);
  }

  /// @deprecated Prefer [roundFuseSeconds80To100Percent]. Kept for any external callers.
  static int randomRoundDurationSec(int configuredMaxSec) =>
      roundFuseSeconds80To100Percent(configuredMaxSec);

  /// Initial `hot_potato_live` map written with [DocumentReference.update].
  static Map<String, dynamic> buildInitialLiveMap({
    required List<String> participantPaths,
    required int holderIndex,
    required int totalRounds,
    required int roundDurationSec,
    required String rtdbDatabaseUrl,
    bool walletCharged = false,
  }) {
    return {
      'round': 1,
      'total_rounds': totalRounds,
      // Exact gameplay length (seconds) for this round — matches lobby "1/2/3 Min".
      'round_duration_sec': roundDurationSec.clamp(15, 3600),
      'round_duration_cap_sec': roundDurationSec.clamp(15, 3600),
      // Client Timestamp avoids pending-null `serverTimestamp` reads that skip
      // [effectiveRoundEnd] and block [hostAdvanceRoundIfExpired] on some clients.
      'round_started_at': Timestamp.fromDate(DateTime.now()),
      'participant_paths': participantPaths,
      'holder_index': holderIndex.clamp(0, participantPaths.length - 1),
      'match_complete': false,
      'last_powerup': null,
      'last_powerup_at': null,
      'last_powerup_actor': null,
      'last_powerup_x': null,
      'last_powerup_y': null,
      'wallet_charged': walletCharged,
      'elimination_order': <String>[],
      'winner_path': null,
      'results_rank': null,
      'positions': <String, dynamic>{},
      'pickups': <Map<String, dynamic>>[],
      'inventory': <String, dynamic>{},
      'pass_immune_until': <String, dynamic>{},
      'rtdb_database_url': hotPotatoEffectiveDatabaseUrl(rtdbDatabaseUrl),
      'ghost_paths': <String>[],
    };
  }

  /// Host advances when the round window ends: eliminate holder, then either
  /// finish with a winner or start the next round.
  /// Deferred snapshot of the authoritative holder path used by
  /// [hostAdvanceRoundIfExpired]. Any client that has an active edge
  /// connection updates this so round-end elimination targets the actual
  /// DO holder rather than the (potentially stale) Firestore mirror.
  static String? _liveAuthoritativeHolder;
  static void setEdgeHolderHint(String? path) {
    _liveAuthoritativeHolder = (path == null || path.isEmpty) ? null : path;
  }

  static Future<void> hostAdvanceRoundIfExpired(
      DocumentReference roomRef) async {
    bool matchEnded = false;
    var rtdbForCleanup = kHotPotatoDefaultRtdbDatabaseUrl;
    String? nextHolderPath;
    String? rtdbHolderPath;
    try {
      final snap = await roomRef.get();
      final d = snap.data();
      if (d is Map<String, dynamic>) {
        final live = HotPotatoLiveState.fromRoomSnapshotData(d);
        if (live != null) {
          rtdbForCleanup = hotPotatoEffectiveDatabaseUrl(live.rtdbDatabaseUrl);
          final passState = await HotPotatoRtdbPositions.readPassState(
            roomRef.id,
            rtdbForCleanup,
          );
          rtdbHolderPath = passState.holderPath;
        }
      }
    } catch (_) {
      // Fallback to Firestore holder index.
    }
    await _serializedTxn(roomRef, (txn) async {
      final snap = await txn.get(roomRef);
      final data = snap.data();
      if (data is! Map<String, dynamic>) return;
      final live = HotPotatoLiveState.fromRoomSnapshotData(data);
      if (live == null || live.matchComplete) return;
      rtdbForCleanup = hotPotatoEffectiveDatabaseUrl(live.rtdbDatabaseUrl);
      if (live.participantPaths.isEmpty) return;
      final end = live.effectiveRoundEnd;
      if (end == null) return;
      // Small skew tolerance; avoid rejecting the first eligible commit tick.
      if (DateTime.now()
          .isBefore(end.subtract(const Duration(milliseconds: 120)))) {
        return;
      }

      final paths = List<String>.from(live.participantPaths);
      final oldLen = paths.length;
      if (oldLen == 0) return;

      if (oldLen == 1) {
        final w = paths.first;
        matchEnded = true;
        _hpTxnUpdate(txn, roomRef, {
          'hot_potato_live.match_complete': true,
          'hot_potato_live.winner_path': w,
          'hot_potato_live.results_rank': <String>[w],
          'hot_potato_live.pickups': <Map<String, dynamic>>[],
          'hot_potato_live.positions': <String, dynamic>{},
          'hot_potato_live.inventory': <String, dynamic>{},
        });
        return;
      }

      var hi = live.holderIndex.clamp(0, oldLen - 1);
      // Edge mode: prefer the DO's authoritative holder over Firestore mirror.
      // The mirror can lag the last pass by ~1 RTT, which would otherwise
      // eliminate the wrong player at round end.
      final edgeHolder = _liveAuthoritativeHolder;
      if (edgeHolder != null) {
        final idx = paths.indexOf(edgeHolder);
        if (idx >= 0) hi = idx;
      } else {
        final rtdbHolder = rtdbHolderPath;
        if (rtdbHolder != null) {
          final idx = paths.indexOf(rtdbHolder);
          if (idx >= 0) hi = idx;
        }
      }
      final nextOld = (hi + 1) % oldLen;
      final loser = paths.removeAt(hi);

      final elim = List<String>.from(live.eliminationOrder)..add(loser);

      int newHolderIdx = 0;
      if (paths.isNotEmpty) {
        if (nextOld > hi) {
          newHolderIdx = nextOld - 1;
        } else if (nextOld < hi) {
          newHolderIdx = nextOld;
        } else {
          newHolderIdx = 0;
        }
        newHolderIdx = newHolderIdx.clamp(0, paths.length - 1);
      }

      final nextRound = live.round + 1;

      void finishMatch({
        required String winner,
        required List<String> rank,
      }) {
        matchEnded = true;
        _hpTxnUpdate(txn, roomRef, <String, dynamic>{
          'hot_potato_live.participant_paths': paths,
          'hot_potato_live.elimination_order': elim,
          'hot_potato_live.holder_index': paths.isEmpty ? 0 : newHolderIdx,
          'hot_potato_live.round': nextRound,
          'hot_potato_live.match_complete': true,
          'hot_potato_live.winner_path': winner,
          'hot_potato_live.results_rank': rank,
          'hot_potato_live.pickups': <Map<String, dynamic>>[],
          'hot_potato_live.positions': <String, dynamic>{},
          'hot_potato_live.inventory': <String, dynamic>{},
        });
      }

      if (paths.length == 1) {
        final w = paths.first;
        nextHolderPath = w;
        final rank = <String>[w, ...elim.reversed];
        finishMatch(winner: w, rank: rank);
        return;
      }

      if (paths.isEmpty) {
        matchEnded = true;
        _hpTxnUpdate(txn, roomRef, <String, dynamic>{
          'hot_potato_live.participant_paths': paths,
          'hot_potato_live.elimination_order': elim,
          'hot_potato_live.match_complete': true,
          'hot_potato_live.winner_path': null,
          'hot_potato_live.results_rank': elim.reversed.toList(),
          'hot_potato_live.pickups': <Map<String, dynamic>>[],
          'hot_potato_live.positions': <String, dynamic>{},
          'hot_potato_live.inventory': <String, dynamic>{},
        });
        return;
      }

      if (nextRound > live.totalRounds) {
        final w = paths.first;
        nextHolderPath = w;
        final rank = <String>[...paths, ...elim.reversed];
        finishMatch(winner: w, rank: rank);
        return;
      }

      final liveMap = data['hot_potato_live'];
      int cap = live.roundDurationSec;
      if (liveMap is Map) {
        final rawCap = liveMap['round_duration_cap_sec'];
        if (rawCap is int) {
          cap = rawCap;
        } else if (rawCap is double) {
          cap = rawCap.round();
        }
      }
      final nextDur = cap.clamp(15, 3600);

      // Rewrite positions/inventory without the eliminated [loser]. Transaction.update
      // does NOT accept FieldPath keys, so we replace the whole sub-maps instead.
      final keptPositions = <String, dynamic>{};
      for (final e in live.positions.entries) {
        if (e.key == loser) continue;
        keptPositions[e.key] = HotPotatoPositionData.buildFirestoreWrite(
          x: e.value.x,
          y: e.value.y,
          vx: e.value.vx,
          vy: e.value.vy,
          speedUntil: e.value.speedUntil,
          shieldUntil: e.value.shieldUntil,
          ghostUntil: e.value.ghostUntil,
          slowUntil: e.value.slowUntil,
          slowMultiplier: e.value.slowMultiplier,
          now: DateTime.now(),
        );
      }
      final keptInventory = <String, dynamic>{};
      for (final e in live.inventory.entries) {
        if (e.key == loser) continue;
        keptInventory[e.key] = Map<String, dynamic>.from(e.value);
      }
      // Clear pass-back immunity at round boundary; the new round starts fresh.
      const Map<String, dynamic> resetImmunity = <String, dynamic>{};

      nextHolderPath = paths[newHolderIdx];
      _hpTxnUpdate(txn, roomRef, <String, dynamic>{
        'hot_potato_live.participant_paths': paths,
        'hot_potato_live.elimination_order': elim,
        'hot_potato_live.holder_index': newHolderIdx,
        'hot_potato_live.round': nextRound,
        'hot_potato_live.round_duration_sec': nextDur,
        'hot_potato_live.round_duration_cap_sec': cap.clamp(15, 3600),
        'hot_potato_live.round_started_at': Timestamp.fromDate(DateTime.now()),
        'hot_potato_live.pickups': <Map<String, dynamic>>[],
        'hot_potato_live.positions': keptPositions,
        'hot_potato_live.inventory': keptInventory,
        'hot_potato_live.pass_immune_until': resetImmunity,
        'hot_potato_live.ghost_paths': FieldValue.arrayUnion(<String>[loser]),
      });
    });

    // Mirror Firestore eliminations / match-end into the RTDB position store so
    // dead players don't stay rendered. Fire-and-forget — RTDB write failures are
    // already swallowed inside [HotPotatoRtdbPositions].
    if (matchEnded) {
      unawaited(HotPotatoRtdbPositions.clearRoom(roomRef.id, rtdbForCleanup));
    } else {
      // Eliminated players become ghosts: keep their RTDB node for spectator motion.
      final next = nextHolderPath;
      if (next != null && next.isNotEmpty) {
        unawaited(HotPotatoRtdbPositions.initializePassState(
          databaseUrl: rtdbForCleanup,
          roomId: roomRef.id,
          holderPath: next,
        ));
      }
    }
  }

  static Future<void> passPotatoToNext(
      DocumentReference roomRef, HotPotatoLiveState live) async {
    if (live.participantPaths.isEmpty) return;
    final next = (live.holderIndex + 1) % live.participantPaths.length;
    await roomRef.update({'hot_potato_live.holder_index': next});
  }

  static Future<void> recordPowerupUse(
      DocumentReference roomRef, String powerupId) async {
    await roomRef.update({
      'hot_potato_live.last_powerup': powerupId,
      'hot_potato_live.last_powerup_at': FieldValue.serverTimestamp(),
    });
  }

  static String newPickupId() =>
      '${DateTime.now().microsecondsSinceEpoch}_${_rng.nextInt(1 << 30)}';

  static Future<void> writeMyPosition(
    DocumentReference roomRef,
    String path,
    double x,
    double y,
    double vx,
    double vy, {
    DateTime? speedUntil,
    DateTime? shieldUntil,
    bool clearSpeed = false,
    bool clearShield = false,
  }) async {
    final payload = HotPotatoPositionData.buildFirestoreWrite(
      x: x.clamp(0.0, 1.0),
      y: y.clamp(0.0, 1.0),
      vx: vx,
      vy: vy,
      speedUntil: speedUntil,
      shieldUntil: shieldUntil,
      clearSpeed: clearSpeed,
      clearShield: clearShield,
      now: DateTime.now(),
    );
    await _hpDocUpdate(roomRef, <Object, Object?>{
      FieldPath(['hot_potato_live', 'positions', path]): payload,
    });
  }

  /// Returns true if holder changed to [targetPath].
  ///
  /// Rejects when [targetPath] is currently within [HotPotatoLiveState.passImmunityWindow]
  /// of having just passed the bomb. On a successful pass we grant the *passer*
  /// (the previous holder) that same window of immunity so a "tag back" pass
  /// loop cannot trap them.
  ///
  /// When [edgeGameplayMirror] is true, shield and pass-immunity checks are
  /// skipped — the Cloudflare DO already validated; Firestore positions can lag.
  static Future<bool> attemptPassToPath(
    DocumentReference roomRef,
    String holderPath,
    String targetPath, {
    bool edgeGameplayMirror = false,
  }) async {
    return _serializedTxn(roomRef, (txn) async {
      final snap = await txn.get(roomRef);
      final data = snap.data();
      if (data is! Map<String, dynamic>) return false;
      final live = HotPotatoLiveState.fromRoomSnapshotData(data);
      if (live == null || live.matchComplete) return false;
      if (live.holderPath != holderPath) return false;
      final ti = live.participantPaths.indexOf(targetPath);
      if (ti < 0) return false;
      final now = DateTime.now();
      if (!edgeGameplayMirror) {
        final pos = live.positions[targetPath];
        if (pos != null && pos.isShieldedAt(now)) return false;
        if (live.isPassImmune(targetPath, now)) return false;
      }

      // Build the new pass_immune_until map: keep any still-active entries,
      // drop expired ones, and grant the passer 3 seconds of "can't receive
      // the bomb back" protection.
      final newImmunity = <String, dynamic>{};
      final cutoff = now;
      live.passImmuneUntil.forEach((path, expiry) {
        if (expiry.isAfter(cutoff)) {
          newImmunity[path] = Timestamp.fromDate(expiry);
        }
      });
      newImmunity[holderPath] = Timestamp.fromDate(
        now.add(HotPotatoLiveState.passImmunityWindow),
      );

      txn.update(roomRef, {
        'hot_potato_live.holder_index': ti,
        'hot_potato_live.pass_immune_until': newImmunity,
      });
      return true;
    });
  }

  static Future<bool> claimPickup(
    DocumentReference roomRef,
    String pickupId,
    String claimingPath,
  ) async {
    return _serializedTxn(roomRef, (txn) async {
      final snap = await txn.get(roomRef);
      final data = snap.data();
      if (data is! Map<String, dynamic>) return false;
      final live = HotPotatoLiveState.fromRoomSnapshotData(data);
      if (live == null || live.matchComplete) return false;
      if (!live.participantPaths.contains(claimingPath)) return false;

      final hp = data['hot_potato_live'];
      if (hp is! Map<String, dynamic>) return false;
      final rawPickups = hp['pickups'];
      if (rawPickups is! List) return false;

      String? claimedKind;
      HotPotatoPickupItem? claimedPickup;
      final newList = <Map<String, dynamic>>[];
      var claimed = false;
      for (final e in rawPickups) {
        if (e is! Map) continue;
        final m = Map<String, dynamic>.from(e);
        final id = m['id']?.toString() ?? '';
        final cb = m['claimed_by']?.toString();
        if (id == pickupId && (cb == null || cb.isEmpty)) {
          claimedPickup = HotPotatoPickupItem.fromMap(m);
          claimedKind = m['kind']?.toString() ?? 'Speed';
          claimed = true;
          if (claimedPickup?.isBananaTrap ?? false) {
            continue;
          }
          m['claimed_by'] = claimingPath;
        }
        newList.add(m);
      }
      if (!claimed) return false;
      final kindStr = (claimedKind == 'Unseen') ? 'Ghost' : (claimedKind ?? '');
      if (kindStr.isEmpty) return false;

      if (claimedPickup?.isBananaTrap ?? false) {
        final now = DateTime.now();
        final armedAt = claimedPickup?.armedAt;
        if (armedAt != null && now.isBefore(armedAt)) return false;
        final target = live.positions[claimingPath] ??
            const HotPotatoPositionData(x: 0.5, y: 0.5, vx: 0, vy: 0);
        final mergedPositions = <String, dynamic>{};
        for (final participant in live.participantPaths) {
          final p = live.positions[participant] ??
              const HotPotatoPositionData(x: 0.5, y: 0.5, vx: 0, vy: 0);
          mergedPositions[participant] =
              HotPotatoPositionData.buildFirestoreWrite(
            x: p.x,
            y: p.y,
            vx: p.vx,
            vy: p.vy,
            speedUntil: p.speedUntil,
            shieldUntil: p.shieldUntil,
            ghostUntil: p.ghostUntil,
            slowUntil: participant == claimingPath
                ? now.add(const Duration(seconds: 5))
                : p.slowUntil,
            slowMultiplier: participant == claimingPath ? 0.5 : p.slowMultiplier,
            now: now,
          );
        }
        mergedPositions[claimingPath] = HotPotatoPositionData.buildFirestoreWrite(
          x: target.x,
          y: target.y,
          vx: target.vx,
          vy: target.vy,
          speedUntil: target.speedUntil,
          shieldUntil: target.shieldUntil,
          ghostUntil: target.ghostUntil,
          slowUntil: now.add(const Duration(seconds: 5)),
          slowMultiplier: 0.5,
          now: now,
        );
        _hpTxnUpdate(txn, roomRef, <String, dynamic>{
          'hot_potato_live.pickups': newList,
          'hot_potato_live.positions': mergedPositions,
        });
        return true;
      }

      final invRaw = hp['inventory'];
      final inv = <String, Map<String, int>>{};
      if (invRaw is Map) {
        for (final e in invRaw.entries) {
          final pk = e.key?.toString();
          if (pk == null || pk.isEmpty) continue;
          if (e.value is! Map) continue;
          final inner = Map<String, dynamic>.from(e.value);
          final counts = <String, int>{};
          for (final ie in inner.entries) {
            var k = ie.key.toString();
            if (k.isEmpty) continue;
            if (k == 'Unseen') k = 'Ghost';
            counts[k] = HotPotatoLiveState._readInt(ie.value, fallback: 0)
                .clamp(0, 999);
          }
          inv[pk] = counts;
        }
      }
      final mine = Map<String, int>.from(inv[claimingPath] ?? {});
      mine[kindStr] = (mine[kindStr] ?? 0) + 1;
      inv[claimingPath] = mine;

      final invFirestore = <String, dynamic>{};
      for (final e in inv.entries) {
        invFirestore[e.key] = e.value;
      }

      _hpTxnUpdate(txn, roomRef, <String, dynamic>{
        'hot_potato_live.pickups': newList,
        'hot_potato_live.inventory': invFirestore,
      });
      return true;
    });
  }

  /// Host: append a new unclaimed pickup if under [maxActive] after pruning expired.
  static Future<void> spawnPickupIfRoom(
    DocumentReference roomRef, {
    required String kind,
    required double x,
    required double y,
    int maxActive = 10,
    Duration maxAge = const Duration(seconds: 40),
  }) async {
    await _serializedTxn(roomRef, (txn) async {
      final snap = await txn.get(roomRef);
      final data = snap.data();
      if (data is! Map<String, dynamic>) return;
      final live = HotPotatoLiveState.fromRoomSnapshotData(data);
      if (live == null || live.matchComplete) return;

      final hp = data['hot_potato_live'];
      if (hp is! Map<String, dynamic>) return;
      final rawPickups = hp['pickups'];
      final now = DateTime.now();
      final kept = <Map<String, dynamic>>[];
      if (rawPickups is List) {
        for (final e in rawPickups) {
          if (e is! Map) continue;
          final m = Map<String, dynamic>.from(e);
          final cb = m['claimed_by']?.toString();
          if (cb != null && cb.isNotEmpty) continue;
          final item = HotPotatoPickupItem.fromMap(m);
          if (item?.isBananaTrap == true &&
              item?.expiresAt != null &&
              !now.isBefore(item!.expiresAt!)) {
            continue;
          }
          final st = item?.spawnedAt;
          if (st != null && now.difference(st) > maxAge) continue;
          kept.add(m);
        }
      }
      if (kept.length >= maxActive) return;

      final id = newPickupId();
      kept.add({
        'id': id,
        'kind': kind,
        'x': x.clamp(0.0, 1.0),
        'y': y.clamp(0.0, 1.0),
        // Must be Timestamp, NOT FieldValue.serverTimestamp(), because this
        // map is appended to the `hot_potato_live.pickups` array. Firestore
        // disallows FieldValue inside arrays; on web it throws
        // "Attempting to box non-Dart object" instead of a clean error.
        'spawned_at': Timestamp.now(),
      });
      _hpTxnUpdate(txn, roomRef, {'hot_potato_live.pickups': kept});
    });
  }

  /// Decrements inventory and applies the requested effect on [path]. Banana
  /// drops a short-lived trap at the user's current position.
  ///
  /// When [inventoryAndPowerupMetaOnly] is true, only `inventory` and
  /// last-powerup metadata are written — not `positions`. Use when gameplay
  /// effects are already applied authoritatively on the Cloudflare DO (edge
  /// mode); otherwise Firestore's stale coordinates can mis-place positional effects.
  static Future<bool> consumeInventory(
    DocumentReference roomRef,
    String path,
    String kind, {
    bool inventoryAndPowerupMetaOnly = false,
    double? lastPowerupWorldX,
    double? lastPowerupWorldY,
  }) async {
    final canonicalKind = kind == 'Unseen' ? 'Ghost' : kind;
    if (canonicalKind != 'Speed' &&
        canonicalKind != 'Shield' &&
        canonicalKind != 'Ghost' &&
        canonicalKind != 'Banana') {
      return false;
    }
    return _serializedTxn(roomRef, (txn) async {
      final snap = await txn.get(roomRef);
      final data = snap.data();
      if (data is! Map<String, dynamic>) return false;
      final live = HotPotatoLiveState.fromRoomSnapshotData(data);
      if (live == null || live.matchComplete) return false;

      final hp = data['hot_potato_live'];
      if (hp is! Map<String, dynamic>) return false;
      final invRaw = hp['inventory'];
      final inv = <String, Map<String, int>>{};
      if (invRaw is Map) {
        for (final e in invRaw.entries) {
          final pk = e.key?.toString();
          if (pk == null || pk.isEmpty) continue;
          if (e.value is! Map) continue;
          final inner = Map<String, dynamic>.from(e.value);
          final counts = <String, int>{};
          for (final ie in inner.entries) {
            final k = ie.key.toString();
            if (k.isEmpty) continue;
            counts[k] = HotPotatoLiveState._readInt(ie.value, fallback: 0)
                .clamp(0, 999);
          }
          inv[pk] = counts;
        }
      }
      final mine = Map<String, int>.from(inv[path] ?? {});
      final n = mine[canonicalKind] ?? 0;
      if (n < 1) return false;
      mine[canonicalKind] = n - 1;
      if (mine[canonicalKind] == 0) mine.remove(canonicalKind);
      if (mine.isEmpty) {
        inv.remove(path);
      } else {
        inv[path] = mine;
      }

      final invFirestore = <String, dynamic>{};
      for (final e in inv.entries) {
        invFirestore[e.key] = e.value;
      }

      HotPotatoPositionData resolvePos(String participantPath) {
        final existing = live.positions[participantPath];
        if (existing != null) return existing;
        final idx = live.participantPaths.indexOf(participantPath);
        var x = 0.5;
        var y = 0.5;
        if (idx >= 0 && live.participantPaths.isNotEmpty) {
          final angle = -pi / 2 + (idx * 2 * pi / live.participantPaths.length);
          x = 0.5 + 0.32 * cos(angle);
          y = 0.5 + 0.28 * sin(angle);
        }
        return HotPotatoPositionData(
          x: x,
          y: y,
          vx: 0,
          vy: 0,
        );
      }

      final pos = resolvePos(path);
      final now = DateTime.now();

      if (inventoryAndPowerupMetaOnly) {
        final lx = lastPowerupWorldX ?? pos.x;
        final ly = lastPowerupWorldY ?? pos.y;
        // Edge mode: positional effects (Banana AoE, Speed/Shield/Ghost timers)
        // are applied authoritatively on the DO. Firestore mirror only carries
        // inventory + last-powerup metadata so the lobby/results UI stays
        // consistent.
        _hpTxnUpdate(txn, roomRef, <String, dynamic>{
          'hot_potato_live.inventory': invFirestore,
          'hot_potato_live.last_powerup': canonicalKind,
          'hot_potato_live.last_powerup_at': FieldValue.serverTimestamp(),
          'hot_potato_live.last_powerup_actor': path,
          'hot_potato_live.last_powerup_x': lx,
          'hot_potato_live.last_powerup_y': ly,
        });
        return true;
      }

      DateTime? newSpeed = pos.speedUntil;
      DateTime? newShield = pos.shieldUntil;
      DateTime? newGhost = pos.ghostUntil;
      if (canonicalKind == 'Speed') {
        newSpeed = now.add(const Duration(seconds: 5));
      } else if (canonicalKind == 'Shield') {
        newShield = now.add(const Duration(seconds: 5));
      } else if (canonicalKind == 'Ghost') {
        newGhost = now.add(const Duration(seconds: 5));
      }

      final posPayload = HotPotatoPositionData.buildFirestoreWrite(
        x: pos.x,
        y: pos.y,
        vx: pos.vx,
        vy: pos.vy,
        speedUntil: newSpeed,
        shieldUntil: newShield,
        ghostUntil: newGhost,
        slowUntil: pos.slowUntil,
        slowMultiplier: pos.slowMultiplier,
        now: now,
      );

      // Replace the whole `positions` sub-map (Transaction.update can't accept
      // FieldPath keys). Banana applies a 50% slow for 5s to anyone within
      // [bananaRadius] of the user; everyone else keeps their current effects.
      final mergedPositions = <String, dynamic>{};
      const bananaRadius = 0.18;
      final bananaUntil = now.add(const Duration(seconds: 5));
      for (final participant in live.participantPaths) {
        final p = resolvePos(participant);
        if (participant == path) continue;
        DateTime? slowUntil = p.slowUntil;
        double? slowMult = p.slowMultiplier;
        if (canonicalKind == 'Banana') {
          final dx = p.x - pos.x;
          final dy = p.y - pos.y;
          if (sqrt(dx * dx + dy * dy) <= bananaRadius) {
            slowUntil = bananaUntil;
            slowMult = 0.5;
          }
        }
        mergedPositions[participant] =
            HotPotatoPositionData.buildFirestoreWrite(
          x: p.x,
          y: p.y,
          vx: p.vx,
          vy: p.vy,
          speedUntil: p.speedUntil,
          shieldUntil: p.shieldUntil,
          ghostUntil: p.ghostUntil,
          slowUntil: slowUntil,
          slowMultiplier: slowMult,
          now: now,
        );
      }
      mergedPositions[path] = posPayload;

      _hpTxnUpdate(txn, roomRef, <String, dynamic>{
        'hot_potato_live.inventory': invFirestore,
        'hot_potato_live.positions': mergedPositions,
        'hot_potato_live.last_powerup': canonicalKind,
        'hot_potato_live.last_powerup_at': FieldValue.serverTimestamp(),
        'hot_potato_live.last_powerup_actor': path,
        'hot_potato_live.last_powerup_x': pos.x,
        'hot_potato_live.last_powerup_y': pos.y,
      });
      return true;
    });
  }

  /// Ends the match when the room host confirms exit, so clients show the results screen.
  static Future<void> hostAbandonMatchToResults(
    DocumentReference roomRef,
    String hostParticipantPath,
  ) async {
    var rtdbForClear = kHotPotatoDefaultRtdbDatabaseUrl;
    await _serializedTxn(roomRef, (txn) async {
      final snap = await txn.get(roomRef);
      final data = snap.data();
      if (data is! Map<String, dynamic>) return;
      final live = HotPotatoLiveState.fromRoomSnapshotData(data);
      if (live == null || live.matchComplete) return;
      rtdbForClear = hotPotatoEffectiveDatabaseUrl(live.rtdbDatabaseUrl);

      final paths = List<String>.from(live.participantPaths);
      if (paths.isEmpty) {
        _hpTxnUpdate(txn, roomRef, <String, dynamic>{
          'hot_potato_live.match_complete': true,
          'hot_potato_live.winner_path': live.winnerPath,
          'hot_potato_live.results_rank':
              live.resultsRank.isNotEmpty ? live.resultsRank : <String>[],
          'hot_potato_live.pickups': <Map<String, dynamic>>[],
          'hot_potato_live.positions': <String, dynamic>{},
          'hot_potato_live.inventory': <String, dynamic>{},
        });
        return;
      }

      final elim = List<String>.from(live.eliminationOrder);
      if (paths.contains(hostParticipantPath)) {
        paths.remove(hostParticipantPath);
        elim.add(hostParticipantPath);
      }

      final String? winnerPath;
      final List<String> rank;
      if (paths.isEmpty) {
        winnerPath = null;
        rank = elim.reversed.toList();
      } else {
        winnerPath = paths.first;
        rank = <String>[...paths, ...elim.reversed];
      }

      _hpTxnUpdate(txn, roomRef, <String, dynamic>{
        'hot_potato_live.participant_paths': paths,
        'hot_potato_live.elimination_order': elim,
        'hot_potato_live.holder_index': paths.isEmpty ? 0 : 0,
        'hot_potato_live.match_complete': true,
        'hot_potato_live.winner_path': winnerPath,
        'hot_potato_live.results_rank': rank,
        'hot_potato_live.pickups': <Map<String, dynamic>>[],
        'hot_potato_live.positions': <String, dynamic>{},
        'hot_potato_live.inventory': <String, dynamic>{},
      });
    });

    // Match is over; drop the RTDB positions for this room.
    unawaited(HotPotatoRtdbPositions.clearRoom(roomRef.id, rtdbForClear));
  }
}
