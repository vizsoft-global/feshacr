import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_exit_model.dart';
export 'game_exit_model.dart';

class GameExitWidget extends StatefulWidget {
  const GameExitWidget({
    super.key,
    required this.room,
    required this.selectedGameID,
  });

  final DocumentReference? room;
  final int? selectedGameID;

  @override
  State<GameExitWidget> createState() => _GameExitWidgetState();
}

class _GameExitWidgetState extends State<GameExitWidget> {
  late GameExitModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameExitModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
      child: ClipRRect(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0x18EC4D41),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FlutterFlowIconButton(
                            borderRadius: 100.0,
                            buttonSize: 40.0,
                            fillColor: Color(0x25EC4D41),
                            icon: Icon(
                              Icons.logout_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),
                      ),
                      InkWell(
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
                    ].divide(SizedBox(width: 8.0)),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'xlaqjnq2' /* Are you sure? */,
                    ),
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.almarai(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    'ym79ln7r' /* are you sure you want to cance... */,
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.almarai(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            var _shouldSetState = false;
                            _model.roomResult =
                                await RoomRecord.getDocumentOnce(widget!.room!);
                            _shouldSetState = true;
                            _model.idmapResult = await queryIDmapRecordOnce(
                              queryBuilder: (iDmapRecord) => iDmapRecord.where(
                                'type',
                                isEqualTo: 'Main',
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);
                            _shouldSetState = true;
                            _model.countGame =
                                _model.roomResult?.selectedGameList?.length;
                            _model.selectedGameList = _model
                                .roomResult!.selectedGameList
                                .toList()
                                .cast<SelectedGameListStruct>();
                            while (_model.countGame! > 0) {
                              if (_model.selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.selectedGameID ==
                                  widget!.selectedGameID) {
                                if ((_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.gameId ==
                                        1001) ||
                                    (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.gameId ==
                                        1003)) {
                                  if (_model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)
                                          ?.teamInfo
                                          ?.firstOrNull
                                          ?.teamInfo ==
                                      null) {
                                    _model.updateSelectedGameListAtIndex(
                                      (_model.countGame!) - 1,
                                      (e) => e
                                        ..updateGameResult(
                                          (e) => e..status = 'exited',
                                        ),
                                    );
                                    _model.countUser = _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.selectedGameUserList
                                        ?.length;

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

                                    context.goNamed(
                                      GameFourS3Widget.routeName,
                                      queryParameters: {
                                        'room': serializeParam(
                                          widget!.room,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );
                                  } else {
                                    if (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.teamInfo?.length == 2
                                        ? (_model.selectedGameList
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
                                                ?.totalResult)
                                        : ((_model.selectedGameList
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
                                                        (_model.countGame!) - 1)
                                                    ?.teamInfo
                                                    ?.firstOrNull
                                                    ?.totalResult !=
                                                (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.teamInfo?.elementAtOrNull(1))?.totalResult) &&
                                            (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.teamInfo?.lastOrNull?.totalResult != (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.teamInfo?.elementAtOrNull(1))?.totalResult))) {
                                      _model.updateSelectedGameListAtIndex(
                                        (_model.countGame!) - 1,
                                        (e) => e
                                          ..gameEndTime = getCurrentTimestamp
                                          ..updateGameResult(
                                            (e) => e
                                              ..status = 'win'
                                              ..teamID = _model.selectedGameList
                                                          .elementAtOrNull(
                                                              (_model.countGame!) -
                                                                  1)
                                                          ?.teamInfo
                                                          ?.length ==
                                                      2
                                                  ? (_model.selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)!
                                                              .teamInfo
                                                              .firstOrNull!
                                                              .totalResult >
                                                          _model.selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)!
                                                              .teamInfo
                                                              .lastOrNull!
                                                              .totalResult
                                                      ? _model.selectedGameList
                                                          .elementAtOrNull(
                                                              (_model.countGame!) -
                                                                  1)
                                                          ?.teamInfo
                                                          ?.firstOrNull
                                                          ?.teamID
                                                      : _model.selectedGameList
                                                          .elementAtOrNull(
                                                              (_model.countGame!) - 1)
                                                          ?.teamInfo
                                                          ?.lastOrNull
                                                          ?.teamID)
                                                  : () {
                                                      if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                              _model.selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)!
                                                                  .teamInfo
                                                                  .lastOrNull!
                                                                  .totalResult) &&
                                                          (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                              _model.selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)!
                                                                  .teamInfo
                                                                  .elementAtOrNull(
                                                                      1)!
                                                                  .totalResult)) {
                                                        return _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.teamID;
                                                      } else if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                                              _model.selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)!
                                                                  .teamInfo
                                                                  .firstOrNull!
                                                                  .totalResult) &&
                                                          (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                                              _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull((_model.countGame!) - 1)!
                                                                  .teamInfo
                                                                  .elementAtOrNull(1)!
                                                                  .totalResult)) {
                                                        return _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.lastOrNull
                                                            ?.teamID;
                                                      } else {
                                                        return (_model
                                                                .selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)
                                                                ?.teamInfo
                                                                ?.elementAtOrNull(
                                                                    1))
                                                            ?.teamID;
                                                      }
                                                    }()
                                              ..teamInfo = _model
                                                          .selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGame!) -
                                                              1)
                                                          ?.teamInfo
                                                          ?.length ==
                                                      2
                                                  ? (_model.selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)!
                                                              .teamInfo
                                                              .firstOrNull!
                                                              .totalResult >
                                                          _model.selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)!
                                                              .teamInfo
                                                              .lastOrNull!
                                                              .totalResult
                                                      ? _model.selectedGameList
                                                          .elementAtOrNull(
                                                              (_model.countGame!) -
                                                                  1)
                                                          ?.teamInfo
                                                          ?.firstOrNull
                                                          ?.teamInfo
                                                      : _model.selectedGameList
                                                          .elementAtOrNull((_model.countGame!) - 1)
                                                          ?.teamInfo
                                                          ?.lastOrNull
                                                          ?.teamInfo)
                                                  : () {
                                                      if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                              _model.selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)!
                                                                  .teamInfo
                                                                  .lastOrNull!
                                                                  .totalResult) &&
                                                          (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                              _model.selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)!
                                                                  .teamInfo
                                                                  .elementAtOrNull(
                                                                      1)!
                                                                  .totalResult)) {
                                                        return _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.teamInfo;
                                                      } else if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                                              _model.selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)!
                                                                  .teamInfo
                                                                  .firstOrNull!
                                                                  .totalResult) &&
                                                          (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                                              _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull((_model.countGame!) - 1)!
                                                                  .teamInfo
                                                                  .elementAtOrNull(1)!
                                                                  .totalResult)) {
                                                        return _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.lastOrNull
                                                            ?.teamInfo;
                                                      } else {
                                                        return (_model
                                                                .selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)
                                                                ?.teamInfo
                                                                ?.elementAtOrNull(
                                                                    1))
                                                            ?.teamInfo;
                                                      }
                                                    }()
                                              ..point = _model.selectedGameList
                                                          .elementAtOrNull(
                                                              (_model.countGame!) -
                                                                  1)
                                                          ?.teamInfo
                                                          ?.length ==
                                                      2
                                                  ? (_model.selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)!
                                                              .teamInfo
                                                              .firstOrNull!
                                                              .totalResult >
                                                          _model.selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)!
                                                              .teamInfo
                                                              .lastOrNull!
                                                              .totalResult
                                                      ? _model.selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGame!) -
                                                              1)
                                                          ?.teamInfo
                                                          ?.firstOrNull
                                                          ?.totalResult
                                                      : _model.selectedGameList
                                                          .elementAtOrNull((_model.countGame!) - 1)
                                                          ?.teamInfo
                                                          ?.lastOrNull
                                                          ?.totalResult)
                                                  : () {
                                                      if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                              _model.selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)!
                                                                  .teamInfo
                                                                  .lastOrNull!
                                                                  .totalResult) &&
                                                          (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                              _model.selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)!
                                                                  .teamInfo
                                                                  .elementAtOrNull(
                                                                      1)!
                                                                  .totalResult)) {
                                                        return _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.totalResult;
                                                      } else if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                                              _model.selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)!
                                                                  .teamInfo
                                                                  .firstOrNull!
                                                                  .totalResult) &&
                                                          (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                                              _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull((_model.countGame!) - 1)!
                                                                  .teamInfo
                                                                  .elementAtOrNull(1)!
                                                                  .totalResult)) {
                                                        return _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.lastOrNull
                                                            ?.totalResult;
                                                      } else {
                                                        return (_model
                                                                .selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)
                                                                ?.teamInfo
                                                                ?.elementAtOrNull(
                                                                    1))
                                                            ?.totalResult;
                                                      }
                                                    }()
                                              ..createdAt = getCurrentTimestamp,
                                          ),
                                      );
                                      _model.countUser = _model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)
                                          ?.selectedGameUserList
                                          ?.length;
                                      _model.selectedUserList = _model
                                          .selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .selectedGameUserList
                                          .toList()
                                          .cast<RoomUserListStruct>();
                                      while (_model.countUser! > 0) {
                                        if (_model.selectedUserList
                                                .elementAtOrNull(
                                                    (_model.countUser!) - 1)
                                                ?.roomUserStatus ==
                                            'active') {
                                          _model.gameHistoryResult45 =
                                              await queryGameHistoryRecordOnce(
                                            queryBuilder: (gameHistoryRecord) =>
                                                gameHistoryRecord
                                                    .where(
                                                      'user_ref',
                                                      isEqualTo: _model
                                                          .selectedUserList
                                                          .elementAtOrNull((_model
                                                                  .countUser!) -
                                                              1)
                                                          ?.roomUserRef,
                                                    )
                                                    .where(
                                                      'session_id',
                                                      isEqualTo: widget!
                                                          .selectedGameID,
                                                    ),
                                          );
                                          _shouldSetState = true;
                                          if (_model.gameHistoryResult45
                                                  ?.length ==
                                              0) {
                                            await GameHistoryRecord.collection
                                                .doc()
                                                .set(
                                                    createGameHistoryRecordData(
                                                  createdAt:
                                                      getCurrentTimestamp,
                                                  updatedAt:
                                                      getCurrentTimestamp,
                                                  gameHistoryID: _model
                                                      .idmapResult?.historyId,
                                                  gameId: _model
                                                      .selectedGameList
                                                      .elementAtOrNull(
                                                          (_model.countGame!) -
                                                              1)
                                                      ?.gameId,
                                                  userId: _model
                                                      .selectedUserList
                                                      .elementAtOrNull(
                                                          (_model.countUser!) -
                                                              1)
                                                      ?.roomUserId
                                                      ?.toString(),
                                                  userRef: _model
                                                      .selectedUserList
                                                      .elementAtOrNull(
                                                          (_model.countUser!) -
                                                              1)
                                                      ?.roomUserRef,
                                                  roomId:
                                                      _model.roomResult?.roomID,
                                                  resultInfo:
                                                      createResultInfoStruct(
                                                    createdAt:
                                                        getCurrentTimestamp,
                                                    status: 'win',
                                                    teamID: _model.selectedGameList
                                                                .elementAtOrNull((_model.countGame!) -
                                                                    1)
                                                                ?.teamInfo
                                                                ?.length ==
                                                            2
                                                        ? (_model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .firstOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult
                                                            ? _model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)
                                                                ?.teamInfo
                                                                ?.firstOrNull
                                                                ?.teamID
                                                            : _model
                                                                .selectedGameList
                                                                .elementAtOrNull((_model.countGame!) - 1)
                                                                ?.teamInfo
                                                                ?.lastOrNull
                                                                ?.teamID)
                                                        : () {
                                                            if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                    _model.selectedGameList
                                                                        .elementAtOrNull((_model.countGame!) -
                                                                            1)!
                                                                        .teamInfo
                                                                        .lastOrNull!
                                                                        .totalResult) &&
                                                                (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                    _model.selectedGameList
                                                                        .elementAtOrNull((_model.countGame!) -
                                                                            1)!
                                                                        .teamInfo
                                                                        .elementAtOrNull(
                                                                            1)!
                                                                        .totalResult)) {
                                                              return _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.firstOrNull
                                                                  ?.teamID;
                                                            } else if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                                                    _model.selectedGameList
                                                                        .elementAtOrNull((_model.countGame!) -
                                                                            1)!
                                                                        .teamInfo
                                                                        .firstOrNull!
                                                                        .totalResult) &&
                                                                (_model.selectedGameList
                                                                        .elementAtOrNull((_model.countGame!) -
                                                                            1)!
                                                                        .teamInfo
                                                                        .lastOrNull!
                                                                        .totalResult >
                                                                    _model.selectedGameList
                                                                        .elementAtOrNull((_model.countGame!) - 1)!
                                                                        .teamInfo
                                                                        .elementAtOrNull(1)!
                                                                        .totalResult)) {
                                                              return _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.lastOrNull
                                                                  ?.teamID;
                                                            } else {
                                                              return (_model
                                                                      .selectedGameList
                                                                      .elementAtOrNull(
                                                                          (_model.countGame!) -
                                                                              1)
                                                                      ?.teamInfo
                                                                      ?.elementAtOrNull(
                                                                          1))
                                                                  ?.teamID;
                                                            }
                                                          }(),
                                                    teamInfo:
                                                        updateMainInfoStruct(
                                                      _model.selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.length ==
                                                              2
                                                          ? (_model.selectedGameList
                                                                      .elementAtOrNull(
                                                                          (_model.countGame!) -
                                                                              1)!
                                                                      .teamInfo
                                                                      .firstOrNull!
                                                                      .totalResult >
                                                                  _model.selectedGameList
                                                                      .elementAtOrNull(
                                                                          (_model.countGame!) -
                                                                              1)!
                                                                      .teamInfo
                                                                      .lastOrNull!
                                                                      .totalResult
                                                              ? _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.firstOrNull
                                                                  ?.teamInfo
                                                              : _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.lastOrNull
                                                                  ?.teamInfo)
                                                          : () {
                                                              if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult) &&
                                                                  (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                      _model.selectedGameList
                                                                          .elementAtOrNull((_model.countGame!) -
                                                                              1)!
                                                                          .teamInfo
                                                                          .elementAtOrNull(
                                                                              1)!
                                                                          .totalResult)) {
                                                                return _model
                                                                    .selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)
                                                                    ?.teamInfo
                                                                    ?.firstOrNull
                                                                    ?.teamInfo;
                                                              } else if ((_model.selectedGameList
                                                                          .elementAtOrNull((_model.countGame!) -
                                                                              1)!
                                                                          .teamInfo
                                                                          .lastOrNull!
                                                                          .totalResult >
                                                                      _model.selectedGameList
                                                                          .elementAtOrNull((_model.countGame!) -
                                                                              1)!
                                                                          .teamInfo
                                                                          .firstOrNull!
                                                                          .totalResult) &&
                                                                  (_model.selectedGameList
                                                                          .elementAtOrNull((_model.countGame!) -
                                                                              1)!
                                                                          .teamInfo
                                                                          .lastOrNull!
                                                                          .totalResult >
                                                                      _model.selectedGameList
                                                                          .elementAtOrNull((_model.countGame!) - 1)!
                                                                          .teamInfo
                                                                          .elementAtOrNull(1)!
                                                                          .totalResult)) {
                                                                return _model
                                                                    .selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)
                                                                    ?.teamInfo
                                                                    ?.lastOrNull
                                                                    ?.teamInfo;
                                                              } else {
                                                                return (_model
                                                                        .selectedGameList
                                                                        .elementAtOrNull(
                                                                            (_model.countGame!) -
                                                                                1)
                                                                        ?.teamInfo
                                                                        ?.elementAtOrNull(
                                                                            1))
                                                                    ?.teamInfo;
                                                              }
                                                            }(),
                                                      clearUnsetFields: false,
                                                      create: true,
                                                    ),
                                                    point: _model.selectedGameList
                                                                .elementAtOrNull((_model.countGame!) -
                                                                    1)
                                                                ?.teamInfo
                                                                ?.length ==
                                                            2
                                                        ? (_model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .firstOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult
                                                            ? _model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)
                                                                ?.teamInfo
                                                                ?.firstOrNull
                                                                ?.totalResult
                                                            : _model
                                                                .selectedGameList
                                                                .elementAtOrNull((_model.countGame!) - 1)
                                                                ?.teamInfo
                                                                ?.lastOrNull
                                                                ?.totalResult)
                                                        : () {
                                                            if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                    _model.selectedGameList
                                                                        .elementAtOrNull((_model.countGame!) -
                                                                            1)!
                                                                        .teamInfo
                                                                        .lastOrNull!
                                                                        .totalResult) &&
                                                                (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                    _model.selectedGameList
                                                                        .elementAtOrNull((_model.countGame!) -
                                                                            1)!
                                                                        .teamInfo
                                                                        .elementAtOrNull(
                                                                            1)!
                                                                        .totalResult)) {
                                                              return _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.firstOrNull
                                                                  ?.totalResult;
                                                            } else if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult >
                                                                    _model.selectedGameList
                                                                        .elementAtOrNull((_model.countGame!) -
                                                                            1)!
                                                                        .teamInfo
                                                                        .firstOrNull!
                                                                        .totalResult) &&
                                                                (_model.selectedGameList
                                                                        .elementAtOrNull((_model.countGame!) -
                                                                            1)!
                                                                        .teamInfo
                                                                        .lastOrNull!
                                                                        .totalResult >
                                                                    _model.selectedGameList
                                                                        .elementAtOrNull((_model.countGame!) - 1)!
                                                                        .teamInfo
                                                                        .elementAtOrNull(1)!
                                                                        .totalResult)) {
                                                              return _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.lastOrNull
                                                                  ?.totalResult;
                                                            } else {
                                                              return (_model
                                                                      .selectedGameList
                                                                      .elementAtOrNull(
                                                                          (_model.countGame!) -
                                                                              1)
                                                                      ?.teamInfo
                                                                      ?.elementAtOrNull(
                                                                          1))
                                                                  ?.totalResult;
                                                            }
                                                          }(),
                                                    clearUnsetFields: false,
                                                    create: true,
                                                  ),
                                                  sessionId: currentUserDocument
                                                      ?.presentRoomGameInfo
                                                      ?.roomSelectedGameID,
                                                ));

                                            await _model.idmapResult!.reference
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'history_id':
                                                      FieldValue.increment(1),
                                                },
                                              ),
                                            });
                                          }
                                        }
                                        _model.countUser =
                                            (_model.countUser!) - 1;
                                      }
                                    } else {
                                      if (_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)
                                              ?.teamInfo
                                              ?.length ==
                                          2) {
                                        _model.updateSelectedGameListAtIndex(
                                          (_model.countGame!) - 1,
                                          (e) => e
                                            ..updateGameResult(
                                              (e) => e
                                                ..status = (_model
                                                                .selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)
                                                                ?.teamInfo
                                                                ?.firstOrNull
                                                                ?.totalResult !=
                                                            _model
                                                                .selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)
                                                                ?.teamInfo
                                                                ?.lastOrNull
                                                                ?.totalResult) &&
                                                        (_model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
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
                                                    .elementAtOrNull(
                                                        (_model.countGame!) - 1)
                                                    ?.teamInfo
                                                    ?.firstOrNull
                                                    ?.totalResult ==
                                                _model.selectedGameList
                                                    .elementAtOrNull(
                                                        (_model.countGame!) - 1)
                                                    ?.teamInfo
                                                    ?.lastOrNull
                                                    ?.totalResult) &&
                                            (_model.selectedGameList
                                                    .elementAtOrNull(
                                                        (_model.countGame!) - 1)
                                                    ?.teamInfo
                                                    ?.firstOrNull
                                                    ?.totalResult ==
                                                (_model.selectedGameList
                                                        .elementAtOrNull(
                                                            (_model.countGame!) -
                                                                1)
                                                        ?.teamInfo
                                                        ?.elementAtOrNull(1))
                                                    ?.totalResult) &&
                                            (_model.selectedGameList
                                                    .elementAtOrNull(
                                                        (_model.countGame!) - 1)
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
                                                  .elementAtOrNull(
                                                      (_model.countGame!) - 1)
                                                  ?.teamInfo
                                                  ?.firstOrNull
                                                  ?.totalResult ==
                                              (_model.selectedGameList
                                                      .elementAtOrNull(
                                                          (_model.countGame!) -
                                                              1)
                                                      ?.teamInfo
                                                      ?.elementAtOrNull(1))
                                                  ?.totalResult) {
                                            if ((_model.selectedGameList
                                                        .elementAtOrNull((_model
                                                                .countGame!) -
                                                            1)!
                                                        .teamInfo
                                                        .firstOrNull!
                                                        .totalResult >
                                                    0) &&
                                                (_model.selectedGameList
                                                        .elementAtOrNull((_model
                                                                .countGame!) -
                                                            1)!
                                                        .teamInfo
                                                        .lastOrNull!
                                                        .totalResult <
                                                    _model.selectedGameList
                                                        .elementAtOrNull((_model
                                                                .countGame!) -
                                                            1)!
                                                        .teamInfo
                                                        .firstOrNull!
                                                        .totalResult)) {
                                              _model
                                                  .updateSelectedGameListAtIndex(
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
                                              _model
                                                  .updateSelectedGameListAtIndex(
                                                (_model.countGame!) - 1,
                                                (e) => e
                                                  ..gameEndTime =
                                                      getCurrentTimestamp
                                                  ..updateGameResult(
                                                    (e) => e
                                                      ..status = 'win'
                                                      ..teamID = _model
                                                          .selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGame!) -
                                                              1)
                                                          ?.teamInfo
                                                          ?.lastOrNull
                                                          ?.teamID
                                                      ..teamInfo = _model
                                                          .selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGame!) -
                                                              1)
                                                          ?.teamInfo
                                                          ?.lastOrNull
                                                          ?.teamInfo
                                                      ..point = _model
                                                          .selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGame!) -
                                                              1)
                                                          ?.teamInfo
                                                          ?.lastOrNull
                                                          ?.totalResult
                                                      ..createdAt =
                                                          getCurrentTimestamp,
                                                  ),
                                              );
                                              _model.countUser = _model
                                                  .selectedGameList
                                                  .elementAtOrNull(
                                                      (_model.countGame!) - 1)
                                                  ?.selectedGameUserList
                                                  ?.length;
                                              _model.selectedUserList = _model
                                                  .selectedGameList
                                                  .elementAtOrNull(
                                                      (_model.countGame!) - 1)!
                                                  .selectedGameUserList
                                                  .toList()
                                                  .cast<RoomUserListStruct>();
                                              while (_model.countUser! > 0) {
                                                if (_model.selectedUserList
                                                        .elementAtOrNull((_model
                                                                .countUser!) -
                                                            1)
                                                        ?.roomUserStatus ==
                                                    'active') {
                                                  _model.gameHistoryResult2 =
                                                      await queryGameHistoryRecordOnce(
                                                    queryBuilder:
                                                        (gameHistoryRecord) =>
                                                            gameHistoryRecord
                                                                .where(
                                                                  'user_ref',
                                                                  isEqualTo: _model
                                                                      .selectedUserList
                                                                      .elementAtOrNull(
                                                                          (_model.countUser!) -
                                                                              1)
                                                                      ?.roomUserRef,
                                                                )
                                                                .where(
                                                                  'session_id',
                                                                  isEqualTo: widget!
                                                                      .selectedGameID,
                                                                ),
                                                  );
                                                  _shouldSetState = true;
                                                  if (_model.gameHistoryResult2
                                                          ?.length ==
                                                      0) {
                                                    await GameHistoryRecord
                                                        .collection
                                                        .doc()
                                                        .set(
                                                            createGameHistoryRecordData(
                                                          createdAt:
                                                              getCurrentTimestamp,
                                                          updatedAt:
                                                              getCurrentTimestamp,
                                                          gameHistoryID: _model
                                                              .idmapResult
                                                              ?.historyId,
                                                          gameId: _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.gameId,
                                                          userId: _model
                                                              .selectedUserList
                                                              .elementAtOrNull(
                                                                  (_model.countUser!) -
                                                                      1)
                                                              ?.roomUserId
                                                              ?.toString(),
                                                          userRef: _model
                                                              .selectedUserList
                                                              .elementAtOrNull(
                                                                  (_model.countUser!) -
                                                                      1)
                                                              ?.roomUserRef,
                                                          roomId: _model
                                                              .roomResult
                                                              ?.roomID,
                                                          resultInfo:
                                                              updateResultInfoStruct(
                                                            ResultInfoStruct(
                                                              createdAt:
                                                                  getCurrentTimestamp,
                                                              status: 'win',
                                                              teamID: _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.lastOrNull
                                                                  ?.teamID,
                                                              teamInfo: _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.lastOrNull
                                                                  ?.teamInfo,
                                                              point: _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.lastOrNull
                                                                  ?.totalResult,
                                                            ),
                                                            clearUnsetFields:
                                                                false,
                                                            create: true,
                                                          ),
                                                          sessionId: currentUserDocument
                                                              ?.presentRoomGameInfo
                                                              ?.roomSelectedGameID,
                                                        ));

                                                    await _model
                                                        .idmapResult!.reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'history_id':
                                                              FieldValue
                                                                  .increment(1),
                                                        },
                                                      ),
                                                    });
                                                  }
                                                }
                                                _model.countUser =
                                                    (_model.countUser!) - 1;
                                              }
                                            }
                                          } else {
                                            if ((_model.selectedGameList
                                                        .elementAtOrNull((_model
                                                                .countGame!) -
                                                            1)
                                                        ?.teamInfo
                                                        ?.elementAtOrNull(1))
                                                    ?.totalResult ==
                                                _model.selectedGameList
                                                    .elementAtOrNull(
                                                        (_model.countGame!) - 1)
                                                    ?.teamInfo
                                                    ?.lastOrNull
                                                    ?.totalResult) {
                                              if ((_model.selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGame!) -
                                                              1)!
                                                          .teamInfo
                                                          .lastOrNull!
                                                          .totalResult >
                                                      0) &&
                                                  (_model.selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGame!) -
                                                              1)!
                                                          .teamInfo
                                                          .firstOrNull!
                                                          .totalResult <
                                                      _model.selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGame!) -
                                                              1)!
                                                          .teamInfo
                                                          .lastOrNull!
                                                          .totalResult)) {
                                                _model
                                                    .updateSelectedGameListAtIndex(
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
                                                _model
                                                    .updateSelectedGameListAtIndex(
                                                  (_model.countGame!) - 1,
                                                  (e) => e
                                                    ..gameEndTime =
                                                        getCurrentTimestamp
                                                    ..updateGameResult(
                                                      (e) => e
                                                        ..status = 'win'
                                                        ..teamID = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.teamID
                                                        ..teamInfo = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.teamInfo
                                                        ..point = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.totalResult
                                                        ..createdAt =
                                                            getCurrentTimestamp,
                                                    ),
                                                );
                                                _model.countUser = _model
                                                    .selectedGameList
                                                    .elementAtOrNull(
                                                        (_model.countGame!) - 1)
                                                    ?.selectedGameUserList
                                                    ?.length;
                                                _model.selectedUserList = _model
                                                    .selectedGameList
                                                    .elementAtOrNull(
                                                        (_model.countGame!) -
                                                            1)!
                                                    .selectedGameUserList
                                                    .toList()
                                                    .cast<RoomUserListStruct>();
                                                while (_model.countUser! > 0) {
                                                  if (_model.selectedUserList
                                                          .elementAtOrNull((_model
                                                                  .countUser!) -
                                                              1)
                                                          ?.roomUserStatus ==
                                                      'active') {
                                                    _model.gameHistoryResult3 =
                                                        await queryGameHistoryRecordOnce(
                                                      queryBuilder:
                                                          (gameHistoryRecord) =>
                                                              gameHistoryRecord
                                                                  .where(
                                                                    'user_ref',
                                                                    isEqualTo: _model
                                                                        .selectedUserList
                                                                        .elementAtOrNull(
                                                                            (_model.countUser!) -
                                                                                1)
                                                                        ?.roomUserRef,
                                                                  )
                                                                  .where(
                                                                    'session_id',
                                                                    isEqualTo:
                                                                        widget!
                                                                            .selectedGameID,
                                                                  ),
                                                    );
                                                    _shouldSetState = true;
                                                    if (_model
                                                            .gameHistoryResult3
                                                            ?.length ==
                                                        0) {
                                                      await GameHistoryRecord
                                                          .collection
                                                          .doc()
                                                          .set(
                                                              createGameHistoryRecordData(
                                                            createdAt:
                                                                getCurrentTimestamp,
                                                            updatedAt:
                                                                getCurrentTimestamp,
                                                            gameHistoryID:
                                                                _model
                                                                    .idmapResult
                                                                    ?.historyId,
                                                            gameId: _model
                                                                .selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)
                                                                ?.gameId,
                                                            userId: _model
                                                                .selectedUserList
                                                                .elementAtOrNull(
                                                                    (_model.countUser!) -
                                                                        1)
                                                                ?.roomUserId
                                                                ?.toString(),
                                                            userRef: _model
                                                                .selectedUserList
                                                                .elementAtOrNull(
                                                                    (_model.countUser!) -
                                                                        1)
                                                                ?.roomUserRef,
                                                            roomId: _model
                                                                .roomResult
                                                                ?.roomID,
                                                            resultInfo:
                                                                updateResultInfoStruct(
                                                              ResultInfoStruct(
                                                                createdAt:
                                                                    getCurrentTimestamp,
                                                                status: 'win',
                                                                teamID: _model
                                                                    .selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)
                                                                    ?.teamInfo
                                                                    ?.lastOrNull
                                                                    ?.teamID,
                                                                teamInfo: _model
                                                                    .selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)
                                                                    ?.teamInfo
                                                                    ?.lastOrNull
                                                                    ?.teamInfo,
                                                                point: _model
                                                                    .selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)
                                                                    ?.teamInfo
                                                                    ?.lastOrNull
                                                                    ?.totalResult,
                                                              ),
                                                              clearUnsetFields:
                                                                  false,
                                                              create: true,
                                                            ),
                                                            sessionId: currentUserDocument
                                                                ?.presentRoomGameInfo
                                                                ?.roomSelectedGameID,
                                                          ));

                                                      await _model.idmapResult!
                                                          .reference
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'history_id':
                                                                FieldValue
                                                                    .increment(
                                                                        1),
                                                          },
                                                        ),
                                                      });
                                                    }
                                                  }
                                                  _model.countUser =
                                                      (_model.countUser!) - 1;
                                                }
                                              }
                                            } else {
                                              if (_model.selectedGameList
                                                      .elementAtOrNull(
                                                          (_model.countGame!) -
                                                              1)
                                                      ?.teamInfo
                                                      ?.firstOrNull
                                                      ?.totalResult ==
                                                  _model.selectedGameList
                                                      .elementAtOrNull(
                                                          (_model.countGame!) -
                                                              1)
                                                      ?.teamInfo
                                                      ?.lastOrNull
                                                      ?.totalResult) {
                                                if ((_model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)!
                                                            .teamInfo
                                                            .lastOrNull!
                                                            .totalResult >
                                                        0) &&
                                                    (_model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)!
                                                            .teamInfo
                                                            .elementAtOrNull(1)!
                                                            .totalResult <
                                                        _model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)!
                                                            .teamInfo
                                                            .lastOrNull!
                                                            .totalResult)) {
                                                  _model
                                                      .updateSelectedGameListAtIndex(
                                                    (_model.countGame!) - 1,
                                                    (e) => e
                                                      ..updateGameResult(
                                                        (e) =>
                                                            e..status = 'tie',
                                                      )
                                                      ..updateTeamInfo(
                                                        (e) => e.removeAt(1),
                                                      ),
                                                  );
                                                } else {
                                                  _model
                                                      .updateSelectedGameListAtIndex(
                                                    (_model.countGame!) - 1,
                                                    (e) => e
                                                      ..gameEndTime =
                                                          getCurrentTimestamp
                                                      ..updateGameResult(
                                                        (e) => e
                                                          ..status = 'win'
                                                          ..teamID = (_model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.elementAtOrNull(
                                                                      1))
                                                              ?.teamID
                                                          ..teamInfo = (_model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.elementAtOrNull(
                                                                      1))
                                                              ?.teamInfo
                                                          ..point = (_model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.elementAtOrNull(
                                                                      1))
                                                              ?.totalResult
                                                          ..createdAt =
                                                              getCurrentTimestamp,
                                                      ),
                                                  );
                                                  _model.countUser = _model
                                                      .selectedGameList
                                                      .elementAtOrNull(
                                                          (_model.countGame!) -
                                                              1)
                                                      ?.selectedGameUserList
                                                      ?.length;
                                                  _model.selectedUserList = _model
                                                      .selectedGameList
                                                      .elementAtOrNull(
                                                          (_model.countGame!) -
                                                              1)!
                                                      .selectedGameUserList
                                                      .toList()
                                                      .cast<
                                                          RoomUserListStruct>();
                                                  while (
                                                      _model.countUser! > 0) {
                                                    if (_model.selectedUserList
                                                            .elementAtOrNull(
                                                                (_model.countUser!) -
                                                                    1)
                                                            ?.roomUserStatus ==
                                                        'active') {
                                                      _model.gameHistoryResult4 =
                                                          await queryGameHistoryRecordOnce(
                                                        queryBuilder:
                                                            (gameHistoryRecord) =>
                                                                gameHistoryRecord
                                                                    .where(
                                                                      'user_ref',
                                                                      isEqualTo: _model
                                                                          .selectedUserList
                                                                          .elementAtOrNull((_model.countUser!) -
                                                                              1)
                                                                          ?.roomUserRef,
                                                                    )
                                                                    .where(
                                                                      'session_id',
                                                                      isEqualTo:
                                                                          widget!
                                                                              .selectedGameID,
                                                                    ),
                                                      );
                                                      _shouldSetState = true;
                                                      if (_model
                                                              .gameHistoryResult4
                                                              ?.length ==
                                                          0) {
                                                        await GameHistoryRecord
                                                            .collection
                                                            .doc()
                                                            .set(
                                                                createGameHistoryRecordData(
                                                              createdAt:
                                                                  getCurrentTimestamp,
                                                              updatedAt:
                                                                  getCurrentTimestamp,
                                                              gameHistoryID: _model
                                                                  .idmapResult
                                                                  ?.historyId,
                                                              gameId: _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.gameId,
                                                              userId: _model
                                                                  .selectedUserList
                                                                  .elementAtOrNull(
                                                                      (_model.countUser!) -
                                                                          1)
                                                                  ?.roomUserId
                                                                  ?.toString(),
                                                              userRef: _model
                                                                  .selectedUserList
                                                                  .elementAtOrNull(
                                                                      (_model.countUser!) -
                                                                          1)
                                                                  ?.roomUserRef,
                                                              roomId: _model
                                                                  .roomResult
                                                                  ?.roomID,
                                                              resultInfo:
                                                                  updateResultInfoStruct(
                                                                ResultInfoStruct(
                                                                  createdAt:
                                                                      getCurrentTimestamp,
                                                                  status: 'win',
                                                                  teamID: _model
                                                                      .selectedGameList
                                                                      .elementAtOrNull(
                                                                          (_model.countGame!) -
                                                                              1)
                                                                      ?.teamInfo
                                                                      ?.lastOrNull
                                                                      ?.teamID,
                                                                  teamInfo: _model
                                                                      .selectedGameList
                                                                      .elementAtOrNull(
                                                                          (_model.countGame!) -
                                                                              1)
                                                                      ?.teamInfo
                                                                      ?.lastOrNull
                                                                      ?.teamInfo,
                                                                  point: _model
                                                                      .selectedGameList
                                                                      .elementAtOrNull(
                                                                          (_model.countGame!) -
                                                                              1)
                                                                      ?.teamInfo
                                                                      ?.lastOrNull
                                                                      ?.totalResult,
                                                                ),
                                                                clearUnsetFields:
                                                                    false,
                                                                create: true,
                                                              ),
                                                              sessionId: currentUserDocument
                                                                  ?.presentRoomGameInfo
                                                                  ?.roomSelectedGameID,
                                                            ));

                                                        await _model
                                                            .idmapResult!
                                                            .reference
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'history_id':
                                                                  FieldValue
                                                                      .increment(
                                                                          1),
                                                            },
                                                          ),
                                                        });
                                                      }
                                                    }
                                                    _model.countUser =
                                                        (_model.countUser!) - 1;
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                } else {
                                  if (_model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)
                                          ?.gameId ==
                                      1002) {
                                    _model.countUser = _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.selectedGameUserList
                                        ?.length;
                                    _model.selectedUserList = _model
                                        .selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)!
                                        .selectedGameUserList
                                        .toList()
                                        .cast<RoomUserListStruct>();
                                    while (_model.countUser! > 0) {
                                      if (_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGame!) - 1)!
                                              .gameSAU
                                              .length >
                                          0) {
                                        _model.roundCount = _model
                                            .selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.gameSAU
                                            ?.length;
                                        _model.roundList = _model
                                            .selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)!
                                            .gameSAU
                                            .toList()
                                            .cast<GameSAUStruct>();
                                        _model.points = 0;
                                        while (_model.roundCount! > 0) {
                                          if (_model.roundList
                                                  .elementAtOrNull(
                                                      (_model.roundCount!) - 1)!
                                                  .roundUserPoint
                                                  .length >
                                              0) {
                                            if (_model.roundList
                                                    .elementAtOrNull(
                                                        (_model.roundCount!) -
                                                            1)!
                                                    .roundUserPoint
                                                    .where((e) =>
                                                        e.roundUserRef ==
                                                        _model.selectedUserList
                                                            .elementAtOrNull(
                                                                (_model.countUser!) -
                                                                    1)
                                                            ?.roomUserRef)
                                                    .toList()
                                                    .length >
                                                0) {
                                              _model.roundUserList = _model
                                                  .roundList
                                                  .elementAtOrNull(
                                                      (_model.roundCount!) - 1)!
                                                  .roundUserPoint
                                                  .toList()
                                                  .cast<
                                                      GameSAURoundUserStruct>();
                                              _model.points = (_model.points!) +
                                                  _model.roundUserList
                                                      .where((e) =>
                                                          e.roundUserRef ==
                                                          _model
                                                              .selectedUserList
                                                              .elementAtOrNull(
                                                                  (_model.countUser!) -
                                                                      1)
                                                              ?.roomUserRef)
                                                      .toList()
                                                      .firstOrNull!
                                                      .roundPoints;
                                              _model
                                                  .updateSelectedUserListAtIndex(
                                                (_model.countUser!) - 1,
                                                (e) => e
                                                  ..roomUserPoints = (_model
                                                          .points!) +
                                                      _model.selectedUserList
                                                          .elementAtOrNull((_model
                                                                  .countUser!) -
                                                              1)!
                                                          .roomUserPoints,
                                              );
                                            } else {
                                              break;
                                            }
                                          } else {
                                            break;
                                          }

                                          _model.roundCount =
                                              (_model.roundCount!) - 1;
                                        }
                                      } else {
                                        _model.updateSelectedGameListAtIndex(
                                          (_model.countGame!) - 1,
                                          (e) => e
                                            ..gameEndTime = getCurrentTimestamp
                                            ..updateGameResult(
                                              (e) => e
                                                ..status = 'notYet'
                                                ..point = 0,
                                            ),
                                        );

                                        await widget!.room!.update({
                                          ...createRoomRecordData(
                                            roomUpdatedAt: getCurrentTimestamp,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'selected_game_list':
                                                  getSelectedGameListListFirestoreData(
                                                _model.selectedGameList,
                                              ),
                                            },
                                          ),
                                        });

                                        await FFAppState()
                                            .currentUserRef!
                                            .update(createUsersRecordData(
                                              presentRoomGameInfo:
                                                  createPresentRoomGameInfoStruct(
                                                      delete: true),
                                            ));

                                        context.goNamed(HomeWidget.routeName);

                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      }

                                      _model.countUser =
                                          (_model.countUser!) - 1;
                                    }
                                    _model.updateSelectedGameListAtIndex(
                                      (_model.countGame!) - 1,
                                      (e) => e
                                        ..gameEndTime = getCurrentTimestamp
                                        ..updateGameResult(
                                          (e) => e
                                            ..status = 'win'
                                            ..point = _model.finalResultUserList
                                                .sortedList(
                                                    keyOf: (e) => e.roundPoints,
                                                    desc: true)
                                                .firstOrNull
                                                ?.roundPoints
                                            ..userRef = _model
                                                .finalResultUserList
                                                .sortedList(
                                                    keyOf: (e) => e.roundPoints,
                                                    desc: true)
                                                .firstOrNull
                                                ?.roundUserRef,
                                        )
                                        ..gameSAUFinalResult =
                                            _model.finalResultUserList.toList()
                                        ..gameSAUStep = 7,
                                    );

                                    await widget!.room!.update({
                                      ...createRoomRecordData(
                                        roomUpdatedAt: getCurrentTimestamp,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'selected_game_list':
                                              getSelectedGameListListFirestoreData(
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
                                    FFAppState().refresh =
                                        FFAppState().refresh + 1;
                                    FFAppState().update(() {});
                                    if (_shouldSetState) safeSetState(() {});
                                    return;
                                  } else {
                                    if (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.gameId ==
                                        1004) {
                                      _model.updateSelectedGameListAtIndex(
                                        (_model.countGame!) - 1,
                                        (e) => e
                                          ..gameEndTime = getCurrentTimestamp
                                          ..gameSAUStep = 3
                                          ..updateGameResult(
                                            (e) => e..status = 'win',
                                          ),
                                      );

                                      await widget!.room!.update({
                                        ...createRoomRecordData(
                                          roomUpdatedAt: getCurrentTimestamp,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'selected_game_list':
                                                getSelectedGameListListFirestoreData(
                                              _model.selectedGameList,
                                            ),
                                          },
                                        ),
                                      });
                                      if (_model.roomResult?.roomType ==
                                          'solo') {
                                        _model.updateSelectedGameListAtIndex(
                                          (_model.countGame!) - 1,
                                          (e) => e
                                            ..gameEndTime = getCurrentTimestamp
                                            ..updateGameResult(
                                              (e) => e
                                                ..status = 'win'
                                                ..teamID = _model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.length ==
                                                        2
                                                    ? (_model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .firstOrNull!
                                                                .totalResult >
                                                            _model
                                                                .selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .lastOrNull!
                                                                .totalResult
                                                        ? _model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.teamID
                                                        : _model.selectedGameList
                                                            .elementAtOrNull((_model.countGame!) - 1)
                                                            ?.teamInfo
                                                            ?.lastOrNull
                                                            ?.teamID)
                                                    : () {
                                                        if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult) &&
                                                            (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(
                                                                        1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.firstOrNull
                                                              ?.teamID;
                                                        } else if ((_model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .firstOrNull!
                                                                    .totalResult) &&
                                                            (_model.selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) - 1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.lastOrNull
                                                              ?.teamID;
                                                        } else {
                                                          return (_model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.elementAtOrNull(
                                                                      1))
                                                              ?.teamID;
                                                        }
                                                      }()
                                                ..teamInfo = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.length ==
                                                        2
                                                    ? (_model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .firstOrNull!
                                                                .totalResult >
                                                            _model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .lastOrNull!
                                                                .totalResult
                                                        ? _model.selectedGameList
                                                            .elementAtOrNull((_model.countGame!) -
                                                                1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.teamInfo
                                                        : _model.selectedGameList
                                                            .elementAtOrNull((_model.countGame!) - 1)
                                                            ?.teamInfo
                                                            ?.lastOrNull
                                                            ?.teamInfo)
                                                    : () {
                                                        if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult) &&
                                                            (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(
                                                                        1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.firstOrNull
                                                              ?.teamInfo;
                                                        } else if ((_model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .firstOrNull!
                                                                    .totalResult) &&
                                                            (_model.selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) - 1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.lastOrNull
                                                              ?.teamInfo;
                                                        } else {
                                                          return (_model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.elementAtOrNull(
                                                                      1))
                                                              ?.teamInfo;
                                                        }
                                                      }()
                                                ..point = _model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.length ==
                                                        2
                                                    ? (_model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .firstOrNull!
                                                                .totalResult >
                                                            _model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .lastOrNull!
                                                                .totalResult
                                                        ? _model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.totalResult
                                                        : _model.selectedGameList
                                                            .elementAtOrNull((_model.countGame!) - 1)
                                                            ?.teamInfo
                                                            ?.lastOrNull
                                                            ?.totalResult)
                                                    : () {
                                                        if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult) &&
                                                            (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(
                                                                        1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.firstOrNull
                                                              ?.totalResult;
                                                        } else if ((_model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .firstOrNull!
                                                                    .totalResult) &&
                                                            (_model.selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) - 1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.lastOrNull
                                                              ?.totalResult;
                                                        } else {
                                                          return (_model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.elementAtOrNull(
                                                                      1))
                                                              ?.totalResult;
                                                        }
                                                      }()
                                                ..createdAt =
                                                    getCurrentTimestamp,
                                            ),
                                        );
                                        _model.countUser = _model
                                            .selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.selectedGameUserList
                                            ?.length;
                                        _model.selectedUserList = _model
                                            .selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)!
                                            .selectedGameUserList
                                            .toList()
                                            .cast<RoomUserListStruct>();

                                        await GameHistoryRecord.collection
                                            .doc()
                                            .set(createGameHistoryRecordData(
                                              createdAt: getCurrentTimestamp,
                                              updatedAt: getCurrentTimestamp,
                                              gameHistoryID:
                                                  _model.idmapResult?.historyId,
                                              gameId: _model.selectedGameList
                                                  .elementAtOrNull(
                                                      (_model.countGame!) - 1)
                                                  ?.gameId,
                                              userId: _model.selectedUserList
                                                  .elementAtOrNull(0)
                                                  ?.roomUserId
                                                  ?.toString(),
                                              userRef: _model.selectedUserList
                                                  .elementAtOrNull(0)
                                                  ?.roomUserRef,
                                              roomId: _model.roomResult?.roomID,
                                              resultInfo:
                                                  createResultInfoStruct(
                                                createdAt: getCurrentTimestamp,
                                                status: 'win',
                                                clearUnsetFields: false,
                                                create: true,
                                              ),
                                              sessionId: currentUserDocument
                                                  ?.presentRoomGameInfo
                                                  ?.roomSelectedGameID,
                                            ));

                                        await _model.idmapResult!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'history_id':
                                                  FieldValue.increment(1),
                                            },
                                          ),
                                        });
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
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.length ==
                                                        2
                                                    ? (_model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .firstOrNull!
                                                                .totalResult >
                                                            _model
                                                                .selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .lastOrNull!
                                                                .totalResult
                                                        ? _model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.teamID
                                                        : _model.selectedGameList
                                                            .elementAtOrNull((_model.countGame!) - 1)
                                                            ?.teamInfo
                                                            ?.lastOrNull
                                                            ?.teamID)
                                                    : () {
                                                        if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult) &&
                                                            (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(
                                                                        1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.firstOrNull
                                                              ?.teamID;
                                                        } else if ((_model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .firstOrNull!
                                                                    .totalResult) &&
                                                            (_model.selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) - 1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.lastOrNull
                                                              ?.teamID;
                                                        } else {
                                                          return (_model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.elementAtOrNull(
                                                                      1))
                                                              ?.teamID;
                                                        }
                                                      }()
                                                ..teamInfo = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.length ==
                                                        2
                                                    ? (_model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .firstOrNull!
                                                                .totalResult >
                                                            _model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .lastOrNull!
                                                                .totalResult
                                                        ? _model.selectedGameList
                                                            .elementAtOrNull((_model.countGame!) -
                                                                1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.teamInfo
                                                        : _model.selectedGameList
                                                            .elementAtOrNull((_model.countGame!) - 1)
                                                            ?.teamInfo
                                                            ?.lastOrNull
                                                            ?.teamInfo)
                                                    : () {
                                                        if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult) &&
                                                            (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(
                                                                        1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.firstOrNull
                                                              ?.teamInfo;
                                                        } else if ((_model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .firstOrNull!
                                                                    .totalResult) &&
                                                            (_model.selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) - 1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.lastOrNull
                                                              ?.teamInfo;
                                                        } else {
                                                          return (_model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.elementAtOrNull(
                                                                      1))
                                                              ?.teamInfo;
                                                        }
                                                      }()
                                                ..point = _model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.length ==
                                                        2
                                                    ? (_model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .firstOrNull!
                                                                .totalResult >
                                                            _model.selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)!
                                                                .teamInfo
                                                                .lastOrNull!
                                                                .totalResult
                                                        ? _model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGame!) -
                                                                    1)
                                                            ?.teamInfo
                                                            ?.firstOrNull
                                                            ?.totalResult
                                                        : _model.selectedGameList
                                                            .elementAtOrNull((_model.countGame!) - 1)
                                                            ?.teamInfo
                                                            ?.lastOrNull
                                                            ?.totalResult)
                                                    : () {
                                                        if ((_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.lastOrNull!.totalResult) &&
                                                            (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.teamInfo.firstOrNull!.totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(
                                                                        1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.firstOrNull
                                                              ?.totalResult;
                                                        } else if ((_model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) -
                                                                        1)!
                                                                    .teamInfo
                                                                    .firstOrNull!
                                                                    .totalResult) &&
                                                            (_model.selectedGameList
                                                                    .elementAtOrNull(
                                                                        (_model.countGame!) -
                                                                            1)!
                                                                    .teamInfo
                                                                    .lastOrNull!
                                                                    .totalResult >
                                                                _model.selectedGameList
                                                                    .elementAtOrNull((_model.countGame!) - 1)!
                                                                    .teamInfo
                                                                    .elementAtOrNull(1)!
                                                                    .totalResult)) {
                                                          return _model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.teamInfo
                                                              ?.lastOrNull
                                                              ?.totalResult;
                                                        } else {
                                                          return (_model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.teamInfo
                                                                  ?.elementAtOrNull(
                                                                      1))
                                                              ?.totalResult;
                                                        }
                                                      }()
                                                ..createdAt =
                                                    getCurrentTimestamp,
                                            ),
                                        );
                                        _model.countUser = _model
                                            .selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.selectedGameUserList
                                            ?.length;
                                        _model.selectedUserList = _model
                                            .selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)!
                                            .selectedGameUserList
                                            .toList()
                                            .cast<RoomUserListStruct>();
                                        while (_model.countUser! > 0) {
                                          if (_model.selectedUserList
                                                  .elementAtOrNull(
                                                      (_model.countUser!) - 1)
                                                  ?.roomUserStatus ==
                                              'active') {
                                            _model.gameHistoryResult1 =
                                                await queryGameHistoryRecordOnce(
                                              queryBuilder:
                                                  (gameHistoryRecord) =>
                                                      gameHistoryRecord
                                                          .where(
                                                            'user_ref',
                                                            isEqualTo: _model
                                                                .selectedUserList
                                                                .elementAtOrNull(
                                                                    (_model.countUser!) -
                                                                        1)
                                                                ?.roomUserRef,
                                                          )
                                                          .where(
                                                            'session_id',
                                                            isEqualTo: widget!
                                                                .selectedGameID,
                                                          ),
                                            );
                                            _shouldSetState = true;
                                            if (_model.gameHistoryResult45
                                                    ?.length ==
                                                0) {
                                              await GameHistoryRecord.collection
                                                  .doc()
                                                  .set(
                                                      createGameHistoryRecordData(
                                                    createdAt:
                                                        getCurrentTimestamp,
                                                    updatedAt:
                                                        getCurrentTimestamp,
                                                    gameHistoryID: _model
                                                        .idmapResult?.historyId,
                                                    gameId: _model
                                                        .selectedGameList
                                                        .elementAtOrNull((_model
                                                                .countGame!) -
                                                            1)
                                                        ?.gameId,
                                                    userId: _model
                                                        .selectedUserList
                                                        .elementAtOrNull((_model
                                                                .countUser!) -
                                                            1)
                                                        ?.roomUserId
                                                        ?.toString(),
                                                    userRef: _model
                                                        .selectedUserList
                                                        .elementAtOrNull((_model
                                                                .countUser!) -
                                                            1)
                                                        ?.roomUserRef,
                                                    roomId: _model
                                                        .roomResult?.roomID,
                                                    resultInfo:
                                                        createResultInfoStruct(
                                                      createdAt:
                                                          getCurrentTimestamp,
                                                      status: 'win',
                                                      clearUnsetFields: false,
                                                      create: true,
                                                    ),
                                                    sessionId: currentUserDocument
                                                        ?.presentRoomGameInfo
                                                        ?.roomSelectedGameID,
                                                  ));

                                              await _model
                                                  .idmapResult!.reference
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'history_id':
                                                        FieldValue.increment(1),
                                                  },
                                                ),
                                              });
                                            }
                                          }
                                          _model.countUser =
                                              (_model.countUser!) - 1;
                                        }
                                      }

                                      unawaited(
                                        () async {
                                          Navigator.pop(context);
                                        }(),
                                      );
                                      FFAppState().refresh =
                                          FFAppState().refresh + 1;
                                      FFAppState().update(() {});
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }
                                  }
                                }

                                break;
                              }
                              _model.countGame = (_model.countGame!) - 1;
                            }

                            await widget!.room!.update({
                              ...createRoomRecordData(
                                roomUpdatedAt: getCurrentTimestamp,
                              ),
                              ...mapToFirestore(
                                {
                                  'selected_game_list':
                                      getSelectedGameListListFirestoreData(
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
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.gameId ==
                                    1001) ||
                                (_model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
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
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
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

                            if (_shouldSetState) safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            '4ikmqcw5' /* Yes */,
                          ),
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconAlignment: IconAlignment.start,
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .override(
                                  fontFamily: 'Gentona Medium',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: FFLocalizations.of(context).getText(
                            '4lee7d2n' /* No */,
                          ),
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 50.0,
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
              ].divide(SizedBox(height: 8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
