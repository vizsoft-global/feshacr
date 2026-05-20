import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

export 'rounds_model.dart';

/// Total-rounds slider (1..10). Capped at `maxRounds = playerCount - 1` so
/// you cannot pick more rounds than there are eliminations to make. Greys
/// the disabled tail so the constraint is obvious.
class RoundsWidget extends StatelessWidget {
  const RoundsWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.dense = false,
    this.maxRounds = 10,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final bool dense;

  /// Hard cap (typically `playerCount - 1`). Slider min is 1.
  final int maxRounds;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final cap = maxRounds.clamp(1, 10);
    final clamped = value.clamp(1, cap);
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: theme.primaryBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.alternate, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$clamped',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 3,
                activeTrackColor: theme.primary,
                inactiveTrackColor: theme.alternate,
                thumbColor: theme.primary,
                overlayColor: theme.primary.withValues(alpha: 0.14),
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 7),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 14),
              ),
              child: Slider(
                value: clamped.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                onChanged: (v) {
                  final picked = v.round().clamp(1, cap);
                  onChanged(picked);
                },
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'max $cap',
            style: TextStyle(
              color: theme.secondaryText,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
