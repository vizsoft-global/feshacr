import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/u_i_game_six/game_six/hot_potato_live.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'hotpotatotimer_model.dart';
export 'hotpotatotimer_model.dart';

/// Round HUD: countdown from shared `hot_potato_live.round_started_at` + duration; host advances rounds.
class HotpotatotimerWidget extends StatefulWidget {
  const HotpotatotimerWidget({
    super.key,
    required this.roomRef,
    required this.live,
    required this.isHost,
    required this.fallbackRoundDuration,
    this.hideVisual = false,
  });

  final DocumentReference roomRef;
  final HotPotatoLiveState? live;
  final bool isHost;
  final Duration fallbackRoundDuration;

  /// When true, no UI is shown but the periodic host tick still runs.
  final bool hideVisual;

  @override
  State<HotpotatotimerWidget> createState() => _HotpotatotimerWidgetState();
}

class _HotpotatotimerWidgetState extends State<HotpotatotimerWidget> {
  late HotpotatotimerModel _model;
  Timer? _timer;
  int? _lastRenderedSecondsLeft;
  /// Last time we invoked [HotPotatoLiveFirestore.hostAdvanceRoundIfExpired] while
  /// the round was already past [HotPotatoLiveState.effectiveRoundEnd]. Throttled
  /// so we do not spam Firestore, but **retries** if the first txn no-ops (fixes
  /// rounds that never end).
  DateTime? _lastExpireAdvanceAt;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotpotatotimerModel());
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void didUpdateWidget(covariant HotpotatotimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.live?.round != widget.live?.round ||
        oldWidget.live?.matchComplete != widget.live?.matchComplete ||
        oldWidget.live?.roundStartedAt != widget.live?.roundStartedAt) {
      _lastRenderedSecondsLeft = null;
      _lastExpireAdvanceAt = null;
    }
  }

  void _tick() {
    if (!mounted) return;
    final live = widget.live;
    int? secondsForRender;
    if (live != null && !live.matchComplete) {
      final end = live.effectiveRoundEnd;
      if (end != null) {
        secondsForRender = end.difference(DateTime.now()).inSeconds;
      }
    }
    if (secondsForRender != _lastRenderedSecondsLeft) {
      _lastRenderedSecondsLeft = secondsForRender;
      safeSetState(() {});
    }

    if (live == null || live.matchComplete) return;

    // While there is plenty of time left, clear the expire-retry clock.
    if (secondsForRender != null && secondsForRender > 3) {
      _lastExpireAdvanceAt = null;
    }

    final end = live.effectiveRoundEnd;
    if (end == null) return;

    final secondsLeft = end.difference(DateTime.now()).inSeconds;
    if (secondsLeft > 0) {
      _lastExpireAdvanceAt = null;
      return;
    }

    // Past round end: retry advance periodically until Firestore moves to the
    // next round (first attempt can lose a txn race or miss a transient read).
    final now = DateTime.now();
    if (_lastExpireAdvanceAt != null &&
        now.difference(_lastExpireAdvanceAt!).inMilliseconds < 1200) {
      return;
    }
    _lastExpireAdvanceAt = now;
    unawaited(HotPotatoLiveFirestore.hostAdvanceRoundIfExpired(widget.roomRef));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _model.maybeDispose();
    super.dispose();
  }

  String _formatMmSs(int totalSeconds) {
    final s = totalSeconds.clamp(0, 86400);
    final m = s ~/ 60;
    final r = s % 60;
    return '${m.toString().padLeft(2, '0')}:${r.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hideVisual) {
      return const SizedBox.shrink();
    }
    final theme = FlutterFlowTheme.of(context);
    final live = widget.live;

    if (live == null) {
      return Material(
        color: theme.primaryBackground,
        elevation: 1,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Connecting to match… If this persists, return to settings and start again.',
                  style: theme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (live.matchComplete) {
      return Material(
        color: theme.primaryBackground,
        elevation: 1,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Round ${live.round} / ${live.totalRounds}',
                style: theme.titleSmall.override(fontWeight: FontWeight.w600),
              ),
              Text(
                'Match complete',
                style: theme.labelLarge.override(color: theme.primary),
              ),
            ],
          ),
        ),
      );
    }

    final end = live.effectiveRoundEnd;
    int secondsLeft;
    if (end != null) {
      secondsLeft = end.difference(DateTime.now()).inSeconds;
    } else {
      secondsLeft = widget.fallbackRoundDuration.inSeconds;
    }

    String subtitle;
    if (live.roundStartedAt == null) {
      subtitle = 'Syncing server clock…';
    } else {
      subtitle = widget.isHost
          ? 'You are the room host — round timing stays in sync for everyone.'
          : 'Timer synced from the room.';
    }

    if (live.lastPowerup != null && live.lastPowerup!.isNotEmpty) {
      subtitle =
          '$subtitle · Last power-up: ${live.lastPowerup}';
    }

    return Material(
      color: theme.primaryBackground,
      elevation: 1,
      shadowColor: Colors.black12,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Round ${live.round} / ${live.totalRounds}',
                  style: theme.titleSmall.override(fontWeight: FontWeight.w600),
                ),
                Text(
                  _formatMmSs(secondsLeft),
                  style: theme.headlineSmall.override(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: theme.labelSmall.override(color: theme.secondaryText),
            ),
          ],
        ),
      ),
    );
  }
}
