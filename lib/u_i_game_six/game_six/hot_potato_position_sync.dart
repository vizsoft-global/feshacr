import 'dart:math' as math;

import '/backend/backend.dart';
import '/u_i_game_six/game_six/hot_potato_latency_config.dart';
import '/u_i_game_six/game_six/hot_potato_positions_rtdb.dart';

/// Throttles position writes (now sent to Realtime Database) and smooths remote
/// player positions for rendering. Positions live in RTDB so they don't fight
/// Firestore's per-doc write cap; everything else (holder, inventory, results)
/// still goes through Firestore.
class HotPotatoPositionSyncer {
  HotPotatoPositionSyncer({
    required this.roomRef,
    required this.myPath,
    required this.databaseUrl,
    this.onWriteRtt,
  }) : roomId = roomRef.id;

  final DocumentReference roomRef;
  final String roomId;
  final String myPath;
  final String databaseUrl;

  /// Optional ping callback. Receives the elapsed time of every successful
  /// RTDB write — the firebase_database SDK awaits server-ack, so this is a
  /// useful proxy for "round trip to RTDB region (Belgium for this app)".
  /// Errors do not invoke the callback so the displayed ping is only ever
  /// real, not a fake high value from a transient failure.
  final void Function(Duration rtt)? onWriteRtt;

  DateTime? _lastSend;
  double _lastSentX = 0.5;
  double _lastSentY = 0.5;
  double _lastSentVx = 0;
  double _lastSentVy = 0;

  /// ~6 Hz when moving, ~1 Hz when idle (see [kHotPotatoPositionMinMsMoving]).
  Future<void> pushIfNeeded({
    required double x,
    required double y,
    required double vx,
    required double vy,
    DateTime? speedUntil,
    DateTime? shieldUntil,
    bool clearSpeed = false,
    bool clearShield = false,
  }) async {
    final now = DateTime.now();
    final dx = (x - _lastSentX).abs();
    final dy = (y - _lastSentY).abs();
    final dvx = (vx - _lastSentVx).abs();
    final dvy = (vy - _lastSentVy).abs();
    final moving = dx > 0.006 || dy > 0.006 || dvx > 0.03 || dvy > 0.03;

    final minMs =
        moving ? kHotPotatoPositionMinMsMoving : kHotPotatoPositionMinMsIdle;
    if (_lastSend != null &&
        now.difference(_lastSend!).inMilliseconds < minMs) {
      return;
    }

    _lastSend = now;
    _lastSentX = x;
    _lastSentY = y;
    _lastSentVx = vx;
    _lastSentVy = vy;

    final start = DateTime.now();
    try {
      await HotPotatoRtdbPositions.writePosition(
        databaseUrl: databaseUrl,
        roomId: roomId,
        path: myPath,
        x: x.clamp(0.0, 1.0),
        y: y.clamp(0.0, 1.0),
        vx: vx,
        vy: vy,
        speedUntil: speedUntil,
        shieldUntil: shieldUntil,
        clearSpeed: clearSpeed,
        clearShield: clearShield,
      );
      final cb = onWriteRtt;
      if (cb != null) {
        cb(DateTime.now().difference(start));
      }
    } catch (_) {
      // Swallow — the inner writePosition already swallows transient errors.
    }
  }
}

/// Smoothed [x],[y] toward Firestore snapshot each frame.
void smoothToward({
  required double dt,
  required double targetX,
  required double targetY,
  required double currentX,
  required double currentY,
  required void Function(double x, double y) onUpdate,
  double stiffness = 14,
}) {
  final t = (stiffness * dt).clamp(0.0, 1.0);
  final nx = currentX + (targetX - currentX) * t;
  final ny = currentY + (targetY - currentY) * t;
  onUpdate(nx, ny);
}

/// Default ring layout when a participant has no [HotPotatoLiveState.positions] entry yet.
void defaultRingPosition({
  required int index,
  required int total,
  required void Function(double x, double y) out,
}) {
  if (total <= 0) {
    out(0.5, 0.5);
    return;
  }
  final angle = -math.pi / 2 + (index * 2 * math.pi / total);
  out(0.5 + 0.32 * math.cos(angle), 0.5 + 0.28 * math.sin(angle));
}
