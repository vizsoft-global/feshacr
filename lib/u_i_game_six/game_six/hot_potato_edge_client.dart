import 'dart:async';
import 'dart:convert';
import 'dart:ui' show Offset;

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '/u_i_game_six/game_six/hot_potato_edge_auth.dart';
import '/u_i_game_six/game_six/hot_potato_edge_config.dart';
import '/u_i_game_six/game_six/hot_potato_latency_config.dart';
import '/u_i_game_six/game_six/hot_potato_live.dart';
import '/u_i_game_six/game_six/hot_potato_snapshot_buffer.dart';
import '/u_i_game_six/game_six/hot_potato_sfx.dart';

typedef HotPotatoEdgePassHandler = Future<void> Function(
  String fromPath,
  String toPath,
);

typedef HotPotatoEdgePowerHandler = Future<void> Function(
  String path,
  String kind,
);

typedef HotPotatoEdgePickupClaimHandler = Future<void> Function(
  String path,
  String pickupId,
  String kind,
);

typedef HotPotatoEdgeRejectionHandler = void Function(
  String action,
  String target,
  String reason,
);

/// Lets arena HUD (sibling widgets) reach the active edge client for a room.
class HotPotatoEdgePowerRelay {
  HotPotatoEdgePowerRelay._();

  static final Map<String, HotPotatoEdgeClient> _byRoom = {};

  static void register(String roomId, HotPotatoEdgeClient client) {
    _byRoom[roomId] = client;
  }

  static void unregister(String roomId) {
    _byRoom.remove(roomId);
  }

  static HotPotatoEdgeClient? clientFor(String roomId) => _byRoom[roomId];
}

/// WebSocket client for Cloudflare Durable Object room authority.
class HotPotatoEdgeClient {
  HotPotatoEdgeClient({
    required this.roomId,
    required this.myPath,
    required this.isHost,
    this.onPassConfirmed,
    this.onPowerUsed,
    this.onPickupClaimed,
    this.onEdgeSimState,
    this.onRtt,
    this.onRejection,
  });

  final String roomId;
  final String myPath;
  final bool isHost;
  final HotPotatoEdgePassHandler? onPassConfirmed;
  final HotPotatoEdgePowerHandler? onPowerUsed;
  final HotPotatoEdgePickupClaimHandler? onPickupClaimed;
  final void Function()? onEdgeSimState;
  final void Function(int rttMs)? onRtt;
  final HotPotatoEdgeRejectionHandler? onRejection;

  /// Bumped on every DO state / pass / power / pickup message so sibling HUD
  /// (e.g. [Powerups1Widget]) can rebuild without waiting on Firestore.
  final ValueNotifier<int> simRevision = ValueNotifier(0);

  final HotPotatoSnapshotInterpolator interpolator =
      HotPotatoSnapshotInterpolator(
    bufferDelayMs: kHotPotatoEdgeBufferDelayMs,
  );

  WebSocketChannel? _channel;
  StreamSubscription? _sub;
  bool _disposed = false;
  int _connectFailureStreak = 0;

  /// Last `serverT` value observed on a `state` frame. Echoed back on
  /// every outgoing message via `echoT` so the worker can measure this
  /// client's RTT (#2) and apply adaptive tolerance + server rewind on
  /// pass attempts. Zero until the first state arrives.
  int _lastServerT = 0;

  /// Monotonic per-message sequence number (#6). Always wins on the
  /// worker's anti-replay echo check and lets the worker re-order or
  /// discard out-of-order inputs in future.
  int _outSeq = 0;

  String _holderPath = '';
  final Map<String, HotPotatoPositionData> _authoritative = {};
  final Map<String, DateTime> _passImmuneUntil = {};
  List<HotPotatoPickupItem>? _edgePickups;
  Map<String, Map<String, int>>? _edgeInventory;

  /// Authoritative floor pickups from the DO (edge mode). Null until first `state`.
  List<HotPotatoPickupItem>? get edgePickups => _edgePickups;

  /// Authoritative inventory snapshot from the DO (edge mode).
  Map<String, Map<String, int>>? get edgeInventory => _edgeInventory;

  int edgeInventoryCount(String path, String kind) {
    final m = _edgeInventory?[path];
    return m?[kind] ?? 0;
  }

  Map<String, HotPotatoPositionData> get authoritativePositions =>
      Map.unmodifiable(_authoritative);

  String get holderPath => _holderPath;

