import '/flutter_flow/flutter_flow_util.dart';
import 'game_six_widget.dart' show GameSixWidget;
import 'package:flutter/material.dart';

/// Local-only bot row for Hot Potato settings (persisted inside `hot_potato_settings` on Start).
class HotPotatoBot {
  HotPotatoBot({
    required this.name,
    required this.avatarEmoji,
    required this.localId,
  });

  final String name;
  final String avatarEmoji;
  final int localId;
}

class GameSixModel extends FlutterFlowModel<GameSixWidget> {
  /// Round time in minutes (1, 2, or 3).
  int roundMinutes = 2;

  /// Total rounds (1, 3, or 5).
  int totalRounds = 3;

  /// Selected power-up ids: Speed, Banana, Shield, Ghost.
  final Set<String> enabledPowerups = {'Speed', 'Banana', 'Shield', 'Ghost'};

  final List<HotPotatoBot> localBots = [];

  int _nextBotLocalId = 1;

  bool isStarting = false;

  /// Host-only: simulate bot movement without RTDB bot writes (see [HotPotatoFirestoreSettings.offlineBotMode]).
  bool offlineBotMode = false;

  /// Bot difficulty for the upcoming match — `easy`, `medium`, or `hard`.
  /// Mirrored to Firestore on Start so the Cloudflare worker / RTDB host
  /// uses the chosen AI ramp.
  String botDifficulty = 'easy';

  /// Host-selected RTDB URL for this match (null = auto probe best on start).
  String? selectedRtdbUrl;

  /// Host-selected edge hint (null = auto probe best on start). Edge mode only.
  String? selectedEdgeHint;

  static const List<String> _botNames = [
    'Chip',
    'Pixel',
    'Nova',
    'Rally',
    'Echo',
    'Bolt',
    'Jinx',
    'Orbit',
  ];

  static const List<String> _botEmojis = [
    '🤖',
    '🦊',
    '🐼',
    '🦁',
    '🐸',
    '🦄',
    '🐙',
    '🦋',
  ];

  void addRandomBot() {
    final i = localBots.length % _botNames.length;
    final j = localBots.length % _botEmojis.length;
    localBots.add(
      HotPotatoBot(
        name: _botNames[i],
        avatarEmoji: _botEmojis[j],
        localId: _nextBotLocalId++,
      ),
    );
  }

  void removeBotAt(int index) {
    if (index >= 0 && index < localBots.length) {
      localBots.removeAt(index);
    }
  }

  void togglePowerup(String id) {
    if (enabledPowerups.contains(id)) {
      enabledPowerups.remove(id);
    } else {
      enabledPowerups.add(id);
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
