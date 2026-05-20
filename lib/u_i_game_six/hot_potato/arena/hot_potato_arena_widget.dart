import 'dart:async';
import 'dart:math' as math;

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/u_i_game_six/game_six/hot_potato_bot_movement.dart';
import '/u_i_game_six/game_six/hot_potato_display_utils.dart';
import '/u_i_game_six/game_six/hot_potato_debug_ingest.dart';
import '/u_i_game_six/game_six/hot_potato_edge_client.dart';
import '/u_i_game_six/game_six/hot_potato_edge_routing.dart';
import '/u_i_game_six/game_six/hot_potato_latency_config.dart';
import '/u_i_game_six/game_six/hot_potato_live.dart';
import '/u_i_game_six/game_six/hot_potato_position_sync.dart';
import '/u_i_game_six/game_six/hot_potato_positions_rtdb.dart';
import '/u_i_game_six/game_six/hot_potato_rtdb_routing.dart';
import '/u_i_game_six/game_six/hot_potato_settings_parser.dart';
import '/u_i_game_six/game_six/hot_potato_sfx.dart';
import '/u_i_game_six/game_six/hot_potato_voice_session.dart';

import 'package:flutter/foundation.dart';
import '/u_i_game_six/game_six/hot_potato_haptics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Canvas arena: joystick movement, collision pass, pickup claim; listens to [roomRef] for live state.
class HotPotatoArenaWidget extends StatelessWidget {
  const HotPotatoArenaWidget({
    super.key,
    required this.roomRef,
    required this.room,
    required this.settings,
    required this.isHost,
    this.onArenaBack,
    this.onArenaExit,
  });

  final DocumentReference roomRef;
  final RoomRecord room;
  final HotPotatoFirestoreSettings settings;
  final bool isHost;
  final VoidCallback? onArenaBack;
  final VoidCallback? onArenaExit;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: StreamBuilder<DocumentSnapshot>(
        stream: roomRef.snapshots(),
        builder: (context, snap) {
          final raw = snap.data?.data();
          if (raw is! Map<String, dynamic>) {
            return const Center(child: CircularProgressIndicator());
          }
          final live = HotPotatoLiveState.fromRoomSnapshotData(raw);
          // Never return an empty [SizedBox.expand] — that paints as a blank
          // screen when live is briefly null (bad partial write) or when this
          // snapshot is ahead of the parent frame (match just completed).
          if (live == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Syncing arena…',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'If this stays stuck, use Back and re-enter the room.',
                      style: FlutterFlowTheme.of(context).labelSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          if (live.matchComplete) {
            return const Center(child: CircularProgressIndicator());
          }
          final hp = HotPotatoFirestoreSettings.fromRoomSnapshotData(raw);
          final rtdbUrl =
              hotPotatoEffectiveDatabaseUrl(live.rtdbDatabaseUrl ?? hp.rtdbUrl);
          return _ArenaTickerScope(
            roomRef: roomRef,
            room: room,
            settings: hp,
            live: live,
            rtdbDatabaseUrl: rtdbUrl,
            isHost: isHost,
            onArenaBack: onArenaBack,
            onArenaExit: onArenaExit,
          );
        },
      ),
    );
  }
}

class _ArenaTickerScope extends StatefulWidget {
  const _ArenaTickerScope({
    required this.roomRef,
    required this.room,
    required this.settings,
    required this.live,
    required this.rtdbDatabaseUrl,
    required this.isHost,
    this.onArenaBack,
    this.onArenaExit,
  });

  final DocumentReference roomRef;
  final RoomRecord room;
  final HotPotatoFirestoreSettings settings;
  final HotPotatoLiveState live;
  final String rtdbDatabaseUrl;
  final bool isHost;
  final VoidCallback? onArenaBack;
  final VoidCallback? onArenaExit;

  @override
  State<_ArenaTickerScope> createState() => _ArenaTickerScopeState();
}

