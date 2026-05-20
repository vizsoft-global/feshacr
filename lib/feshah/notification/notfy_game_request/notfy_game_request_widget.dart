import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'notfy_game_request_model.dart';
export 'notfy_game_request_model.dart';

class NotfyGameRequestWidget extends StatefulWidget {
  const NotfyGameRequestWidget({
    super.key,
    required this.notification,
  });

  final NotificationRecord? notification;

  @override
  State<NotfyGameRequestWidget> createState() => _NotfyGameRequestWidgetState();
}

class _NotfyGameRequestWidgetState extends State<NotfyGameRequestWidget> {
  late NotfyGameRequestModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotfyGameRequestModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primaryText,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      textScaler: MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget!.notification!.gameInfo.fromUserName,
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                          ),
                          TextSpan(
                            text: FFLocalizations.of(context).getText(
                              'dunk7f7e' /*  has invited to */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.almarai(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          )
                        ],
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.almarai(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await widget!.notification!.reference
                            .update(createNotificationRecordData(
                          updatedAt: getCurrentTimestamp,
                          notificationType: 'room_clear',
                          notificationStatus: 'clear',
                        ));
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.asset(
                        'assets/images/_Group_.png',
                        width: 32.0,
                        height: 32.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<List<GameRecord>>(
                            stream: queryGameRecord(
                              queryBuilder: (gameRecord) => gameRecord.where(
                                'game_ID',
                                isEqualTo:
                                    widget!.notification?.gameInfo?.gameID,
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
                              List<GameRecord> textGameRecordList =
                                  snapshot.data!;
                              final textGameRecord =
                                  textGameRecordList.isNotEmpty
                                      ? textGameRecordList.first
                                      : null;

                              return Text(
                                FFLocalizations.of(context).getVariableText(
                                  enText: () {
                                    if (textGameRecord?.gameInfoManualTranslate
                                            ?.name?.en !=
                                        '') {
                                      return textGameRecord
                                          ?.gameInfoManualTranslate?.name?.en;
                                    } else if (textGameRecord
                                            ?.gameInfoTranslate?.name?.en !=
                                        '') {
                                      return textGameRecord
                                          ?.gameInfoTranslate?.name?.en;
                                    } else {
                                      return textGameRecord?.gameInfo?.name;
                                    }
                                  }(),
                                  arText: () {
                                    if (textGameRecord?.gameInfoManualTranslate
                                            ?.name?.ar !=
                                        '') {
                                      return textGameRecord
                                          ?.gameInfoManualTranslate?.name?.ar;
                                    } else if (textGameRecord
                                            ?.gameInfoTranslate?.name?.ar !=
                                        '') {
                                      return textGameRecord
                                          ?.gameInfoTranslate?.name?.ar;
                                    } else {
                                      return textGameRecord?.gameInfo?.name;
                                    }
                                  }(),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                              );
                            },
                          ),
                          Text(
                            widget!.notification!.roomInfo.roomInfo.name,
                            textAlign: TextAlign.start,
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          _model.roomResult1 = await queryRoomRecordOnce(
                            queryBuilder: (roomRecord) => roomRecord.where(
                              'room_ID',
                              isEqualTo: widget!.notification?.gameInfo?.roomId,
                            ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          _model.countGameList =
                              _model.roomResult1?.selectedGameList?.length;
                          _model.selectedGameList = _model
                              .roomResult1!.selectedGameList
                              .toList()
                              .cast<SelectedGameListStruct>();
                          while (_model.countGameList! > 0) {
                            if (_model.selectedGameList
                                    .elementAtOrNull(
                                        (_model.countGameList!) - 1)
                                    ?.selectedGameID ==
                                widget!.notification?.gameInfo
                                    ?.roomUserSelectedGameId) {
                              if (!((_model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGameList!) - 1)
                                          ?.gameResult
                                          ?.status !=
                                      'win') ||
                                  (_model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGameList!) - 1)
                                          ?.gameResult
                                          ?.status !=
                                      'notYet'))) {
                                break;
                              }
                              _model.selectedUserList = _model.selectedGameList
                                  .elementAtOrNull((_model.countGameList!) - 1)!
                                  .selectedGameUserList
                                  .toList()
                                  .cast<RoomUserListStruct>();
                              _model.countUserList = _model.selectedGameList
                                  .elementAtOrNull((_model.countGameList!) - 1)
                                  ?.selectedGameUserList
                                  ?.length;
                              while (_model.countUserList! > 0) {
                                if (_model.selectedUserList
                                        .elementAtOrNull(
                                            (_model.countUserList!) - 1)
                                        ?.roomUserRef ==
                                    currentUserReference) {
                                  _model.updateSelectedGameListAtIndex(
                                    (_model.countGameList!) - 1,
                                    (e) => e
                                      ..updateSelectedGameUserList(
                                        (e) => e[(_model.countUserList!) - 1]
                                          ..roomUserJoinTime =
                                              getCurrentTimestamp
                                          ..roomUserStatus = 'active'
                                          ..roomUserOnlineStatus = 'active'
                                          ..roomUserUpdatedTime =
                                              getCurrentTimestamp
                                          ..roomUserNotificationSendStatus =
                                              'stocker',
                                      ),
                                  );
                                  break;
                                }
                                _model.countUserList =
                                    (_model.countUserList!) - 1;
                              }
                              break;
                            }
                            _model.countGameList = (_model.countGameList!) - 1;
                          }

                          await _model.roomResult1!.reference.update({
                            ...mapToFirestore(
                              {
                                'selected_game_list':
                                    getSelectedGameListListFirestoreData(
                                  _model.selectedGameList,
                                ),
                              },
                            ),
                          });
                          _model.gameResult = await queryGameRecordOnce(
                            queryBuilder: (gameRecord) => gameRecord.where(
                              'game_ID',
                              isEqualTo: widget!.notification?.gameInfo?.gameID,
                            ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);

                          await currentUserReference!
                              .update(createUsersRecordData(
                            presentRoomGameInfo:
                                createPresentRoomGameInfoStruct(
                              roomRef: _model.roomResult1?.reference,
                              roomAdminRef:
                                  _model.roomResult1?.roomCreatedUserRef,
                              roomGameAdminStatus: 'start',
                              roomSelectedGameID: widget!.notification?.gameInfo
                                  ?.roomUserSelectedGameId,
                              roomGameId:
                                  widget!.notification?.gameInfo?.gameID,
                              roomAdminSelectedGameRef:
                                  _model.gameResult?.reference,
                              clearUnsetFields: false,
                            ),
                          ));
                          unawaited(
                            () async {
                              await widget!.notification!.reference
                                  .update(createNotificationRecordData(
                                updatedAt: getCurrentTimestamp,
                                notificationType: 'game_active',
                                notificationStatus: 'active',
                              ));
                            }(),
                          );
                          if (_model.gameResult?.gameID == 1001) {
                            context.goNamed(
                              GameOneS2Widget.routeName,
                              queryParameters: {
                                'room': serializeParam(
                                  _model.roomResult1?.reference,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );
                          } else {
                            if (_model.gameResult?.gameID == 1002) {
                              if ((_model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGameList!) - 1)
                                          ?.gameResult
                                          ?.status !=
                                      'win') ||
                                  (_model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGameList!) - 1)
                                          ?.gameResult
                                          ?.status !=
                                      'notYet')) {
                                context.goNamed(
                                  GameTwoWidget.routeName,
                                  queryParameters: {
                                    'room': serializeParam(
                                      _model.roomResult1?.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );
                              } else {
                                unawaited(
                                  () async {
                                    await widget!.notification!.reference
                                        .update(createNotificationRecordData(
                                      updatedAt: getCurrentTimestamp,
                                      notificationType: 'game_deactive',
                                      notificationStatus: 'deactive',
                                    ));
                                  }(),
                                );
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        content: Text(
                                            FFLocalizations.of(context)
                                                .getVariableText(
                                          enText:
                                              'Game has been completed already.',
                                          arText:
                                              'تم الانتهاء من اللعبة بالفعل.',
                                        )),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            } else {
                              if (_model.gameResult?.gameID == 1004) {
                                if ((_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGameList!) - 1)
                                            ?.gameResult
                                            ?.status !=
                                        'win') ||
                                    (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGameList!) - 1)
                                            ?.gameResult
                                            ?.status !=
                                        'notYet')) {
                                  context.goNamed(
                                    GameFourWidget.routeName,
                                    queryParameters: {
                                      'room': serializeParam(
                                        _model.roomResult1?.reference,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                  );
                                } else {
                                  unawaited(
                                    () async {
                                      await widget!.notification!.reference
                                          .update(createNotificationRecordData(
                                        updatedAt: getCurrentTimestamp,
                                        notificationType: 'game_deactive',
                                        notificationStatus: 'deactive',
                                      ));
                                    }(),
                                  );
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          content: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                            enText:
                                                'Game has been completed already.',
                                            arText:
                                                'تم الانتهاء من اللعبة بالفعل.',
                                          )),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              }
                            }
                          }

                          safeSetState(() {});
                        },
                        text: FFLocalizations.of(context).getText(
                          'ncwmc49a' /* Accept */,
                        ),
                        options: FFButtonOptions(
                          width: 500.0,
                          height: 36.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconAlignment: IconAlignment.start,
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).tertiary,
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
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.roomResult2 = await queryRoomRecordOnce(
                              queryBuilder: (roomRecord) => roomRecord.where(
                                'room_ID',
                                isEqualTo:
                                    widget!.notification?.gameInfo?.roomId,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);
                            _model.countGameList =
                                _model.roomResult2?.selectedGameList?.length;
                            _model.selectedGameList = _model
                                .roomResult2!.selectedGameList
                                .toList()
                                .cast<SelectedGameListStruct>();
                            while (_model.countGameList! > 0) {
                              if (_model.selectedGameList
                                      .elementAtOrNull(
                                          (_model.countGameList!) - 1)
                                      ?.selectedGameID ==
                                  widget!.notification?.gameInfo
                                      ?.roomUserSelectedGameId) {
                                _model.selectedUserList = _model
                                    .selectedGameList
                                    .elementAtOrNull(
                                        (_model.countGameList!) - 1)!
                                    .selectedGameUserList
                                    .toList()
                                    .cast<RoomUserListStruct>();
                                _model.countUserList = _model.selectedGameList
                                    .elementAtOrNull(
                                        (_model.countGameList!) - 1)
                                    ?.selectedGameUserList
                                    ?.length;
                                while (_model.countUserList! > 0) {
                                  if (_model.selectedUserList
                                          .elementAtOrNull(
                                              (_model.countUserList!) - 1)
                                          ?.roomUserRef ==
                                      currentUserReference) {
                                    _model.updateSelectedGameListAtIndex(
                                      (_model.countGameList!) - 1,
                                      (e) => e
                                        ..updateSelectedGameUserList(
                                          (e) => e[(_model.countUserList!) - 1]
                                            ..roomUserJoinTime =
                                                getCurrentTimestamp
                                            ..roomUserStatus = 'deactive'
                                            ..roomUserOnlineStatus = 'deactive'
                                            ..roomUserUpdatedTime =
                                                getCurrentTimestamp,
                                        ),
                                    );
                                    break;
                                  }
                                  _model.countUserList =
                                      (_model.countUserList!) - 1;
                                }
                                break;
                              }
                              _model.countGameList =
                                  (_model.countGameList!) - 1;
                            }

                            await _model.roomResult2!.reference.update({
                              ...mapToFirestore(
                                {
                                  'selected_game_list':
                                      getSelectedGameListListFirestoreData(
                                    _model.selectedGameList,
                                  ),
                                },
                              ),
                            });

                            await widget!.notification!.reference
                                .update(createNotificationRecordData(
                              updatedAt: getCurrentTimestamp,
                              notificationType: 'game_deactive',
                              notificationStatus: 'deactive',
                            ));

                            safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'kh89uzcm' /* Decline */,
                          ),
                          options: FFButtonOptions(
                            width: 500.0,
                            height: 36.0,
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
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1.0, 1.0),
                child: Text(
                  dateTimeFormat(
                    "d/M h:mm a",
                    widget!.notification!.updatedAt!,
                    locale: FFLocalizations.of(context).languageCode,
                  ),
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.almarai(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 10.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodySmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodySmall.fontStyle,
                      ),
                ),
              ),
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}
