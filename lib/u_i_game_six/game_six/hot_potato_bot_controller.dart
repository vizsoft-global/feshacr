import 'dart:math';

import '/u_i_game_six/game_six/hot_potato_live.dart';

/// Host-side bot pass timing (plan §C). Rounds are still advanced only by the host
/// timer via [HotPotatoLiveFirestore.hostAdvanceRoundIfExpired] — bots never write
/// round fields.
abstract final class HotPotatoBotController {
  /// [urgency] in \[0,1\]: 0 = much time left, 1 = round almost over.
  /// Uses [HotPotatoLiveState.lastPowerup] / [HotPotatoLiveState.lastPowerupAt] so
  /// bots react slightly differently after power-ups.
  static int computeBotPassDelayMs({
    required double urgency,
    required HotPotatoLiveState live,
  }) {
    const minMs = 350;
    const maxMs = 2600;
    var delay = (maxMs - (maxMs - minMs) * urgency.clamp(0.0, 1.0)).round() +
        Random().nextInt(520);

    final p = live.lastPowerup ?? '';
    double powerMul = 1.0;
    if (p == 'Speed') {
      powerMul = 0.72;
    } else if (p == 'Banana') {
      powerMul = 1.10;
    } else if (p == 'Shield') {
      powerMul = 0.88;
    } else if (p == 'Ghost' || p == 'Unseen') {
      powerMul = 0.94 + Random().nextDouble() * 0.2;
    }

    final lpu = live.lastPowerupAt;
    if (lpu != null && p.isNotEmpty) {
      final recent = DateTime.now().difference(lpu).inSeconds < 14;
      if (recent) {
        powerMul *= 0.9;
      }
    }

    delay = (delay * powerMul).round().clamp(220, 4500);
    return delay;
  }
}
