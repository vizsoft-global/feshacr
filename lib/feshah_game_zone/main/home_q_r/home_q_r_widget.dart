import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah_game_zone/main/q_r_question/q_r_question_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import '/u_i_game_six/game_six/hot_potato_qr_join.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home_q_r_model.dart';
export 'home_q_r_model.dart';

class HomeQRWidget extends StatefulWidget {
  const HomeQRWidget({super.key});

  @override
  State<HomeQRWidget> createState() => _HomeQRWidgetState();
}

class _HomeQRWidgetState extends State<HomeQRWidget> {
  late HomeQRModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeQRModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x19EC4D41),
              offset: Offset(
                0.0,
                5.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Builder(
          builder: (context) => InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              var _shouldSetState = false;
              FFAppState().deleteQRvalue();
              FFAppState().QRvalue = 'null';

              if (loggedIn == true) {
                _model.scanResult = await FlutterBarcodeScanner.scanBarcode(
                  '#C62828', // scanning line color
                  FFLocalizations.of(context).getText(
                    'okbpmh49' /* Cancel */,
                  ), // cancel button text
                  true, // whether to show the torch (camera LED) toggle icon
                  ScanMode.QR,
                );

                _shouldSetState = true;
                if (_model.scanResult == '-1') {
                  if (_shouldSetState) safeSetState(() {});
                  return;
                }

                _model.qrValue = functions
                    .str2split(_model.scanResult!)
                    .toList()
                    .cast<String>();
                _model.roomID = int.parse((_model.qrValue.firstOrNull!));
                _model.selectGameID = int.parse((_model.qrValue.lastOrNull!));
                if ((_model.scanResult == null || _model.scanResult == '') ||
                    (_model.scanResult == '')) {
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return WebViewAware(
                        child: AlertDialog(
                          content:
                              Text(FFLocalizations.of(context).getVariableText(
                            enText: 'No QR code detected.',
                            arText: 'لم يتم اكتشاف رمز الاستجابة السريعة.',
                          )),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext),
                              child: Text(
                                  FFLocalizations.of(context).getVariableText(
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
                } else {
                  if (_model.qrValue.length < 2) {
                    await showDialog(
                      barrierColor: Color(0x7B000000),
                      barrierDismissible: false,
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: WebViewAware(
                            child: Container(
                              height: 350.0,
                              width: MediaQuery.sizeOf(context).width * 0.75,
                              child: QRQuestionWidget(
                                question: _model.scanResult!,
                              ),
                            ),
                          ),
                        );
                      },
                    );

                    if (_shouldSetState) safeSetState(() {});
                    return;
                  }
                }

                _model.qrScannerResultMob = await queryRoomRecordOnce(
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
                  if (_model.qrScannerResultMob!.roomMemberLimit >
                      _model.qrScannerResultMob!.roomUserList.length) {
                    _model.gameList = _model
                        .qrScannerResultMob!.selectedGameList
                        .toList()
                        .cast<SelectedGameListStruct>();
                    _model.countGame =
                        _model.qrScannerResultMob?.selectedGameList?.length;
                    _model.roomUserList = _model
                        .qrScannerResultMob!.roomUserList
                        .toList()
                        .cast<RoomUserListStruct>();
                    _model.gameUserList = _model
                        .qrScannerResultMob!.selectedGameList
                        .where((e) => e.selectedGameID == _model.selectGameID)
                        .toList()
                        .firstOrNull!
                        .selectedGameUserList
                        .toList()
                        .cast<RoomUserListStruct>();
                    while (_model.countGame! > 0) {
                      if (_model.gameList
                              .elementAtOrNull((_model.countGame!) - 1)
                              ?.selectedGameID ==
                          _model.selectGameID) {
                        if (_model.roomUserList
                                .where((e) =>
                                    e.roomUserRef == currentUserReference)
                                .toList()
                                .length ==
                            0) {
                          _model.addToRoomUserList(RoomUserListStruct(
                            roomUserOnlineStatus: 'active',
                            roomUserStatus: 'active',
                            roomUserUpdatedTime: getCurrentTimestamp,
                            roomUserJoinTime: getCurrentTimestamp,
                            roomUserId:
                                valueOrDefault(currentUserDocument?.userId, 0),
                            roomUserRef: currentUserReference,
                          ));
                        }
                        if (_model.gameUserList
                                .where((e) =>
                                    e.roomUserRef == currentUserReference)
                                .toList()
                                .length ==
                            0) {
                          _model.addToGameUserList(RoomUserListStruct(
                            roomUserOnlineStatus: 'active',
                            roomUserStatus: 'active',
                            roomUserUpdatedTime: getCurrentTimestamp,
                            roomUserJoinTime: getCurrentTimestamp,
                            roomUserId:
                                valueOrDefault(currentUserDocument?.userId, 0),
                            roomUserRef: currentUserReference,
                            roomUserNotificationSendStatus: 'stocker',
                          ));
                          _model.updateGameListAtIndex(
                            (_model.countGame!) - 1,
                            (e) => e
                              ..selectedGameUserList =
                                  _model.gameUserList.toList(),
                          );
                        }

                        await _model.qrScannerResultMob!.reference.update({
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
                          presentRoomGameInfo: createPresentRoomGameInfoStruct(
                            roomRef: _model.qrScannerResultMob?.reference,
                            roomAdminRef:
                                _model.qrScannerResultMob?.roomCreatedUserRef,
                            roomGameAdminStatus: 'start',
                            roomSelectedGameID: _model.selectGameID,
                            roomGameId: _model
                                .qrScannerResultMob?.selectedGameList
                                ?.where((e) =>
                                    e.selectedGameID == _model.selectGameID)
                                .toList()
                                ?.firstOrNull
                                ?.gameId,
                            clearUnsetFields: false,
                          ),
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              FFLocalizations.of(context).getVariableText(
                                enText: 'Game found. You added successfully.',
                                arText: 'تم العثور على اللعبة. لقد أضفت بنجاح.',
                              ),
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                        if (_model.qrScannerResultMob?.selectedGameList
                                ?.where((e) =>
                                    e.selectedGameID == _model.selectGameID)
                                .toList()
                                ?.firstOrNull
                                ?.gameId ==
                            1001) {
                          context.goNamed(
                            GameOneS2Widget.routeName,
                            queryParameters: {
                              'room': serializeParam(
                                _model.qrScannerResultMob?.reference,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                          );

                          if (_shouldSetState) safeSetState(() {});
                          return;
                        } else {
                          if (_model.qrScannerResultMob?.selectedGameList
                                  ?.where((e) =>
                                      e.selectedGameID == _model.selectGameID)
                                  .toList()
                                  ?.firstOrNull
                                  ?.gameId ==
                              1002) {
                            context.goNamed(
                              GameTwoWidget.routeName,
                              queryParameters: {
                                'room': serializeParam(
                                  _model.qrScannerResultMob?.reference,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );

                            if (_shouldSetState) safeSetState(() {});
                            return;
                          } else if (_model.qrScannerResultMob?.selectedGameList
                                  ?.where((e) =>
                                      e.selectedGameID == _model.selectGameID)
                                  .toList()
                                  ?.firstOrNull
                                  ?.gameId ==
                              HotPotatoQrJoin.hotPotatoGameFirestoreId) {
                            final games = await queryGameRecordOnce(
                              queryBuilder: (g) => g.where(
                                  'game_ID',
                                  isEqualTo:
                                      HotPotatoQrJoin.hotPotatoGameFirestoreId,
                                ),
                              singleRecord: true,
                            );
                            final gref = games.firstOrNull?.reference;
                            if (gref != null) {
                              await currentUserReference!.update({
                                'present_room_game_info.room_admin_selected_game_ref':
                                    gref,
                              });
                            }
                            context.goNamed(
                              GameSixWidget.routeName,
                              queryParameters: {
                                'room': serializeParam(
                                  _model.qrScannerResultMob?.reference,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );

                            if (_shouldSetState) safeSetState(() {});
                            return;
                          } else {
                            if (_shouldSetState) safeSetState(() {});
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
                                FFLocalizations.of(context).getVariableText(
                              enText:
                                  'The maximum number of room members has been exceeded.',
                              arText:
                                  'لقد تم تجاوز الحد الأقصى لعدد أعضاء الغرفة.',
                            )),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext),
                                child: Text(
                                    FFLocalizations.of(context).getVariableText(
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
                          content:
                              Text(FFLocalizations.of(context).getVariableText(
                            enText: 'Unrecognized Code.',
                            arText: 'رمز غير معروف.',
                          )),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext),
                              child: Text(
                                  FFLocalizations.of(context).getVariableText(
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
                width: 38.0,
                height: 38.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
