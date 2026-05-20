import 'dart:async';
import 'dart:math';

import '/backend/backend.dart';
import '/u_i_game_six/game_six/hot_potato_live.dart';
import '/u_i_game_six/game_six/hot_potato_settings_parser.dart';

import 'package:flutter/material.dart';

/// Periodically spawns floor pickups. Only the host actually
/// writes to Firestore — every client subscribes to the same field via the room stream.
class HotPotatoPickupSpawnerScheduler extends StatefulWidget {
  const HotPotatoPickupSpawnerScheduler({
    super.key,
    required this.roomRef,
    required this.live,
    required this.isHost,
    required this.settings,
    required this.child,
  });

  final DocumentReference roomRef;
  final HotPotatoLiveState live;
  final bool isHost;
  final HotPotatoFirestoreSettings settings;
  final Widget child;

  @override
  State<HotPotatoPickupSpawnerScheduler> createState() =>
      _HotPotatoPickupSpawnerSchedulerState();
}

class _HotPotatoPickupSpawnerSchedulerState
    extends State<HotPotatoPickupSpawnerScheduler> {
  Timer? _timer;
  final Random _rng = Random();

  static const _spawnable = {'Speed', 'Shield', 'Ghost', 'Banana'};
  static const int _maxActivePickups = 14;

  /// Bot difficulty controls how often and how many pickups appear. Harder
  /// difficulty makes powerups *scarcer*, so survival depends more on skill.
  ({int everySec, int minBurst, int maxBurst}) _spawnTuning() {
    switch (widget.settings.botDifficulty) {
      case 'medium':
        return (everySec: 32, minBurst: 1, maxBurst: 2);
      case 'hard':
        return (everySec: 50, minBurst: 1, maxBurst: 1);
      case 'easy':
      default:
        return (everySec: 20, minBurst: 2, maxBurst: 3);
    }
  }

  @override
  void initState() {
    super.initState();
    _scheduleNext();
  }

  void _scheduleNext() {
    _timer?.cancel();
    final t = _spawnTuning();
    _timer = Timer(Duration(seconds: t.everySec), () {
      unawaited(_spawnThenReschedule());
    });
  }

  Future<void> _spawnThenReschedule() async {
    if (!mounted) return;
    if (!widget.isHost) {
      _scheduleNext();
      return;
    }
    if (!kHotPotatoPowerupsEnabled) {
      // Spawner is fully off — no Firestore touches at all. We still keep the
      // [Timer] cycling cheaply so flipping the flag back doesn't require a
      // restart of the arena.
      _scheduleNext();
      return;
    }
    try {
      final snap = await widget.roomRef.get();
      final data = snap.data();
      if (data is! Map<String, dynamic>) {
        _scheduleNext();
        return;
      }
      final live = HotPotatoLiveState.fromRoomSnapshotData(data);
      if (live == null || live.matchComplete) {
        _scheduleNext();
        return;
      }

      final kinds =
          widget.settings.orderedPowerups.where(_spawnable.contains).toList();
      if (kinds.isEmpty) {
        _scheduleNext();
        return;
      }
      final t = _spawnTuning();
      final burst = t.minBurst + _rng.nextInt(t.maxBurst - t.minBurst + 1);
      for (var i = 0; i < burst; i++) {
        final kind = kinds[_rng.nextInt(kinds.length)];
        final x = 0.10 + _rng.nextDouble() * 0.80;
        final y = 0.10 + _rng.nextDouble() * 0.80;
        await HotPotatoLiveFirestore.spawnPickupIfRoom(
          widget.roomRef,
          kind: kind,
          x: x,
          y: y,
          maxActive: _maxActivePickups,
        );
        if (i < burst - 1) {
          await Future<void>.delayed(const Duration(milliseconds: 70));
        }
      }
    } catch (_) {
      // Swallow transient Firestore errors so the arena keeps rendering.
    }
    _scheduleNext();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
