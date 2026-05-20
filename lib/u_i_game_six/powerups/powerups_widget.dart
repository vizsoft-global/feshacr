import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

export 'powerups_model.dart';

/// Emoji-first multi-select power-ups: Speed, Banana, Shield, Ghost.
/// Each chip is a small filled circle when enabled, outlined when disabled —
/// consistent with the rest of the lobby's pill language.
class PowerupsWidget extends StatelessWidget {
  const PowerupsWidget({
    super.key,
    required this.selected,
    required this.onToggle,
  });

  final Set<String> selected;
  final ValueChanged<String> onToggle;

  static const List<_PowerupDef> _defs = [
    _PowerupDef('Speed', '⚡', Color(0xFFE74C3C)),
    _PowerupDef('Banana', '🍌', Color(0xFFF1C40F)),
    _PowerupDef('Shield', '🛡️', Color(0xFFF39C12)),
    _PowerupDef('Ghost', '👻', Color(0xFF9B59B6)),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _defs.map((d) {
        final on = selected.contains(d.id);
        return Tooltip(
          message: d.id,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onToggle(d.id),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: on ? d.color : theme.primaryBackground,
                  border: Border.all(
                    color: on ? d.color : theme.alternate,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  d.emoji,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PowerupDef {
  const _PowerupDef(this.id, this.emoji, this.color);
  final String id;
  final String emoji;
  final Color color;
}
