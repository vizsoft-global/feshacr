import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_one_tie_start_model.dart';
export 'game_one_tie_start_model.dart';

class GameOneTieStartWidget extends StatefulWidget {
  const GameOneTieStartWidget({
    super.key,
    required this.room,
    required this.selectedIndex,
  });

  final RoomRecord? room;
  final int? selectedIndex;

  @override
  State<GameOneTieStartWidget> createState() => _GameOneTieStartWidgetState();
}

class _GameOneTieStartWidgetState extends State<GameOneTieStartWidget> {
  late GameOneTieStartModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameOneTieStartModel());

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
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primaryText,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'gv71ubzl' /* Tie Breaker */,
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      font: GoogleFonts.almarai(
                        fontWeight: FontWeight.w600,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
              child: RichText(
                textScaler: MediaQuery.of(context).textScaler,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: FFLocalizations.of(context).getText(
                        'gbxc7ldr' /* Answer 10 rapid-fire questions... */,
                      ),
                      style: TextStyle(),
                    )
                  ],
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.almarai(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
              child: RichText(
                textScaler: MediaQuery.of(context).textScaler,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget!.room!.selectedGameList
                          .elementAtOrNull(widget!.selectedIndex!)!
                          .teamInfo
                          .elementAtOrNull(widget!.room!.selectedGameList
                              .elementAtOrNull(widget!.selectedIndex!)!
                              .presentTeamIndex)!
                          .teamInfo
                          .name,
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.almarai(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                    ),
                    TextSpan(
                      text: FFLocalizations.of(context).getText(
                        'a0ltk6s3' /*  now your turn */,
                      ),
                      style: TextStyle(),
                    )
                  ],
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.almarai(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                _model.selectedGameList = widget!.room!.selectedGameList
                    .toList()
                    .cast<SelectedGameListStruct>();
                _model.updateSelectedGameListAtIndex(
                  widget!.selectedIndex!,
                  (e) => e
                    ..gameTieBreakStatus = 'start'
                    ..gameTieBreakStartTime = getCurrentTimestamp,
                );

                await widget!.room!.reference.update({
                  ...mapToFirestore(
                    {
                      'selected_game_list':
                          getSelectedGameListListFirestoreData(
                        _model.selectedGameList,
                      ),
                    },
                  ),
                });
                _model.refresh = (_model.refresh!) + 1;
                _model.updatePage(() {});
              },
              text: FFLocalizations.of(context).getText(
                'killujuq' /* Start the game */,
              ),
              options: FFButtonOptions(
                width: 150.0,
                height: 50.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Gentona Medium',
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryText,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ].divide(SizedBox(height: 8.0)),
        ),
      ),
    );
  }
}
