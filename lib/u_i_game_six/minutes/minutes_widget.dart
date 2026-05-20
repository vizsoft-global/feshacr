import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

export 'minutes_model.dart';

/// Round duration in minutes (1, 2, or 3). Same pill language as the bot
/// difficulty picker for visual consistency in the settings card.
class MinutesWidget extends StatelessWidget {
  const MinutesWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.dense = false,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final bool dense;

  static const List<int> options = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Row(
      children: options.map((m) {
        final selected = value == m;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onChanged(m),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: selected
                        ? theme.primary
                        : theme.primaryBackground,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected ? theme.primary : theme.alternate,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$m min',
                    style: TextStyle(
                      color: selected ? Colors.white : theme.primaryText,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