  Map<String, DateTime> get passImmuneUntil => Map.unmodifiable(_passImmuneUntil);

  Future<void> connect() async {
    if (_disposed) return;
    final token = await fetchHotPotatoEdgeToken(
      roomId: roomId,
      participantPath: myPath,
    );
    if (token == null || _disposed) return;

    final wsBase = token.workerUrl.isNotEmpty
        ? _httpToWs(token.workerUrl)
        : hotPotatoEdgeWorkerWsBase();
    final uri = Uri.parse('$wsBase/room/$roomId').replace(
      queryParameters: {'token': token.token},
    );

    await _sub?.cancel();
    _channel?.sink.close();

    final sw = Stopwatch()..start();
    _channel = WebSocketChannel.connect(uri);
    _sub = _channel!.stream.listen(
      _onMessage,
      onError: (_) => _scheduleReconnect(),
      onDone: () => _scheduleReconnect(),
    );
    _connectFailureStreak = 0;
    sw.stop();
    onRtt?.call(sw.elapsedMilliseconds.clamp(0, 5000));

    _send({'type': 'hello', 'path': myPath});
  }

  Future<void> configureRoom({
    required List<String> participantPaths,
    required String holderPath,
    int round = 1,
    String botDifficulty = 'easy',
  }) async {
    if (!isHost) return;
    _holderPath = holderPath;
    _send({
      'type': 'configure',
      'participantPaths': participantPaths,
      'holderPath': holderPath,
      'round': round,
      'botDifficulty': botDifficulty,
    });
  }

  void syncRoom({
    required List<String> participantPaths,
    required int round,
    String? holderPath,
    String? botDifficulty,
  }) {
    if (!isHost) return;
    if (holderPath != null && holderPath.isNotEmpty) {
      _holderPath = holderPath;
    }
    _send({
      'type': 'sync_room',
      'participantPaths': participantPaths,
      'round': round,
      if (holderPath != null && holderPath.isNotEmpty) 'holderPath': holderPath,
      if (botDifficulty != null) 'botDifficulty': botDifficulty,
    });
  }

  void updatePickups(List<HotPotatoPickupItem> pickups) {
    if (!isHost) return;
    final available = pickups.where((p) => p.isAvailable).map((p) => {
          'id': p.id,
          'kind': p.kind,
          'x': p.x,
          'y': p.y,
          if (p.isBananaTrap) 'trap': true,
          if (p.expiresAt != null) 'expires_at_ms': p.expiresAt!.millisecondsSinceEpoch,
        }).toList();
    _send({
      'type': 'pickups_update',
      'pickups': available,
    });
  }

  void syncInventory(Map<String, Map<String, int>> inventory) {
    if (!isHost) return;
    final out = <String, Map<String, int>>{};
    for (final e in inventory.entries) {
      final counts = <String, int>{};
      for (final ie in e.value.entries) {
        if (ie.value > 0) counts[ie.key] = ie.value;
      }
      if (counts.isNotEmpty) out[e.key] = counts;
    }
    _send({
      'type': 'sync_inventory',
      'inventory': out,
    });
  }

  void claimPickup({
    required String pickupId,
    double? clientX,
    double? clientY,
  }) {
    _send({
      'type': 'claim_pickup',
      'pickupId': pickupId,
      if (clientX != null) 'clientX': clientX,
      if (clientY != null) 'clientY': clientY,
    });
  }

  /// Remove a pickup from the local edge cache immediately so the player gets
  /// instant visual feedback. The DO remains authoritative; the next state
  /// frame will replace this list and re-add the pickup if the claim was
  /// rejected. Local-only Banana drops (`banana-local:*`) live in this list
  /// too, so we keep them visible until the DO confirms with a real id.
  void optimisticRemovePickup(String pickupId) {
    final list = _edgePickups;
    if (list == null) return;
    final next = list.where((p) => p.id != pickupId).toList(growable: false);
    if (next.length == list.length) return;
    _edgePickups = next;
    simRevision.value++;
    onEdgeSimState?.call();
  }

  void sendInput({
    required double dirX,
    required double dirY,
    required double throttle,
    double? x,
    double? y,
    double? vx,
    double? vy,
  }) {
    _send({
      'type': 'input',
      'dirX': dirX,
      'dirY': dirY,
      'throttle': throttle,
      // Bounded server reconciliation: the worker uses these to keep its
      // human position close to local prediction. Without them, tiny input
      // timing differences accumulate until server=0.2+ away from what the
      // player sees, causing pass/pickup rejects.
      if (x != null) 'clientX': x,
      if (y != null) 'clientY': y,
      if (vx != null) 'clientVx': vx,
      if (vy != null) 'clientVy': vy,
    });
  }

