import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/u_i_game_six/game_six/hot_potato_live.dart';
import '/u_i_game_six/game_six/hot_potato_settings_parser.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'hot_potato_model.dart';
export 'hot_potato_model.dart';

/// Potato centerpiece: shared holder from [live], pass action, fallback demo label.
class HotPotatoWidget extends StatefulWidget {
  const HotPotatoWidget({
    super.key,
    required this.participantNames,
    required this.room,
    required this.settings,
    required this.live,
    required this.roomRef,
    required this.isHolder,
  });

  final List<String> participantNames;
  final RoomRecord room;
  final HotPotatoFirestoreSettings settings;
  final HotPotatoLiveState? live;
  final DocumentReference roomRef;
  final bool isHolder;

  @override
  State<HotPotatoWidget> createState() => _HotPotatoWidgetState();
}

class _HotPotatoWidgetState extends State<HotPotatoWidget> {
  late HotPotatoModel _model;
  late String _fallbackHolder;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotPotatoModel());
    final names = widget.participantNames.where((n) => n.isNotEmpty).toList();
    if (names.isEmpty) {
      _fallbackHolder = 'Waiting for players';
    } else {
      _fallbackHolder = names[Random().nextInt(names.length)];
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  String _holderLabel() {
    final live = widget.live;
    if (live != null) {
      return _resolveHolderDisplayName(
        live,
        widget.room,
        widget.settings,
      );
    }
    return _fallbackHolder;
  }

  String _resolveHolderDisplayName(
    HotPotatoLiveState live,
    RoomRecord room,
    HotPotatoFirestoreSettings settings,
  ) {
    final p = live.holderPath;
    if (p.startsWith('bot:')) {
      final id = int.tryParse(p.substring(4)) ?? -1;
      for (final b in settings.bots) {
        if (b.localId == id) return b.name;
      }
      return 'Bot';
    }
    for (final u in room.roomUserList) {
      if (u.roomUserRef?.path == p) {
        final n = u.roomUserInfo.userName;
        return n.isNotEmpty ? n : 'Player';
      }
    }
    return 'Player';
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final live = widget.live;
    final holderLabel = _holderLabel();
    final botHolding = live != null && live.isHolderBot;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '🥔',
          style: TextStyle(
            fontSize: 88,
            shadows: [
              Shadow(
                blurRadius: 12,
                color: theme.primary.withValues(alpha: 0.35),
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Pass the potato!',
          style: theme.titleMedium.override(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          live == null
              ? 'Holder (offline demo): $holderLabel'
              : 'Holder: $holderLabel',
          style: theme.bodySmall.override(color: theme.secondaryText),
          textAlign: TextAlign.center,
        ),
        if (botHolding) ...[
          const SizedBox(height: 8),
          Text(
            'A bot is holding the potato.',
            style: theme.labelSmall,
            textAlign: TextAlign.center,
          ),
        ],
        if (widget.isHolder && !botHolding && live != null) ...[
          const SizedBox(height: 16),
          Text(
            'Touch another player in the arena to pass the potato.',
            style: theme.bodySmall.override(color: theme.secondaryText),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
