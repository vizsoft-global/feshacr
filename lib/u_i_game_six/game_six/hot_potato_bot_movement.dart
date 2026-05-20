import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show Offset;

import '/backend/backend.dart';
import '/u_i_game_six/game_six/hot_potato_latency_config.dart';
import '/u_i_game_six/game_six/hot_potato_live.dart';
import '/u_i_game_six/game_six/hot_potato_position_sync.dart';
import '/u_i_game_six/game_six/hot_potato_positions_rtdb.dart';

/// Autonomous computer-player step for Hot Potato. Driven by exactly **one** client
/// per match (the host). All bot positions for a tick are written in a single
/// Realtime Database update; Firestore is only touched for the rare tag transaction.
class HotPotatoBotAutoplay {
  HotPotatoBotAutoplay._();

  // Persist short bot intent windows so movement stays coherent across ticks.
  static final Map<String, DateTime> _holderHumanFocusUntil = {};
  static final Map<String, String> _holderHumanFocusTarget = {};
  static final Map<String, DateTime> _holderChaosUntil = {};
  static final Map<String, String> _holderChaosTarget = {};

  static final Set<String> _botPickupClaimInFlight = {};
  static final Map<String, int> _lastBotPowerUseMs = {};

  /// One simulation step. Reads the current `live` snapshot directly from caller to
  /// avoid a Firestore round-trip per tick, plus the latest RTDB positions for
  /// distance checks. Writes all bot positions for this tick in one RTDB call.
  static Future<void> tick({
    required DocumentReference roomRef,
    required String databaseUrl,
    required HotPotatoLiveState live,
    required Map<String, HotPotatoPositionData> livePositions,
    required String holderPath,
    required bool Function(String path, DateTime now) isPassImmune,
    required Future<void> Function(String fromPath, String toPath) onPass,
    double tickDeltaSec = kHotPotatoBotSimPeriodSec,

    /// When true, bot positions are not written to RTDB; [onLocalBotBatch] receives
    /// the same payload that would have been batch-written (host applies in-memory).
    bool skipRtdbBotWrites = false,
    void Function(Map<String, RtdbPositionWrite> batch)? onLocalBotBatch,
  }) async {
    if (live.matchComplete) return;
    final paths = live.participantPaths;
    if (paths.isEmpty) return;

    if (kHotPotatoPowerupsEnabled) {
      await _maybeBotsUseInventory(
        roomRef: roomRef,
        live: live,
        databaseUrl: databaseUrl,
        livePositions: livePositions,
        holderPath: holderPath,
      );
    }

    final batched = <String, RtdbPositionWrite>{};
    String? tagFromBotHolder;
    String? tagToTarget;

    final holder = holderPath;
    final hp = livePositions[holder];
    final hi = paths.indexOf(holder);
    var hx = 0.5;
    var hy = 0.5;
    if (hp != null) {
      hx = hp.x;
      hy = hp.y;
    } else if (hi >= 0) {
      defaultRingPosition(
        index: hi,
        total: paths.length,
        out: (x, y) {
          hx = x;
          hy = y;
        },
      );
    }

    for (var i = 0; i < paths.length; i++) {
      final path = paths[i];
      if (!path.startsWith('bot:')) continue;

      final cur = livePositions[path];
      var bx = cur?.x ?? 0.5;
      var by = cur?.y ?? 0.5;
      if (cur == null) {
        defaultRingPosition(
          index: i,
          total: paths.length,
          out: (x, y) {
            bx = x;
            by = y;
          },
        );
      }
      var vx = cur?.vx ?? 0.0;
      var vy = cur?.vy ?? 0.0;

      // Same dt clamp as Durable Object sim (`bot-sim.ts`).
      final step = tickDeltaSec.clamp(0.03, 0.16);

      final now = DateTime.now();
      final selfSpeedMul =
          (cur ?? const HotPotatoPositionData(x: 0.5, y: 0.5, vx: 0, vy: 0))
              .speedMultiplierAt(now);
      // Keep "personality" stable for short windows instead of reseeding every
      // tick, which produced direction flicker and visible jitter.
      final rng =
          math.Random(path.hashCode ^ (now.millisecondsSinceEpoch >> 11));

      if (path == holder) {
        // Has the bomb: hunt the nearest player you can tag (ignore shielded
        // and pass-immune players — chasing someone you can't tag is wasted
        // motion that makes the AI look dumb).
        double? bxT;
        double? byT;
        String? preyPath;
        var bestD = double.infinity;
        for (final o in paths) {
          if (o == path) continue;
          final op = livePositions[o];
          if (op?.isShieldedAt(now) ?? false) continue;
          if (op?.isGhostAt(now) ?? false) continue;
          if (isPassImmune(o, now)) continue;
          final oi = paths.indexOf(o);
          var ox = 0.5;
          var oy = 0.5;
          if (op != null) {
            ox = op.x;
            oy = op.y;
          } else if (oi >= 0) {
            defaultRingPosition(
              index: oi,
              total: paths.length,
              out: (x, y) {
                ox = x;
                oy = y;
              },
            );
          }
          final d = math.sqrt(math.pow(bx - ox, 2) + math.pow(by - oy, 2));
          if (d < bestD) {
            bestD = d;
            bxT = ox;
            byT = oy;
            preyPath = o;
          }
        }

        // Break "two bots in a corner passing forever": maintain a brief
        // human-focused chase window so intent is stable and readable.
        final humans =
            paths.where((p) => !p.startsWith('bot:') && p != path).toList();
        final hasBotPrey = preyPath != null && preyPath.startsWith('bot:');
        if (humans.isNotEmpty && hasBotPrey) {
          final focusUntil = _holderHumanFocusUntil[path];
          final focusAlive = focusUntil != null && now.isBefore(focusUntil);
          final shouldStartFocus = !focusAlive && rng.nextDouble() < 0.03;
          if (shouldStartFocus) {
            _holderHumanFocusUntil[path] = now.add(
              const Duration(milliseconds: 620),
            );
            _holderHumanFocusTarget[path] = humans[rng.nextInt(humans.length)];
          }
        }
        final focusTarget = _holderHumanFocusTarget[path];
        final focusUntil = _holderHumanFocusUntil[path];
        if (focusTarget != null &&
            focusUntil != null &&
            now.isBefore(focusUntil) &&
            humans.contains(focusTarget)) {
          final h = focusTarget;
          final hi = paths.indexOf(h);
          var ox = 0.5;
          var oy = 0.5;
          final hop = livePositions[h];
          if (hop != null) {
            ox = hop.x;
            oy = hop.y;
          } else if (hi >= 0) {
            defaultRingPosition(
              index: hi,
              total: paths.length,
              out: (x, y) {
                ox = x;
                oy = y;
              },
            );
          }
          bxT = ox;
          byT = oy;
          bestD = math.sqrt(math.pow(bx - ox, 2) + math.pow(by - oy, 2));
        }
        // Occasional "chaos" burst, also held briefly to avoid twitching.
        final chaosUntil = _holderChaosUntil[path];
        final chaosAlive = chaosUntil != null && now.isBefore(chaosUntil);
        if (!chaosAlive && paths.length > 2 && rng.nextDouble() < 0.05) {
          String? choice;
          var farD = -1.0;
          for (final o in paths) {
            if (o == path) continue;
            if (isPassImmune(o, now)) continue;
            final op = livePositions[o];
            if (op?.isShieldedAt(now) ?? false) continue;
            if (op?.isGhostAt(now) ?? false) continue;
            final oi = paths.indexOf(o);
            var ox = 0.5;
            var oy = 0.5;
            if (op != null) {
              ox = op.x;
              oy = op.y;
            } else if (oi >= 0) {
              defaultRingPosition(
                index: oi,
                total: paths.length,
                out: (x, y) {
                  ox = x;
                  oy = y;
                },
              );
            }
            final d = math.sqrt(math.pow(bx - ox, 2) + math.pow(by - oy, 2));
            if (d > farD) {
              farD = d;
              choice = o;
            }
          }
          if (choice != null) {
            _holderChaosTarget[path] = choice;
            _holderChaosUntil[path] =
                now.add(const Duration(milliseconds: 650));
          }
        }
        final chaos = _holderChaosTarget[path];
        if (chaos != null &&
            (_holderChaosUntil[path]?.isAfter(now) ?? false) &&
            chaos != path &&
            !isPassImmune(chaos, now)) {
          final oi = paths.indexOf(chaos);
          var ox = 0.5;
          var oy = 0.5;
          final cop = livePositions[chaos];
          if (cop != null) {
            ox = cop.x;
            oy = cop.y;
          } else if (oi >= 0) {
            defaultRingPosition(
              index: oi,
              total: paths.length,
              out: (x, y) {
                ox = x;
                oy = y;
              },
            );
          }
          bxT = ox;
          byT = oy;
          bestD = math.sqrt(math.pow(bx - ox, 2) + math.pow(by - oy, 2));
        }

        double sx = 0;
        double sy = 0;
        if (bxT != null && byT != null) {
          final dx = bxT - bx;
          final dy = byT - by;
          final len = math.max(0.001, math.sqrt(dx * dx + dy * dy));
          sx += dx / len;
          sy += dy / len;
        } else {
          final dx = 0.5 - bx;
          final dy = 0.5 - by;
          final len = math.max(0.001, math.sqrt(dx * dx + dy * dy));
          sx += (dx / len) * 0.35;
          sy += (dy / len) * 0.35;
        }
        final wallH = _wallRepel(bx, by);
        sx += wallH.dx * 0.42;
        sy += wallH.dy * 0.42;
        sx += (0.5 - bx) * 0.12;
        sy += (0.5 - by) * 0.12;
        final puH = _pickupSteerDelta(
          pickups: live.pickups,
          bx: bx,
          by: by,
          strength: 1.0,
        );
        sx += puH.dx;
        sy += puH.dy;
        final slH = math.sqrt(sx * sx + sy * sy);
        final dirXH = slH > 1e-6 ? sx / slH : 0.0;
        final dirYH = slH > 1e-6 ? sy / slH : 0.0;
        final throttleH = (bxT != null && byT != null)
            ? 0.36 + 0.34 * math.min(1.0, bestD / 0.48)
            : 0.32;
        hotPotatoArenaIntegrate(
          dirX: dirXH,
          dirY: dirYH,
          throttle01: throttleH,
          dt: step,
          speedMult: selfSpeedMul,
          ghostActive: cur?.isGhostAt(now) ?? false,
          x: bx,
          y: by,
          vx: vx,
          vy: vy,
          emit: (nx, ny, nvx, nvy) {
            bx = nx;
            by = ny;
            vx = nvx;
            vy = nvy;
          },
        );

        for (final o in paths) {
          if (o == path) continue;
          final op = livePositions[o];
          if (op?.isShieldedAt(now) ?? false) continue;
          if (op?.isGhostAt(now) ?? false) continue;
          if (isPassImmune(o, now)) continue;
          final oi = paths.indexOf(o);
          var ox = 0.5;
          var oy = 0.5;
          if (op != null) {
            ox = op.x;
            oy = op.y;
          } else if (oi >= 0) {
            defaultRingPosition(
              index: oi,
              total: paths.length,
              out: (x, y) {
                ox = x;
                oy = y;
              },
            );
          }
          if (HotPotatoLiveState.hasPassContact(
            ax: bx,
            ay: by,
            bx: ox,
            by: oy,
          )) {
            tagFromBotHolder = path;
            tagToTarget = o;
            break;
          }
        }
      } else {
        // No bomb: run from the holder and juke so you are harder to tag; spread from crowding.
        final fx = bx - hx;
        final fy = by - hy;
        final distH = math.max(0.001, math.sqrt(fx * fx + fy * fy));
        // 0 when holder is far, ramps up when they are within tagging range.
        final danger = ((0.24 - distH) / 0.24).clamp(0.0, 1.0);

        final ux = fx / distH;
        final uy = fy / distH;
        // Perpendicular strafe with fixed polarity per bot (not oscillating)
        // so movement doesn't wiggle left-right every few frames.
        final strafeSign = (path.hashCode & 1) == 0 ? 1.0 : -1.0;
        final px = -uy * strafeSign;
        final py = ux * strafeSign;

        var sepX = 0.0;
        var sepY = 0.0;
        for (final o in paths) {
          if (o == path || o == holder) continue;
          final op = livePositions[o];
          final oi = paths.indexOf(o);
          var ox = 0.5;
          var oy = 0.5;
          if (op != null) {
            ox = op.x;
            oy = op.y;
          } else if (oi >= 0) {
            defaultRingPosition(
              index: oi,
              total: paths.length,
              out: (x, y) {
                ox = x;
                oy = y;
              },
            );
          }
          final ddx = bx - ox;
          final ddy = by - oy;
          final d = math.sqrt(ddx * ddx + ddy * ddy);
          if (d < 0.001 || d > 0.2) continue;
          sepX += ddx / d;
          sepY += ddy / d;
        }
        final slSep = math.sqrt(sepX * sepX + sepY * sepY);
        if (slSep > 0.001) {
          sepX /= slSep;
          sepY /= slSep;
        }

        final anchor = _botAnchor(path);
        final axIn = anchor.dx - bx;
        final ayIn = anchor.dy - by;
        final al = math.max(0.001, math.sqrt(axIn * axIn + ayIn * ayIn));
        final anchorX = axIn / al;
        final anchorY = ayIn / al;

        final wall = _wallRepel(bx, by);
        final flee = 0.24 + 0.18 * danger;
        final strafe = 0.055 + 0.065 * danger;
        var mx =
            ux * flee +
            px * strafe +
            sepX * 0.13 +
            anchorX * (0.10 - 0.06 * danger) +
            wall.dx * 0.32 +
            (0.5 - bx) * 0.08;
        var my =
            uy * flee +
            py * strafe +
            sepY * 0.13 +
            anchorY * (0.10 - 0.06 * danger) +
            wall.dy * 0.32 +
            (0.5 - by) * 0.08;

        final puF = _pickupSteerDelta(
          pickups: live.pickups,
          bx: bx,
          by: by,
          strength: 0.85,
        );
        mx += puF.dx;
        my += puF.dy;
        final slN = math.sqrt(mx * mx + my * my);
        final dirXN = slN > 1e-6 ? mx / slN : 0.0;
        final dirYN = slN > 1e-6 ? my / slN : 0.0;
        final throttleN = 0.34 + 0.34 * danger;
        hotPotatoArenaIntegrate(
          dirX: dirXN,
          dirY: dirYN,
          throttle01: throttleN,
          dt: step,
          speedMult: selfSpeedMul,
          ghostActive: cur?.isGhostAt(now) ?? false,
          x: bx,
          y: by,
          vx: vx,
          vy: vy,
          emit: (nx, ny, nvx, nvy) {
            bx = nx;
            by = ny;
            vx = nvx;
            vy = nvy;
          },
        );
      }

      final existing = livePositions[path];
      batched[path] = RtdbPositionWrite(
        x: bx.clamp(0.0, 1.0),
        y: by.clamp(0.0, 1.0),
        vx: vx,
        vy: vy,
        speedUntil: existing?.speedUntil,
        shieldUntil: existing?.shieldUntil,
      );
    }

    if (kHotPotatoPowerupsEnabled && batched.isNotEmpty) {
      for (final e in batched.entries) {
        final path = e.key;
        if (!path.startsWith('bot:')) continue;
        final wx = e.value.x;
        final wy = e.value.y;
        for (final pu in live.pickups) {
          if (!pu.isAvailable) continue;
          if (_botPickupClaimInFlight.contains(pu.id)) continue;
          final dx = wx - pu.x;
          final dy = wy - pu.y;
          if (math.sqrt(dx * dx + dy * dy) > 0.068) continue;
          _botPickupClaimInFlight.add(pu.id);
          try {
            await HotPotatoLiveFirestore.claimPickup(
              roomRef,
              pu.id,
              path,
            );
          } catch (_) {
            // Transient Firestore contention — next tick retries movement.
          } finally {
            _botPickupClaimInFlight.remove(pu.id);
          }
          break;
        }
      }
    }

    if (batched.isNotEmpty) {
      if (skipRtdbBotWrites) {
        onLocalBotBatch?.call(batched);
      } else {
        await HotPotatoRtdbPositions.batchWrite(
          databaseUrl: databaseUrl,
          roomId: roomRef.id,
          positions: batched,
        );
      }
    }

    // Hand the bomb over only when a contact actually happened.
    if (tagFromBotHolder != null && tagToTarget != null) {
      await onPass(tagFromBotHolder, tagToTarget);
    }
  }

