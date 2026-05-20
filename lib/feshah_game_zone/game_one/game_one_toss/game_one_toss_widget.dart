import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'game_one_toss_model.dart';
export 'game_one_toss_model.dart';

class GameOneTossWidget extends StatefulWidget {
  const GameOneTossWidget({
    super.key,
    required this.room,
    required this.selectedIndex,
  });

  final DocumentReference? room;
  final int? selectedIndex;

  @override
  State<GameOneTossWidget> createState() => _GameOneTossWidgetState();
}

class _GameOneTossWidgetState extends State<GameOneTossWidget> {
  late GameOneTossModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameOneTossModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: StreamBuilder<RoomRecord>(
        stream: RoomRecord.getDocument(widget!.room!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 2.0,
                height: 2.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0x00EC4D41),
                  ),
                ),
              ),
            );
          }

          final containerRoomRecord = snapshot.data!;

          return Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_model.flipStatus == 'start')
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/Comp2_2-ezgif.com-video-to-gif-converter.gif',
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 1.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: FFLocalizations.of(context).getText(
                                      'w44rxnym' /* Click the button to flip the c... */,
                                    ),
                                    style: TextStyle(),
                                  )
                                ],
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.selectedGameList = containerRoomRecord
                                  .selectedGameList
                                  .toList()
                                  .cast<SelectedGameListStruct>();
                              _model.flipResult =
                                  random_data.randomInteger(0, 2);
                              _model.flipStatus = 'done';
                              _model.flipResult = _model.selectedGameList
                                          .elementAtOrNull(
                                              widget!.selectedIndex!)
                                          ?.teamInfo
                                          ?.length ==
                                      2
                                  ? ((_model.flipResult == 1) ||
                                          (_model.flipResult == 2)
                                      ? 1
                                      : 0)
                                  : _model.flipResult;
                              safeSetState(() {});
                            },
                            text: FFLocalizations.of(context).getText(
                              'l0mneerr' /* Toss the coin */,
                            ),
                            icon: Icon(
                              FFIcons.kfi44,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              width: 150.0,
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Gentona Medium',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
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
                        ],
                      ),
                    ),
                  if (_model.flipStatus != 'start')
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Lottie.asset(
                          'assets/jsons/data_(3).json',
                          width: 100.0,
                          height: 80.0,
                          fit: BoxFit.contain,
                          animate: true,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 8.0),
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: containerRoomRecord.selectedGameList
                                      .elementAtOrNull(widget!.selectedIndex!)!
                                      .teamInfo
                                      .elementAtOrNull(_model.flipResult!)!
                                      .teamInfo
                                      .name,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        font: GoogleFonts.almarai(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                        ),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                ),
                                TextSpan(
                                  text: FFLocalizations.of(context).getText(
                                    'jagrq08a' /*  wins the toss! */,
                                  ),
                                  style: TextStyle(),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            _model.selectedGameList = containerRoomRecord
                                .selectedGameList
                                .toList()
                                .cast<SelectedGameListStruct>();
                            _model.updateSelectedGameListAtIndex(
                              widget!.selectedIndex!,
                              (e) => e
                                ..presentTeamID = (_model.selectedGameList
                                        .elementAtOrNull(widget!.selectedIndex!)
                                        ?.teamInfo
                                        ?.elementAtOrNull(_model.flipResult!))
                                    ?.teamID
                                ..gameTossWinTeamId = (_model.selectedGameList
                                        .elementAtOrNull(widget!.selectedIndex!)
                                        ?.teamInfo
                                        ?.elementAtOrNull(_model.flipResult!))
                                    ?.teamID
                                ..presentTeamIndex = _model.flipResult
                                ..gameTosswinTeamIndex = _model.flipResult,
                            );

                            await widget!.room!.update({
                              ...mapToFirestore(
                                {
                                  'selected_game_list':
                                      getSelectedGameListListFirestoreData(
                                    _model.selectedGameList,
                                  ),
                                },
                              ),
                            });
                            if (currentUserDocument
                                    ?.userSetting?.isSoundstatus ==
                                true) {
                              _model.soundPlayer ??= AudioPlayer();
                              if (_model.soundPlayer!.playing) {
                                await _model.soundPlayer!.stop();
                              }
                              _model.soundPlayer!.setVolume(0.2);
                              _model.soundPlayer!
                                  .setAsset('assets/audios/Game_Opening.mp3')
                                  .then((_) => _model.soundPlayer!.play());
                            }
                            _model.flipStatus = 'completed';
                            _model.updatePage(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'dn3w6pqv' /* Continue */,
                          ),
                          options: FFButtonOptions(
                            width: 100.0,
                            height: 32.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Gentona Medium',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
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
                      ],
                    ),
                ].divide(SizedBox(height: 8.0)),
              ),
            ),
          );
        },
      ),
    );
  }
}