class _ArenaTickerScopeState extends State<_ArenaTickerScope>
    with SingleTickerProviderStateMixin {
  Ticker? _ticker;
  Duration? _lastElapsed;

  late HotPotatoLiveState _live;
  HotPotatoPositionSyncer? _syncer;
  HotPotatoEdgeClient? _edgeClient;
  bool _edgeConfigured = false;
  String _lastSyncedPathsKey = '';
  String _lastSyncedHolder = '';
  int _lastSyncedRound = 0;
  String _lastSyncedPickupsKey = '';
  String _lastSyncedInventoryKey = '';
  int _edgeFirestoreMirrorDepth = 0;
  final Set<String> _pickupMirrorPendingIds = {};
  DateTime? _lastEdgeInputSend;
  /// Last `(dirX, dirY, throttle)` actually transmitted to the worker.
  /// Used by [_sendEdgeInputIfDue] to detect direction changes (especially
  /// releases) and forward them immediately instead of waiting for the
  /// idle-input timer — which would otherwise let the server keep moving
  /// you for up to 450 ms after you let go.
  double _lastSentDirX = 0;
  double _lastSentDirY = 0;
  double _lastSentThrottle = 0.30;

  /// HTTP `/latency-probe` samples (same as lobby settings), not WS connect time.
  Timer? _edgeHttpPingTimer;

  /// Snapshot of positions from Realtime Database; refreshed via [_rtdbSub].
  /// Authoritative for everyone except the local player (whose token uses
  /// the local prediction at [_lx],[_ly] for zero-latency feel).
  Map<String, HotPotatoPositionData> _rtdbPositions = const {};
  StreamSubscription<Map<String, HotPotatoPositionData>>? _rtdbSub;
  StreamSubscription<RtdbPassState>? _passStateSub;
  String? _holderPathRtdb;
  final Map<String, DateTime> _passImmuneUntilRtdb = {};

  /// Host-only overlay when [HotPotatoFirestoreSettings.offlineBotMode]: bot
  /// positions updated locally without RTDB writes.
  final Map<String, HotPotatoPositionData> _offlineBotByPath = {};

  double _lx = 0.5;
  double _ly = 0.5;
  double _lvx = 0;
  double _lvy = 0;
  double _throttle01 = 0.30;
  Offset _lastInputDir = Offset.zero;

  final Map<String, Offset> _smoothRemote = {};

  Offset _joystick = Offset.zero;
  // 25% larger than the original 42 — better thumb target on phones.
  static const double _joyRadius = 52;

  DateTime? _lastTagAttempt;
  final Set<String> _pickupClaimInFlight = {};

  /// Autonomous bot simulation uses the same arena clock as your movement. To stay under
  /// Firestore's 1-write/sec per-document budget, **only the room host** drives bots and
  /// every bot's position update is batched into one `update()` per tick.
  double _botSimAccumSec = 0;
  bool _botTickInFlight = false;
  double _ghostBotDriftAccumSec = 0;
  bool _ghostBotDriftInFlight = false;

  /// Smoothed RTDB write round-trip in milliseconds. `null` until the first
  /// successful write returns. Driven by the syncer's onWriteRtt callback;
  /// rendered by [_PingBadge] next to the arena back button.
  int? _pingMs;
  // Throttle the setState — we only want the badge to repaint when the
  // displayed bucket changes, otherwise this fights the painter for budget.
  int? _lastPaintedPingMs;

  /// Transient toast surfaced when the DO rejects a tag/pickup/power so the
  /// user understands why the action did not register (e.g. `too_far:0.142`).
  _RejectionBanner? _rejectionBanner;

  final HotPotatoVoiceSession _voiceSession = HotPotatoVoiceSession();

  // #region agent log
  int _hpDbgTick = 0;
  int _hpDbgLastWallLog = 0;
  double _hpDbgMaxBotTargetDelta = 0;
  // #endregion

  String? get _myPath => currentUserReference?.path;

  bool get _useEdge => widget.settings.edgeRealtime;

  _RoundGateUi _roundGateUi(DateTime now) {
    if (_live.matchComplete) return const _RoundGateUi.unlocked();
    final started = _live.roundStartedAt;
    if (started == null) return const _RoundGateUi.unlocked();
    final elapsedMs = now.difference(started).inMilliseconds;
    final hasElimBanner = _live.round > 1 && _live.eliminationOrder.isNotEmpty;
    final bannerSec =
        hasElimBanner ? HotPotatoLiveState.roundEliminationBannerSec : 0;
    final totalSec = HotPotatoLiveState.roundStartCountdownSec + bannerSec;
    final totalMs = totalSec * 1000;
    if (elapsedMs >= totalMs) return const _RoundGateUi.unlocked();

    if (hasElimBanner && elapsedMs < bannerSec * 1000) {
      final eliminatedPath = _live.eliminationOrder.last;
      final eliminatedName = hotPotatoPathLabelForRoom(
        eliminatedPath,
        widget.room,
        widget.settings,
      );
      return _RoundGateUi(
        locked: true,
        title: '$eliminatedName eliminated',
        subtitle: 'Next round starts shortly',
      );
    }

    final remainingMs = (totalMs - elapsedMs).clamp(0, totalMs);
    final count = (remainingMs / 1000).ceil().clamp(
          0,
          HotPotatoLiveState.roundStartCountdownSec,
        );
    return _RoundGateUi(
      locked: true,
      title: 'Starting round ${_live.round}',
      subtitle: 'Get ready',
      countdown: count,
    );
  }

  bool _isLocalGhost(String? mePath) {
    if (mePath == null) return false;
    return _live.ghostPaths.contains(mePath) &&
        !_live.participantPaths.contains(mePath);
  }

  void _sendEdgeInputIfDue(DateTime now, double dirX, double dirY) {
    if (!_useEdge) return;
    final last = _lastEdgeInputSend;
    // Active = joystick is currently being pushed OR what we'd send now
    // differs from the last input the server saw. The "differs" branch is
    // what makes joystick *releases* and direction *reversals* land on the
    // worker within one input frame — without it, friction-decay positions
    // barely change locally so the server keeps applying the stale
    // direction for up to 450ms, causing server-position drift of ~0.2.
    final hasInput = dirX.abs() > 0.02 || dirY.abs() > 0.02;
    final dirChanged = (dirX - _lastSentDirX).abs() > 0.03 ||
        (dirY - _lastSentDirY).abs() > 0.03 ||
        (_throttle01 - _lastSentThrottle).abs() > 0.10;
    final minMs = (hasInput || dirChanged)
        ? kHotPotatoEdgeInputMinMsMoving
        : kHotPotatoEdgeInputMinMsIdle;
    if (last == null || now.difference(last).inMilliseconds >= minMs) {
      _lastEdgeInputSend = now;
      _lastSentDirX = dirX;
      _lastSentDirY = dirY;
      _lastSentThrottle = _throttle01;
      _edgeClient?.sendInput(
        dirX: dirX,
        dirY: dirY,
        throttle: _throttle01,
        x: _lx,
        y: _ly,
        vx: _lvx,
        vy: _lvy,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _live = widget.live;
    _bootstrapLocal();
    if (_useEdge) {
      _bindEdgeClient();
    } else {
      _bindRtdbSubscription();
      _bindPassStateSubscription();
    }
    _ticker = createTicker(_onTick)..start();
  }

  void _bindEdgeClient() {
    final me = _myPath;
    if (me == null) return;
    _edgeClient?.dispose();
    _edgeClient = HotPotatoEdgeClient(
      roomId: widget.roomRef.id,
      myPath: me,
      isHost: widget.isHost,
      onPassConfirmed: (from, to) async {
        await HotPotatoLiveFirestore.attemptPassToPath(
          widget.roomRef,
          from,
          to,
          edgeGameplayMirror: true,
        );
      },
      onPowerUsed: (path, kind) async {
        if (!widget.isHost) return;
        _edgeFirestoreMirrorDepth++;
        try {
          final auth = _edgeClient?.authoritativePositions[path];
          await HotPotatoLiveFirestore.consumeInventory(
            widget.roomRef,
            path,
            kind,
            inventoryAndPowerupMetaOnly: true,
            lastPowerupWorldX: auth?.x,
            lastPowerupWorldY: auth?.y,
          );
        } catch (_) {
        } finally {
          _edgeFirestoreMirrorDepth--;
        }
      },
      onPickupClaimed: (path, pickupId, kind) async {
        if (!widget.isHost) return;
        _edgeFirestoreMirrorDepth++;
        _pickupMirrorPendingIds.add(pickupId);
        try {
          await HotPotatoLiveFirestore.claimPickup(
            widget.roomRef,
            pickupId,
            path,
          );
        } catch (_) {
        } finally {
          _pickupMirrorPendingIds.remove(pickupId);
          _edgeFirestoreMirrorDepth--;
        }
      },
      onEdgeSimState: () {
        if (mounted) setState(() {});
      },
      // Edge ping uses HTTP latency-probe (see [_startEdgeHttpPingTimer]); WS
      // connect completes in ~1ms and is not comparable to lobby chips.
      onRtt: null,
      onRejection: (action, target, reason) {
        if (!mounted) return;
        // Suppress race-condition / wait-and-try-again rejections so the user
        // only ever sees banners they can actually act on. These all resolve
        // on their own within a frame or two.
        if (action == 'pickup' && reason.startsWith('not_found')) {
          _pickupClaimInFlight.remove(target);
          return;
        }
        if (action == 'tag' &&
            (reason.startsWith('not_holder') ||
                reason.startsWith('no_holder_state') ||
                reason.startsWith('target_pass_immune'))) {
          return;
        }
        setState(() {
          _rejectionBanner =
              _RejectionBanner(action: action, reason: reason, until:
                DateTime.now().add(const Duration(milliseconds: 1500)));
        });
      },
    );
    unawaited(() async {
      await _edgeClient?.connect();
      if (!mounted || _edgeClient == null) return;
      HotPotatoEdgePowerRelay.register(widget.roomRef.id, _edgeClient!);
      _startEdgeHttpPingTimer();
      if (widget.isHost && !_edgeConfigured) {
        _edgeConfigured = true;
        final paths = _live.participantPaths;
        final holder = _live.holderPath;
        if (paths.isNotEmpty &&
            holder.isNotEmpty &&
            paths.contains(holder)) {
          await _edgeClient!.configureRoom(
            participantPaths: paths,
            holderPath: holder,
            round: _live.round,
            botDifficulty: widget.settings.botDifficulty,
          );
        }
        _syncEdgeStateIfNeeded(_live, force: true);
      }
    }());
  }

  String _edgeProbeHintId() {
    final h = widget.settings.edgeLocationHint?.trim();
    if (h == null || h.isEmpty) return 'apac';
    return h.toLowerCase();
  }

  void _startEdgeHttpPingTimer() {
    _edgeHttpPingTimer?.cancel();
    unawaited(_probeEdgeHttpOnce());
    _edgeHttpPingTimer =
        Timer.periodic(const Duration(seconds: 3), (_) => unawaited(_probeEdgeHttpOnce()));
  }

  Future<void> _probeEdgeHttpOnce() async {
    if (!mounted || !_useEdge) return;
    final ms = await measureHotPotatoEdgeLatencyForHint(_edgeProbeHintId());
    if (!mounted || ms >= (1 << 30)) return;
    _recordPingMs(ms);
  }

  List<HotPotatoPickupItem> _pickupsForEdgeHostPush(HotPotatoLiveState live) {
    return live.pickups
        .where(
          (p) => p.isAvailable && !_pickupMirrorPendingIds.contains(p.id),
        )
        .toList();
  }

  String _pickupsKey(HotPotatoLiveState live) {
    return _pickupsForEdgeHostPush(live)
        .map((p) => '${p.id}:${p.kind}:${p.x}:${p.y}')
        .join('|');
  }

  String _inventoryKey(HotPotatoLiveState live) {
    final parts = <String>[];
    for (final e in live.inventory.entries) {
      final counts = e.value.entries
          .where((ie) => ie.value > 0)
          .map((ie) => '${ie.key}=${ie.value}')
          .toList()
        ..sort();
      if (counts.isNotEmpty) {
        parts.add('${e.key}:${counts.join(',')}');
      }
    }
    parts.sort();
    return parts.join('|');
  }

  List<HotPotatoPickupItem> _effectivePickupsForPaint() {
    if (_useEdge && _edgeClient?.edgePickups != null) {
      return _edgeClient!.edgePickups!;
    }
    return _live.pickups;
  }

  void _syncEdgeStateIfNeeded(HotPotatoLiveState live, {bool force = false}) {
    if (!_useEdge || !widget.isHost || _edgeClient == null) return;

    final pathsKey = live.participantPaths.join('|');
    final holder = live.holderPath;
    final round = live.round;
    final pickupsKey = _pickupsKey(live);
    final inventoryKey = _inventoryKey(live);

    if (force ||
        pathsKey != _lastSyncedPathsKey ||
        holder != _lastSyncedHolder ||
        round != _lastSyncedRound) {
      if (_edgeConfigured) {
        final structuralChange =
            pathsKey != _lastSyncedPathsKey || round != _lastSyncedRound;
        _edgeClient!.syncRoom(
          participantPaths: live.participantPaths,
          round: round,
          holderPath: structuralChange ? holder : null,
          botDifficulty: widget.settings.botDifficulty,
        );
      }
      _lastSyncedPathsKey = pathsKey;
      _lastSyncedHolder = holder;
      _lastSyncedRound = round;
    }

    if (force ||
        (pickupsKey != _lastSyncedPickupsKey &&
            _edgeFirestoreMirrorDepth == 0)) {
      _edgeClient!.updatePickups(_pickupsForEdgeHostPush(live));
      _lastSyncedPickupsKey = pickupsKey;
    }

    if (force ||
        (inventoryKey != _lastSyncedInventoryKey &&
            _edgeFirestoreMirrorDepth == 0)) {
      _edgeClient!.syncInventory(live.inventory);
      _lastSyncedInventoryKey = inventoryKey;
    }
  }

  void _recordPingMs(int ms) {
    if (!mounted) return;
    final smoothed = _pingMs == null ? ms : (_pingMs! * 0.7 + ms * 0.3).round();
    _pingMs = smoothed;
    final bucket = (smoothed ~/ 10) * 10;
    if (_lastPaintedPingMs != bucket) {
      _lastPaintedPingMs = bucket;
      setState(() {});
    }
  }

  void _bindRtdbSubscription() {
    _rtdbSub?.cancel();
    _rtdbSub = HotPotatoRtdbPositions.subscribe(
      widget.roomRef.id,
      widget.rtdbDatabaseUrl,
    ).listen((positions) {
      if (!mounted) return;
      setState(() {
        _rtdbPositions = positions;
      });
    });
  }

  void _bindPassStateSubscription() {
    _passStateSub?.cancel();
    _passStateSub = HotPotatoRtdbPositions.subscribePassState(
      widget.roomRef.id,
      widget.rtdbDatabaseUrl,
    ).listen((state) {
      if (!mounted) return;
      setState(() {
        _holderPathRtdb = state.holderPath;
        _passImmuneUntilRtdb
          ..clear()
          ..addAll(state.passImmuneUntil);
      });
    });
  }

  Map<String, HotPotatoPositionData> _viewPositions() {
    final base = _useEdge
        ? Map<String, HotPotatoPositionData>.from(
            _edgeClient?.authoritativePositions ?? const {},
          )
        : Map<String, HotPotatoPositionData>.from(_rtdbPositions);
    final out = base;
    if (!_useEdge) {
      for (final e in _offlineBotByPath.entries) {
        out[e.key] = e.value;
      }
    }
    // Gameplay effects (shield/speed/ghost/freeze-slow) are sourced from
    // Firestore `hot_potato_live.positions`; movement is sourced from RTDB.
    // Merge them so effects stay visible and authoritative while still using
    // smooth RTDB motion.
    for (final e in _live.positions.entries) {
      final rtdb = out[e.key];
      final fs = e.value;
      if (rtdb == null) {
        out[e.key] = fs;
        continue;
      }
      out[e.key] = HotPotatoPositionData(
        x: rtdb.x,
        y: rtdb.y,
        vx: rtdb.vx,
        vy: rtdb.vy,
        speedUntil: rtdb.speedUntil ?? fs.speedUntil,
        shieldUntil: rtdb.shieldUntil ?? fs.shieldUntil,
        ghostUntil: rtdb.ghostUntil ?? fs.ghostUntil,
        slowUntil: rtdb.slowUntil ?? fs.slowUntil,
        slowMultiplier:
            rtdb.slowUntil != null ? rtdb.slowMultiplier : fs.slowMultiplier,
      );
    }
    return out;
  }

  String _effectiveHolderPath() {
    if (_useEdge) {
      final hp = _edgeClient?.holderPath;
      if (hp != null &&
          hp.isNotEmpty &&
          _live.participantPaths.contains(hp)) {
        return hp;
      }
    }
    final hp = _holderPathRtdb;
    if (hp != null && _live.participantPaths.contains(hp)) {
      return hp;
    }
    return _live.holderPath;
  }

  bool _isPassImmune(String path, DateTime now) {
    if (_useEdge) {
      final t = _edgeClient?.passImmuneUntil[path];
      if (t != null) return now.isBefore(t);
    }
    final t = _passImmuneUntilRtdb[path];
    if (t != null) return now.isBefore(t);
    return _live.isPassImmune(path, now);
  }

  void _bootstrapLocal() {
    final me = _myPath;
    if (me == null) return;
    final aliveIdx = _live.participantPaths.indexOf(me);
    final ghostIdx = _live.ghostPaths.indexOf(me);
    if (aliveIdx >= 0) {
      defaultRingPosition(
        index: aliveIdx,
        total: math.max(1, _live.participantPaths.length),
        out: (x, y) {
          _lx = x;
          _ly = y;
        },
      );
    } else if (ghostIdx >= 0) {
      defaultRingPosition(
        index: ghostIdx,
        total: math.max(1, _live.ghostPaths.length),
        out: (x, y) {
          _lx = x;
          _ly = y;
        },
      );
    }
    _syncer = HotPotatoPositionSyncer(
      roomRef: widget.roomRef,
      myPath: me,
      databaseUrl: widget.rtdbDatabaseUrl,
      onWriteRtt: _recordPing,
    );
  }

  /// Exponentially smoothed ping (alpha = 0.3) so the badge doesn't flicker
  /// across single-write spikes; we still react to a sustained change quickly.
  void _recordPing(Duration rtt) {
    if (!mounted) return;
    final ms = rtt.inMilliseconds.clamp(0, 5000);
    final prev = _pingMs;
    final smoothed = prev == null ? ms : (prev * 0.7 + ms * 0.3).round();
    _pingMs = smoothed;
    // Repaint only when the user-visible bucket changes (10 ms granularity).
    final bucket = (smoothed ~/ 10) * 10;
    if (_lastPaintedPingMs != bucket) {
      _lastPaintedPingMs = bucket;
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant _ArenaTickerScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.live.eliminationOrder.length >
        oldWidget.live.eliminationOrder.length) {
      HotPotatoSfx.playElimination();
    }
    _live = widget.live;
    _syncEdgeStateIfNeeded(_live);
    if (oldWidget.settings.edgeLocationHint !=
            widget.settings.edgeLocationHint &&
        _useEdge) {
      unawaited(_probeEdgeHttpOnce());
    }
    _offlineBotByPath.removeWhere(
      (k, _) => !_live.participantPaths.contains(k),
    );
    if (oldWidget.settings.offlineBotMode && !widget.settings.offlineBotMode) {
      _offlineBotByPath.clear();
    }
    if (oldWidget.rtdbDatabaseUrl != widget.rtdbDatabaseUrl && !_useEdge) {
      _bindRtdbSubscription();
      _bindPassStateSubscription();
      final me = _myPath;
      if (me != null) {
        _syncer = HotPotatoPositionSyncer(
          roomRef: widget.roomRef,
          myPath: me,
          databaseUrl: widget.rtdbDatabaseUrl,
          onWriteRtt: _recordPing,
        );
      }
    }
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _edgeHttpPingTimer?.cancel();
    _rtdbSub?.cancel();
    _passStateSub?.cancel();
    _edgeClient?.dispose();
    HotPotatoEdgePowerRelay.unregister(widget.roomRef.id);
    // Intentionally NOT clearing the edge holder hint on dispose — if the
    // arena closes right at round-end (e.g. results screen taking over) the
    // pending host elimination txn still needs the most recent edge holder.
    _voiceSession.dispose();
    unawaited(HotPotatoSfx.dispose());
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    final last = _lastElapsed;
    _lastElapsed = elapsed;
    var dt = last == null ? 0.016 : (elapsed - last).inMicroseconds / 1e6;
    if (dt <= 0 || !mounted) return;
    // Large gaps (debugger pause, tab switch) used to skip the whole tick and starve bot AI.
    if (dt > 0.12) dt = 0.05;

    final now = DateTime.now();
    final gateUi = _roundGateUi(now);
    if (gateUi.locked) {
      _lvx = 0;
      _lvy = 0;
      _throttle01 = 0.30;
      _lastInputDir = Offset.zero;
      _joystick = Offset.zero;
      _botSimAccumSec = 0;
      _edgeClient?.setRoundPaused(true);
      if (mounted) setState(() {});
      return;
    }
    _edgeClient?.setRoundPaused(false);

    final positions = _viewPositions();
    final holderPath = _effectiveHolderPath();
    // Keep round-end elimination targeting the actual edge holder, not the
    // (potentially lagged) Firestore mirror. Cleared on dispose.
    HotPotatoLiveFirestore.setEdgeHolderHint(_useEdge ? holderPath : null);

    // Bot sim + RTDB batch: legacy path only (edge uses DO authority).
    if (!_useEdge) {
      _botSimAccumSec += dt;
      if (_botSimAccumSec >= kHotPotatoBotSimPeriodSec) {
        _botSimAccumSec = 0;
        if (widget.isHost && !_botTickInFlight) {
          _botTickInFlight = true;
          final liveAtTick = _live;
          final positionsAtTick =
              Map<String, HotPotatoPositionData>.from(positions);
          final offlineLocalBots =
              widget.settings.offlineBotMode && widget.isHost;
          unawaited(() async {
            final swBot = Stopwatch()..start();
            try {
              await HotPotatoBotAutoplay.tick(
                roomRef: widget.roomRef,
                databaseUrl: widget.rtdbDatabaseUrl,
                live: liveAtTick,
                livePositions: positionsAtTick,
                holderPath: holderPath,
                isPassImmune: _isPassImmune,
                tickDeltaSec: kHotPotatoBotSimPeriodSec,
                onPass: (fromPath, toPath) async {
                  final ok = await HotPotatoRtdbPositions.attemptPass(
                    databaseUrl: widget.rtdbDatabaseUrl,
                    roomId: widget.roomRef.id,
                    holderPath: fromPath,
                    targetPath: toPath,
                  );
                  if (!ok || !mounted) return;
                  setState(() {
                    _holderPathRtdb = toPath;
                    _passImmuneUntilRtdb[fromPath] = DateTime.now().add(
                      HotPotatoLiveState.passImmunityWindow,
                    );
                  });
                },
                skipRtdbBotWrites: offlineLocalBots,
                onLocalBotBatch: offlineLocalBots
                    ? (batch) {
                        if (!mounted) return;
                        setState(() {
                          _offlineBotByPath.removeWhere(
                            (k, _) =>
                                !liveAtTick.participantPaths.contains(k),
                          );
                          for (final e in batch.entries) {
                            _offlineBotByPath[e.key] = HotPotatoPositionData(
                              x: e.value.x,
                              y: e.value.y,
                              vx: e.value.vx,
                              vy: e.value.vy,
                              speedUntil: e.value.speedUntil,
                              shieldUntil: e.value.shieldUntil,
                            );
                          }
                        });
                      }
                    : null,
              );
            } catch (_) {
              // Swallow transient errors so the arena keeps rendering.
            } finally {
              swBot.stop();
              HotPotatoDebugIngest.log(
                hypothesisId: 'H3_hostBatch',
                location: 'arena:bot_unawaited',
                message: 'bot_tick_finished',
                data: {
                  'elapsedMs': swBot.elapsedMilliseconds,
                  'botPeriodCfg': kHotPotatoBotSimPeriodSec,
                  'offlineBots': offlineLocalBots,
                },
              );
              _botTickInFlight = false;
            }
          }());
        }
      }

      _ghostBotDriftAccumSec += dt;
      if (_ghostBotDriftAccumSec >= 0.52 &&
          widget.isHost &&
          !_ghostBotDriftInFlight &&
          _live.ghostPaths.any((p) => p.startsWith('bot:'))) {
        _ghostBotDriftAccumSec = 0;
        _ghostBotDriftInFlight = true;
        final driftLive = _live;
        final driftPos = Map<String, HotPotatoPositionData>.from(positions);
        unawaited(() async {
          try {
            await HotPotatoBotAutoplay.tickGhostDrift(
              databaseUrl: widget.rtdbDatabaseUrl,
              roomId: widget.roomRef.id,
              ghostPaths: driftLive.ghostPaths,
              livePositions: driftPos,
            );
          } catch (_) {
            // ignore
          } finally {
            _ghostBotDriftInFlight = false;
          }
        }());
      }
    }

    final me = _myPath;
    final localGhost = _isLocalGhost(me);
    if (me == null || (!_live.participantPaths.contains(me) && !localGhost)) {
      if (mounted) setState(() {});
      return;
    }

    final posSelf = positions[me];
    final speedMult =
        (posSelf ?? const HotPotatoPositionData(x: 0, y: 0, vx: 0, vy: 0))
            .speedMultiplierAt(now);

    final ax = _joystick.dx / _joyRadius;
    final ay = _joystick.dy / _joyRadius;
    final inputMag = math.sqrt(ax * ax + ay * ay).clamp(0.0, 1.0);
    const ez = kHotPotatoArenaDirDeadzone;
    final dir =
        inputMag > ez ? Offset(ax / inputMag, ay / inputMag) : Offset.zero;
    if (inputMag > ez) {
      final hadDir = _lastInputDir.distanceSquared > 0.0001;
      final dot = hadDir
          ? (_lastInputDir.dx * dir.dx + _lastInputDir.dy * dir.dy)
          : 1.0;
      // (Movement haptic removed — users found the constant pulse buzzy.
      // Only pass and powerup actions now trigger vibration.)
      if (dot < -0.35) {
        // Opposite direction behaves like a traction/rubber-band loss.
        _throttle01 = (_throttle01 - dt * 0.85).clamp(0.30, 1.0);
      } else {
        // 30% -> 100% over roughly 2.3 seconds of steady push.
        _throttle01 = (_throttle01 + dt * (0.70 / 2.3)).clamp(0.30, 1.0);
      }
      _lastInputDir = dir;
    } else {
      _throttle01 = (_throttle01 - dt * 0.30).clamp(0.30, 1.0);
      _lastInputDir = Offset.zero;
    }

    hotPotatoArenaIntegrate(
      dirX: dir.dx,
      dirY: dir.dy,
      throttle01: _throttle01,
      dt: dt,
      speedMult: speedMult,
      ghostActive: localGhost,
      x: _lx,
      y: _ly,
      vx: _lvx,
      vy: _lvy,
      emit: (nx, ny, nvx, nvy) {
        _lx = nx;
        _ly = ny;
        _lvx = nvx;
        _lvy = nvy;
      },
    );

    Iterable<String> renderPaths() sync* {
      for (final p in _live.participantPaths) {
        yield p;
      }
      for (final p in _live.ghostPaths) {
        if (!_live.participantPaths.contains(p)) yield p;
      }
    }

    for (final path in renderPaths()) {
      if (path == me) continue;
      if (_useEdge) {
        final disp = _edgeClient?.displayPositions(excludePath: me)[path];
        if (disp != null) {
          _smoothRemote[path] = disp;
        }
        continue;
      }
      final p = positions[path];
      double tx = 0.5;
      double ty = 0.5;
      if (p != null) {
        // Display-only dead reckoning: brief extrapolation from last vx,vy.
        final lead = path.startsWith('bot:')
            ? kHotPotatoDeadReckonLeadSecBot
            : kHotPotatoDeadReckonLeadSec;
        tx = (p.x + p.vx * lead).clamp(0.04, 0.96);
        ty = (p.y + p.vy * lead).clamp(0.04, 0.96);
      } else {
        final aliveIdx = _live.participantPaths.indexOf(path);
        if (aliveIdx >= 0) {
          defaultRingPosition(
            index: aliveIdx,
            total: math.max(1, _live.participantPaths.length),
            out: (x, y) {
              tx = x;
              ty = y;
            },
          );
        } else {
          final gix = _live.ghostPaths.indexOf(path);
          defaultRingPosition(
            index: gix < 0 ? 0 : gix,
            total: math.max(1, _live.ghostPaths.length),
            out: (x, y) {
              tx = x;
              ty = y;
            },
          );
        }
      }
      final cur = _smoothRemote[path] ?? Offset(tx, ty);
      // #region agent log
      if (path.startsWith('bot:')) {
        final d = math.sqrt(
          math.pow(tx - cur.dx, 2) + math.pow(ty - cur.dy, 2),
        );
        if (d > _hpDbgMaxBotTargetDelta) {
          _hpDbgMaxBotTargetDelta = d;
        }
      }
      // #endregion
      final isBotPath = path.startsWith('bot:');
      smoothToward(
        dt: dt,
        targetX: tx,
        targetY: ty,
        currentX: cur.dx,
        currentY: cur.dy,
        stiffness: isBotPath
            ? kHotPotatoRemoteSmoothStiffnessBot
            : kHotPotatoRemoteSmoothStiffness,
        onUpdate: (nx, ny) => _smoothRemote[path] = Offset(nx, ny),
      );
    }

    if (!localGhost) {
      if (_useEdge) {
        // Local prediction owns the player position. Server snapshots arrive
        // ~150ms late at typical RTT — every blend toward them produces the
        // visible rubber-band/twitch. Only snap on catastrophic drift
        // (e.g. reconnect, teleport, or wall collision desync).
        final auth = _edgeClient?.authoritativePositions[me];
        if (auth != null) {
          final dx = auth.x - _lx;
          final dy = auth.y - _ly;
          final drift = math.sqrt(dx * dx + dy * dy);
          if (drift > 0.45) {
            _lx = auth.x;
            _ly = auth.y;
            _lvx = auth.vx;
            _lvy = auth.vy;
          }
        }
        _sendEdgeInputIfDue(now, dir.dx, dir.dy);
      }
      _maybeTag(me, now, positions, holderPath);
      _maybeClaimPickups(me);
    }

    final fsPos = positions[me];
    if (!_useEdge) {
      unawaited(() async {
        try {
          await _syncer?.pushIfNeeded(
            x: _lx,
            y: _ly,
            vx: _lvx,
            vy: _lvy,
            speedUntil: fsPos?.speedUntil,
            shieldUntil: fsPos?.shieldUntil,
          );
        } catch (_) {
          // Swallow transient Firestore errors so the arena keeps rendering.
        }
      }());
    }

    // #region agent log
    _hpDbgTick++;
    final wall = DateTime.now().millisecondsSinceEpoch;
    if (wall - _hpDbgLastWallLog > 450) {
      _hpDbgLastWallLog = wall;
      HotPotatoDebugIngest.log(
        hypothesisId: 'H1_smooth',
        location: 'arena:_onTick',
        message: 'arena_tick_summary',
        data: {
          'dt': dt,
          'isHost': widget.isHost,
          'botInFlight': _botTickInFlight,
          'botPeriodSec': kHotPotatoBotSimPeriodSec,
          'thrMovingMs': kHotPotatoPositionMinMsMoving,
          'maxBotTargetDelta': _hpDbgMaxBotTargetDelta,
          'pingMs': _pingMs,
          'tickIdx': _hpDbgTick,
        },
      );
      _hpDbgMaxBotTargetDelta = 0;
    }
    // #endregion

    setState(() {});
  }

  Future<void> _maybeTag(
    String me,
    DateTime now,
    Map<String, HotPotatoPositionData> positions,
    String holderPath,
  ) async {
    if (holderPath != me || holderPath.startsWith('bot:')) return;
    final last = _lastTagAttempt;
    if (last != null &&
        now.difference(last) < const Duration(milliseconds: 120)) {
      return;
    }

    // Use the player's locally-rendered position (what they see) for the
    // contact check. The server validates the tag with a wider tolerance
    // (HUMAN_TAG_TOLERANCE in bot-sim.ts) to absorb input/snapshot lag, so we
    // do not need to go through the delayed authoritative snapshot here.
    final myAx = _lx;
    final myAy = _ly;

    for (final path in _live.participantPaths) {
      if (path == me) continue;
      final op = positions[path];
      final shield = op?.isShieldedAt(now) ?? false;
      if (shield) continue;
      if ((op?.isGhostAt(now) ?? false) && path != me) continue;
      if (_isPassImmune(path, now)) continue;
      double ox = 0.5;
      double oy = 0.5;
      if (_useEdge) {
        final disp = _edgeClient?.displayPositions(excludePath: me)[path];
        if (disp != null) {
          ox = disp.dx;
          oy = disp.dy;
        } else {
          final authO = _edgeClient?.authoritativePositions[path];
          if (authO != null) {
            ox = authO.x;
            oy = authO.y;
          } else if (op != null) {
            ox = op.x;
            oy = op.y;
          }
        }
      } else if (op != null) {
        ox = op.x;
        oy = op.y;
      } else {
        final sm = _smoothRemote[path];
        if (sm != null) {
          ox = sm.dx;
          oy = sm.dy;
        } else {
          final idx = _live.participantPaths.indexOf(path);
          defaultRingPosition(
            index: idx < 0 ? 0 : idx,
            total: _live.participantPaths.length,
            out: (x, y) {
              ox = x;
              oy = y;
            },
          );
        }
      }
      if (HotPotatoLiveState.hasPassContact(
        ax: myAx,
        ay: myAy,
        bx: ox,
        by: oy,
      )) {
        _lastTagAttempt = now;
        HotPotatoHaptics.heavy();
        if (_useEdge) {
          _edgeClient?.sendTag(
            fromPath: me,
            targetPath: path,
            clientX: myAx,
            clientY: myAy,
            targetClientX: ox,
            targetClientY: oy,
          );
          return;
        }
        try {
          final ok = await HotPotatoRtdbPositions.attemptPass(
            databaseUrl: widget.rtdbDatabaseUrl,
            roomId: widget.roomRef.id,
            holderPath: me,
            targetPath: path,
          );
          if (ok && mounted) {
            HotPotatoSfx.playPass();
            setState(() {
              _holderPathRtdb = path;
              _passImmuneUntilRtdb[me] =
                  now.add(HotPotatoLiveState.passImmunityWindow);
            });
          }
        } catch (_) {
          // Swallow transient RTDB errors so the arena keeps rendering.
        }
        return;
      }
    }
  }

  Future<void> _maybeClaimPickups(String me) async {
    final pickups = _useEdge && _edgeClient?.edgePickups != null
        ? _edgeClient!.edgePickups!
        : _live.pickups;
    for (final p in pickups) {
      if (!p.isAvailable) continue;
      if (_pickupClaimInFlight.contains(p.id)) continue;
      // Distance is checked from BOTH local prediction and server-authoritative
      // self position so that whichever is closer wins. This avoids the case
      // where the player visually overlaps the pickup (local truth) but the
      // server snapshot is briefly behind, blocking the claim.
      final lx = _lx;
      final ly = _ly;
      final ax =
          _useEdge ? (_edgeClient?.authoritativePositions[me]?.x ?? lx) : lx;
      final ay =
          _useEdge ? (_edgeClient?.authoritativePositions[me]?.y ?? ly) : ly;
      final dLocal = math.sqrt((lx - p.x) * (lx - p.x) + (ly - p.y) * (ly - p.y));
      final dAuth = math.sqrt((ax - p.x) * (ax - p.x) + (ay - p.y) * (ay - p.y));
      // Tightened from 0.085 → 0.058 so the pickup only triggers when the
      // player visibly steps onto it (token radius ~0.03 + pickup radius
      // ~0.025 → contact at ~0.055).
      if (math.min(dLocal, dAuth) > 0.058) continue;
      _pickupClaimInFlight.add(p.id);
      if (_useEdge) {
        _edgeClient?.optimisticRemovePickup(p.id);
        _edgeClient?.claimPickup(
          pickupId: p.id,
          clientX: lx,
          clientY: ly,
        );
        HotPotatoSfx.playPickup();
        unawaited(
          Future<void>.delayed(const Duration(milliseconds: 250), () {
            if (mounted) _pickupClaimInFlight.remove(p.id);
          }),
        );
      } else {
        try {
          final ok = await HotPotatoLiveFirestore.claimPickup(
            widget.roomRef,
            p.id,
            me,
          );
          if (ok && mounted) HotPotatoSfx.playPickup();
        } catch (_) {
          // Swallow transient Firestore errors so the arena keeps rendering.
        } finally {
          if (mounted) _pickupClaimInFlight.remove(p.id);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final me = _myPath;
    if (me == null) {
      return Center(
        child: Text(
          'Sign in to move in the arena.',
          style: theme.bodyMedium,
        ),
      );
    }

    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (context, c) {
          final topInset = MediaQuery.paddingOf(context).top;
          final bottomInset = MediaQuery.paddingOf(context).bottom;
          final back = widget.onArenaBack;
          final exit = widget.onArenaExit;
          // 0..1 sinusoidal pulse derived from wall clock so it keeps animating
          // even if the ticker briefly stalls. Powers the holder glow + the
          // pass-immunity ring, mirroring the reference's `_protectionPulse`.
          final ms = DateTime.now().millisecondsSinceEpoch;
          final pulse = 0.5 + 0.5 * math.sin(ms * 2 * math.pi / 900);
          final viewPos = _viewPositions();
          final holderPath = _effectiveHolderPath();
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _ArenaPainter(
                    live: _live,
                    pickups: _effectivePickupsForPaint(),
                    room: widget.room,
                    settings: widget.settings,
                    myPath: me,
                    holderPath: holderPath,
                    passImmuneUntil: _passImmuneUntilRtdb,
                    localX: _lx,
                    localY: _ly,
                    positions: viewPos,
                    smoothRemote: _smoothRemote,
                    ghostPaths: _live.ghostPaths,
                    theme: theme,
                    pulse: pulse,
                  ),
                ),
              ),
              if (back != null)
                Positioned(
                  left: 6,
                  top: topInset + 6,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: back,
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                                color: theme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      _PingBadge(
                        pingMs: _pingMs,
                        rtdbRegionLabel: _useEdge
                            ? hotPotatoEdgeHudLabel(
                                widget.settings.edgeLocationHint ?? 'edge',
                              )
                            : hotPotatoRtdbHudRegionLabel(
                                widget.rtdbDatabaseUrl,
                              ),
                      ),
                      const SizedBox(width: 2),
                      HotPotatoVoiceHud(
                        session: _voiceSession,
                        roomId: widget.roomRef.id,
                        participantPath: me,
                        iconColor: theme.primary,
                      ),
                    ],
                  ),
                ),
              if (kDebugMode && back != null)
                Positioned(
                  left: 6,
                  top: topInset + 40,
                  child: IgnorePointer(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Colors.amber.shade700, width: 0.5),
                      ),
                      child: Text(
                        'HP dbg: RTT=${_pingMs ?? "—"}ms '
                        '· thr=${kHotPotatoPositionMinMsMoving}ms '
                        '· bot=${kHotPotatoBotSimPeriodSec.toStringAsFixed(2)}s '
                        '· smooth=${kHotPotatoRemoteSmoothStiffness.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 9,
                          height: 1.1,
                          color: Colors.brown.shade900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              if (exit != null)
                Positioned(
                  right: 6,
                  top: topInset + 6,
                  child: Opacity(
                    opacity: 0.5,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: exit,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Icons.logout_rounded,
                            size: 20,
                            color: theme.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                right: 36,
                top: topInset + 2,
                child: _ArenaHud(
                  round: _live.round,
                  totalRounds: _live.totalRounds,
                  playersAlive: _live.participantPaths.length,
                  playersInitial: _live.participantPaths.length +
                      _live.eliminationOrder.length,
                ),
              ),
              Positioned(
                left: 24,
                bottom: bottomInset + 28,
                child: _DPadJoystick(
                  radius: _joyRadius,
                  knob: _joystick,
                  onChanged: (o) => setState(() => _joystick = o),
                ),
              ),
              if (_rejectionBanner != null &&
                  DateTime.now().isBefore(_rejectionBanner!.until))
                Positioned(
                  top: topInset + 64,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.80),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _rejectionBanner!.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              () {
                final gate = _roundGateUi(DateTime.now());
                if (!gate.locked) return const SizedBox.shrink();
                return Positioned.fill(
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.30),
                      alignment: Alignment.center,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 320),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color:
                              theme.primaryBackground.withValues(alpha: 0.96),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.alternate,
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              gate.title,
                              textAlign: TextAlign.center,
                              style: theme.titleLarge.override(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (gate.subtitle.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                gate.subtitle,
                                textAlign: TextAlign.center,
                                style: theme.bodySmall.override(
                                  color: theme.secondaryText,
                                ),
                              ),
                            ],
                            if (gate.countdown != null) ...[
                              const SizedBox(height: 10),
                              Text(
                                '${gate.countdown}',
                                style: theme.displaySmall.override(
                                  fontWeight: FontWeight.w800,
                                  color: theme.error,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }(),
            ],
          );
        },
      ),
    );
  }
}

class _RejectionBanner {
  const _RejectionBanner({
    required this.action,
    required this.reason,
    required this.until,
  });
  final String action;
  final String reason;
  final DateTime until;
  String get label {
    final friendly = switch (action) {
      'tag' => 'Pass failed',
      'pickup' => 'Pickup failed',
      'power' => 'Powerup failed',
      _ => 'Action failed',
    };
    return reason.isEmpty ? friendly : '$friendly — $reason';
  }
}

class _RoundGateUi {
  const _RoundGateUi({
    required this.locked,
    required this.title,
    required this.subtitle,
    this.countdown,
  });

  const _RoundGateUi.unlocked()
      : locked = false,
        title = '',
        subtitle = '',
        countdown = null;

  final bool locked;
  final String title;
  final String subtitle;
  final int? countdown;
}

/// Tiny pill next to the arena back button: **RTDB region** (EU / SG / US) and
/// smoothed write **RTT** (ms). Color follows RTT thresholds:
///   * green  &lt; 80ms — feels great
///   * amber 80-160ms — playable, occasional snap
///   * red   &gt;= 160ms — high latency, expect bot/movement choppiness
class _PingBadge extends StatelessWidget {
  const _PingBadge({
    required this.pingMs,
    required this.rtdbRegionLabel,
  });

  final int? pingMs;
  final String rtdbRegionLabel;

  Color _color() {
    final p = pingMs;
    if (p == null) return const Color(0xFF7F8C8D);
    if (p < 80) return const Color(0xFF27AE60); // success
    if (p < 160) return const Color(0xFFF39C12); // warning
    return const Color(0xFFE74C3C); // error
  }

  @override
  Widget build(BuildContext context) {
    final color = _color();
    final pingPart = pingMs == null ? '— ms' : '$pingMs ms';
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.7), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 5),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$rtdbRegionLabel · ',
                    style: TextStyle(
                      color: const Color(0xFF2C3E50).withValues(alpha: 0.78),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  TextSpan(
                    text: pingPart,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArenaHud extends StatelessWidget {
  const _ArenaHud({
    required this.round,
    required this.totalRounds,
    required this.playersAlive,
    required this.playersInitial,
  });

  final int round;
  final int totalRounds;
  final int playersAlive;
  final int playersInitial;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    Widget cell(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.labelSmall.override(
                color: theme.secondaryText,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: theme.titleSmall.override(
                color: theme.error,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    final divider = Container(
      width: 1,
      height: 28,
      color: theme.alternate,
    );

    return Material(
      color: theme.primaryBackground.withValues(alpha: 0.95),
      borderRadius: BorderRadius.circular(14),
      elevation: 2,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            cell('Round', '$round/$totalRounds'),
            divider,
            cell('Player',
                '$playersAlive/${playersInitial == 0 ? playersAlive : playersInitial}'),
          ],
        ),
      ),
    );
  }
}

/// DPad-style joystick: outer circle with up/down/left/right chevrons; the white knob
/// in the center moves with the drag. The whole control is roughly half-opaque so it
/// blends into the arena, but each chevron stays readable.
class _DPadJoystick extends StatelessWidget {
  const _DPadJoystick({
    required this.radius,
    required this.knob,
    required this.onChanged,
  });

  final double radius;
  final Offset knob;
  final ValueChanged<Offset> onChanged;

  static const double _pad = 12;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final size = radius * 2 + _pad * 2;
    final chevColor = theme.secondaryText.withValues(alpha: 0.7);
    return SizedBox(
      width: size,
      height: size,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (d) {
          final o = d.localPosition - Offset(size / 2, size / 2);
          final m = o.distance;
          final c =
              m > radius ? Offset(o.dx * radius / m, o.dy * radius / m) : o;
          onChanged(c);
        },
        onPanUpdate: (d) {
          final o = d.localPosition - Offset(size / 2, size / 2);
          final m = o.distance;
          final c =
              m > radius ? Offset(o.dx * radius / m, o.dy * radius / m) : o;
          onChanged(c);
        },
        onPanEnd: (_) => onChanged(Offset.zero),
        onPanCancel: () => onChanged(Offset.zero),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring (subtle background).
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.55),
                border: Border.all(
                  color: theme.alternate.withValues(alpha: 0.6),
                  width: 1.2,
                ),
                boxShadow: const [
                  BoxShadow(blurRadius: 10, color: Color(0x14000000)),
                ],
              ),
            ),
            // Chevrons.
            Positioned(
              top: 8,
              child: Icon(Icons.keyboard_arrow_up_rounded,
                  color: chevColor, size: 22),
            ),
            Positioned(
              bottom: 8,
              child: Icon(Icons.keyboard_arrow_down_rounded,
                  color: chevColor, size: 22),
            ),
            Positioned(
              left: 8,
              child: Icon(Icons.keyboard_arrow_left_rounded,
                  color: chevColor, size: 22),
            ),
            Positioned(
              right: 8,
              child: Icon(Icons.keyboard_arrow_right_rounded,
                  color: chevColor, size: 22),
            ),
            // Knob.
            Transform.translate(
              offset: knob,
              child: Container(
                width: radius * 0.9,
                height: radius * 0.9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: theme.alternate,
                    width: 1.2,
                  ),
                  boxShadow: const [
                    BoxShadow(blurRadius: 6, color: Color(0x22000000)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArenaPainter extends CustomPainter {
  _ArenaPainter({
    required this.live,
    required this.pickups,
    required this.room,
    required this.settings,
    required this.myPath,
    required this.holderPath,
    required this.passImmuneUntil,
    required this.localX,
    required this.localY,
    required this.positions,
    required this.smoothRemote,
    required this.ghostPaths,
    required this.theme,
    required this.pulse,
  });

  final HotPotatoLiveState live;
  final List<HotPotatoPickupItem> pickups;
  final RoomRecord room;
  final HotPotatoFirestoreSettings settings;
  final String myPath;
  final String holderPath;
  final Map<String, DateTime> passImmuneUntil;
  final double localX;
  final double localY;
  final Map<String, HotPotatoPositionData> positions;
  final Map<String, Offset> smoothRemote;
  final List<String> ghostPaths;
  final FlutterFlowTheme theme;

  /// 0..1 oscillating value driven by the arena ticker. Used for the
  /// pass-immunity ring around players in their 3-second escape window.
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(18));
    canvas.drawRRect(rrect, Paint()..color = theme.primaryBackground);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = theme.alternate.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    const step = 40.0;
    final grid = Paint()
      ..color = theme.secondaryText.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (var y = 0.0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final now = DateTime.now();

    // Banana AoE flash: when someone uses Banana, briefly draw a yellow ring
    // around their last-known position so observers see who triggered it.
    final bananaAt = live.lastPowerupAt;
    if (live.lastPowerup == 'Banana' &&
        bananaAt != null &&
        now.difference(bananaAt).inMilliseconds <= 800 &&
        live.lastPowerupX != null &&
        live.lastPowerupY != null) {
      final cx = live.lastPowerupX!.clamp(0.0, 1.0) * size.width;
      final cy = live.lastPowerupY!.clamp(0.0, 1.0) * size.height;
      final t = (now.difference(bananaAt).inMilliseconds / 800.0)
          .clamp(0.0, 1.0);
      final radius = 60.0 + 28.0 * t;
      canvas.drawCircle(
        Offset(cx, cy),
        radius,
        Paint()
          ..color = const Color(0xFFF1C40F).withValues(alpha: 0.22 * (1.0 - t))
          ..style = PaintingStyle.fill,
      );
      canvas.drawCircle(
        Offset(cx, cy),
        radius,
        Paint()
          ..color = const Color(0xFFF1C40F).withValues(alpha: 0.85 * (1.0 - t))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0,
      );
    }

    void drawPill({
      required double cx,
      required double cy,
      required String text,
      required Color bg,
      required Color textColor,
      double dy = 0,
      double fontSize = 10,
      FontWeight weight = FontWeight.w700,
    }) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: weight,
            color: textColor,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: 96);
      final pillRect = Rect.fromCenter(
        center: Offset(cx, cy + dy),
        width: tp.width + 14,
        height: tp.height + 6,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(pillRect, const Radius.circular(10)),
        Paint()..color = bg,
      );
      tp.paint(
        canvas,
        Offset(pillRect.center.dx - tp.width / 2,
            pillRect.center.dy - tp.height / 2),
      );
    }

    void drawToken({
      required double nx,
      required double ny,
      required String name,
      required String emoji,
      required bool holder,
      required bool isMe,
      required bool shield,
      required bool speed,
      required bool slowed,
      required bool passImmune,
      required bool ghost,
    }) {
      final cx = nx * size.width;
      final cy = ny * size.height;
      // Self-ghost is significantly more transparent than "you can see it but
      // others can't" — players were missing the activation feedback.
      final ghostAlpha = ghost ? (isMe ? 0.30 : 0.55) : 1.0;

      // Pass-immunity ring (3-second buffer after passing the bomb). Pulsing
      // teal ring inspired by the reference implementation's protection glow,
      // but drawn here on the canvas so it stays in sync with token motion.
      if (passImmune && !ghost) {
        final r = 30.0 + 6.0 * pulse;
        canvas.drawCircle(
          Offset(cx, cy),
          r,
          Paint()
            ..color =
                const Color(0xFF5BB5B5).withValues(alpha: 0.55 + 0.25 * pulse)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3,
        );
      }
      void activeRing(Color color, double baseRadius) {
        canvas.drawCircle(
          Offset(cx, cy),
          baseRadius + 5 * pulse,
          Paint()
            ..color = color.withValues(alpha: 0.58 + 0.25 * pulse)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3,
        );
      }
      if (!ghost && speed) {
        activeRing(const Color(0xFFE74C3C), 37);
      }
      if (!ghost && slowed) {
        activeRing(const Color(0xFFF1C40F), 41);
      }
      if (shield && !ghost) {
        canvas.drawCircle(
          Offset(cx, cy),
          32,
          Paint()
            ..color = Colors.blue.withValues(alpha: 0.22)
            ..style = PaintingStyle.fill,
        );
      }
      if (holder && !ghost) {
        // Pulse the holder's red glow so the bomb is unmistakable on screen.
        canvas.drawCircle(
          Offset(cx, cy),
          34 + 4 * pulse,
          Paint()
            ..color = theme.error.withValues(alpha: 0.30 + 0.15 * pulse)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
        );
      }
      canvas.drawCircle(
        Offset(cx, cy),
        24,
        Paint()
          ..color = theme.secondaryBackground.withValues(alpha: ghostAlpha),
      );
      canvas.drawCircle(
        Offset(cx, cy),
        24,
        Paint()
          ..color =
              (holder ? theme.error : (isMe ? theme.primary : theme.alternate))
                  .withValues(alpha: ghost ? 0.45 : 1.0)
          ..style = PaintingStyle.stroke
          ..strokeWidth = holder ? 3 : (isMe ? 2 : 1.2),
      );
      final glyph = TextPainter(
        text: TextSpan(text: emoji, style: const TextStyle(fontSize: 26)),
        textDirection: TextDirection.ltr,
      )..layout();
      glyph.paint(canvas, Offset(cx - glyph.width / 2, cy - glyph.height / 2));

      if (holder && !ghost) {
        drawPill(
          cx: cx,
          cy: cy,
          dy: -38,
          text: 'Pass it!',
          bg: theme.error,
          textColor: Colors.white,
          fontSize: 10,
        );
      }
      drawPill(
        cx: cx,
        cy: cy,
        dy: 34,
        text: ghost ? 'Ghost' : name,
        bg: theme.secondaryBackground.withValues(alpha: ghost ? 0.75 : 0.95),
        textColor: theme.primaryText.withValues(alpha: ghost ? 0.65 : 1.0),
        fontSize: 10,
        weight: FontWeight.w600,
      );
      if (isMe) {
        drawPill(
          cx: cx,
          cy: cy,
          dy: 50,
          text: ghost ? 'You (ghost)' : 'You',
          bg: theme.primary,
          textColor: Colors.white,
          fontSize: 9,
        );
        if (ghost) {
          drawPill(
            cx: cx,
            cy: cy,
            dy: -38,
            text: '👻 GHOST',
            bg: const Color(0xFF9B59B6),
            textColor: Colors.white,
            fontSize: 10,
          );
        }
      }
    }

    for (final path in live.participantPaths) {
      final name = hotPotatoPathLabelForRoom(path, room, settings);
      final emoji = hotPotatoPathAvatarEmoji(path, settings, room);
      final holder = path == holderPath;
      final isMe = path == myPath;
      // Effects (shield) follow the raw RTDB record, but rendered position
      // uses [smoothRemote] which interpolates 60fps toward the latest write.
      // The previous version drew straight from [op], which made bots/players
      // teleport every ~220 ms (the host's bot tick interval). On Android
      // builds the snap was very visible.
      final op = positions[path];
      if ((op?.isGhostAt(now) ?? false) && !isMe) {
        continue;
      }
      final shield = op?.isShieldedAt(now) ?? false;
      final speed = op?.speedUntil != null && now.isBefore(op!.speedUntil!);
      final slowed = op?.slowUntil != null && now.isBefore(op!.slowUntil!);
      final activeGhost = op?.isGhostAt(now) ?? false;
      final passImmune = (passImmuneUntil[path]?.isAfter(now) ?? false) ||
          live.isPassImmune(path, now);
      double nx = 0.5;
      double ny = 0.5;
      if (isMe) {
        nx = localX;
        ny = localY;
      } else {
        final sm = smoothRemote[path];
        if (sm != null) {
          nx = sm.dx;
          ny = sm.dy;
        } else if (op != null) {
          nx = op.x;
          ny = op.y;
        } else {
          final idx = live.participantPaths.indexOf(path);
          defaultRingPosition(
            index: idx < 0 ? 0 : idx,
            total: live.participantPaths.length,
            out: (x, y) {
              nx = x;
              ny = y;
            },
          );
        }
      }
      drawToken(
        nx: nx,
        ny: ny,
        name: name,
        emoji: emoji,
        holder: holder,
        isMe: isMe,
        shield: shield,
        speed: speed,
        slowed: slowed,
        passImmune: passImmune,
        ghost: isMe && activeGhost,
      );
    }

    for (final path in ghostPaths) {
      if (live.participantPaths.contains(path)) continue;
      final name = hotPotatoPathLabelForRoom(path, room, settings);
      final emoji = hotPotatoPathAvatarEmoji(path, settings, room);
      final isMe = path == myPath;
      final op = positions[path];
      final shield = op?.isShieldedAt(now) ?? false;
      final speed = op?.speedUntil != null && now.isBefore(op!.speedUntil!);
      final slowed = op?.slowUntil != null && now.isBefore(op!.slowUntil!);
      final passImmune = (passImmuneUntil[path]?.isAfter(now) ?? false) ||
          live.isPassImmune(path, now);
      double nx = 0.5;
      double ny = 0.5;
      if (isMe) {
        nx = localX;
        ny = localY;
      } else {
        final sm = smoothRemote[path];
        if (sm != null) {
          nx = sm.dx;
          ny = sm.dy;
        } else if (op != null) {
          nx = op.x;
          ny = op.y;
        } else {
          final gix = ghostPaths.indexOf(path);
          defaultRingPosition(
            index: gix < 0 ? 0 : gix,
            total: math.max(1, ghostPaths.length),
            out: (x, y) {
              nx = x;
              ny = y;
            },
          );
        }
      }
      drawToken(
        nx: nx,
        ny: ny,
        name: name,
        emoji: emoji,
        holder: false,
        isMe: isMe,
        shield: shield,
        speed: speed,
        slowed: slowed,
        passImmune: passImmune,
        ghost: true,
      );
    }

    String pickupEmoji(String kind) {
      switch (kind) {
        case 'Shield':
          return '🛡️';
        case 'Speed':
          return '⚡';
        case 'Ghost':
        case 'Unseen':
          return '👻';
        case 'Banana':
        case 'BananaTrap':
          return '🍌';
        default:
          return '🎁';
      }
    }

    for (final pu in pickups) {
      if (!pu.isAvailable) continue;
      final cx = pu.x * size.width;
      final cy = pu.y * size.height;
      final kind = pu.kind == 'Unseen' ? 'Ghost' : pu.kind;
      final color = switch (kind) {
        'Shield' => const Color(0xFFF39C12),
        'Banana' || 'BananaTrap' => const Color(0xFFF1C40F),
        'Ghost' => const Color(0xFF9B59B6),
        _ => const Color(0xFFE74C3C),
      };
      final pr = 17.0 + pulse * 3.5;
      final haloR = pr + 5 + pulse * 6;
      canvas.drawCircle(
        Offset(cx, cy),
        haloR,
        Paint()..color = color.withValues(alpha: 0.18 + pulse * 0.12),
      );
      canvas.drawCircle(
        Offset(cx, cy),
        pr,
        Paint()..color = color.withValues(alpha: 0.9),
      );
      canvas.drawCircle(
        Offset(cx, cy),
        pr,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.65)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2,
      );
      final itp = TextPainter(
        text: TextSpan(
          text: pickupEmoji(pu.kind),
          style: const TextStyle(
            fontSize: 20,
            height: 1.0,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 44);
      itp.paint(canvas, Offset(cx - itp.width / 2, cy - itp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _ArenaPainter oldDelegate) => true;
}
