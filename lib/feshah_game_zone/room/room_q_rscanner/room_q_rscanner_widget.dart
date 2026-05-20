import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'room_q_rscanner_model.dart';
export 'room_q_rscanner_model.dart';

class RoomQRscannerWidget extends StatefulWidget {
  const RoomQRscannerWidget({super.key});

  @override
  State<RoomQRscannerWidget> createState() => _RoomQRscannerWidgetState();
}

class _RoomQRscannerWidgetState extends State<RoomQRscannerWidget> {
  late RoomQRscannerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RoomQRscannerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(1.0, -1.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                ),
              ),
              Container(
                width: 250.0,
                height: 250.0,
                child: Stack(
                  children: [
                    if (isWeb == false)
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            var _shouldSetState = false;
                            if (loggedIn == true) {
                              _model.scanResult =
                                  await FlutterBarcodeScanner.scanBarcode(
                                '#C62828', // scanning line color
                                FFLocalizations.of(context).getText(
                                  'ivti1hj0' /* Cancel */,
                                ), // cancel button text
                                true, // whether to show the torch (camera LED) toggle icon
                                ScanMode.QR,
                              );

                              _shouldSetState = true;
                              _model.qrValue = functions
                                  .str2split(_model.scanResult!)
                                  .toList()
                                  .cast<String>();
                              _model.roomID =
                                  int.parse((_model.qrValue.firstOrNull!));
                              _model.selectGameID =
                                  int.parse((_model.qrValue.lastOrNull!));
                              _model.qrScannerResultMob =
                                  await queryRoomRecordOnce(
                                queryBuilder: (roomRecord) => roomRecord
                                    .where(
                                      'room_code',
                                      isEqualTo: _model.roomID,
                                    )
                                    .where(
                                      'room_status',
                                      isEqualTo: 'active',
                                    ),
                                singleRecord: true,
                              ).then((s) => s.firstOrNull);
                              _shouldSetState = true;
                              if ((_model.qrScannerResultMob != null) == true) {
                                if (_model.qrScannerResultMob?.roomType ==
                                        'solo'
                                    ? true
                                    : (_model.qrScannerResultMob!
                                            .roomMemberLimit >
                                        _model.qrScannerResultMob!.roomUserList
                                            .length)) {
                                  _model.gameList = _model
                                      .qrScannerResultMob!.selectedGameList
                                      .toList()
                                      .cast<SelectedGameListStruct>();
                                  _model.countGame = _model.qrScannerResultMob
                                      ?.selectedGameList?.length;
                                  _model.roomUserList = _model
                                      .qrScannerResultMob!.roomUserList
                                      .toList()
                                      .cast<RoomUserListStruct>();
                                  _model.gameUserList = _model
                                      .qrScannerResultMob!.selectedGameList
                                      .where((e) =>
                                          e.selectedGameID ==
                                          _model.selectGameID)
                                      .toList()
                                      .firstOrNull!
                                      .selectedGameUserList
                                      .toList()
                                      .cast<RoomUserListStruct>();
                                  while (_model.countGame! > 0) {
                                    if (_model.gameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.selectedGameID ==
                                        _model.selectGameID) {
                                      if (_model.roomUserList
                                              .where((e) =>
                                                  e.roomUserRef ==
                                                  currentUserReference)
                                              .toList()
                                              .length ==
                                          0) {
                                        _model.addToRoomUserList(
                                            RoomUserListStruct(
                                          roomUserOnlineStatus: 'active',
                                          roomUserStatus: 'active',
                                          roomUserUpdatedTime:
                                              getCurrentTimestamp,
                                          roomUserJoinTime: getCurrentTimestamp,
                                          roomUserId: valueOrDefault(
                                              currentUserDocument?.userId, 0),
                                          roomUserRef: currentUserReference,
                                        ));
                                      }
                                      if (_model.gameUserList
                                              .where((e) =>
                                                  e.roomUserRef ==
                                                  currentUserReference)
                                              .toList()
                                              .length ==
                                          0) {
                                        _model.addToGameUserList(
                                            RoomUserListStruct(
                                          roomUserOnlineStatus: 'active',
                                          roomUserStatus: 'active',
                                          roomUserUpdatedTime:
                                              getCurrentTimestamp,
                                          roomUserJoinTime: getCurrentTimestamp,
                                          roomUserId: valueOrDefault(
                                              currentUserDocument?.userId, 0),
                                          roomUserRef: currentUserReference,
                                          roomUserNotificationSendStatus:
                                              'stocker',
                                        ));
                                        _model.updateGameListAtIndex(
                                          (_model.countGame!) - 1,
                                          (e) => e
                                            ..selectedGameUserList =
                                                _model.gameUserList.toList(),
                                        );
                                      }

                                      await _model.qrScannerResultMob!.reference
                                          .update({
                                        ...createRoomRecordData(
                                          roomUpdatedAt: getCurrentTimestamp,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'room_user_list':
                                                getRoomUserListListFirestoreData(
                                              _model.roomUserList,
                                            ),
                                            'selected_game_list':
                                                getSelectedGameListListFirestoreData(
                                              _model.gameList,
                                            ),
                                          },
                                        ),
                                      });

                                      await currentUserReference!
                                          .update(createUsersRecordData(
                                        presentRoomGameInfo:
                                            createPresentRoomGameInfoStruct(
                                          roomRef: _model
                                              .qrScannerResultMob?.reference,
                                          roomAdminRef: _model
                                              .qrScannerResultMob
                                              ?.roomCreatedUserRef,
                                          roomGameAdminStatus: 'start',
                                          roomSelectedGameID:
                                              _model.selectGameID,
                                          roomGameId: _model.qrScannerResultMob
                                              ?.selectedGameList
                                              ?.where((e) =>
                                                  e.selectedGameID ==
                                                  _model.selectGameID)
                                              .toList()
                                              ?.firstOrNull
                                              ?.gameId,
                                          clearUnsetFields: false,
                                        ),
                                      ));
                                      if (_model.qrScannerResultMob
                                              ?.selectedGameList
                                              ?.where((e) =>
                                                  e.selectedGameID ==
                                                  _model.selectGameID)
                                              .toList()
                                              ?.firstOrNull
                                              ?.gameId ==
                                          1001) {
                                        context.goNamed(
                                          GameOneS2Widget.routeName,
                                          queryParameters: {
                                            'room': serializeParam(
                                              _model.qrScannerResultMob
                                                  ?.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );

                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      } else {
                                        if (_model.qrScannerResultMob
                                                ?.selectedGameList
                                                ?.where((e) =>
                                                    e.selectedGameID ==
                                                    _model.selectGameID)
                                                .toList()
                                                ?.firstOrNull
                                                ?.gameId ==
                                            1002) {
                                          context.goNamed(
                                            GameTwoWidget.routeName,
                                            queryParameters: {
                                              'room': serializeParam(
                                                _model.qrScannerResultMob
                                                    ?.reference,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );

                                          if (_shouldSetState)
                                            safeSetState(() {});
                                          return;
                                        } else {
                                          if (_shouldSetState)
                                            safeSetState(() {});
                                          return;
                                        }
                                      }
                                    }
                                    _model.countGame = (_model.countGame!) - 1;
                                  }
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          content: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                            enText:
                                                'The maximum number of room members has been exceeded.',
                                            arText:
                                                'لقد تم تجاوز الحد الأقصى لعدد أعضاء الغرفة.',
                                          )),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text(
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                enText: 'Ok',
                                                arText: 'نعم',
                                              )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                }
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        content: Text(
                                            FFLocalizations.of(context)
                                                .getVariableText(
                                          enText: 'No room found.',
                                          arText: 'لم يتم العثور على غرفة.',
                                        )),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              enText: 'Ok',
                                              arText: 'نعم',
                                            )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }
                            } else {
                              context.goNamed(
                                LoginWidget.routeName,
                                extra: <String, dynamic>{
                                  '__transition_info__': TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );

                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }

                            if (_shouldSetState) safeSetState(() {});
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Qr_code_(1)_(1).gif',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    if (isWeb == true)
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            var _shouldSetState = false;
                            _model.qrValue = functions
                                .str2split(FFAppState().QRvalue)
                                .toList()
                                .cast<String>();
                            _model.roomID =
                                int.parse((_model.qrValue.firstOrNull!));
                            _model.selectGameID =
                                int.parse((_model.qrValue.lastOrNull!));
                            _model.qrScannerResultWeb =
                                await queryRoomRecordOnce(
                              queryBuilder: (roomRecord) => roomRecord
                                  .where(
                                    'room_code',
                                    isEqualTo: _model.roomID,
                                  )
                                  .where(
                                    'room_status',
                                    isEqualTo: 'active',
                                  ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);
                            _shouldSetState = true;
                            if ((_model.qrScannerResultWeb != null) == true) {
                              if (_model.qrScannerResultWeb?.roomType == 'solo'
                                  ? true
                                  : (_model
                                          .qrScannerResultWeb!.roomMemberLimit >
                                      _model.qrScannerResultWeb!.roomUserList
                                          .length)) {
                                _model.gameList = _model
                                    .qrScannerResultWeb!.selectedGameList
                                    .toList()
                                    .cast<SelectedGameListStruct>();
                                _model.countGame = _model.qrScannerResultWeb
                                    ?.selectedGameList?.length;
                                _model.roomUserList = _model
                                    .qrScannerResultWeb!.roomUserList
                                    .toList()
                                    .cast<RoomUserListStruct>();
                                _model.gameUserList = _model
                                    .qrScannerResultWeb!.selectedGameList
                                    .where((e) =>
                                        e.selectedGameID == _model.selectGameID)
                                    .toList()
                                    .firstOrNull!
                                    .selectedGameUserList
                                    .toList()
                                    .cast<RoomUserListStruct>();
                                while (_model.countGame! > 0) {
                                  if (_model.gameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)
                                          ?.selectedGameID ==
                                      _model.selectGameID) {
                                    if (_model.roomUserList
                                            .where((e) =>
                                                e.roomUserRef ==
                                                currentUserReference)
                                            .toList()
                                            .length ==
                                        0) {
                                      _model
                                          .addToRoomUserList(RoomUserListStruct(
                                        roomUserOnlineStatus: 'active',
                                        roomUserStatus: 'active',
                                        roomUserUpdatedTime:
                                            getCurrentTimestamp,
                                        roomUserJoinTime: getCurrentTimestamp,
                                        roomUserId: valueOrDefault(
                                            currentUserDocument?.userId, 0),
                                        roomUserRef: currentUserReference,
                                      ));
                                    }
                                    if (_model.gameUserList
                                            .where((e) =>
                                                e.roomUserRef ==
                                                currentUserReference)
                                            .toList()
                                            .length ==
                                        0) {
                                      _model
                                          .addToGameUserList(RoomUserListStruct(
                                        roomUserOnlineStatus: 'active',
                                        roomUserStatus: 'active',
                                        roomUserUpdatedTime:
                                            getCurrentTimestamp,
                                        roomUserJoinTime: getCurrentTimestamp,
                                        roomUserId: valueOrDefault(
                                            currentUserDocument?.userId, 0),
                                        roomUserRef: currentUserReference,
                                        roomUserNotificationSendStatus:
                                            'stocker',
                                      ));
                                      _model.updateGameListAtIndex(
                                        (_model.countGame!) - 1,
                                        (e) => e
                                          ..selectedGameUserList =
                                              _model.gameUserList.toList(),
                                      );
                                    }

                                    await _model.qrScannerResultWeb!.reference
                                        .update({
                                      ...createRoomRecordData(
                                        roomUpdatedAt: getCurrentTimestamp,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'room_user_list':
                                              getRoomUserListListFirestoreData(
                                            _model.roomUserList,
                                          ),
                                          'selected_game_list':
                                              getSelectedGameListListFirestoreData(
                                            _model.gameList,
                                          ),
                                        },
                                      ),
                                    });

                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      presentRoomGameInfo:
                                          createPresentRoomGameInfoStruct(
                                        roomRef: _model
                                            .qrScannerResultWeb?.reference,
                                        roomAdminRef: _model.qrScannerResultWeb
                                            ?.roomCreatedUserRef,
                                        roomGameAdminStatus: 'start',
                                        roomSelectedGameID: _model.selectGameID,
                                        roomGameId: _model.qrScannerResultWeb
                                            ?.selectedGameList
                                            ?.where((e) =>
                                                e.selectedGameID ==
                                                _model.selectGameID)
                                            .toList()
                                            ?.firstOrNull
                                            ?.gameId,
                                        clearUnsetFields: false,
                                      ),
                                    ));
                                    if (_model.qrScannerResultWeb
                                            ?.selectedGameList
                                            ?.where((e) =>
                                                e.selectedGameID ==
                                                _model.selectGameID)
                                            .toList()
                                            ?.firstOrNull
                                            ?.gameId ==
                                        1001) {
                                      context.goNamed(
                                        GameOneS2Widget.routeName,
                                        queryParameters: {
                                          'room': serializeParam(
                                            _model
                                                .qrScannerResultWeb?.reference,
                                            ParamType.DocumentReference,
                                          ),
                                        }.withoutNulls,
                                      );

                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    } else {
                                      if (_model.qrScannerResultWeb
                                              ?.selectedGameList
                                              ?.where((e) =>
                                                  e.selectedGameID ==
                                                  _model.selectGameID)
                                              .toList()
                                              ?.firstOrNull
                                              ?.gameId ==
                                          1002) {
                                        context.goNamed(
                                          GameTwoWidget.routeName,
                                          queryParameters: {
                                            'room': serializeParam(
                                              _model.qrScannerResultWeb
                                                  ?.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );

                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      } else {
                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      }
                                    }
                                  }
                                  _model.countGame = (_model.countGame!) - 1;
                                }
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        content: Text(
                                            'The maximum number of room members has been exceeded.'),
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
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      content: Text('No room found.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }

                            if (_shouldSetState) safeSetState(() {});
                          },
                          child: Container(
                            width: 250.0,
                            height: 250.0,
                            child: custom_widgets.Qrscanner(
                              width: 300.0,
                              height: 300.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    '0sal2b9p' /* Tap the QR image to scan. */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.almarai(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
