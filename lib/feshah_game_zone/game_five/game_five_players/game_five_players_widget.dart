import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_five_players_model.dart';
export 'game_five_players_model.dart';

class GameFivePlayersWidget extends StatefulWidget {
  const GameFivePlayersWidget({
    super.key,
    required this.roomUser,
    required this.user,
    required this.index,
    required this.room,
    bool? gameSAUvoteStatus,
    required this.selectedGameIndex,
    bool? gameUserRemove,
    bool? gameUserAdd,
  })  : this.gameSAUvoteStatus = gameSAUvoteStatus ?? false,
        this.gameUserRemove = gameUserRemove ?? false,
        this.gameUserAdd = gameUserAdd ?? false;

  final RoomUserListStruct? roomUser;
  final DocumentReference? user;
  final int? index;
  final RoomRecord? room;
  final bool gameSAUvoteStatus;
  final int? selectedGameIndex;
  final bool gameUserRemove;
  final bool gameUserAdd;

  @override
  State<GameFivePlayersWidget> createState() => _GameFivePlayersWidgetState();
}

class _GameFivePlayersWidgetState extends State<GameFivePlayersWidget> {
  late GameFivePlayersModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFivePlayersModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget!.room?.roomType != 'solo')
          StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(widget!.user!),
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

              final roomUsersRecord = snapshot.data!;

              return Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                valueOrDefault<String>(
                                  roomUsersRecord.photoUrl,
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/7fnvxvk9w0jj/Frame_2087324742.png',
                                ),
                              ).image,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 12.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    roomUsersRecord.displayName,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.almarai(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 13.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  if (currentUserReference ==
                                      widget!.roomUser?.roomUserRef)
                                    Icon(
                                      FFIcons.kfi13,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 14.0,
                                    ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    valueOrDefault<String>(
                                      '${FFLocalizations.of(context).getVariableText(
                                        enText: 'Player ID: ',
                                        arText: 'معرف اللاعب:',
                                      )}${roomUsersRecord.userId.toString()}',
                                      ' Player ID: 22364598',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.almarai(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 13.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  if (currentUserReference ==
                                      widget!.roomUser?.roomUserRef)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x1967B5B0),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 2.0, 8.0, 2.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            '6yc55e4n' /* You */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.almarai(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ].divide(SizedBox(height: 4.0)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (widget!.room?.roomCreatedUserRef ==
                              widget!.roomUser?.roomUserRef)
                            FlutterFlowIconButton(
                              borderRadius: 20.0,
                              borderWidth: 0.0,
                              buttonSize: 32.0,
                              fillColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              icon: Icon(
                                FFIcons.kfi13,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 16.0,
                              ),
                              onPressed: () {
                                print('Admin pressed ...');
                              },
                            ),
                          if (widget!.gameSAUvoteStatus == true)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (((widget!.room?.selectedGameList
                                                ?.elementAtOrNull(
                                                    widget!.selectedGameIndex!))
                                            ?.gameSAU
                                            ?.lastOrNull
                                            ?.voteUser
                                            ?.where((e) =>
                                                e.fromUserRef ==
                                                currentUserReference)
                                            .toList()
                                            ?.length ==
                                        0) &&
                                    (widget!.roomUser?.roomUserRef !=
                                        currentUserReference))
                                  FFButtonWidget(
                                    onPressed: () async {
                                      _model.selectedGameList = widget!
                                          .room!.selectedGameList
                                          .toList()
                                          .cast<SelectedGameListStruct>();
                                      _model.gameSAU = widget!
                                          .room!.selectedGameList
                                          .elementAtOrNull(
                                              widget!.selectedGameIndex!)!
                                          .gameSAU
                                          .toList()
                                          .cast<GameSAUStruct>();
                                      _model.indexSAU = widget!
                                              .room!.selectedGameList
                                              .elementAtOrNull(
                                                  widget!.selectedGameIndex!)!
                                              .gameSAU
                                              .length -
                                          1;
                                      _model.voteCount = _model.gameSAU
                                          .elementAtOrNull(_model.indexSAU!)
                                          ?.voteUser
                                          ?.length;
                                      _model.voteList = _model.gameSAU
                                          .elementAtOrNull(_model.indexSAU!)!
                                          .voteUser
                                          .toList()
                                          .cast<GameSAUVoteUserStruct>();
                                      while (_model.voteCount! > 0) {
                                        if (_model.voteList
                                                .elementAtOrNull(
                                                    (_model.voteCount!) - 1)
                                                ?.fromUserRef ==
                                            currentUserReference) {
                                          _model.removeAtIndexFromVoteList(
                                              (_model.voteCount!) - 1);
                                          _model.updateSelectedGameListAtIndex(
                                            widget!.selectedGameIndex!,
                                            (e) => e
                                              ..updateGameSAU(
                                                (e) => e[_model.indexSAU!]
                                                  ..voteUser =
                                                      _model.voteList.toList(),
                                              ),
                                          );
                                          break;
                                        }
                                        _model.voteCount =
                                            (_model.voteCount!) - 1;
                                      }
                                      _model.idmapResult =
                                          await queryIDmapRecordOnce(
                                        queryBuilder: (iDmapRecord) =>
                                            iDmapRecord.where(
                                          'type',
                                          isEqualTo: 'Main',
                                        ),
                                        singleRecord: true,
                                      ).then((s) => s.firstOrNull);
                                      _model.updateSelectedGameListAtIndex(
                                        widget!.selectedGameIndex!,
                                        (e) => e
                                          ..updateGameSAU(
                                            (e) => e[_model.indexSAU!]
                                              ..updateVoteUser(
                                                (e) =>
                                                    e.add(GameSAUVoteUserStruct(
                                                  voteCreatedAt:
                                                      getCurrentTimestamp,
                                                  voteUpdatedAt:
                                                      getCurrentTimestamp,
                                                  voteStatus: 'active',
                                                  voteId: _model
                                                      .idmapResult?.voteId,
                                                  toUserRef: widget!
                                                      .roomUser?.roomUserRef,
                                                  fromUserRef:
                                                      currentUserReference,
                                                  fromUserUid: valueOrDefault(
                                                          currentUserDocument
                                                              ?.userId,
                                                          0)
                                                      .toString(),
                                                  toUserUid:
                                                      roomUsersRecord.uid,
                                                )),
                                              ),
                                          ),
                                      );

                                      await _model.idmapResult!.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'vote_id': FieldValue.increment(1),
                                          },
                                        ),
                                      });

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

                                      safeSetState(() {});
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      '3ethgslp' /* Vote */,
                                    ),
                                    options: FFButtonOptions(
                                      height: 32.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.almarai(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                if (widget!.room!.selectedGameList
                                        .elementAtOrNull(
                                            widget!.selectedGameIndex!)!
                                        .gameSAU
                                        .lastOrNull!
                                        .voteUser
                                        .where((e) =>
                                            (e.fromUserRef ==
                                                currentUserReference) &&
                                            (e.toUserRef ==
                                                widget!.roomUser?.roomUserRef))
                                        .toList()
                                        .length >
                                    0)
                                  FFButtonWidget(
                                    onPressed: () {
                                      print('Vote_OFF pressed ...');
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      'k8w10afb' /* You Voted */,
                                    ),
                                    options: FFButtonOptions(
                                      height: 32.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.almarai(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                              ].divide(SizedBox(width: 12.0)),
                            ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (widget!.gameUserRemove == true)
                                FlutterFlowIconButton(
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  borderRadius: 100.0,
                                  borderWidth: 0.5,
                                  buttonSize: 32.0,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  icon: Icon(
                                    Icons.remove_outlined,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 16.0,
                                  ),
                                  showLoadingIndicator: true,
                                  onPressed: () async {
                                    _model.notificationResultRemove =
                                        await queryNotificationRecordOnce(
                                      queryBuilder: (notificationRecord) =>
                                          notificationRecord
                                              .where(
                                                'to_userRef',
                                                isEqualTo: widget!.user,
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
                                                    .selectedGameList
                                                    .elementAtOrNull(widget!
                                                        .selectedGameIndex!)
                                                    ?.selectedGameID,
                                              ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    if ((_model.notificationResultRemove !=
                                            null) ==
                                        true) {
                                      unawaited(
                                        () async {
                                          await _model.notificationResultRemove!
                                              .reference
                                              .delete();
                                        }(),
                                      );
                                    }
                                    _model.selectedGameList = widget!
                                        .room!.selectedGameList
                                        .toList()
                                        .cast<SelectedGameListStruct>();
                                    _model.userCount = (widget!
                                            .room?.selectedGameList
                                            ?.elementAtOrNull(
                                                widget!.selectedGameIndex!))
                                        ?.selectedGameUserList
                                        ?.length;
                                    _model.userList = widget!
                                        .room!.selectedGameList
                                        .elementAtOrNull(
                                            widget!.selectedGameIndex!)!
                                        .selectedGameUserList
                                        .toList()
                                        .cast<RoomUserListStruct>();
                                    while (_model.userCount! > 0) {
                                      if (_model.userList
                                              .elementAtOrNull(
                                                  (_model.userCount!) - 1)
                                              ?.roomUserRef ==
                                          widget!.user) {
                                        _model.updateUserListAtIndex(
                                          (_model.userCount!) - 1,
                                          (e) => e
                                            ..roomUserNotificationSendStatus =
                                                null
                                            ..roomUserNotificationRef = null,
                                        );
                                        _model.updateSelectedGameListAtIndex(
                                          widget!.selectedGameIndex!,
                                          (e) => e
                                            ..selectedGameUserList =
                                                _model.userList.toList(),
                                        );
                                        break;
                                      }
                                      _model.userCount =
                                          (_model.userCount!) - 1;
                                    }

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

                                    safeSetState(() {});
                                  },
                                ),
                              if (widget!.gameUserAdd == true)
                                FlutterFlowIconButton(
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  borderRadius: 100.0,
                                  borderWidth: 0.5,
                                  buttonSize: 32.0,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  icon: Icon(
                                    Icons.add_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 16.0,
                                  ),
                                  showLoadingIndicator: true,
                                  onPressed: () async {
                                    var _shouldSetState = false;
                                    _model.selectedGameList = widget!
                                        .room!.selectedGameList
                                        .toList()
                                        .cast<SelectedGameListStruct>();
                                    _model.userCount = (widget!
                                            .room?.selectedGameList
                                            ?.elementAtOrNull(
                                                widget!.selectedGameIndex!))
                                        ?.selectedGameUserList
                                        ?.length;
                                    _model.userList = widget!
                                        .room!.selectedGameList
                                        .elementAtOrNull(
                                            widget!.selectedGameIndex!)!
                                        .selectedGameUserList
                                        .toList()
                                        .cast<RoomUserListStruct>();
                                    _model.countGame =
                                        widget!.room?.selectedGameList?.length;
                                    _model.userFoundStatus = 'notFound';
                                    while (_model.userCount! > 0) {
                                      if ((_model.selectedGameList
                                                  .elementAtOrNull(widget!
                                                      .selectedGameIndex!)
                                                  ?.selectedGameUserList
                                                  ?.elementAtOrNull(
                                                      (_model.userCount!) - 1))
                                              ?.roomUserRef ==
                                          widget!.user) {
                                        if (_model.userList
                                                .elementAtOrNull(
                                                    (_model.userCount!) - 1)
                                                ?.roomUserNotificationSendStatus ==
                                            '') {
                                          _model.userFoundStatus = 'found';
                                          _model.updateSelectedGameListAtIndex(
                                            widget!.selectedGameIndex!,
                                            (e) => e
                                              ..updateSelectedGameUserList(
                                                (e) => e[
                                                    (_model.userCount!) - 1]
                                                  ..roomUserNotificationSendStatus =
                                                      'send',
                                              ),
                                          );
                                          break;
                                        } else {
                                          _model.notificationResultNew =
                                              await queryNotificationRecordCount(
                                            queryBuilder:
                                                (notificationRecord) =>
                                                    notificationRecord
                                                        .where(
                                                          'to_userRef',
                                                          isEqualTo:
                                                              widget!.user,
                                                        )
                                                        .where(
                                                          'notification_status',
                                                          isEqualTo: 'send',
                                                        )
                                                        .where(
                                                          'notification_type',
                                                          isEqualTo:
                                                              'game_invite',
                                                        )
                                                        .where(
                                                          'game_info.room_user_selected_game_id',
                                                          isEqualTo: (widget!
                                                                  .room
                                                                  ?.selectedGameList
                                                                  ?.elementAtOrNull(
                                                                      widget!
                                                                          .selectedGameIndex!))
                                                              ?.selectedGameID,
                                                        ),
                                          );
                                          _shouldSetState = true;
                                          if (_model.notificationResultNew! >
                                              0) {
                                            unawaited(
                                              () async {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return WebViewAware(
                                                      child: AlertDialog(
                                                        content: Text(
                                                            'Already added in game.'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: Text('Ok'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              }(),
                                            );
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          } else {
                                            _model.userFoundStatus = 'found';
                                            _model
                                                .updateSelectedGameListAtIndex(
                                              widget!.selectedGameIndex!,
                                              (e) => e
                                                ..updateSelectedGameUserList(
                                                  (e) => e[
                                                      (_model.userCount!) - 1]
                                                    ..roomUserNotificationSendStatus =
                                                        'send',
                                                ),
                                            );
                                          }
                                        }

                                        _model.userFoundStatus = 'found';
                                        _model.updateSelectedGameListAtIndex(
                                          widget!.selectedGameIndex!,
                                          (e) => e
                                            ..updateSelectedGameUserList(
                                              (e) => e[(_model.userCount!) - 1]
                                                ..roomUserNotificationSendStatus =
                                                    'send',
                                            ),
                                        );
                                        break;
                                      }
                                      _model.userCount =
                                          (_model.userCount!) - 1;
                                    }
                                    if (_model.userFoundStatus == 'notFound') {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return WebViewAware(
                                            child: AlertDialog(
                                              content: Text(
                                                  'Already added in game.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
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
                                    if ((_model.userFoundStatus == 'found') &&
                                        ((widget!.room?.selectedGameList
                                                    ?.elementAtOrNull(widget!
                                                        .selectedGameIndex!))
                                                ?.gameSelectedByUserRef !=
                                            widget!.user)) {
                                      _model.gameResult =
                                          await queryGameRecordOnce(
                                        queryBuilder: (gameRecord) => gameRecord
                                            .where(
                                              'game_status',
                                              isEqualTo: 'active',
                                            )
                                            .where(
                                              'game_ID',
                                              isEqualTo: _model.selectedGameList
                                                  .elementAtOrNull(widget!
                                                      .selectedGameIndex!)
                                                  ?.gameId,
                                            ),
                                        singleRecord: true,
                                      ).then((s) => s.firstOrNull);
                                      _shouldSetState = true;
                                      _model.idmapNotificationResult2 =
                                          await queryIDmapRecordOnce(
                                        queryBuilder: (iDmapRecord) =>
                                            iDmapRecord.where(
                                          'type',
                                          isEqualTo: 'Main',
                                        ),
                                        singleRecord: true,
                                      ).then((s) => s.firstOrNull);
                                      _shouldSetState = true;

                                      await NotificationRecord.collection
                                          .doc()
                                          .set(createNotificationRecordData(
                                            createdAt: getCurrentTimestamp,
                                            updatedAt: getCurrentTimestamp,
                                            notificationID: _model
                                                .idmapNotificationResult2
                                                ?.notificationId,
                                            notificationStatus: 'send',
                                            toUserRef:
                                                widget!.roomUser?.roomUserRef,
                                            fromUserRef: currentUserReference,
                                            notificationType: 'game_invite',
                                            gameInfo: updateGameInfoStruct(
                                              GameInfoStruct(
                                                roomId: widget!.room?.roomID,
                                                roomInfo:
                                                    widget!.room?.roomMainInfo,
                                                gameID:
                                                    _model.gameResult?.gameID,
                                                gameInfo:
                                                    _model.gameResult?.gameInfo,
                                                gameInviteTime:
                                                    getCurrentTimestamp,
                                                gameInviteStatus: 'game_invite',
                                                fromUserId: valueOrDefault(
                                                    currentUserDocument?.userId,
                                                    0),
                                                fromUserRef:
                                                    currentUserReference,
                                                roomUserSelectedGameId: _model
                                                    .selectedGameList
                                                    .elementAtOrNull(widget!
                                                        .selectedGameIndex!)
                                                    ?.selectedGameID,
                                                fromUserName:
                                                    currentUserDisplayName,
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                          ));

                                      await _model
                                          .idmapNotificationResult2!.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'notification_id':
                                                FieldValue.increment(1),
                                          },
                                        ),
                                      });

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
                                    }
                                    if (_shouldSetState) safeSetState(() {});
                                  },
                                ),
                            ].divide(SizedBox(width: 4.0)),
                          ),
                        ].divide(SizedBox(width: 4.0)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        if (widget!.room?.roomType == 'solo')
          Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/7fnvxvk9w0jj/Frame_2087324742.png',
                          ).image,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget!.roomUser!.roomUserInfo.userName,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.almarai(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).primary,
                        borderRadius: 100.0,
                        borderWidth: 0.5,
                        buttonSize: 32.0,
                        fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        icon: Icon(
                          Icons.remove_outlined,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 16.0,
                        ),
                        showLoadingIndicator: true,
                        onPressed: () async {
                          _model.selectedGameList = widget!
                              .room!.selectedGameList
                              .toList()
                              .cast<SelectedGameListStruct>();
                          _model.userCount = (widget!.room?.selectedGameList
                                  ?.elementAtOrNull(widget!.selectedGameIndex!))
                              ?.selectedGameUserList
                              ?.length;
                          _model.userList = widget!.room!.selectedGameList
                              .elementAtOrNull(widget!.selectedGameIndex!)!
                              .selectedGameUserList
                              .toList()
                              .cast<RoomUserListStruct>();
                          _model.removeAtIndexFromUserList(widget!.index!);
                          _model.updateSelectedGameListAtIndex(
                            widget!.selectedGameIndex!,
                            (e) => e
                              ..selectedGameUserList = _model.userList.toList(),
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
                          safeSetState(() {});
                        },
                      ),
                    ].divide(SizedBox(width: 4.0)),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
