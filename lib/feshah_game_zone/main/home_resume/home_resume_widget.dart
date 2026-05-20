import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_resume_model.dart';
export 'home_resume_model.dart';

class HomeResumeWidget extends StatefulWidget {
  const HomeResumeWidget({
    super.key,
    required this.room,
    required this.selectedGameID,
  });

  final DocumentReference? room;
  final int? selectedGameID;

  @override
  State<HomeResumeWidget> createState() => _HomeResumeWidgetState();
}

class _HomeResumeWidgetState extends State<HomeResumeWidget> {
  late HomeResumeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeResumeModel());

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
      child: AuthUserStreamWidget(
        builder: (context) => StreamBuilder<List<GameRecord>>(
          stream: queryGameRecord(
            queryBuilder: (gameRecord) => gameRecord.where(
              'game_ID',
              isEqualTo: currentUserDocument?.presentRoomGameInfo?.roomGameId,
            ),
            singleRecord: true,
          ),
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
            List<GameRecord> containerGameRecordList = snapshot.data!;
            // Return an empty Container when the item does not exist.
            if (snapshot.data!.isEmpty) {
              return Container();
            }
            final containerGameRecord = containerGameRecordList.isNotEmpty
                ? containerGameRecordList.first
                : null;

            return ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                width: 350.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primaryText,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(1.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await currentUserReference!
                                  .update(createUsersRecordData(
                                presentRoomGameInfo:
                                    createPresentRoomGameInfoStruct(
                                        delete: true),
                              ));
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            containerGameRecord!.gameInfo.mainImage,
                            width: 150.0,
                            height: 150.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '87m5grfv' /* Resume Your Game? */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                font: GoogleFonts.almarai(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                        ),
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          '7j3gs4xk' /* You were in the middle of a ga... */,
                        ),
                        textAlign: TextAlign.center,
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
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: FFButtonWidget(
                                onPressed: () async {
                                  _model.presentRoomResult =
                                      await RoomRecord.getDocumentOnce(
                                          currentUserDocument!
                                              .presentRoomGameInfo.roomRef!);
                                  if ((_model.presentRoomResult
                                              ?.selectedGameList
                                              ?.where((e) =>
                                                  e.selectedGameID ==
                                                  currentUserDocument
                                                      ?.presentRoomGameInfo
                                                      ?.roomSelectedGameID)
                                              .toList()
                                              ?.firstOrNull
                                              ?.gameResult
                                              ?.status !=
                                          'win') ||
                                      (_model.presentRoomResult
                                              ?.selectedGameList
                                              ?.where((e) =>
                                                  e.selectedGameID ==
                                                  currentUserDocument
                                                      ?.presentRoomGameInfo
                                                      ?.roomSelectedGameID)
                                              .toList()
                                              ?.firstOrNull
                                              ?.gameResult
                                              ?.status !=
                                          'tie')) {
                                    if ((currentUserDocument
                                                ?.presentRoomGameInfo
                                                ?.roomGameId ==
                                            1001) ||
                                        (currentUserDocument
                                                ?.presentRoomGameInfo
                                                ?.roomGameId ==
                                            1003)) {
                                      if (currentUserDocument
                                              ?.presentRoomGameInfo
                                              ?.roomAdminRef ==
                                          currentUserReference) {
                                        if (_model.presentRoomResult!
                                                .selectedGameList
                                                .where((e) =>
                                                    e.selectedGameID ==
                                                    currentUserDocument
                                                        ?.presentRoomGameInfo
                                                        ?.roomSelectedGameID)
                                                .toList()
                                                .firstOrNull!
                                                .teamInfo
                                                .length <=
                                            0) {
                                          FFAppState().gameZoneSteps = 1;
                                          if (currentUserDocument
                                                  ?.presentRoomGameInfo
                                                  ?.roomGameId ==
                                              1001) {
                                            FFAppState().gameZoneSteps = 1;

                                            context.goNamed(
                                              GameOneWidget.routeName,
                                              queryParameters: {
                                                'room': serializeParam(
                                                  _model.presentRoomResult
                                                      ?.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          } else {
                                            if (currentUserDocument
                                                    ?.presentRoomGameInfo
                                                    ?.roomGameId ==
                                                1003) {
                                              context.goNamed(
                                                GameFourWidget.routeName,
                                                queryParameters: {
                                                  'room': serializeParam(
                                                    _model.presentRoomResult
                                                        ?.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            }
                                          }
                                        } else {
                                          if (_model.presentRoomResult!
                                                  .selectedGameList
                                                  .where((e) =>
                                                      e.selectedGameID ==
                                                      currentUserDocument
                                                          ?.presentRoomGameInfo
                                                          ?.roomSelectedGameID)
                                                  .toList()
                                                  .firstOrNull!
                                                  .selectedTopicIDList
                                                  .length <=
                                              0) {
                                            FFAppState().gameZoneSteps = 2;
                                            if (currentUserDocument
                                                    ?.presentRoomGameInfo
                                                    ?.roomGameId ==
                                                1001) {
                                              FFAppState().gameZoneSteps = 2;

                                              context.goNamed(
                                                GameOneWidget.routeName,
                                                queryParameters: {
                                                  'room': serializeParam(
                                                    _model.presentRoomResult
                                                        ?.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            } else {
                                              if (currentUserDocument
                                                      ?.presentRoomGameInfo
                                                      ?.roomGameId ==
                                                  1003) {
                                                context.goNamed(
                                                  GameFourWidget.routeName,
                                                  queryParameters: {
                                                    'room': serializeParam(
                                                      _model.presentRoomResult
                                                          ?.reference,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              }
                                            }
                                          } else {
                                            if ((_model.presentRoomResult
                                                        ?.selectedGameList
                                                        ?.where((e) =>
                                                            e.selectedGameID ==
                                                            currentUserDocument
                                                                ?.presentRoomGameInfo
                                                                ?.roomSelectedGameID)
                                                        .toList()
                                                        ?.firstOrNull
                                                        ?.gameTieBreakStatus ==
                                                    'SetWaitStart') ||
                                                (_model.presentRoomResult
                                                        ?.selectedGameList
                                                        ?.where((e) =>
                                                            e.selectedGameID ==
                                                            currentUserDocument
                                                                ?.presentRoomGameInfo
                                                                ?.roomSelectedGameID)
                                                        .toList()
                                                        ?.firstOrNull
                                                        ?.gameTieBreakStatus ==
                                                    'start')) {
                                              if (currentUserDocument
                                                      ?.presentRoomGameInfo
                                                      ?.roomGameId ==
                                                  1001) {
                                                context.goNamed(
                                                  GameOneS2Widget.routeName,
                                                  queryParameters: {
                                                    'room': serializeParam(
                                                      _model.presentRoomResult
                                                          ?.reference,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                    'tieBreakStatus':
                                                        serializeParam(
                                                      true,
                                                      ParamType.bool,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              } else {
                                                if (currentUserDocument
                                                        ?.presentRoomGameInfo
                                                        ?.roomGameId ==
                                                    1003) {
                                                  context.goNamed(
                                                    GameFourS2Widget.routeName,
                                                    queryParameters: {
                                                      'room': serializeParam(
                                                        widget!.room,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                      'tieBreakStatus':
                                                          serializeParam(
                                                        true,
                                                        ParamType.bool,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                }
                                              }
                                            } else {
                                              if (currentUserDocument
                                                      ?.presentRoomGameInfo
                                                      ?.roomGameId ==
                                                  1001) {
                                                context.goNamed(
                                                  GameOneS1Widget.routeName,
                                                  queryParameters: {
                                                    'room': serializeParam(
                                                      widget!.room,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              } else {
                                                if (currentUserDocument
                                                        ?.presentRoomGameInfo
                                                        ?.roomGameId ==
                                                    1003) {
                                                  context.goNamed(
                                                    GameFourS1Widget.routeName,
                                                    queryParameters: {
                                                      'room': serializeParam(
                                                        widget!.room,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                }
                                              }
                                            }
                                          }
                                        }
                                      } else {
                                        await currentUserReference!
                                            .update(createUsersRecordData(
                                          presentRoomGameInfo:
                                              createPresentRoomGameInfoStruct(
                                                  delete: true),
                                        ));
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      if (currentUserDocument
                                              ?.presentRoomGameInfo
                                              ?.roomGameId ==
                                          1002) {
                                        context.goNamed(
                                          GameTwoWidget.routeName,
                                          queryParameters: {
                                            'room': serializeParam(
                                              widget!.room,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      } else {
                                        if (currentUserDocument
                                                ?.presentRoomGameInfo
                                                ?.roomGameId ==
                                            1004) {
                                          context.goNamed(
                                            GameFiveWidget.routeName,
                                            queryParameters: {
                                              'room': serializeParam(
                                                widget!.room,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        }
                                      }
                                    }
                                  } else {
                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      presentRoomGameInfo:
                                          createPresentRoomGameInfoStruct(
                                              delete: true),
                                    ));
                                    Navigator.pop(context);
                                  }

                                  safeSetState(() {});
                                },
                                text: FFLocalizations.of(context).getText(
                                  'ultamev2' /* Continue Game */,
                                ),
                                options: FFButtonOptions(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 8.0)),
                        ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
