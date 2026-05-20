import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_four_timer_model.dart';
export 'game_four_timer_model.dart';

class GameFourTimerWidget extends StatefulWidget {
  const GameFourTimerWidget({
    super.key,
    required this.timeMS,
    bool? resetStatus,
    bool? startStatus,
  })  : this.resetStatus = resetStatus ?? true,
        this.startStatus = startStatus ?? true;

  final int? timeMS;
  final bool resetStatus;
  final bool startStatus;

  @override
  State<GameFourTimerWidget> createState() => _GameFourTimerWidgetState();
}

class _GameFourTimerWidgetState extends State<GameFourTimerWidget> {
  late GameFourTimerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFourTimerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 35.0,
          decoration: BoxDecoration(
            color: Color(0x2667B5B0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  FFIcons.kfi4,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 14.0,
                ),
                FlutterFlowTimer(
                  initialTime: valueOrDefault<int>(
                    widget!.timeMS,
                    30000,
                  ),
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
                  onEnded: () async {
                    FFAppState().helpLineStatus = false;
                    FFAppState().update(() {});
                  },
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.almarai(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 13.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                if (responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                  tabletLandscape: false,
                  desktop: false,
                ))
                  Text(
                    FFLocalizations.of(context).getText(
                      'hvrceqcu' /* Sec */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.almarai(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
              ].divide(SizedBox(width: 4.0)),
            ),
          ),
        ),
        if (widget!.resetStatus == true)
          FlutterFlowIconButton(
            borderRadius: 8.0,
            buttonSize: 35.0,
            fillColor: Color(0x26EC4D41),
            icon: Icon(
              FFIcons.kfi14,
              color: FlutterFlowTheme.of(context).primary,
              size: 16.0,
            ),
            onPressed: () async {
              _model.timerController.timer.setPresetTime(
                mSec: valueOrDefault<int>(
                  widget!.timeMS,
                  30000,
                ),
                add: false,
              );
              _model.timerController.onResetTimer();

              _model.timerController.onStopTimer();
              _model.timePlayPauseStatus = 'play';
              safeSetState(() {});
            },
          ),
        if (widget!.startStatus == true)
          Stack(
            children: [
              if (_model.timePlayPauseStatus == 'play')
                FlutterFlowIconButton(
                  borderRadius: 8.0,
                  buttonSize: 35.0,
                  fillColor: Color(0x7267B5B0),
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    color: FlutterFlowTheme.of(context).success,
                    size: 20.0,
                  ),
                  onPressed: () async {
                    _model.timerController.onStartTimer();
                    _model.timePlayPauseStatus = 'pause';
                    safeSetState(() {});
                  },
                ),
              if (_model.timePlayPauseStatus == 'pause')
                FlutterFlowIconButton(
                  borderRadius: 8.0,
                  buttonSize: 35.0,
                  fillColor: Color(0x7267B5B0),
                  icon: Icon(
                    Icons.pause_rounded,
                    color: FlutterFlowTheme.of(context).success,
                    size: 16.0,
                  ),
                  onPressed: () async {
                    _model.timerController.onStopTimer();
                    _model.timePlayPauseStatus = 'play';
                    safeSetState(() {});
                  },
                ),
            ],
          ),
      ].divide(SizedBox(width: 8.0)),
    );
  }
}
