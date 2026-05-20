import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'room_q_rauto_redirect_model.dart';
export 'room_q_rauto_redirect_model.dart';

class RoomQRautoRedirectWidget extends StatefulWidget {
  const RoomQRautoRedirectWidget({super.key});

  @override
  State<RoomQRautoRedirectWidget> createState() =>
      _RoomQRautoRedirectWidgetState();
}

class _RoomQRautoRedirectWidgetState extends State<RoomQRautoRedirectWidget> {
  late RoomQRautoRedirectModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RoomQRautoRedirectModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      while (FFAppState().refresh > 0) {
        if (FFAppState().QRvalue != '') {
          FFAppState().refresh = 0;
          _model.qrValue =
              functions.str2split(FFAppState().QRvalue).toList().cast<String>();
          _model.qrScannerResultMob = await queryRoomRecordOnce(
            queryBuilder: (roomRecord) => roomRecord
                .where(
                  'room_code',
                  isEqualTo: int.parse((_model.qrValue.firstOrNull!)),
                )
                .where(
                  'room_status',
                  isEqualTo: 'active',
                ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          if ((_model.qrScannerResultMob != null) == true) {
            _model.gameList = _model.qrScannerResultMob!.selectedGameList
                .toList()
                .cast<SelectedGameListStruct>();
            _model.countGame =
                _model.qrScannerResultMob?.selectedGameList?.length;
            _model.userList = _model.qrScannerResultMob!.roomUserList
                .toList()
                .cast<RoomUserListStruct>();
            _model.gmaeUserList = _model.qrScannerResultMob!.selectedGameList
                .where((e) =>
                    e.selectedGameID ==
                    (int.parse((_model.qrValue.lastOrNull!))))
                .toList()
                .firstOrNull!
                .selectedGameUserList
                .toList()
                .cast<RoomUserListStruct>();
            while (_model.countGame! > 0) {
              if (_model.gameList
                      .elementAtOrNull((_model.countGame!) - 1)
                      ?.selectedGameID ==
                  (int.parse((_model.qrValue.lastOrNull!)))) {
                if (_model.userList
                        .where((e) => e.roomUserRef == currentUserReference)
                        .toList()
                        .length ==
                    0) {
                  _model.addToUserList(RoomUserListStruct(
                    roomUserOnlineStatus: 'active',
                    roomUserStatus: 'active',
                    roomUserUpdatedTime: getCurrentTimestamp,
                    roomUserJoinTime: getCurrentTimestamp,
                    roomUserId: valueOrDefault(currentUserDocument?.userId, 0),
                    roomUserRef: currentUserReference,
                  ));
                }
                if (_model.gmaeUserList
                        .where((e) => e.roomUserRef == currentUserReference)
                        .toList()
                        .length ==
                    0) {
                  _model.addToGmaeUserList(RoomUserListStruct(
                    roomUserOnlineStatus: 'active',
                    roomUserStatus: 'active',
                    roomUserUpdatedTime: getCurrentTimestamp,
                    roomUserJoinTime: getCurrentTimestamp,
                    roomUserId: valueOrDefault(currentUserDocument?.userId, 0),
                    roomUserRef: currentUserReference,
                    roomUserNotificationSendStatus: 'stocker',
                  ));
                  _model.updateGameListAtIndex(
                    (_model.countGame!) - 1,
                    (e) =>
                        e..selectedGameUserList = _model.gmaeUserList.toList(),
                  );
                }

                await _model.qrScannerResultMob!.reference.update({
                  ...createRoomRecordData(
                    roomUpdatedAt: getCurrentTimestamp,
                  ),
                  ...mapToFirestore(
                    {
                      'room_user_list': getRoomUserListListFirestoreData(
                        _model.userList,
                      ),
                      'selected_game_list':
                          getSelectedGameListListFirestoreData(
                        _model.gameList,
                      ),
                    },
                  ),
                });

                await currentUserReference!.update(createUsersRecordData(
                  presentRoomGameInfo: createPresentRoomGameInfoStruct(
                    roomRef: _model.qrScannerResultMob?.reference,
                    roomAdminRef: _model.qrScannerResultMob?.roomCreatedUserRef,
                    roomGameAdminStatus: 'start',
                    roomSelectedGameID: int.parse((_model.qrValue.lastOrNull!)),
                    roomGameId: _model.qrScannerResultMob?.selectedGameList
                        ?.where((e) =>
                            e.selectedGameID ==
                            (int.parse((_model.qrValue.lastOrNull!))))
                        .toList()
                        ?.firstOrNull
                        ?.gameId,
                    clearUnsetFields: false,
                  ),
                ));
                if (_model.qrScannerResultMob?.selectedGameList
                        ?.where((e) =>
                            e.selectedGameID ==
                            (int.parse((_model.qrValue.lastOrNull!))))
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
                } else {
                  if (_model.qrScannerResultMob?.selectedGameList
                          ?.where((e) =>
                              e.selectedGameID ==
                              (int.parse((_model.qrValue.lastOrNull!))))
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
                  }
                }

                return;
              }
              _model.countGame = (_model.countGame!) - 1;
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
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: Text('Ok'),
                      ),
                    ],
                  ),
                );
              },
            );
            return;
          }
        }
        await Future.delayed(
          Duration(
            milliseconds: 3000,
          ),
        );
        FFAppState().refresh = 2;
        FFAppState().update(() {});
      }
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
    context.watch<FFAppState>();

    return Container();
  }
}
