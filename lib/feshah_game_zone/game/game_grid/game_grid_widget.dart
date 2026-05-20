import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/coming_soon/coming_soon_widget.dart';
import '/feshah/payment/point_list_private_wallet/point_list_private_wallet_widget.dart';
import '/feshah_game_zone/game/game_hint_video/game_hint_video_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/index.dart';
import '/u_i_game_six/game_six/hot_potato_qr_join.dart';
import '/u_i_game_six/game_six/hot_potato_room_code.dart';
import 'package:styled_divider/styled_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_grid_model.dart';
export 'game_grid_model.dart';

class GameGridWidget extends StatefulWidget {
  const GameGridWidget({
    super.key,
    required this.game,
    required this.playStatus,
    this.room,
  });

  final GameRecord? game;
  final bool? playStatus;
  final DocumentReference? room;

  @override
  State<GameGridWidget> createState() => _GameGridWidgetState();
}

class _GameGridWidgetState extends State<GameGridWidget> {
  late GameGridModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameGridModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          var _shouldSetState = false;
          if (_model.gridClickStatus == false) {
            _model.gridClickStatus = true;
          } else {
            if (_shouldSetState) safeSetState(() {});
            return;
          }

          if (loggedIn) {
            if ((widget!.game?.gameID == 1002) ||
                (widget!.game?.gameID == 1003) ||
                (widget!.game?.gameID == 1004) ||
                (widget!.game?.gameID ==
                    HotPotatoQrJoin.hotPotatoGameFirestoreId)) {
              if (!(widget!.room != null)) {
                if (widget!.game?.gameID ==
                    HotPotatoQrJoin.hotPotatoGameFirestoreId) {
                  final entry = await showHotPotatoEntryDialog(context);
                  if (entry == null) {
                    _model.gridClickStatus = false;
                    if (_shouldSetState) safeSetState(() {});
                    return;
                  }
                  if (entry is HotPotatoEntryJoinRoom) {
                    final code = entry.code;
                    final joinRoom = await findActiveHotPotatoRoomByCode(code);
                    if (joinRoom == null) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'No active Hot Potato room matches that code.',
                            ),
                          ),
                        );
                      }
                      _model.gridClickStatus = false;
                      if (_shouldSetState) safeSetState(() {});
                      return;
                    }
                    if (joinRoom.roomMemberLimit <=
                        joinRoom.roomUserList.length) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              FFLocalizations.of(context).getVariableText(
                                enText:
                                    'This room is full. Try another code or start a new game.',
                                arText:
                                    'الغرفة ممتلئة. جرّب رمزًا آخر أو ابدأ لعبة جديدة.',
                              ),
                            ),
                          ),
                        );
                      }
                      _model.gridClickStatus = false;
                      if (_shouldSetState) safeSetState(() {});
                      return;
                    }
                    try {
                      await applyHotPotatoJoinToFirestore(joinRoom);
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Could not join: $e')),
                        );
                      }
                      _model.gridClickStatus = false;
                      if (_shouldSetState) safeSetState(() {});
                      return;
                    }
                    FFAppState().gameInfo = widget!.game!.gameInfo;
                    FFAppState().gameZoneSteps = 1;
                    if (mounted) {
                      context.goNamed(
                        GameSixWidget.routeName,
                        queryParameters: {
                          'room': serializeParam(
                            joinRoom.reference,
                            ParamType.DocumentReference,
                          ),
                        }.withoutNulls,
                      );
                    }
                    _model.gridClickStatus = false;
                    if (_shouldSetState) safeSetState(() {});
                    return;
                  }
                  // Hot Potato new game: never reuse the user's old solo room (same URL /
                  // stuck `hot_potato_*` forever). Close the previous solo room
                  // and always take the "create new room" path below.
                  final soloPrev = await queryRoomRecordOnce(
                    queryBuilder: (roomRecord) => roomRecord
                        .where(
                          'room_status',
                          isEqualTo: 'active',
                        )
                        .where(
                          'room_created_userRef',
                          isEqualTo: currentUserReference,
                        )
                        .where(
                          'room_type',
                          isEqualTo: 'solo',
                        ),
                    singleRecord: true,
                  ).then((s) => s.firstOrNull);
                  _shouldSetState = true;
                  if (soloPrev != null) {
                    try {
                      await soloPrev.reference.update(
                        createRoomRecordData(
                          roomStatus: 'closed',
                          roomUpdatedAt: getCurrentTimestamp,
                        ),
                      );
                    } catch (_) {
                      // If rules block closing, still create a new room below.
                    }
                  }
                  _model.roomSoloResult = null;
                } else {
                  _model.roomSoloResult = await queryRoomRecordOnce(
                    queryBuilder: (roomRecord) => roomRecord
                        .where(
                          'room_status',
                          isEqualTo: 'active',
                        )
                        .where(
                          'room_created_userRef',
                          isEqualTo: currentUserReference,
                        )
                        .where(
                          'room_type',
                          isEqualTo: 'solo',
                        ),
                    singleRecord: true,
                  ).then((s) => s.firstOrNull);
                  _shouldSetState = true;
                }
                if ((_model.roomSoloResult != null) != true) {
                  _model.idmapRoomResult = await queryIDmapRecordOnce(
                    queryBuilder: (iDmapRecord) => iDmapRecord.where(
                      'type',
                      isEqualTo: 'Main',
                    ),
                    singleRecord: true,
                  ).then((s) => s.firstOrNull);
                  _shouldSetState = true;

                  var allocatedRoomCode =
                      valueOrDefault(currentUserDocument?.userId, 0);
                  if (widget!.game?.gameID ==
                      HotPotatoQrJoin.hotPotatoGameFirestoreId) {
                    allocatedRoomCode = await allocateUnusedHotPotatoRoomCode();
                  }

                  var roomRecordReference1 = RoomRecord.collection.doc();
                  await roomRecordReference1.set({
                    ...createRoomRecordData(
                      roomStatus: 'active',
                      roomCreatedAt: getCurrentTimestamp,
                      roomCreatedBy:
                          valueOrDefault(currentUserDocument?.userId, 0)
                              .toString(),
                      roomMemberLimit: 999,
                      roomMainInfo: updateMainInfoStruct(
                        MainInfoStruct(
                          name: currentUserDisplayName,
                          mainImage:
                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/nx4yo2w3wqhm/%F0%9F%8F%A0.png',
                        ),
                        clearUnsetFields: false,
                        create: true,
                      ),
                      roomCurrentUserId:
                          valueOrDefault(currentUserDocument?.userId, 0),
                      roomUpdatedAt: getCurrentTimestamp,
                      roomID: _model.idmapRoomResult?.roomId,
                      roomCreatedByUid: currentUserUid,
                      roomCreatedUserRef: currentUserReference,
                      isRoomWalletStatus: false,
                      roomWalletTotalPoint: 0,
                      roomPresentStatus: 'create',
                      roomType: 'solo',
                      roomCode: allocatedRoomCode,
                    ),
                    ...mapToFirestore(
                      {
                        'room_user_list': [
                          getRoomUserListFirestoreData(
                            updateRoomUserListStruct(
                              RoomUserListStruct(
                                roomUserJoinTime: getCurrentTimestamp,
                                roomUserId: valueOrDefault(
                                    currentUserDocument?.userId, 0),
                                roomUserRef: currentUserReference,
                                roomUserStatus: 'active',
                                roomUserUpdatedTime: getCurrentTimestamp,
                                roomUserOnlineStatus: 'active',
                              ),
                              clearUnsetFields: false,
                              create: true,
                            ),
                            true,
                          )
                        ],
                      },
                    ),
                  });
                  _model.newRoomResult = RoomRecord.getDocumentFromData({
                    ...createRoomRecordData(
                      roomStatus: 'active',
                      roomCreatedAt: getCurrentTimestamp,
                      roomCreatedBy:
                          valueOrDefault(currentUserDocument?.userId, 0)
                              .toString(),
                      roomMemberLimit: 999,
                      roomMainInfo: updateMainInfoStruct(
                        MainInfoStruct(
                          name: currentUserDisplayName,
                          mainImage:
                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/nx4yo2w3wqhm/%F0%9F%8F%A0.png',
                        ),
                        clearUnsetFields: false,
                        create: true,
                      ),
                      roomCurrentUserId:
                          valueOrDefault(currentUserDocument?.userId, 0),
                      roomUpdatedAt: getCurrentTimestamp,
                      roomID: _model.idmapRoomResult?.roomId,
                      roomCreatedByUid: currentUserUid,
                      roomCreatedUserRef: currentUserReference,
                      isRoomWalletStatus: false,
                      roomWalletTotalPoint: 0,
                      roomPresentStatus: 'create',
                      roomType: 'solo',
                      roomCode: allocatedRoomCode,
                    ),
                    ...mapToFirestore(
                      {
                        'room_user_list': [
                          getRoomUserListFirestoreData(
                            updateRoomUserListStruct(
                              RoomUserListStruct(
                                roomUserJoinTime: getCurrentTimestamp,
                                roomUserId: valueOrDefault(
                                    currentUserDocument?.userId, 0),
                                roomUserRef: currentUserReference,
                                roomUserStatus: 'active',
                                roomUserUpdatedTime: getCurrentTimestamp,
                                roomUserOnlineStatus: 'active',
                              ),
                              clearUnsetFields: false,
                              create: true,
                            ),
                            true,
                          )
                        ],
                      },
                    ),
                  }, roomRecordReference1);
                  _shouldSetState = true;

                  await _model.idmapRoomResult!.reference.update({
                    ...mapToFirestore(
                      {
                        'room_id': FieldValue.increment(1),
                      },
                    ),
                  });
                }
              }
              _model.roomResultGameCount = await RoomRecord.getDocumentOnce(
                  widget!.room != null
                      ? widget!.room!
                      : ((_model.roomSoloResult != null) == true
                          ? _model.roomSoloResult!.reference
                          : _model.newRoomResult!.reference));
              _shouldSetState = true;
              if (widget!.game?.gameID == 1004) {
                if (_model.roomResultGameCount!.selectedGameList
                        .where((e) => e.gameId == 1004)
                        .toList()
                        .length >
                    5) {
                  await _model.roomResultGameCount!.reference.update({
                    ...mapToFirestore(
                      {
                        'selected_game_list': FieldValue.delete(),
                        'room_attended_question_list': FieldValue.delete(),
                      },
                    ),
                  });
                }
              } else {
                if (_model.roomResultGameCount!.selectedGameList.length > 20) {
                  await _model.roomResultGameCount!.reference.update({
                    ...mapToFirestore(
                      {
                        'selected_game_list': FieldValue.delete(),
                        'room_attended_question_list': FieldValue.delete(),
                      },
                    ),
                  });
                }
              }

              _model.roomResult1 = await RoomRecord.getDocumentOnce(
                  widget!.room != null
                      ? widget!.room!
                      : ((_model.roomSoloResult != null) == true
                          ? _model.roomSoloResult!.reference
                          : _model.newRoomResult!.reference));
              _shouldSetState = true;
              _model.roomAdminResult = await UsersRecord.getDocumentOnce(
                  _model.roomResult1!.roomCreatedUserRef!);
              _shouldSetState = true;
              _model.pointResultAuth = await queryPointRecordOnce(
                queryBuilder: (pointRecord) => pointRecord.where(
                  'point_status',
                  isEqualTo: 'active',
                ),
              );
              _shouldSetState = true;
              if ((_model.roomResult1?.roomType == 'solo') ||
                  (_model.roomResult1?.isRoomWalletStatus == false)) {
                if (widget!.game?.gameID !=
                        HotPotatoQrJoin.hotPotatoGameFirestoreId &&
                    ((_model.roomAdminResult!.walletPoint <= 0) ||
                        (_model.roomAdminResult!.walletPoint <
                            widget!.game!.gamePoint))) {
                  FFAppState().updateUserflowStruct(
                    (e) => e..paymentProcessingTime = null,
                  );
                  if (currentUserDocument?.userSetting?.isSoundstatus == true) {
                    _model.soundPlayer1 ??= AudioPlayer();
                    if (_model.soundPlayer1!.playing) {
                      await _model.soundPlayer1!.stop();
                    }
                    _model.soundPlayer1!.setVolume(0.2);
                    _model.soundPlayer1!
                        .setAsset('assets/audios/No_Balance_in_wallet.mp3')
                        .then((_) => _model.soundPlayer1!.play());
                  }
                  if (_model.pointResultAuth!.length > 0) {
                    FFAppState().updateUserflowStruct(
                      (e) => e
                        ..updatePaymentProcessingTime(
                          (e) => e
                            ..presentUserRef = currentUserReference
                            ..paymentPlanItem = OrderCartItemStruct(
                              type: 'points',
                              planId:
                                  _model.pointResultAuth?.firstOrNull?.pointID,
                              planInfo:
                                  _model.pointResultAuth?.firstOrNull?.mainInfo,
                              quantity: 1,
                              planPrice: _model.pointResultAuth?.firstOrNull
                                  ?.pointInfo?.price,
                              totalPrice: _model.pointResultAuth?.firstOrNull
                                  ?.pointInfo?.price,
                              planPoint: _model.pointResultAuth?.firstOrNull
                                  ?.pointInfo?.point,
                              planRef: _model
                                  .pointResultAuth?.firstOrNull?.reference,
                              planFor: 'auth',
                            ),
                        ),
                    );
                    safeSetState(() {});
                  }
                  _model.gridClickStatus = false;
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Color(0x9A000000),
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return WebViewAware(
                        child: Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: PointListPrivateWalletWidget(
                            orderFor: 'auth',
                          ),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));

                  if (_shouldSetState) safeSetState(() {});
                  return;
                }
              } else {
                if (widget!.game?.gameID !=
                        HotPotatoQrJoin.hotPotatoGameFirestoreId &&
                    ((_model.roomResult1!.roomWalletTotalPoint <= 0) ||
                        (_model.roomResult1!.roomWalletTotalPoint <
                            widget!.game!.gamePoint))) {
                  FFAppState().updateUserflowStruct(
                    (e) => e..paymentProcessingTime = null,
                  );
                  if (currentUserDocument?.userSetting?.isSoundstatus == true) {
                    _model.soundPlayer2 ??= AudioPlayer();
                    if (_model.soundPlayer2!.playing) {
                      await _model.soundPlayer2!.stop();
                    }
                    _model.soundPlayer2!.setVolume(0.2);
                    _model.soundPlayer2!
                        .setAsset('assets/audios/No_Balance_in_wallet.mp3')
                        .then((_) => _model.soundPlayer2!.play());
                  }
                  if (_model.pointResultAuth!.length > 0) {
                    FFAppState().updateUserflowStruct(
                      (e) => e
                        ..updatePaymentProcessingTime(
                          (e) => e
                            ..presentUserRef = currentUserReference
                            ..paymentPlanItem = OrderCartItemStruct(
                              type: 'points',
                              planId:
                                  _model.pointResultAuth?.firstOrNull?.pointID,
                              planInfo:
                                  _model.pointResultAuth?.firstOrNull?.mainInfo,
                              quantity: 1,
                              planPrice: _model.pointResultAuth?.firstOrNull
                                  ?.pointInfo?.price,
                              totalPrice: _model.pointResultAuth?.firstOrNull
                                  ?.pointInfo?.price,
                              planPoint: _model.pointResultAuth?.firstOrNull
                                  ?.pointInfo?.point,
                              planRef: _model
                                  .pointResultAuth?.firstOrNull?.reference,
                              planFor: 'room',
                              roomRef: _model.roomResult1?.reference,
                            ),
                        ),
                    );
                    safeSetState(() {});
                  }
                  _model.gridClickStatus = false;
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Color(0x9A000000),
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return WebViewAware(
                        child: Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: PointListPrivateWalletWidget(
                            orderFor: 'room',
                            room: _model.roomResult1,
                          ),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));

                  if (_shouldSetState) safeSetState(() {});
                  return;
                }
              }

              _model.gameRoomResult1 = await RoomRecord.getDocumentOnce(
                  _model.roomResult1!.reference);
              _shouldSetState = true;
              var confirmDialogResponse = await showDialog<bool>(
                    context: context,
                    builder: (alertDialogContext) {
                      return WebViewAware(
                        child: AlertDialog(
                          title: Text(
                              '${FFLocalizations.of(context).getVariableText(
                            enText: 'You have ',
                            arText: 'لديك',
                          )}${_model.roomResult1?.isRoomWalletStatus == false ? valueOrDefault(currentUserDocument?.walletPoint, 0).toString() : _model.roomResult1?.roomWalletTotalPoint?.toString()}${FFLocalizations.of(context).getVariableText(
                            enText: ' points in your wallet.',
                            arText: 'نقاط في محفظتك.',
                          )}'),
                          content: Text(
                            widget!.game?.gameID ==
                                    HotPotatoQrJoin.hotPotatoGameFirestoreId
                                ? '${FFLocalizations.of(context).getVariableText(
                                    enText:
                                        'You will open Hot Potato setup. The entry fee is ',
                                    arText:
                                        'ستفتح إعداد اللعبة. رسوم الدخول ',
                                  )}${widget!.game?.gamePoint?.toString()}${FFLocalizations.of(context).getVariableText(
                                    enText:
                                        ' points and is charged only when you tap Start Game, not when you open this screen.',
                                    arText:
                                        ' نقطة وتُخصم فقط عند الضغط على بدء اللعبة وليس عند فتح هذه الشاشة.',
                                  )}'
                                : '${FFLocalizations.of(context).getVariableText(
                                    enText: 'To proceed, ',
                                    arText: 'للمضي قدما،',
                                  )}${widget!.game?.gamePoint?.toString()}${FFLocalizations.of(context).getVariableText(
                                    enText: ' points will be deducted.',
                                    arText: 'سيتم خصم النقاط.',
                                  )}${widget!.game?.gameID == 1002 ? FFLocalizations.of(context).getVariableText(
                                        enText:
                                            ' This game requires at least 3 players to play.',
                                        arText:
                                            'تتطلب هذه اللعبة ما لا يقل عن 3 لاعبين للعب.',
                                      ) : ' '}'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, false),
                              child: Text(
                                  FFLocalizations.of(context).getVariableText(
                                enText: 'Cancel',
                                arText: 'يلغي',
                              )),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, true),
                              child: Text(
                                  FFLocalizations.of(context).getVariableText(
                                enText: 'Proceed',
                                arText: 'يتابع',
                              )),
                            ),
                          ],
                        ),
                      );
                    },
                  ) ??
                  false;
              if (confirmDialogResponse) {
                _model.idmapGameResult = await queryIDmapRecordOnce(
                  queryBuilder: (iDmapRecord) => iDmapRecord.where(
                    'type',
                    isEqualTo: 'Main',
                  ),
                  singleRecord: true,
                ).then((s) => s.firstOrNull);
                _shouldSetState = true;
                if (widget!.game?.gameID == 1001) {
                  await _model.roomResult1!.reference.update({
                    ...createRoomRecordData(
                      roomUpdatedAt: getCurrentTimestamp,
                    ),
                    ...mapToFirestore(
                      {
                        'selected_game_list': FieldValue.arrayUnion([
                          getSelectedGameListFirestoreData(
                            updateSelectedGameListStruct(
                              SelectedGameListStruct(
                                gameId: widget!.game?.gameID,
                                gameStartTime: getCurrentTimestamp,
                                gameSelectedByUid: valueOrDefault(
                                        currentUserDocument?.userId, 0)
                                    .toString(),
                                gameSelectedByUserRef: currentUserReference,
                                gameSelectedPoint: widget!.game?.gamePoint,
                                gameInfo: widget!.game?.gameInfo,
                                selectedGameID:
                                    _model.idmapGameResult?.selectGameId,
                                selectedGameIndex: _model
                                    .roomResult1?.selectedGameList?.length,
                                selectedGameUserList: _model
                                    .roomResult1?.roomUserList
                                    ?.where((e) => e.roomUserStatus == 'active')
                                    .toList(),
                                teamLimit: 2,
                                gameSAUStarterUserref: currentUserReference,
                              ),
                              clearUnsetFields: false,
                            ),
                            true,
                          )
                        ]),
                      },
                    ),
                  });

                  await _model.idmapGameResult!.reference.update({
                    ...mapToFirestore(
                      {
                        'select_game_id': FieldValue.increment(1),
                      },
                    ),
                  });
                  FFAppState().gameInfo = widget!.game!.gameInfo;
                  FFAppState().gameZoneSteps = 1;
                  FFAppState().teamInputFields = [];
                  FFAppState().addToTeamInputFields(0);
                  FFAppState().addToTeamInputFields(1);

                  await currentUserReference!.update(createUsersRecordData(
                    presentRoomGameInfo: createPresentRoomGameInfoStruct(
                      roomRef: widget!.room != null
                          ? widget!.room
                          : ((_model.roomSoloResult != null) == true
                              ? _model.roomSoloResult?.reference
                              : _model.newRoomResult?.reference),
                      roomAdminRef: _model.roomAdminResult?.reference,
                      roomAdminSelectedGameRef: widget!.game?.reference,
                      roomGameAdminStatus: 'start',
                      roomSelectedGameID: _model.idmapGameResult?.selectGameId,
                      roomGameId: widget!.game?.gameID,
                      clearUnsetFields: false,
                    ),
                  ));

                  context.goNamed(
                    GameOneWidget.routeName,
                    queryParameters: {
                      'room': serializeParam(
                        widget!.room != null
                            ? widget!.room
                            : ((_model.roomSoloResult != null) == true
                                ? _model.roomSoloResult?.reference
                                : _model.newRoomResult?.reference),
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
                  );
                } else {
                  if (widget!.game?.gameID == 1002) {
                    if (_model.roomResult1?.isRoomWalletStatus == false) {
                      _model.addToRoomUserList(_model.roomResult1!.roomUserList
                          .where((e) =>
                              (e.roomUserRef == currentUserReference) &&
                              (e.roomUserStatus == 'active'))
                          .toList()
                          .firstOrNull!);
                      _model.updateRoomUserListAtIndex(
                        0,
                        (e) => e..roomUserNotificationSendStatus = 'send',
                      );
                    } else {
                      _model.roomUserList = _model.roomResult1!.roomUserList
                          .where((e) => e.roomUserStatus == 'active')
                          .toList()
                          .cast<RoomUserListStruct>();
                      _model.roomUsersCount = _model.roomResult1?.roomUserList
                          ?.where((e) => e.roomUserStatus == 'active')
                          .toList()
                          ?.length;
                      while (_model.roomUsersCount! > 0) {
                        if (_model.roomUserList
                                .elementAtOrNull((_model.roomUsersCount!) - 1)
                                ?.roomUserId ==
                            valueOrDefault(currentUserDocument?.userId, 0)) {
                          _model.updateRoomUserListAtIndex(
                            (_model.roomUsersCount!) - 1,
                            (e) => e..roomUserNotificationSendStatus = 'send',
                          );
                        } else {
                          _model.updateRoomUserListAtIndex(
                            (_model.roomUsersCount!) - 1,
                            (e) => e
                              ..roomUserNotificationSendStatus = null
                              ..roomUserNotificationRef = null,
                          );
                          _model.notificationResultNew =
                              await queryNotificationRecordOnce(
                            queryBuilder: (notificationRecord) =>
                                notificationRecord
                                    .where(
                                      'to_userRef',
                                      isEqualTo: _model.roomUserList
                                          .elementAtOrNull(
                                              (_model.roomUsersCount!) - 1)
                                          ?.roomUserRef,
                                    )
                                    .where(
                                      'notification_status',
                                      isEqualTo: 'send',
                                    )
                                    .where(
                                      'notification_type',
                                      isEqualTo: 'game_invite',
                                    )
                                    .where(
                                      'game_info.room_user_selected_game_id',
                                      isEqualTo:
                                          _model.idmapGameResult?.selectGameId,
                                    ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          _shouldSetState = true;
                          if ((_model.notificationResultNew != null) == true) {
                            unawaited(
                              () async {
                                await _model.notificationResultNew!.reference
                                    .delete();
                              }(),
                            );
                          }
                        }

                        _model.roomUsersCount = _model.roomUsersCount! + -1;
                      }
                    }

                    await _model.roomResult1!.reference.update({
                      ...createRoomRecordData(
                        roomUpdatedAt: getCurrentTimestamp,
                      ),
                      ...mapToFirestore(
                        {
                          'selected_game_list': FieldValue.arrayUnion([
                            getSelectedGameListFirestoreData(
                              updateSelectedGameListStruct(
                                SelectedGameListStruct(
                                  gameId: widget!.game?.gameID,
                                  gameStartTime: getCurrentTimestamp,
                                  gameSelectedByUid: valueOrDefault(
                                          currentUserDocument?.userId, 0)
                                      .toString(),
                                  gameSelectedByUserRef: currentUserReference,
                                  gameSelectedPoint: widget!.game?.gamePoint,
                                  gameInfo: widget!.game?.gameInfo,
                                  selectedGameID:
                                      _model.idmapGameResult?.selectGameId,
                                  selectedGameIndex: _model
                                      .roomResult1?.selectedGameList?.length,
                                  selectedGameUserList: _model.roomUserList,
                                  gameSAUStep: 1,
                                  gameSAUStarterUserref: currentUserReference,
                                ),
                                clearUnsetFields: false,
                              ),
                              true,
                            )
                          ]),
                          'room_user_list': getRoomUserListListFirestoreData(
                            _model.roomUserList,
                          ),
                        },
                      ),
                    });

                    await _model.idmapGameResult!.reference.update({
                      ...mapToFirestore(
                        {
                          'select_game_id': FieldValue.increment(1),
                        },
                      ),
                    });
                    FFAppState().gameInfo = widget!.game!.gameInfo;
                    FFAppState().gameZoneSteps = 1;

                    await currentUserReference!.update(createUsersRecordData(
                      presentRoomGameInfo: createPresentRoomGameInfoStruct(
                        roomRef: widget!.room != null
                            ? widget!.room
                            : ((_model.roomSoloResult != null) == true
                                ? _model.roomSoloResult?.reference
                                : _model.newRoomResult?.reference),
                        roomAdminRef: _model.roomAdminResult?.reference,
                        roomAdminSelectedGameRef: widget!.game?.reference,
                        roomGameAdminStatus: 'start',
                        roomSelectedGameID:
                            _model.idmapGameResult?.selectGameId,
                        roomGameId: widget!.game?.gameID,
                        clearUnsetFields: false,
                      ),
                    ));

                    context.goNamed(
                      GameTwoWidget.routeName,
                      queryParameters: {
                        'room': serializeParam(
                          widget!.room != null
                              ? widget!.room
                              : ((_model.roomSoloResult != null) == true
                                  ? _model.roomSoloResult?.reference
                                  : _model.newRoomResult?.reference),
                          ParamType.DocumentReference,
                        ),
                      }.withoutNulls,
                    );
                  } else {
                    if (widget!.game?.gameID == 1003) {
                      if (_model.roomResultGameCount!.roomAttendedQuestionList
                              .length >
                          20) {
                        await _model.roomResultGameCount!.reference.update({
                          ...mapToFirestore(
                            {
                              'room_attended_question_list':
                                  FieldValue.delete(),
                            },
                          ),
                        });
                      }

                      await _model.roomResult1!.reference.update({
                        ...createRoomRecordData(
                          roomUpdatedAt: getCurrentTimestamp,
                        ),
                        ...mapToFirestore(
                          {
                            'selected_game_list': FieldValue.arrayUnion([
                              getSelectedGameListFirestoreData(
                                updateSelectedGameListStruct(
                                  SelectedGameListStruct(
                                    gameId: widget!.game?.gameID,
                                    gameStartTime: getCurrentTimestamp,
                                    gameSelectedByUid: valueOrDefault(
                                            currentUserDocument?.userId, 0)
                                        .toString(),
                                    gameSelectedByUserRef: currentUserReference,
                                    gameSelectedPoint: widget!.game?.gamePoint,
                                    gameInfo: widget!.game?.gameInfo,
                                    selectedGameID:
                                        _model.idmapGameResult?.selectGameId,
                                    selectedGameIndex: _model
                                        .roomResult1?.selectedGameList?.length,
                                    selectedGameUserList: _model
                                        .roomResult1?.roomUserList
                                        ?.where(
                                            (e) => e.roomUserStatus == 'active')
                                        .toList(),
                                    teamLimit: 2,
                                    gameSAUStarterUserref: currentUserReference,
                                  ),
                                  clearUnsetFields: false,
                                ),
                                true,
                              )
                            ]),
                          },
                        ),
                      });

                      await _model.idmapGameResult!.reference.update({
                        ...mapToFirestore(
                          {
                            'select_game_id': FieldValue.increment(1),
                          },
                        ),
                      });
                      FFAppState().gameInfo = widget!.game!.gameInfo;
                      FFAppState().gameZoneSteps = 1;
                      FFAppState().teamInputFields = [];
                      FFAppState().addToTeamInputFields(0);
                      FFAppState().addToTeamInputFields(1);

                      await currentUserReference!.update(createUsersRecordData(
                        presentRoomGameInfo: createPresentRoomGameInfoStruct(
                          roomRef: widget!.room != null
                              ? widget!.room
                              : ((_model.roomSoloResult != null) == true
                                  ? _model.roomSoloResult?.reference
                                  : _model.newRoomResult?.reference),
                          roomAdminRef: _model.roomAdminResult?.reference,
                          roomAdminSelectedGameRef: widget!.game?.reference,
                          roomGameAdminStatus: 'start',
                          roomSelectedGameID:
                              _model.idmapGameResult?.selectGameId,
                          roomGameId: widget!.game?.gameID,
                          clearUnsetFields: false,
                        ),
                      ));

                      context.goNamed(
                        GameFourWidget.routeName,
                        queryParameters: {
                          'room': serializeParam(
                            widget!.room != null
                                ? widget!.room
                                : ((_model.roomSoloResult != null) == true
                                    ? _model.roomSoloResult?.reference
                                    : _model.newRoomResult?.reference),
                            ParamType.DocumentReference,
                          ),
                        }.withoutNulls,
                      );
                    } else {
                      if (widget!.game?.gameID == 1004) {
                        if (_model.roomResult1?.isRoomWalletStatus == false) {
                          _model.addToRoomUserList(_model
                              .roomResult1!.roomUserList
                              .where((e) =>
                                  (e.roomUserRef == currentUserReference) &&
                                  (e.roomUserStatus == 'active'))
                              .toList()
                              .firstOrNull!);
                          _model.updateRoomUserListAtIndex(
                            0,
                            (e) => e
                              ..roomUserNotificationSendStatus = 'send'
                              ..roomUserInfo = OrderUserMainInfoStruct(
                                userEmail: currentUserEmail,
                                userId: valueOrDefault(
                                        currentUserDocument?.userId, 0)
                                    .toString(),
                                userName: currentUserDisplayName,
                                userPhone: currentPhoneNumber,
                                userRole: valueOrDefault(
                                    currentUserDocument?.userRole, ''),
                              ),
                          );
                        } else {
                          _model.roomUserList = _model.roomResult1!.roomUserList
                              .where((e) => e.roomUserStatus == 'active')
                              .toList()
                              .cast<RoomUserListStruct>();
                          _model.roomUsersCount = _model
                              .roomResult1?.roomUserList
                              ?.where((e) => e.roomUserStatus == 'active')
                              .toList()
                              ?.length;
                          while (_model.roomUsersCount! > 0) {
                            _model.roomUserInfo = await queryUsersRecordOnce(
                              queryBuilder: (usersRecord) => usersRecord.where(
                                'user_id',
                                isEqualTo: _model.roomUserList
                                    .elementAtOrNull(
                                        (_model.roomUsersCount!) - 1)
                                    ?.roomUserId,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);
                            _shouldSetState = true;
                            if (_model.roomUserList
                                    .elementAtOrNull(
                                        (_model.roomUsersCount!) - 1)
                                    ?.roomUserId ==
                                valueOrDefault(
                                    currentUserDocument?.userId, 0)) {
                              _model.updateRoomUserListAtIndex(
                                (_model.roomUsersCount!) - 1,
                                (e) => e
                                  ..roomUserNotificationSendStatus = 'send'
                                  ..updateRoomUserInfo(
                                    (e) => e
                                      ..userName =
                                          _model.roomUserInfo?.displayName,
                                  ),
                              );
                            } else {
                              _model.updateRoomUserListAtIndex(
                                (_model.roomUsersCount!) - 1,
                                (e) => e
                                  ..roomUserNotificationSendStatus = null
                                  ..roomUserNotificationRef = null
                                  ..updateRoomUserInfo(
                                    (e) => e
                                      ..userName =
                                          _model.roomUserInfo?.displayName,
                                  ),
                              );
                              _model.notificationResultNewGame5 =
                                  await queryNotificationRecordOnce(
                                queryBuilder: (notificationRecord) =>
                                    notificationRecord
                                        .where(
                                          'to_userRef',
                                          isEqualTo: _model.roomUserList
                                              .elementAtOrNull(
                                                  (_model.roomUsersCount!) - 1)
                                              ?.roomUserRef,
                                        )
                                        .where(
                                          'notification_status',
                                          isEqualTo: 'send',
                                        )
                                        .where(
                                          'notification_type',
                                          isEqualTo: 'game_invite',
                                        )
                                        .where(
                                          'game_info.room_user_selected_game_id',
                                          isEqualTo: _model
                                              .idmapGameResult?.selectGameId,
                                        ),
                                singleRecord: true,
                              ).then((s) => s.firstOrNull);
                              _shouldSetState = true;
                              if ((_model.notificationResultNewGame5 != null) ==
                                  true) {
                                unawaited(
                                  () async {
                                    await _model
                                        .notificationResultNewGame5!.reference
                                        .delete();
                                  }(),
                                );
                              }
                            }

                            _model.roomUsersCount = _model.roomUsersCount! + -1;
                          }
                        }

                        await _model.roomResult1!.reference.update({
                          ...createRoomRecordData(
                            roomUpdatedAt: getCurrentTimestamp,
                          ),
                          ...mapToFirestore(
                            {
                              'selected_game_list': FieldValue.arrayUnion([
                                getSelectedGameListFirestoreData(
                                  updateSelectedGameListStruct(
                                    SelectedGameListStruct(
                                      gameId: widget!.game?.gameID,
                                      gameStartTime: getCurrentTimestamp,
                                      gameSelectedByUid: valueOrDefault(
                                              currentUserDocument?.userId, 0)
                                          .toString(),
                                      gameSelectedByUserRef:
                                          currentUserReference,
                                      gameSelectedPoint:
                                          widget!.game?.gamePoint,
                                      gameInfo: widget!.game?.gameInfo,
                                      selectedGameID:
                                          _model.idmapGameResult?.selectGameId,
                                      selectedGameIndex: _model.roomResult1
                                          ?.selectedGameList?.length,
                                      selectedGameUserList: _model.roomUserList,
                                      gameSAUStep: 1,
                                      gameSAUStarterUserref:
                                          currentUserReference,
                                    ),
                                    clearUnsetFields: false,
                                  ),
                                  true,
                                )
                              ]),
                              'room_user_list':
                                  getRoomUserListListFirestoreData(
                                _model.roomUserList,
                              ),
                            },
                          ),
                        });

                        await _model.idmapGameResult!.reference.update({
                          ...mapToFirestore(
                            {
                              'select_game_id': FieldValue.increment(1),
                            },
                          ),
                        });
                        FFAppState().gameInfo = widget!.game!.gameInfo;
                        FFAppState().gameZoneSteps = 1;

                        await currentUserReference!
                            .update(createUsersRecordData(
                          presentRoomGameInfo: createPresentRoomGameInfoStruct(
                            roomRef: widget!.room != null
                                ? widget!.room
                                : ((_model.roomSoloResult != null) == true
                                    ? _model.roomSoloResult?.reference
                                    : _model.newRoomResult?.reference),
                            roomAdminRef: _model.roomAdminResult?.reference,
                            roomAdminSelectedGameRef: widget!.game?.reference,
                            roomGameAdminStatus: 'start',
                            roomSelectedGameID:
                                _model.idmapGameResult?.selectGameId,
                            roomGameId: widget!.game?.gameID,
                            clearUnsetFields: false,
                          ),
                        ));

                        context.goNamed(
                          GameFiveWidget.routeName,
                          queryParameters: {
                            'room': serializeParam(
                              widget!.room != null
                                  ? widget!.room
                                  : ((_model.roomSoloResult != null) == true
                                      ? _model.roomSoloResult?.reference
                                      : _model.newRoomResult?.reference),
                              ParamType.DocumentReference,
                            ),
                          }.withoutNulls,
                        );
                      } else {
                        if (widget!.game?.gameID ==
                            HotPotatoQrJoin.hotPotatoGameFirestoreId) {
                          await _model.roomResult1!.reference.update({
                            ...createRoomRecordData(
                              roomUpdatedAt: getCurrentTimestamp,
                            ),
                            ...mapToFirestore(
                              {
                                'selected_game_list': FieldValue.arrayUnion([
                                  getSelectedGameListFirestoreData(
                                    updateSelectedGameListStruct(
                                      SelectedGameListStruct(
                                        gameId: widget!.game?.gameID,
                                        gameStartTime: getCurrentTimestamp,
                                        gameSelectedByUid: valueOrDefault(
                                                currentUserDocument?.userId, 0)
                                            .toString(),
                                        gameSelectedByUserRef:
                                            currentUserReference,
                                        gameSelectedPoint:
                                            widget!.game?.gamePoint,
                                        gameInfo: widget!.game?.gameInfo,
                                        selectedGameID: _model
                                            .idmapGameResult?.selectGameId,
                                        selectedGameIndex: _model.roomResult1
                                            ?.selectedGameList?.length,
                                        selectedGameUserList: _model
                                            .roomResult1?.roomUserList
                                            ?.where((e) =>
                                                e.roomUserStatus == 'active')
                                            .toList(),
                                        teamLimit: 2,
                                        gameSAUStarterUserref:
                                            currentUserReference,
                                      ),
                                      clearUnsetFields: false,
                                    ),
                                    true,
                                  )
                                ]),
                              },
                            ),
                          });

                          // Run independent writes in parallel to reduce tap-to-navigation latency.
                          final userGameInfoUpdate = currentUserReference!
                              .update(createUsersRecordData(
                            presentRoomGameInfo:
                                createPresentRoomGameInfoStruct(
                              roomRef: widget!.room != null
                                  ? widget!.room
                                  : ((_model.roomSoloResult != null) == true
                                      ? _model.roomSoloResult?.reference
                                      : _model.newRoomResult?.reference),
                              roomAdminRef: _model.roomAdminResult?.reference,
                              roomAdminSelectedGameRef: widget!.game?.reference,
                              roomGameAdminStatus: 'start',
                              roomSelectedGameID:
                                  _model.idmapGameResult?.selectGameId,
                              roomGameId: widget!.game?.gameID,
                              clearUnsetFields: false,
                            ),
                          ));
                          final idMapUpdate = _model.idmapGameResult!.reference
                              .update({
                            ...mapToFirestore(
                              {
                                'select_game_id': FieldValue.increment(1),
                              },
                            ),
                          });
                          await Future.wait<Object?>([
                            idMapUpdate,
                            userGameInfoUpdate,
                          ]);
                          FFAppState().gameInfo = widget!.game!.gameInfo;
                          FFAppState().gameZoneSteps = 1;
                          FFAppState().teamInputFields = [];
                          FFAppState().addToTeamInputFields(0);
                          FFAppState().addToTeamInputFields(1);

                          context.goNamed(
                            GameSixWidget.routeName,
                            queryParameters: {
                              'room': serializeParam(
                                widget!.room != null
                                    ? widget!.room
                                    : ((_model.roomSoloResult != null) == true
                                        ? _model.roomSoloResult?.reference
                                        : _model.newRoomResult?.reference),
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                          );
                        }
                      }
                    }
                  }
                }
              } else {
                _model.gridClickStatus = false;
                safeSetState(() {});
                if (_shouldSetState) safeSetState(() {});
                return;
              }
            } else {
              _model.gridClickStatus = false;
              await showDialog(
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
                        width: 500.0,
                        child: ComingSoonWidget(),
                      ),
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
        child: Container(
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
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        valueOrDefault<String>(
                          widget!.game?.gameInfo?.mainImageId == ''
                              ? widget!.game?.gameInfo?.mainImage
                              : '${FFAppConstants.imageBaseURL}${widget!.game?.gameInfo?.mainImageId}/public',
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/the-anime-challenge-w37vip/assets/fmxws2uvymwi/mobile_(1).png',
                        ),
                        width: 85.0,
                        height: 78.0,
                        fit: BoxFit.contain,
                        alignment: Alignment(0.0, 0.0),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FFLocalizations.of(context).getVariableText(
                            enText: () {
                              if (widget!.game?.gameInfoManualTranslate?.name
                                      ?.en !=
                                  '') {
                                return widget!
                                    .game?.gameInfoManualTranslate?.name?.en;
                              } else if (widget!
                                      .game?.gameInfoTranslate?.name?.en !=
                                  '') {
                                return widget!
                                    .game?.gameInfoTranslate?.name?.en;
                              } else {
                                return widget!.game?.gameInfo?.name;
                              }
                            }(),
                            arText: () {
                              if (widget!.game?.gameInfoManualTranslate?.name
                                      ?.ar !=
                                  '') {
                                return widget!
                                    .game?.gameInfoManualTranslate?.name?.ar;
                              } else if (widget!
                                      .game?.gameInfoTranslate?.name?.ar !=
                                  '') {
                                return widget!
                                    .game?.gameInfoTranslate?.name?.ar;
                              } else {
                                return widget!.game?.gameInfo?.name;
                              }
                            }(),
                          ),
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 4.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return WebViewAware(
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: GameHintVideoWidget(
                                        video:
                                            widget!.game!.gameInfo.mainVideoUrl,
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0x12EC4D41),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.solidQuestionCircle,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 11.0,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'vxrw3hlx' /* How to play */,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.almarai(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 4.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 6.0)),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget!.playStatus == true)
                            SizedBox(
                              height: 40.0,
                              child: StyledVerticalDivider(
                                width: 1.0,
                                thickness: 1.0,
                                color: Color(0xFFF6BFB5),
                                lineStyle: DividerLineStyle.dashed,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: Image.asset(
                            'assets/images/Coin-min.png',
                            width: 14.0,
                            height: 14.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            widget!.game?.gamePoint?.toString(),
                            '0',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ].divide(SizedBox(width: 4.0)),
                    ),
                    Container(
                      width: 75.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Visibility(
                        visible: widget!.playStatus == true,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 4.0, 8.0, 4.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '88ia49c0' /* Start  > */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 10.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