  /// Tracks the previous holder when [sendTag] optimistically advances
  /// `_holderPath`, so a `tag_rejected` message from the worker can revert
  /// the change immediately instead of waiting ~40ms for the next state
  /// frame to overwrite it. Cleared whenever a non-rejection message
  /// confirms a holder change.
  String? _pendingTagPrevHolder;

  void sendTag({
    required String fromPath,
    required String targetPath,
    double? clientX,
    double? clientY,
    double? targetClientX,
    double? targetClientY,
  }) {
    _send({
      'type': 'tag',
      'fromPath': fromPath,
      'targetPath': targetPath,
      if (clientX != null) 'clientX': clientX,
      if (clientY != null) 'clientY': clientY,
      if (targetClientX != null) 'targetClientX': targetClientX,
      if (targetClientY != null) 'targetClientY': targetClientY,
    });
    // Optimistically advance the holder locally so subsequent ticks don't
    // re-fire `_maybeTag` and flood the server with tag attempts while the
    // server's pass_ok is still in flight. If the server rejects, the
    // matching `tag_rejected` handler reverts this so we can retry on the
    // very next tick (no ~40ms state-frame wait).
    if (_holderPath == fromPath) {
      _pendingTagPrevHolder = fromPath;
      _holderPath = targetPath;
      // Matches server PASS_IMMUNITY_MS (3000ms) — keeps the local optimistic
      // immunity in lock-step so `_maybeTag` won't try to tag the same
      // ex-holder right back during the lockout window.
      _passImmuneUntil[fromPath] = DateTime.now().add(
        const Duration(milliseconds: 3000),
      );
      simRevision.value++;
      onEdgeSimState?.call();
    }
  }

  void setRoundPaused(bool paused) {
    if (!isHost) return;
    _send({'type': 'round_pause', 'paused': paused});
  }

  void usePower({
    required String path,
    required String kind,
  }) {
    _send({'type': 'use_power', 'path': path, 'kind': kind});
  }

  /// Local-only echo so the player gets instant movement/effect feedback while
  /// the DO message is in flight. The server remains authoritative and will
  /// replace this on the next state frame.
  void optimisticUsePower({
    required String path,
    required String kind,
  }) {
    final now = DateTime.now();
    final p = _authoritative[path];
    if (p != null) {
      // Banana drops a server-side trap with a server-generated id; we do NOT
      // add a local placeholder because if the user walked over their own
      // local banana, the worker would reject the claim with "not_found"
      // (different id space). The real trap arrives in the next state frame
      // after a 300ms server arm delay anyway.
      _authoritative[path] = HotPotatoPositionData(
        x: p.x,
        y: p.y,
        vx: p.vx,
        vy: p.vy,
        speedUntil: kind == 'Speed'
            ? now.add(const Duration(seconds: 5))
            : p.speedUntil,
        shieldUntil: kind == 'Shield'
            ? now.add(const Duration(seconds: 5))
            : p.shieldUntil,
        ghostUntil: kind == 'Ghost'
            ? now.add(const Duration(seconds: 5))
            : p.ghostUntil,
        slowUntil: p.slowUntil,
        slowMultiplier: p.slowMultiplier,
      );
    }
    final inv = _edgeInventory;
    if (inv != null) {
      final mine = Map<String, int>.from(inv[path] ?? const {});
      final n = mine[kind] ?? 0;
      if (n <= 1) {
        mine.remove(kind);
      } else {
        mine[kind] = n - 1;
      }
      _edgeInventory = Map<String, Map<String, int>>.from(inv);
      if (mine.isEmpty) {
        _edgeInventory!.remove(path);
      } else {
        _edgeInventory![path] = mine;
      }
    }
    simRevision.value++;
    onEdgeSimState?.call();
  }

  /// Legacy alias — prefer [usePower].
  void applyPower({
    required String path,
    required String kind,
  }) =>
      usePower(path: path, kind: kind);

  Map<String, Offset> displayPositions({String? excludePath}) {
    final raw = interpolator.allDisplayPositions();
    if (excludePath == null) return raw;
    return Map.fromEntries(
      raw.entries.where((e) => e.key != excludePath),
    );
  }

