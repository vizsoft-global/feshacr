import 'package:cloud_firestore/cloud_firestore.dart';

/// Bot roster persisted under `hot_potato_settings.bots`.
class HotPotatoFirestoreBot {
  const HotPotatoFirestoreBot({
    required this.name,
    required this.avatarEmoji,
    required this.localId,
  });

  final String name;
  final String avatarEmoji;
  final int localId;
}

/// Parsed `room` document field `hot_potato_settings` (not on [RoomRecord] schema).
///
/// Live match clock / holder / power-ups use sibling field `hot_potato_live` — see
/// [HotPotatoLiveState] in `hot_potato_live.dart`.
class HotPotatoFirestoreSettings {
  const HotPotatoFirestoreSettings({
    required this.roundMinutes,
    required this.totalRounds,
    required this.powerups,
    required this.bots,
    required this.state,
    this.startedAt,
    this.rtdbUrl,
    this.offlineBotMode = false,
    this.edgeRealtime = false,
    this.edgeLocationHint,
    this.edgeWorkerUrl,
    this.botDifficulty = 'easy',
  });

  /// Bot AI ramp. One of: `easy` (default, current behavior),
  /// `medium` (sharper chases, more powerup use), `hard` (predictive,
  /// aggressive — built to make survival genuinely difficult).
  final String botDifficulty;
  static const Set<String> botDifficultyValues = {'easy', 'medium', 'hard'};

  static const String stateArena = 'arena';
  static const String stateSettings = 'settings';

  final int roundMinutes;
  final int totalRounds;
  final List<String> powerups;
  final List<HotPotatoFirestoreBot> bots;
  final String state;
  final DateTime? startedAt;

  /// Realtime Database URL chosen when the arena started (positions path).
  final String? rtdbUrl;

  /// When true, the host simulates bot positions in-memory only (no RTDB writes
  /// for `bot:*` paths) for latency experiments. Only offered when no other humans
  /// are in the room.
  final bool offlineBotMode;

  /// Cloudflare Durable Object realtime for positions / pass / bots.
  final bool edgeRealtime;

  /// CF `locationHint` chosen by host probe (e.g. apac, weur).
  final String? edgeLocationHint;

  /// Worker base URL used for this match.
  final String? edgeWorkerUrl;

  bool get isArena => state == stateArena;

  /// Canonical power-up order for UI chips.
  static const List<String> canonicalPowerupOrder = [
    'Speed',
    'Banana',
    'Shield',
    'Ghost',
  ];

  /// Power-ups from settings, ordered canonically and de-duplicated.
  List<String> get orderedPowerups {
    final set = powerups.toSet();
    return canonicalPowerupOrder.where(set.contains).toList();
  }

  static HotPotatoFirestoreSettings fromRoomSnapshotData(
    Map<String, dynamic> snapshotData,
  ) {
    final raw = snapshotData['hot_potato_settings'];
    if (raw is! Map) {
      return _defaults();
    }
    final map = Map<String, dynamic>.from(raw);
    final roundMinutes =
        _readInt(map['round_minutes'], fallback: 2).clamp(1, 3);
    final totalRounds = _readInt(map['total_rounds'], fallback: 3);
    final tr = ({1, 3, 5}.contains(totalRounds)) ? totalRounds : 3;

    final powerList = map['powerups'];
    final rawPowerIds = <String>{};
    if (powerList is List) {
      for (final e in powerList) {
        if (e is! String) continue;
        final id = e == 'Unseen' ? 'Ghost' : e;
        if (canonicalPowerupOrder.contains(id)) {
          rawPowerIds.add(id);
        }
      }
    }
    List<String> powerups =
        canonicalPowerupOrder.where(rawPowerIds.contains).toList();
    if (powerups.isEmpty) {
      powerups = List<String>.from(canonicalPowerupOrder);
    }

    final botsRaw = map['bots'];
    final bots = <HotPotatoFirestoreBot>[];
    if (botsRaw is List) {
      for (final e in botsRaw) {
        if (e is! Map) continue;
        final m = Map<String, dynamic>.from(e);
        final name = m['name']?.toString() ?? 'Bot';
        final avatar = m['avatar']?.toString() ?? '🤖';
        final lid = _readInt(m['local_id'], fallback: bots.length + 1);
        bots.add(
          HotPotatoFirestoreBot(
            name: name,
            avatarEmoji: avatar,
            localId: lid,
          ),
        );
      }
    }

    final state = map['state']?.toString() ?? stateSettings;
    DateTime? startedAt;
    final st = map['started_at'];
    if (st is Timestamp) {
      startedAt = st.toDate();
    } else if (st is DateTime) {
      startedAt = st;
    }

    final rawRtdb = map['rtdb_url'];
    final String? rtdbUrl =
        rawRtdb is String && rawRtdb.trim().isNotEmpty ? rawRtdb.trim() : null;

    final offlineBotMode = map['offline_bot_mode'] == true;
    final edgeRealtime = map['edge_realtime'] == true;
    var botDifficulty = map['bot_difficulty']?.toString() ?? 'easy';
    if (!botDifficultyValues.contains(botDifficulty)) botDifficulty = 'easy';
    final rawEdgeHint = map['edge_location_hint'];
    final edgeLocationHint =
        rawEdgeHint is String && rawEdgeHint.trim().isNotEmpty
            ? rawEdgeHint.trim()
            : null;
    final rawEdgeUrl = map['edge_worker_url'];
    final edgeWorkerUrl =
        rawEdgeUrl is String && rawEdgeUrl.trim().isNotEmpty
            ? rawEdgeUrl.trim()
            : null;

    return HotPotatoFirestoreSettings(
      roundMinutes: roundMinutes,
      totalRounds: tr,
      powerups: powerups,
      bots: bots,
      state: state,
      startedAt: startedAt,
      rtdbUrl: rtdbUrl,
      offlineBotMode: offlineBotMode,
      edgeRealtime: edgeRealtime,
      edgeLocationHint: edgeLocationHint,
      edgeWorkerUrl: edgeWorkerUrl,
      botDifficulty: botDifficulty,
    );
  }

  static HotPotatoFirestoreSettings _defaults() =>
      const HotPotatoFirestoreSettings(
        roundMinutes: 2,
        totalRounds: 3,
        powerups: canonicalPowerupOrder,
        bots: [],
        state: stateSettings,
        startedAt: null,
        rtdbUrl: null,
        offlineBotMode: false,
        edgeRealtime: false,
        edgeLocationHint: null,
        edgeWorkerUrl: null,
      );

  static int _readInt(Object? v, {required int fallback}) {
    if (v is int) return v;
    if (v is double) return v.round();
    return fallback;
  }
}