  /// Host-only: keep eliminated bot ghosts drifting so spectators look alive.
  static Future<void> tickGhostDrift({
    required String databaseUrl,
    required String roomId,
    required List<String> ghostPaths,
    required Map<String, HotPotatoPositionData> livePositions,
  }) async {
    final rng = math.Random();
    final batch = <String, RtdbPositionWrite>{};
    for (final path in ghostPaths) {
      if (!path.startsWith('bot:')) continue;
      final cur = livePositions[path];
      var bx = cur?.x ?? 0.5;
      var by = cur?.y ?? 0.5;
      final vx = (rng.nextDouble() - 0.5) * 0.26;
      final vy = (rng.nextDouble() - 0.5) * 0.26;
      bx = (bx + vx * 0.38).clamp(0.06, 0.94);
      by = (by + vy * 0.38).clamp(0.06, 0.94);
      batch[path] = RtdbPositionWrite(
        x: bx.clamp(0.0, 1.0),
        y: by.clamp(0.0, 1.0),
        vx: vx,
        vy: vy,
        speedUntil: cur?.speedUntil,
        shieldUntil: cur?.shieldUntil,
      );
    }
    if (batch.isEmpty) return;
    await HotPotatoRtdbPositions.batchWrite(
      databaseUrl: databaseUrl,
      roomId: roomId,
      positions: batch,
    );
  }