  void dispose() {
    _disposed = true;
    _sub?.cancel();
    _channel?.sink.close();
    interpolator.clear();
    _edgePickups = null;
    _edgeInventory = null;
    simRevision.dispose();
  }

  void _scheduleReconnect() {
    if (_disposed) return;
    _connectFailureStreak++;
    // Stay on edge only: never fall back to RTDB. Back off to avoid hammering
    // the worker after failures, but always retry.
    final waitSec = (_connectFailureStreak * 2).clamp(2, 30);
    Future<void>.delayed(Duration(seconds: waitSec), () {
      if (!_disposed) unawaited(connect());
    });
  }

  void _send(Map<String, Object?> msg) {
    // Stamp every outgoing message with:
    //  - `t`     : a monotonic client sequence number (#6) for ordering /
    //              replay detection
    //  - `echoT` : the last `serverT` we saw in a state frame — the worker
    //              subtracts this from its current time to compute our RTT
    //              and feed adaptive tolerance + server rewind (#2 + #3 + #1)
    msg.putIfAbsent('t', () => ++_outSeq);
    if (_lastServerT > 0) {
      msg.putIfAbsent('echoT', () => _lastServerT);
    }
    try {
      _channel?.sink.add(jsonEncode(msg));
    } catch (_) {}
  }

  void _onMessage(dynamic raw) {
    Map<String, dynamic> msg;
    try {
      msg = jsonDecode(raw as String) as Map<String, dynamic>;
    } catch (_) {
      return;
    }
    final type = msg['type']?.toString() ?? '';
    // Any valid server message means the socket is healthy again.
    _connectFailureStreak = 0;
    if (type == 'state') {
      _ingestState(msg);
      return;
    }
    if (type == 'pass_ok') {
      final hp = msg['holderPath']?.toString();
      final from = msg['fromPath']?.toString() ?? '';
      final to = msg['toPath']?.toString() ?? '';
      if (hp != null && hp.isNotEmpty) _holderPath = hp;
      final t = msg['t'];
      final nowMs = t is int ? t : DateTime.now().millisecondsSinceEpoch;
      if (from.isNotEmpty) {
        _passImmuneUntil[from] = DateTime.fromMillisecondsSinceEpoch(
          nowMs + HotPotatoLiveState.passImmunityWindow.inMilliseconds,
        );
      }
      HotPotatoSfx.playPass();
      simRevision.value++;
      onEdgeSimState?.call();
      final cb = onPassConfirmed;
      if (cb != null && from.isNotEmpty && to.isNotEmpty) {
        unawaited(cb(from, to));
      }
      return;
    }
    if (type == 'power_used') {
      final path = msg['path']?.toString() ?? '';
      final kind = msg['kind']?.toString() ?? '';
      simRevision.value++;
      onEdgeSimState?.call();
      final cb = onPowerUsed;
      if (cb != null && path.isNotEmpty && kind.isNotEmpty) {
        unawaited(cb(path, kind));
      }
      return;
    }
    if (type == 'tag_rejected' ||
        type == 'pickup_rejected' ||
        type == 'power_rejected') {
      final reason = msg['reason']?.toString() ?? '';
      final target = msg['target']?.toString() ?? '';
      final action = type.split('_').first;
      // Tag rejected: revert the optimistic holder advance so the next
      // arena tick re-checks contact and can immediately retry.
      if (action == 'tag' && _pendingTagPrevHolder != null) {
        _holderPath = _pendingTagPrevHolder!;
        _pendingTagPrevHolder = null;
        // Clear the optimistic pass immunity we set on the previous
        // holder — the pass never happened.
        _passImmuneUntil.remove(_holderPath);
        simRevision.value++;
        onEdgeSimState?.call();
      }
      onRejection?.call(action, target, reason);
      return;
    }
    // Any successful pass / authoritative state frame clears the pending
    // optimistic revert flag so a later rejection doesn't undo a confirmed
    // pass.
    if (type == 'pass_ok' || type == 'state') {
      _pendingTagPrevHolder = null;
    }
    if (type == 'pickup_claimed') {
      final path = msg['path']?.toString() ?? '';
      final pickupId = msg['pickupId']?.toString() ?? '';
      final kind = msg['kind']?.toString() ?? '';
      if (path == myPath) HotPotatoSfx.playPickup();
      simRevision.value++;
      onEdgeSimState?.call();
      final cb = onPickupClaimed;
      if (cb != null &&
          path.isNotEmpty &&
          pickupId.isNotEmpty &&
          kind.isNotEmpty) {
        unawaited(cb(path, pickupId, kind));
      }
      return;
    }
  }

