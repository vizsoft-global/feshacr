/// Hot Potato realtime tuning (latency plan — RTDB path).
library hot_potato_latency_config;

import 'dart:math' as math;

/// Durable Object sim + client local prediction use the same arena integrator.
/// Keep numeric values aligned with `workers/hot-potato-room/src/bot-sim.ts`.
const double kHotPotatoArenaBaseAccel = 2.4;
const double kHotPotatoArenaFriction = 0.90;
const double kHotPotatoArenaMaxSpeed = 0.42;
const double kHotPotatoArenaGhostSpeedFactor = 0.82;
const double kHotPotatoArenaSpeedPowerMult = 1.5;
const double kHotPotatoArenaDirDeadzone = 0.02;

/// Single physics step: accel → friction → speed cap (with [speedMult] only
/// from powerups) → position clamp → kill velocity into walls (reduces edge jitter).
void hotPotatoArenaIntegrate({
  required double dirX,
  required double dirY,
  required double throttle01,
  required double dt,
  required double speedMult,
  required bool ghostActive,
  required double x,
  required double y,
  required double vx,
  required double vy,
  required void Function(double nx, double ny, double nvx, double nvy) emit,
}) {
  final mag = math.sqrt(dirX * dirX + dirY * dirY);
  final inputMag = mag.clamp(0.0, 1.0);
  const ez = kHotPotatoArenaDirDeadzone;
  final ux = inputMag > ez ? dirX / math.max(0.001, mag) : 0.0;
  final uy = inputMag > ez ? dirY / math.max(0.001, mag) : 0.0;
  final accelScale = (0.30 + 0.70 * throttle01) * inputMag;
  var nvx = vx + ux * kHotPotatoArenaBaseAccel * dt * speedMult * accelScale;
  var nvy = vy + uy * kHotPotatoArenaBaseAccel * dt * speedMult * accelScale;
  final f = math.pow(kHotPotatoArenaFriction, dt * 60).toDouble();
  nvx *= f;
  nvy *= f;
  final maxBase = ghostActive
      ? kHotPotatoArenaMaxSpeed * kHotPotatoArenaGhostSpeedFactor
      : kHotPotatoArenaMaxSpeed;
  final cap = maxBase * speedMult;
  nvx = nvx.clamp(-cap, cap);
  nvy = nvy.clamp(-cap, cap);
  var nx = (x + nvx * dt).clamp(0.04, 0.96);
  var ny = (y + nvy * dt).clamp(0.04, 0.96);
  const eps = 0.003;
  if (nx <= 0.04 + eps && nvx < 0) nvx = 0;
  if (nx >= 0.96 - eps && nvx > 0) nvx = 0;
  if (ny <= 0.04 + eps && nvy < 0) nvy = 0;
  if (ny >= 0.96 - eps && nvy > 0) nvy = 0;
  emit(nx, ny, nvx, nvy);
}

/// Minimum milliseconds between RTDB position writes while the token is moving.
const int kHotPotatoPositionMinMsMoving = 42;

/// Minimum milliseconds between writes when nearly idle.
const int kHotPotatoPositionMinMsIdle = 450;

/// Host bot simulation / batched RTDB write cadence. Kept **faster** than
/// [kHotPotatoPositionMinMsMoving] so bot snapshots arrive often enough for
/// interpolation to look human-like; still one batched `update()` per tick.
const double kHotPotatoBotSimPeriodSec = 0.03;

/// [smoothToward] stiffness for remote human tokens.
const double kHotPotatoRemoteSmoothStiffness = 40;

/// Slightly stiffer follow for `bot:` paths — they only move on discrete host ticks.
const double kHotPotatoRemoteSmoothStiffnessBot = 40;

/// Display-only extrapolation for remotes: lead time × velocity before smoothing.
const double kHotPotatoDeadReckonLeadSec = 0.06;

/// Extra lead for bot tokens so motion stays fluid between sparse-ish snapshots.
const double kHotPotatoDeadReckonLeadSecBot = 0.03;

/// Low-pass on reported bot velocity (0 = snap, 1 = ignore new).
const double kHotPotatoBotVelocityBlend = 0.74;

/// Interpolation delay for edge DO snapshots (ms behind server time).
const int kHotPotatoEdgeBufferDelayMs = 110;

/// Minimum ms between edge input messages while moving.
const int kHotPotatoEdgeInputMinMsMoving = 42;

/// Minimum ms between edge input messages when idle.
const int kHotPotatoEdgeInputMinMsIdle = 450;
