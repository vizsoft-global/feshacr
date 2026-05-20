import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_two_timer_model.dart';
export 'game_two_timer_model.dart';

class GameTwoTimerWidget extends StatefulWidget {
  const GameTwoTimerWidget({
    super.key,
    required this.timeMS,
  });

  final int? timeMS;

  @override
  State<GameTwoTimerWidget> createState() => _GameTwoTimerWidgetState();
}

class _GameTwoTimerWidgetState extends State<GameTwoTimerWidget> {
  late GameTwoTimerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameTwoTimerModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.onStartTimer();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      decoration: BoxDecoration(
        color: Color(0x2667B5B0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FFIcons.kfi4,
              color: FlutterFlowTheme.of(context).tertiary,
              size: 20.0,
            ),
            FlutterFlowTimer(
              initialTime: widget!.timeMS!,
              getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                value,
                hours: false,
                milliSecond: false,
              ),
              controller: _model.timerController,
              updateStateInterval: Duration(milliseconds: 1000),
              onChanged: (value, displayTime, shouldUpdate) {
                _model.timerMilliseconds = value;
                _model.timerValue = displayTime;
                if (shouldUpdate) safeSetState(() {});
              },
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.almarai(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).tertiary,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            Text(
              FFLocalizations.of(context).getText(
                'z3dbzp8h' /* Sec */,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.almarai(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).tertiary,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ].divide(SizedBox(width: 4.0)),
        ),
      ),
    );
  }
}
