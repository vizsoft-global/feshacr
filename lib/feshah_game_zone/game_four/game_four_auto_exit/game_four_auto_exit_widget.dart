import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_four_auto_exit_model.dart';
export 'game_four_auto_exit_model.dart';

class GameFourAutoExitWidget extends StatefulWidget {
  const GameFourAutoExitWidget({
    super.key,
    required this.room,
    required this.selectedGameID,
  });

  final DocumentReference? room;
  final int? selectedGameID;

  @override
  State<GameFourAutoExitWidget> createState() => _GameFourAutoExitWidgetState();
}

class _GameFourAutoExitWidgetState extends State<GameFourAutoExitWidget> {
  late GameFourAutoExitModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFourAutoExitModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      while (_model.refresh != 0) {
        _model.roomResultEntry =
            await RoomRecord.getDocumentOnce(widget!.room!);
        _model.idmapResultEntry = await queryIDmapRecordOnce(
          queryBuilder: (iDmapRecord) => iDmapRecord.where(
            'type',
            isEqualTo: 'Main',
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        _model.countGame = _model.roomResultEntry?.selectedGameList?.length;
        _model.selectedGameList = _model.roomResultEntry!.selectedGameList
            .toList()
            .cast<SelectedGameListStruct>();
        while (_model.countGame! > 0) {
          if (_model.selectedGameList
                  .elementAtOrNull((_model.countGame!) - 1)
                  ?.selectedGameID ==
              widget!.selectedGameID) {
            if ((_model.selectedGameList
                        .elementAtOrNull((_model.countGame!) - 1)
                        ?.gameId ==
                    1001) ||
                (_model.selectedGameList
                        .elementAtOrNull((_model.countGame!) - 1)
                        ?.gameId ==
                    1003)) {
              _model.selectedQuestionCount = _model.selectedGameList
                  .elementAtOrNull((_model.countGame!) - 1)
                  ?.listedQuestionIDList
                  ?.length;
              _model.statusSQ = 'move';
              while (_model.selectedQuestionCount! > 0) {
                if (_model.selectedGameList
                        .elementAtOrNull((_model.countGame!) - 1)
                        ?.selectedQuestionIDList
                        ?.contains(_model.selectedGameList
                            .elementAtOrNull((_model.countGame!) - 1)
                            ?.listedQuestionIDList
                            ?.elementAtOrNull(
                                (_model.selectedQuestionCount!) - 1)) ==
                    false) {
                  _model.statusSQ = 'no';
                  break;
                }
                _model.selectedQuestionCount =
                    (_model.selectedQuestionCount!) - 1;
              }
              if ((_model.selectedGameList
                          .elementAtOrNull((_model.countGame!) - 1)
                          ?.gameId ==
                      1003) &&
                  ((_model.selectedGameList
                              .elementAtOrNull((_model.countGame!) - 1)
                              ?.selectedQuestionIDList
                              ?.length ==
                          10) ||
                      (_model.statusSQ == 'move'))) {
                _model.foundStatus = 'found';
                if (_model.selectedGameList
                            .elementAtOrNull((_model.countGame!) - 1)
                            ?.teamInfo
                            ?.length ==
                        2
                    ? (_model.selectedGameList
                            .elementAtOrNull((_model.countGame!) - 1)
                            ?.teamInfo
                            ?.firstOrNull
                            ?.totalResult !=
                        _model.selectedGameList
                            .elementAtOrNull((_model.countGame!) - 1)
                            ?.teamInfo
                            ?.lastOrNull
                            ?.totalResult)
                    : ((_model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)
                                ?.teamInfo
                                ?.firstOrNull
                                ?.totalResult !=
                            _model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)
                                ?.teamInfo
                                ?.lastOrNull
                                ?.totalResult) &&
                        (_model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)
                                ?.teamInfo
                                ?.firstOrNull
                                ?.totalResult !=
                            (_model.selectedGameList
                                    .elementAtOrNull((_model.countGame!) - 1)
                                    ?.teamInfo
                                    ?.elementAtOrNull(1))
                                ?.totalResult) &&
                        (_model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)
                                ?.teamInfo
                                ?.lastOrNull
                                ?.totalResult !=
                            (_model.selectedGameList
                                    .elementAtOrNull((_model.countGame!) - 1)
                                    ?.teamInfo
                                    ?.elementAtOrNull(1))
                                ?.totalResult))) {
                  _model.updateSelectedGameListAtIndex(
                    (_model.countGame!) - 1,
                    (e) => e
                      ..gameEndTime = getCurrentTimestamp
                      ..updateGameResult(
                        (e) => e
                          ..status = 'win'
                          ..teamID = _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.length ==
                                  2
                              ? (_model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .teamInfo
                                          .firstOrNull!
                                          .totalResult >
                                      _model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .teamInfo
                                          .lastOrNull!
                                          .totalResult
                                  ? _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.firstOrNull
                                      ?.teamID
                                  : _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.lastOrNull
                                      ?.teamID)
                              : () {
                                  if ((_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .firstOrNull!
                                              .totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .lastOrNull!
                                              .totalResult) &&
                                      (_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .firstOrNull!
                                              .totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .elementAtOrNull(1)!
                                              .totalResult)) {
                                    return _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.teamInfo
                                        ?.firstOrNull
                                        ?.teamID;
                                  } else if ((_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .lastOrNull!
                                              .totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .firstOrNull!
                                              .totalResult) &&
                                      (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull((_model.countGame!) - 1)!
                                              .teamInfo
                                              .elementAtOrNull(1)!
                                              .totalResult)) {
                                    return _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.teamInfo
                                        ?.lastOrNull
                                        ?.teamID;
                                  } else {
                                    return (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.teamInfo
                                            ?.elementAtOrNull(1))
                                        ?.teamID;
                                  }
                                }()
                          ..teamInfo = _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.length ==
                                  2
                              ? (_model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .teamInfo
                                          .firstOrNull!
                                          .totalResult >
                                      _model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .teamInfo
                                          .lastOrNull!
                                          .totalResult
                                  ? _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.firstOrNull
                                      ?.teamInfo
                                  : _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.lastOrNull
                                      ?.teamInfo)
                              : () {
                                  if ((_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .firstOrNull!
                                              .totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .lastOrNull!
                                              .totalResult) &&
                                      (_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .firstOrNull!
                                              .totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .elementAtOrNull(1)!
                                              .totalResult)) {
                                    return _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.teamInfo
                                        ?.firstOrNull
                                        ?.teamInfo;
                                  } else if ((_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .lastOrNull!
                                              .totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .firstOrNull!
                                              .totalResult) &&
                                      (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull((_model.countGame!) - 1)!
                                              .teamInfo
                                              .elementAtOrNull(1)!
                                              .totalResult)) {
                                    return _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.teamInfo
                                        ?.lastOrNull
                                        ?.teamInfo;
                                  } else {
                                    return (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.teamInfo
                                            ?.elementAtOrNull(1))
                                        ?.teamInfo;
                                  }
                                }()
                          ..point = _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.length ==
                                  2
                              ? (_model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .teamInfo
                                          .firstOrNull!
                                          .totalResult >
                                      _model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .teamInfo
                                          .lastOrNull!
                                          .totalResult
                                  ? _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.firstOrNull
                                      ?.totalResult
                                  : _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.lastOrNull
                                      ?.totalResult)
                              : () {
                                  if ((_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .firstOrNull!
                                              .totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .lastOrNull!
                                              .totalResult) &&
                                      (_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .firstOrNull!
                                              .totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .elementAtOrNull(1)!
                                              .totalResult)) {
                                    return _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.teamInfo
                                        ?.firstOrNull
                                        ?.totalResult;
                                  } else if ((_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .lastOrNull!
                                              .totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .teamInfo
                                              .firstOrNull!
                                              .totalResult) &&
                                      (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                          _model.selectedGameList
                                              .elementAtOrNull((_model.countGame!) - 1)!
                                              .teamInfo
                                              .elementAtOrNull(1)!
                                              .totalResult)) {
                                    return _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.teamInfo
                                        ?.lastOrNull
                                        ?.totalResult;
                                  } else {
                                    return (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.teamInfo
                                            ?.elementAtOrNull(1))
                                        ?.totalResult;
                                  }
                                }()
                          ..createdAt = getCurrentTimestamp,
                      ),
                  );
                  _model.countUser = _model.selectedGameList
                      .elementAtOrNull((_model.countGame!) - 1)
                      ?.selectedGameUserList
                      ?.length;
                  _model.selectedUserList = _model.selectedGameList
                      .elementAtOrNull((_model.countGame!) - 1)!
                      .selectedGameUserList
                      .toList()
                      .cast<RoomUserListStruct>();
                  while (_model.countUser! > 0) {
                    if (_model.selectedUserList
                            .elementAtOrNull((_model.countUser!) - 1)
                            ?.roomUserStatus ==
                        'active') {
                      _model.gameHistoryResult1 =
                          await queryGameHistoryRecordOnce(
                        queryBuilder: (gameHistoryRecord) => gameHistoryRecord
                            .where(
                              'user_id',
                              isEqualTo: _model.selectedUserList
                                  .elementAtOrNull((_model.countUser!) - 1)
                                  ?.roomUserId
                                  ?.toString(),
                            )
                            .where(
                              'session_id',
                              isEqualTo: currentUserDocument
                                  ?.presentRoomGameInfo?.roomSelectedGameID,
                            ),
                      );
                      if (_model.gameHistoryResult1!.length > 0) {
                        await GameHistoryRecord.collection
                            .doc()
                            .set(createGameHistoryRecordData(
                              createdAt: getCurrentTimestamp,
                              updatedAt: getCurrentTimestamp,
                              gameHistoryID: _model.idmapResultEntry?.historyId,
                              gameId: _model.selectedGameList
                                  .elementAtOrNull((_model.countGame!) - 1)
                                  ?.gameId,
                              userId: _model.selectedUserList
                                  .elementAtOrNull((_model.countUser!) - 1)
                                  ?.roomUserId
                                  ?.toString(),
                              userRef: _model.selectedUserList
                                  .elementAtOrNull((_model.countUser!) - 1)
                                  ?.roomUserRef,
                              roomId: _model.roomResultEntry?.roomID,
                              resultInfo: updateResultInfoStruct(
                                _model.selectedGameList
                                    .elementAtOrNull((_model.countGame!) - 1)
                                    ?.gameResult,
                                clearUnsetFields: false,
                                create: true,
                              ),
                              sessionId: currentUserDocument
                                  ?.presentRoomGameInfo?.roomSelectedGameID,
                            ));

                        await _model.idmapResultEntry!.reference.update({
                          ...mapToFirestore(
                            {
                              'history_id': FieldValue.increment(1),
                            },
                          ),
                        });
                      }
                    }
                    _model.countUser = (_model.countUser!) - 1;
                  }
                } else {
                  if (_model.selectedGameList
                          .elementAtOrNull((_model.countGame!) - 1)
                          ?.teamInfo
                          ?.length ==
                      2) {
                    _model.updateSelectedGameListAtIndex(
                      (_model.countGame!) - 1,
                      (e) => e
                        ..updateGameResult(
                          (e) => e
                            ..status = (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.teamInfo
                                            ?.firstOrNull
                                            ?.totalResult !=
                                        _model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.teamInfo
                                            ?.lastOrNull
                                            ?.totalResult) &&
                                    (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)!
                                            .teamInfo
                                            .firstOrNull!
                                            .totalResult >
                                        0)
                                ? 'win'
                                : 'tie',
                        ),
                    );
                  } else {
                    if ((_model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)
                                ?.teamInfo
                                ?.firstOrNull
                                ?.totalResult ==
                            _model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)
                                ?.teamInfo
                                ?.lastOrNull
                                ?.totalResult) &&
                        (_model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)
                                ?.teamInfo
                                ?.firstOrNull
                                ?.totalResult ==
                            (_model.selectedGameList
                                    .elementAtOrNull((_model.countGame!) - 1)
                                    ?.teamInfo
                                    ?.elementAtOrNull(1))
                                ?.totalResult) &&
                        (_model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)
                                ?.teamInfo
                                ?.lastOrNull
                                ?.totalResult ==
                            (_model.selectedGameList
                                    .elementAtOrNull((_model.countGame!) - 1)
                                    ?.teamInfo
                                    ?.elementAtOrNull(1))
                                ?.totalResult)) {
                      _model.updateSelectedGameListAtIndex(
                        (_model.countGame!) - 1,
                        (e) => e
                          ..updateGameResult(
                            (e) => e..status = 'tie',
                          ),
                      );
                    } else {
                      if (_model.selectedGameList
                              .elementAtOrNull((_model.countGame!) - 1)
                              ?.teamInfo
                              ?.firstOrNull
                              ?.totalResult ==
                          (_model.selectedGameList
                                  .elementAtOrNull((_model.countGame!) - 1)
                                  ?.teamInfo
                                  ?.elementAtOrNull(1))
                              ?.totalResult) {
                        if ((_model.selectedGameList
                                    .elementAtOrNull((_model.countGame!) - 1)!
                                    .teamInfo
                                    .firstOrNull!
                                    .totalResult >
                                0) &&
                            (_model.selectedGameList
                                    .elementAtOrNull((_model.countGame!) - 1)!
                                    .teamInfo
                                    .lastOrNull!
                                    .totalResult <
                                _model.selectedGameList
                                    .elementAtOrNull((_model.countGame!) - 1)!
                                    .teamInfo
                                    .firstOrNull!
                                    .totalResult)) {
                          _model.updateSelectedGameListAtIndex(
                            (_model.countGame!) - 1,
                            (e) => e
                              ..updateGameResult(
                                (e) => e..status = 'tie',
                              )
                              ..updateTeamInfo(
                                (e) => e.removeAt(2),
                              ),
                          );
                        } else {
                          _model.updateSelectedGameListAtIndex(
                            (_model.countGame!) - 1,
                            (e) => e
                              ..gameEndTime = getCurrentTimestamp
                              ..updateGameResult(
                                (e) => e
                                  ..status = 'win'
                                  ..teamID = _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.lastOrNull
                                      ?.teamID
                                  ..teamInfo = _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.lastOrNull
                                      ?.teamInfo
                                  ..point = _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.lastOrNull
                                      ?.totalResult
                                  ..createdAt = getCurrentTimestamp,
                              ),
                          );
                          _model.countUser = _model.selectedGameList
                              .elementAtOrNull((_model.countGame!) - 1)
                              ?.selectedGameUserList
                              ?.length;
                          _model.selectedUserList = _model.selectedGameList
                              .elementAtOrNull((_model.countGame!) - 1)!
                              .selectedGameUserList
                              .toList()
                              .cast<RoomUserListStruct>();
                          while (_model.countUser! > 0) {
                            if (_model.selectedUserList
                                    .elementAtOrNull((_model.countUser!) - 1)
                                    ?.roomUserStatus ==
                                'active') {
                              _model.gameHistoryResult2 =
                                  await queryGameHistoryRecordOnce(
                                queryBuilder: (gameHistoryRecord) =>
                                    gameHistoryRecord
                                        .where(
                                          'user_id',
                                          isEqualTo: _model.selectedUserList
                                              .elementAtOrNull(
                                                  (_model.countUser!) - 1)
                                              ?.roomUserId
                                              ?.toString(),
                                        )
                                        .where(
                                          'session_id',
                                          isEqualTo: currentUserDocument
                                              ?.presentRoomGameInfo
                                              ?.roomSelectedGameID,
                                        ),
                              );
                              if (_model.gameHistoryResult2!.length > 0) {
                                await GameHistoryRecord.collection
                                    .doc()
                                    .set(createGameHistoryRecordData(
                                      createdAt: getCurrentTimestamp,
                                      updatedAt: getCurrentTimestamp,
                                      gameHistoryID:
                                          _model.idmapResultEntry?.historyId,
                                      gameId: _model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)
                                          ?.gameId,
                                      userId: _model.selectedUserList
                                          .elementAtOrNull(
                                              (_model.countUser!) - 1)
                                          ?.roomUserId
                                          ?.toString(),
                                      userRef: _model.selectedUserList
                                          .elementAtOrNull(
                                              (_model.countUser!) - 1)
                                          ?.roomUserRef,
                                      roomId: _model.roomResultEntry?.roomID,
                                      resultInfo: updateResultInfoStruct(
                                        _model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.gameResult,
                                        clearUnsetFields: false,
                                        create: true,
                                      ),
                                      sessionId: currentUserDocument
                                          ?.presentRoomGameInfo
                                          ?.roomSelectedGameID,
                                    ));

                                await _model.idmapResultEntry!.reference
                                    .update({
                                  ...mapToFirestore(
                                    {
                                      'history_id': FieldValue.increment(1),
                                    },
                                  ),
                                });
                              }
                            }
                            _model.countUser = (_model.countUser!) - 1;
                          }
                        }
                      } else {
                        if ((_model.selectedGameList
                                    .elementAtOrNull((_model.countGame!) - 1)
                                    ?.teamInfo
                                    ?.elementAtOrNull(1))
                                ?.totalResult ==
                            _model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)
                                ?.teamInfo
                                ?.lastOrNull
                                ?.totalResult) {
                          if ((_model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)!
                                      .teamInfo
                                      .lastOrNull!
                                      .totalResult >
                                  0) &&
                              (_model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)!
                                      .teamInfo
                                      .firstOrNull!
                                      .totalResult <
                                  _model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)!
                                      .teamInfo
                                      .lastOrNull!
                                      .totalResult)) {
                            _model.updateSelectedGameListAtIndex(
                              (_model.countGame!) - 1,
                              (e) => e
                                ..updateGameResult(
                                  (e) => e..status = 'tie',
                                )
                                ..updateTeamInfo(
                                  (e) => e.removeAt(0),
                                ),
                            );
                          } else {
                            _model.updateSelectedGameListAtIndex(
                              (_model.countGame!) - 1,
                              (e) => e
                                ..gameEndTime = getCurrentTimestamp
                                ..updateGameResult(
                                  (e) => e
                                    ..status = 'win'
                                    ..teamID = _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.teamInfo
                                        ?.firstOrNull
                                        ?.teamID
                                    ..teamInfo = _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.teamInfo
                                        ?.firstOrNull
                                        ?.teamInfo
                                    ..point = _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.teamInfo
                                        ?.firstOrNull
                                        ?.totalResult
                                    ..createdAt = getCurrentTimestamp,
                                ),
                            );
                            _model.countUser = _model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)
                                ?.selectedGameUserList
                                ?.length;
                            _model.selectedUserList = _model.selectedGameList
                                .elementAtOrNull((_model.countGame!) - 1)!
                                .selectedGameUserList
                                .toList()
                                .cast<RoomUserListStruct>();
                            while (_model.countUser! > 0) {
                              if (_model.selectedUserList
                                      .elementAtOrNull((_model.countUser!) - 1)
                                      ?.roomUserStatus ==
                                  'active') {
                                _model.gameHistoryResult3 =
                                    await queryGameHistoryRecordOnce(
                                  queryBuilder: (gameHistoryRecord) =>
                                      gameHistoryRecord
                                          .where(
                                            'user_id',
                                            isEqualTo: _model.selectedUserList
                                                .elementAtOrNull(
                                                    (_model.countUser!) - 1)
                                                ?.roomUserId
                                                ?.toString(),
                                          )
                                          .where(
                                            'session_id',
                                            isEqualTo: currentUserDocument
                                                ?.presentRoomGameInfo
                                                ?.roomSelectedGameID,
                                          ),
                                );
                                if (_model.gameHistoryResult3!.length > 0) {
                                  await GameHistoryRecord.collection
                                      .doc()
                                      .set(createGameHistoryRecordData(
                                        createdAt: getCurrentTimestamp,
                                        updatedAt: getCurrentTimestamp,
                                        gameHistoryID:
                                            _model.idmapResultEntry?.historyId,
                                        gameId: _model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.gameId,
                                        userId: _model.selectedUserList
                                            .elementAtOrNull(
                                                (_model.countUser!) - 1)
                                            ?.roomUserId
                                            ?.toString(),
                                        userRef: _model.selectedUserList
                                            .elementAtOrNull(
                                                (_model.countUser!) - 1)
                                            ?.roomUserRef,
                                        roomId: _model.roomResultEntry?.roomID,
                                        resultInfo: updateResultInfoStruct(
                                          _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)
                                              ?.gameResult,
                                          clearUnsetFields: false,
                                          create: true,
                                        ),
                                        sessionId: currentUserDocument
                                            ?.presentRoomGameInfo
                                            ?.roomSelectedGameID,
                                      ));

                                  await _model.idmapResultEntry!.reference
                                      .update({
                                    ...mapToFirestore(
                                      {
                                        'history_id': FieldValue.increment(1),
                                      },
                                    ),
                                  });
                                }
                              }
                              _model.countUser = (_model.countUser!) - 1;
                            }
                          }
                        } else {
                          if (_model.selectedGameList
                                  .elementAtOrNull((_model.countGame!) - 1)
                                  ?.teamInfo
                                  ?.firstOrNull
                                  ?.totalResult ==
                              _model.selectedGameList
                                  .elementAtOrNull((_model.countGame!) - 1)
                                  ?.teamInfo
                                  ?.lastOrNull
                                  ?.totalResult) {
                            if ((_model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)!
                                        .teamInfo
                                        .lastOrNull!
                                        .totalResult >
                                    0) &&
                                (_model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)!
                                        .teamInfo
                                        .elementAtOrNull(1)!
                                        .totalResult <
                                    _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)!
                                        .teamInfo
                                        .lastOrNull!
                                        .totalResult)) {
                              _model.updateSelectedGameListAtIndex(
                                (_model.countGame!) - 1,
                                (e) => e
                                  ..updateGameResult(
                                    (e) => e..status = 'tie',
                                  )
                                  ..updateTeamInfo(
                                    (e) => e.removeAt(1),
                                  ),
                              );
                            } else {
                              _model.updateSelectedGameListAtIndex(
                                (_model.countGame!) - 1,
                                (e) => e
                                  ..gameEndTime = getCurrentTimestamp
                                  ..updateGameResult(
                                    (e) => e
                                      ..status = 'win'
                                      ..teamID = (_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)
                                              ?.teamInfo
                                              ?.elementAtOrNull(1))
                                          ?.teamID
                                      ..teamInfo = (_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)
                                              ?.teamInfo
                                              ?.elementAtOrNull(1))
                                          ?.teamInfo
                                      ..point = (_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)
                                              ?.teamInfo
                                              ?.elementAtOrNull(1))
                                          ?.totalResult
                                      ..createdAt = getCurrentTimestamp,
                                  ),
                              );
                              _model.countUser = _model.selectedGameList
                                  .elementAtOrNull((_model.countGame!) - 1)
                                  ?.selectedGameUserList
                                  ?.length;
                              _model.selectedUserList = _model.selectedGameList
                                  .elementAtOrNull((_model.countGame!) - 1)!
                                  .selectedGameUserList
                                  .toList()
                                  .cast<RoomUserListStruct>();
                              while (_model.countUser! > 0) {
                                if (_model.selectedUserList
                                        .elementAtOrNull(
                                            (_model.countUser!) - 1)
                                        ?.roomUserStatus ==
                                    'active') {
                                  _model.gameHistoryResult4 =
                                      await queryGameHistoryRecordOnce(
                                    queryBuilder: (gameHistoryRecord) =>
                                        gameHistoryRecord
                                            .where(
                                              'user_id',
                                              isEqualTo: _model.selectedUserList
                                                  .elementAtOrNull(
                                                      (_model.countUser!) - 1)
                                                  ?.roomUserId
                                                  ?.toString(),
                                            )
                                            .where(
                                              'session_id',
                                              isEqualTo: currentUserDocument
                                                  ?.presentRoomGameInfo
                                                  ?.roomSelectedGameID,
                                            ),
                                  );
                                  if (_model.gameHistoryResult4!.length > 0) {
                                    await GameHistoryRecord.collection
                                        .doc()
                                        .set(createGameHistoryRecordData(
                                          createdAt: getCurrentTimestamp,
                                          updatedAt: getCurrentTimestamp,
                                          gameHistoryID: _model
                                              .idmapResultEntry?.historyId,
                                          gameId: _model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)
                                              ?.gameId,
                                          userId: _model.selectedUserList
                                              .elementAtOrNull(
                                                  (_model.countUser!) - 1)
                                              ?.roomUserId
                                              ?.toString(),
                                          userRef: _model.selectedUserList
                                              .elementAtOrNull(
                                                  (_model.countUser!) - 1)
                                              ?.roomUserRef,
                                          roomId:
                                              _model.roomResultEntry?.roomID,
                                          resultInfo: updateResultInfoStruct(
                                            _model.selectedGameList
                                                .elementAtOrNull(
                                                    (_model.countGame!) - 1)
                                                ?.gameResult,
                                            clearUnsetFields: false,
                                            create: true,
                                          ),
                                          sessionId: currentUserDocument
                                              ?.presentRoomGameInfo
                                              ?.roomSelectedGameID,
                                        ));

                                    await _model.idmapResultEntry!.reference
                                        .update({
                                      ...mapToFirestore(
                                        {
                                          'history_id': FieldValue.increment(1),
                                        },
                                      ),
                                    });
                                  }
                                }
                                _model.countUser = (_model.countUser!) - 1;
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              } else {
                await Future.delayed(
                  Duration(
                    milliseconds: 5000,
                  ),
                );
                safeSetState(() {});
              }
            }
            break;
          }
          _model.countGame = (_model.countGame!) - 1;
        }
        if (_model.foundStatus != 'notFound') {
          await widget!.room!.update({
            ...createRoomRecordData(
              roomUpdatedAt: getCurrentTimestamp,
            ),
            ...mapToFirestore(
              {
                'selected_game_list': getSelectedGameListListFirestoreData(
                  _model.selectedGameList,
                ),
              },
            ),
          });
          unawaited(
            () async {
              Navigator.pop(context);
            }(),
          );
          if ((_model.selectedGameList
                      .elementAtOrNull((_model.countGame!) - 1)
                      ?.gameId ==
                  1001) ||
              (_model.selectedGameList
                      .elementAtOrNull((_model.countGame!) - 1)
                      ?.gameId ==
                  1003)) {
            if (_model.selectedGameList
                    .elementAtOrNull((_model.countGame!) - 1)
                    ?.gameId ==
                1001) {
              if (Navigator.of(context).canPop()) {
                context.pop();
              }
              context.pushNamed(
                GameOneS3Widget.routeName,
                queryParameters: {
                  'room': serializeParam(
                    widget!.room,
                    ParamType.DocumentReference,
                  ),
                }.withoutNulls,
              );
            } else {
              if (_model.selectedGameList
                      .elementAtOrNull((_model.countGame!) - 1)
                      ?.gameId ==
                  1003) {
                context.goNamed(
                  GameFourS3Widget.routeName,
                  queryParameters: {
                    'room': serializeParam(
                      widget!.room,
                      ParamType.DocumentReference,
                    ),
                  }.withoutNulls,
                );
              }
            }
          } else {
            if (_model.selectedGameList
                    .elementAtOrNull((_model.countGame!) - 1)
                    ?.gameId ==
                1002) {
              context.goNamed(HomeWidget.routeName);
            }
          }
        } else {
          await Future.delayed(
            Duration(
              milliseconds: 5000,
            ),
          );
          _model.refresh = _model.refresh! + ((_model.refresh!) + 1);
          safeSetState(() {});
        }
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
