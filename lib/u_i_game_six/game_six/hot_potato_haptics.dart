import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:vibration/vibration.dart';

/// Hot Potato haptic feedback wrapper.
///
/// Android: uses the `vibration` package which talks to the system Vibrator
/// directly (guaranteed to fire with the `VIBRATE` manifest permission).
/// iOS: uses Flutter's [HapticFeedback] which routes to CoreHaptics on
/// supported devices. Both layers are best-effort — never throws.
abstract final class HotPotatoHaptics {
  /// Probed once on first use; cached. False on web and on hardware that
  /// reports no vibrator. We still let the `HapticFeedback` fallback fire,
  /// because iOS reports `hasVibrator() == false` but CoreHaptics works.
  static bool? _hasVibrator;

  static Future<bool> _probe() async {
    if (kIsWeb) return false;
    try {
      final v = await Vibration.hasVibrator();
      return v == true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> _ensureProbed() async {
    _hasVibrator ??= await _probe();
  }

  /// Light pulse for repeated/movement events (joystick direction changes).
  /// Short (~20ms) so it doesn't feel buzzy when fired ~5×/sec.
  static void light() {
    unawaited(_fire(durationMs: 20, hf: HapticFeedback.lightImpact));
  }

  /// Medium thump for power-up activation, pickup claim.
  static void medium() {
    unawaited(_fire(durationMs: 45, hf: HapticFeedback.mediumImpact));
  }

  /// Strong thump for pass / tag / elimination — confirms a major event.
  static void heavy() {
    unawaited(_fire(durationMs: 80, hf: HapticFeedback.heavyImpact));
  }

  static Future<void> _fire({
    required int durationMs,
    required Future<void> Function() hf,
  }) async {
    if (kIsWeb) return;
    await _ensureProbed();
    if (_hasVibrator == true) {
      try {
        await Vibration.vibrate(duration: durationMs);
        return;
      } catch (e) {
        debugPrint('HotPotatoHaptics vibration error: $e');
      }
    }
    try {
      await hf();
    } catch (_) {}
  }
}