  /// Steering bias toward nearest pickup (aligned with `pickupSteerDelta` in
  /// `workers/hot-potato-room/src/bot-sim.ts`).
  static Offset _pickupSteerDelta({
    required List<HotPotatoPickupItem> pickups,
    required double bx,
    required double by,
    double strength = 1.0,
  }) {
    if (!kHotPotatoPowerupsEnabled || pickups.isEmpty) {
      return Offset.zero;
    }
    HotPotatoPickupItem? nearest;
    var best = double.infinity;
    for (final pu in pickups) {
      if (!pu.isAvailable) continue;
      final dx = pu.x - bx;
      final dy = pu.y - by;
      final d = math.sqrt(dx * dx + dy * dy);
      if (d < best) {
        best = d;
        nearest = pu;
      }
    }
    if (nearest == null || best < 1e-8 || best > 0.44) {
      return Offset.zero;
    }
    final t = 1.0 - best / 0.44;
    final w = 0.22 * strength * t * t;
    return Offset(
      (nearest.x - bx) / best * w,
      (nearest.y - by) / best * w,
    );
  }

  static Future<void> _maybeBotsUseInventory({
    required DocumentReference roomRef,
    required HotPotatoLiveState live,
    required String databaseUrl,
    required Map<String, HotPotatoPositionData> livePositions,
    required String holderPath,
  }) async {
    if (live.matchComplete || !kHotPotatoPowerupsEnabled) return;
    final now = DateTime.now();
    final nowMs = now.millisecondsSinceEpoch;
    final rng = math.Random(nowMs ~/ 400);

    for (final path in live.participantPaths) {
      if (!path.startsWith('bot:')) continue;
      final prevMs = _lastBotPowerUseMs[path] ?? 0;
      if (nowMs - prevMs < 780) continue;

      final options = <String>[];
      for (final k in const ['Shield', 'Speed', 'Ghost', 'Banana']) {
        if (live.inventoryCount(path, k) > 0) options.add(k);
      }
      if (options.isEmpty) continue;

      final isHolder = path == holderPath;
      final roll = rng.nextDouble();
      if (roll > (isHolder ? 0.52 : 0.34)) continue;

      _lastBotPowerUseMs[path] = nowMs;
      final kind = options[rng.nextInt(options.length)];
      final mePos = livePositions[path] ??
          const HotPotatoPositionData(x: 0.5, y: 0.5, vx: 0, vy: 0);
      if (kind == 'Speed' || kind == 'Shield') {
        unawaited(
          HotPotatoRtdbPositions.writePosition(
            databaseUrl: databaseUrl,
            roomId: roomRef.id,
            path: path,
            x: mePos.x,
            y: mePos.y,
            vx: mePos.vx,
            vy: mePos.vy,
            speedUntil: kind == 'Speed'
                ? now.add(const Duration(seconds: 5))
                : mePos.speedUntil,
            shieldUntil: kind == 'Shield'
                ? now.add(const Duration(seconds: 5))
                : mePos.shieldUntil,
          ),
        );
      }
      try {
        await HotPotatoLiveFirestore.consumeInventory(roomRef, path, kind);
      } catch (_) {}
    }
  }

  static Offset _wallRepel(double x, double y) {
    const edge = 0.16;
    double fx = 0;
    double fy = 0;
    if (x < edge) fx += (edge - x) / edge;
    if (x > 1.0 - edge) fx -= (x - (1.0 - edge)) / edge;
    if (y < edge) fy += (edge - y) / edge;
    if (y > 1.0 - edge) fy -= (y - (1.0 - edge)) / edge;
    return Offset(fx.clamp(-1.0, 1.0), fy.clamp(-1.0, 1.0));
  }

  static Offset _botAnchor(String path) {
    final h = path.hashCode;
    final angle = ((h % 360) * math.pi) / 180.0;
    const r = 0.32;
    return Offset(0.5 + r * math.cos(angle), 0.5 + r * math.sin(angle));
  }
}