  void _ingestState(Map<String, dynamic> msg) {
    final t = msg['t'];
    final serverMs = t is int ? t : DateTime.now().millisecondsSinceEpoch;
    // Capture `serverT` for echo-back on the next outgoing message so the
    // worker can measure RTT. Falls back to `t` for older worker builds.
    final st = msg['serverT'];
    if (st is int && st > _lastServerT) {
      _lastServerT = st;
    } else if (serverMs > _lastServerT) {
      _lastServerT = serverMs;
    }
    final hp = msg['holderPath']?.toString();
    if (hp != null && hp.isNotEmpty) _holderPath = hp;

    final imm = msg['passImmuneUntilMs'];
    if (imm is Map) {
      _passImmuneUntil.clear();
      for (final e in imm.entries) {
        final k = e.key?.toString();
        final v = e.value;
        if (k == null || k.isEmpty) continue;
        if (v is int) {
          _passImmuneUntil[k] = DateTime.fromMillisecondsSinceEpoch(v);
        }
      }
    }

    final rawPickups = msg['pickups'];
    if (rawPickups is List) {
      final list = <HotPotatoPickupItem>[];
      for (final e in rawPickups) {
        if (e is! Map) continue;
        final m = Map<String, dynamic>.from(e);
        final id = m['id']?.toString() ?? '';
        if (id.isEmpty) continue;
        list.add(
          HotPotatoPickupItem(
            id: id,
            kind: m['kind']?.toString() ?? 'Speed',
            x: _dbl(m['x'], 0.5),
            y: _dbl(m['y'], 0.5),
            trap: m['trap'] == true || m['kind'] == 'BananaTrap',
            expiresAt: _ms(m['expires_at_ms']),
            armedAt: _ms(m['armed_at_ms']),
          ),
        );
      }
      _edgePickups = list;
    }

    final rawInv = msg['inventory'];
    if (rawInv is Map) {
      final out = <String, Map<String, int>>{};
      for (final e in rawInv.entries) {
        final path = e.key.toString();
        if (path.isEmpty) continue;
        if (e.value is! Map) continue;
        final inner = <String, int>{};
        for (final ie in (e.value as Map).entries) {
          final k = ie.key.toString();
          if (k.isEmpty) continue;
          final n = ie.value is int ? ie.value as int : (ie.value as num?)?.toInt() ?? 0;
          if (n > 0) inner[k] = n;
        }
        if (inner.isNotEmpty) out[path] = inner;
      }
      _edgeInventory = out;
    }

    final pos = msg['positions'];
    if (pos is! Map) return;
    for (final e in pos.entries) {
      final path = e.key.toString();
      if (e.value is! Map) continue;
      final m = Map<String, dynamic>.from(e.value as Map);
      final x = _dbl(m['x'], 0.5);
      final y = _dbl(m['y'], 0.5);
      final vx = _dbl(m['vx'], 0);
      final vy = _dbl(m['vy'], 0);
      final su = _ms(m['speed_until_ms']);
      final sh = _ms(m['shield_until_ms']);
      final gh = _ms(m['ghost_until_ms']);
      final sl = _ms(m['slow_until_ms']);
      final slowMult = _dbl(m['slow_mult'], 1.0);

      interpolator.ingest(
        path: path,
        serverTimeMs: serverMs,
        x: x,
        y: y,
        vx: vx,
        vy: vy,
      );

      _authoritative[path] = HotPotatoPositionData(
        x: x,
        y: y,
        vx: vx,
        vy: vy,
        speedUntil: su,
        shieldUntil: sh,
        ghostUntil: gh,
        slowUntil: sl,
        slowMultiplier: slowMult,
      );
    }

    simRevision.value++;
    onEdgeSimState?.call();
  }

  double _dbl(Object? v, double fb) {
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is num) return v.toDouble();
    return fb;
  }

  DateTime? _ms(Object? v) {
    if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
    return null;
  }

  String _httpToWs(String url) {
    var u = url.trim();
    if (u.endsWith('/')) u = u.substring(0, u.length - 1);
    if (u.startsWith('https://')) return 'wss://${u.substring(8)}';
    if (u.startsWith('http://')) return 'ws://${u.substring(7)}';
    if (u.startsWith('wss://') || u.startsWith('ws://')) return u;
    return 'wss://$u';
  }
}
