import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_two/game_two_timer/game_two_timer_widget.dart';
import '/feshah_game_zone/game_two/game_two_user/game_two_user_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_two_model.dart';
export 'game_two_model.dart';

class GameTwoWidget extends StatefulWidget {
  const GameTwoWidget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  static String routeName = 'GameTwo';
  static String routePath = '/gametwo';

  @override
  State<GameTwoWidget> createState() => _GameTwoWidgetState();
}

class _GameTwoWidgetState extends State<GameTwoWidget> {
  late GameTwoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameTwoModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.setOrientation();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              automaticallyImplyLeading: false,
              title: AuthUserStreamWidget(
                builder: (context) => StreamBuilder<List<GameRecord>>(
                  stream: queryGameRecord(
                    queryBuilder: (gameRecord) => gameRecord.where(
                      'game_ID',
                      isEqualTo:
                          currentUserDocument?.presentRoomGameInfo?.roomGameId,
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
                    List<GameRecord> columnGameRecordList = snapshot.data!;
                    final columnGameRecord = columnGameRecordList.isNotEmpty
                        ? columnGameRecordList.first
                        : null;

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
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

                              final appBarGameRoomRecord = snapshot.data!;

                              return wrapWithModel(
                                model: _model.appBarGameModel,
                                updateCallback: () => safeSetState(() {}),
                                updateOnChange: true,
                                child: AppBarGameWidget(
                                  backButtonStatus: false,
                                  topicButtonStatus: false,
                                  exitButtonStatus: appBarGameRoomRecord
                                          .selectedGameList
                                          .where((e) =>
                                              e.selectedGameID ==
                                              currentUserDocument
                                                  ?.presentRoomGameInfo
                                                  ?.roomSelectedGameID)
                                          .toList()
                                          .firstOrNull
                                          ?.gameSAUStep !=
                                      7,
                                  selectedGameID: currentUserDocument
                                      ?.presentRoomGameInfo?.roomSelectedGameID,
                                  pageTitle: FFLocalizations.of(context)
                                      .getVariableText(
                                    enText: () {
                                      if (columnGameRecord
                                              ?.gameInfoManualTranslate
                                              ?.name
                                              ?.en !=
                                          '') {
                                        return columnGameRecord
                                            ?.gameInfoManualTranslate?.name?.en;
                                      } else if (columnGameRecord
                                              ?.gameInfoTranslate?.name?.en !=
                                          '') {
                                        return columnGameRecord
                                            ?.gameInfoTranslate?.name?.en;
                                      } else {
                                        return columnGameRecord?.gameInfo?.name;
                                      }
                                    }(),
                                    arText: () {
                                      if (columnGameRecord
                                              ?.gameInfoManualTranslate
                                              ?.name
                                              ?.ar !=
                                          '') {
                                        return columnGameRecord
                                            ?.gameInfoManualTranslate?.name?.ar;
                                      } else if (columnGameRecord
                                              ?.gameInfoTranslate?.name?.ar !=
                                          '') {
                                        return columnGameRecord
                                            ?.gameInfoTranslate?.name?.ar;
                                      } else {
                                        return columnGameRecord?.gameInfo?.name;
                                      }
                                    }(),
                                  ),
                                  room: widget!.room,
                                  presentTeamInfoStatus: false,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 1.0,
            ),
          ),
          body: StreamBuilder<RoomRecord>(
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

              final stackRoomRecord = snapshot.data!;

              return Stack(
                children: [
                  wrapWithModel(
                    model: _model.userStatusCheckerModel,
                    updateCallback: () => safeSetState(() {}),
                    child: UserStatusCheckerWidget(),
                  ),
                  AuthUserStreamWidget(
                    builder: (context) => StreamBuilder<List<GameRecord>>(
                      stream: queryGameRecord(
                        queryBuilder: (gameRecord) => gameRecord
                            .where(
                              'game_ID',
                              isEqualTo: stackRoomRecord.selectedGameList
                                  .where((e) =>
                                      e.selectedGameID ==
                                      currentUserDocument?.presentRoomGameInfo
                                          ?.roomSelectedGameID)
                                  .toList()
                                  .firstOrNull
                                  ?.gameId,
                            )
                            .where(
                              'game_status',
                              isEqualTo: 'active',
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
                        List<GameRecord> stackGameRecordList = snapshot.data!;
                        final stackGameRecord = stackGameRecordList.isNotEmpty
                            ? stackGameRecordList.first
                            : null;

                        return Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final mainGame = stackRoomRecord
                                      .selectedGameList
                                      .where((e) =>
                                          e.selectedGameID ==
                                          currentUserDocument
                                              ?.presentRoomGameInfo
                                              ?.roomSelectedGameID)
                                      .toList()
                                      .take(1)
                                      .toList();

                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(mainGame.length,
                                        (mainGameIndex) {
                                      final mainGameItem =
                                          mainGame[mainGameIndex];
                                      return Expanded(
                                        child: Stack(
                                          children: [
                                            if ((stackRoomRecord
                                                        .selectedGameList
                                                        .where((e) =>
                                                            e.selectedGameID ==
                                                            currentUserDocument
                                                                ?.presentRoomGameInfo
                                                                ?.roomSelectedGameID)
                                                        .toList()
                                                        .firstOrNull
                                                        ?.gameSAUStarterUserref !=
                                                    currentUserReference) &&
                                                (stackRoomRecord
                                                        .selectedGameList
                                                        .where((e) =>
                                                            e.selectedGameID ==
                                                            currentUserDocument
                                                                ?.presentRoomGameInfo
                                                                ?.roomSelectedGameID)
                                                        .toList()
                                                        .firstOrNull
                                                        ?.gameSAUStep ==
                                                    1))
                                              Padding(
                                                padding: EdgeInsets.all(24.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          1.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'atna3qq0' /* Players info & Status */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .almarai(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: mainGameItem
                                                                            .selectedGameUserList
                                                                            .where((e) =>
                                                                                (e.roomUserNotificationSendStatus == 'send') ||
                                                                                (e.roomUserNotificationSendStatus == 'stocker'))
                                                                            .toList()
                                                                            .length
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .override(
                                                                              font: GoogleFonts.almarai(
                                                                                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'ytlcvpoa' /* Joined */,
                                                                        ),
                                                                        style:
                                                                            TextStyle(),
                                                                      )
                                                                    ],
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.almarai(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 8.0)),
                                                        ),
                                                        Expanded(
                                                          child: Builder(
                                                            builder: (context) {
                                                              final activeUserList = mainGameItem
                                                                  .selectedGameUserList
                                                                  .where((e) =>
                                                                      (e.roomUserNotificationSendStatus ==
                                                                          'send') ||
                                                                      (e.roomUserNotificationSendStatus ==
                                                                          'stocker'))
                                                                  .toList();
                                                              if (activeUserList
                                                                  .isEmpty) {
                                                                return Center(
                                                                  child:
                                                                      EmptyWidgetRoomWidget(),
                                                                );
                                                              }

                                                              return ListView
                                                                  .separated(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                primary: false,
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                itemCount:
                                                                    activeUserList
                                                                        .length,
                                                                separatorBuilder: (_,
                                                                        __) =>
                                                                    SizedBox(
                                                                        height:
                                                                            12.0),
                                                                itemBuilder:
                                                                    (context,
                                                                        activeUserListIndex) {
                                                                  final activeUserListItem =
                                                                      activeUserList[
                                                                          activeUserListIndex];
                                                                  return GameTwoUserWidget(
                                                                    key: Key(
                                                                        'Key9md_${activeUserListIndex}_of_${activeUserList.length}'),
                                                                    index:
                                                                        activeUserListIndex,
                                                                    gameSAUvoteStatus:
                                                                        false,
                                                                    selectedGameIndex:
                                                                        mainGameItem
                                                                            .selectedGameIndex,
                                                                    room:
                                                                        stackRoomRecord,
                                                                    user: activeUserListItem
                                                                        .roomUserRef!,
                                                                    roomUser:
                                                                        activeUserListItem,
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (stackRoomRecord.selectedGameList
                                                    .where((e) =>
                                                        e.selectedGameID ==
                                                        currentUserDocument
                                                            ?.presentRoomGameInfo
                                                            ?.roomSelectedGameID)
                                                    .toList()
                                                    .firstOrNull
                                                    ?.gameSAUStep !=
                                                6)
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  valueOrDefault<
                                                                      double>(
                                                                    FFLocalizations.of(context).languageCode ==
                                                                            'en'
                                                                        ? 48.0
                                                                        : 16.0,
                                                                    0.0,
                                                                  ),
                                                                  16.0,
                                                                  valueOrDefault<
                                                                      double>(
                                                                    FFLocalizations.of(context).languageCode !=
                                                                            'en'
                                                                        ? 48.0
                                                                        : 16.0,
                                                                    0.0,
                                                                  ),
                                                                  16.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                if ((stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                currentUserDocument
                                                                                    ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.gameSAUStarterUserref ==
                                                                        currentUserReference) &&
                                                                    (stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.gameSAUStep ==
                                                                        1))
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          width:
                                                                              0.5,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(16.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          '7dqsx6fy' /* Choose Topic */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                              font: GoogleFonts.almarai(
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                              ),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                      RichText(
                                                                                        textScaler: MediaQuery.of(context).textScaler,
                                                                                        text: TextSpan(
                                                                                          children: [
                                                                                            TextSpan(
                                                                                              text: FFLocalizations.of(context).getText(
                                                                                                'ibo152d2' /* Choose  */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                            TextSpan(
                                                                                              text: _model.topicLimit == 3 ? '3' : '1',
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                            TextSpan(
                                                                                              text: FFLocalizations.of(context).getText(
                                                                                                'rkbcpeu7' /*  Topics to start the game */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            )
                                                                                          ],
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.almarai(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 4.0)),
                                                                                  ),
                                                                                ),
                                                                                FFButtonWidget(
                                                                                  onPressed: () async {
                                                                                    _model.topicResultRandom = await queryTopicRecordOnce(
                                                                                      queryBuilder: (topicRecord) => topicRecord
                                                                                          .where(
                                                                                            'topic_status',
                                                                                            isEqualTo: 'active',
                                                                                          )
                                                                                          .where(
                                                                                            'game_ID',
                                                                                            arrayContains: mainGameItem.gameId,
                                                                                          ),
                                                                                    );
                                                                                    _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                                    _model.countGame = stackRoomRecord.selectedGameList.length;
                                                                                    _model.countTopic = stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.selectedTopicIDList?.length;
                                                                                    _model.selectedTopicList = stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull!.selectedTopicIDList.toList().cast<int>();
                                                                                    _model.topicFoundStatus = 'notFound';
                                                                                    _model.randomIndex = random_data.randomInteger(0, _model.topicResultRandom!.length - 1);
                                                                                    _model.randomTopicStatus = false;
                                                                                    while (_model.countTopic! > 0) {
                                                                                      if (_model.selectedTopicList.elementAtOrNull((_model.countTopic!) - 1) == _model.topicResultRandom?.elementAtOrNull(_model.randomIndex!)?.topicID) {
                                                                                        _model.updateSelectedGameListAtIndex(
                                                                                          _model.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull!.selectedGameIndex,
                                                                                          (e) => e
                                                                                            ..updateSelectedTopicIDList(
                                                                                              (e) => e.removeAt((_model.countTopic!) - 1),
                                                                                            ),
                                                                                        );
                                                                                        _model.topicFoundStatus = 'found';
                                                                                      } else {
                                                                                        break;
                                                                                      }

                                                                                      _model.countTopic = (_model.countTopic!) - 1;
                                                                                    }
                                                                                    if ((_model.topicFoundStatus == 'notFound') && (mainGameItem.selectedTopicIDList.length < _model.topicLimit!)) {
                                                                                      _model.updateSelectedGameListAtIndex(
                                                                                        _model.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull!.selectedGameIndex,
                                                                                        (e) => e
                                                                                          ..updateSelectedTopicIDList(
                                                                                            (e) => e.add(_model.topicResultRandom!.elementAtOrNull(_model.randomIndex!)!.topicID),
                                                                                          ),
                                                                                      );
                                                                                      _model.randomTopicStatus = false;
                                                                                    }

                                                                                    await widget!.room!.update({
                                                                                      ...mapToFirestore(
                                                                                        {
                                                                                          'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                            _model.selectedGameList,
                                                                                          ),
                                                                                        },
                                                                                      ),
                                                                                    });
                                                                                    _model.countGame = _model.countGame! + 1;
                                                                                    safeSetState(() {});

                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  text: FFLocalizations.of(context).getText(
                                                                                    'n1edt54a' /* Random */,
                                                                                  ),
                                                                                  icon: Icon(
                                                                                    Icons.shuffle_rounded,
                                                                                    size: 15.0,
                                                                                  ),
                                                                                  options: FFButtonOptions(
                                                                                    height: 30.0,
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                    iconAlignment: IconAlignment.start,
                                                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                          font: GoogleFonts.almarai(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          fontSize: 14.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                        ),
                                                                                    elevation: 0.0,
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      width: 1.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      valueOrDefault<String>(
                                                                                        ((_model.topicLimit!) - stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull!.selectedTopicIDList.length).toString(),
                                                                                        '0',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                            font: GoogleFonts.almarai(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'ja27kzbs' /* remaining */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.almarai(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 4.0)),
                                                                                ),
                                                                              ].divide(SizedBox(width: 8.0)),
                                                                            ),
                                                                            Expanded(
                                                                              child: StreamBuilder<List<TopicRecord>>(
                                                                                stream: queryTopicRecord(
                                                                                  queryBuilder: (topicRecord) => topicRecord
                                                                                      .where(
                                                                                        'topic_status',
                                                                                        isEqualTo: 'active',
                                                                                      )
                                                                                      .where(
                                                                                        'game_ID',
                                                                                        arrayContains: stackGameRecord?.gameID,
                                                                                      ),
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
                                                                                  List<TopicRecord> gridViewTopicRecordList = snapshot.data!;

                                                                                  return GridView.builder(
                                                                                    padding: EdgeInsets.zero,
                                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                      crossAxisCount: MediaQuery.sizeOf(context).width < kBreakpointMedium ? 3 : 3,
                                                                                      crossAxisSpacing: 8.0,
                                                                                      mainAxisSpacing: 8.0,
                                                                                      childAspectRatio: 0.77,
                                                                                    ),
                                                                                    primary: false,
                                                                                    shrinkWrap: true,
                                                                                    scrollDirection: Axis.vertical,
                                                                                    itemCount: gridViewTopicRecordList.length,
                                                                                    itemBuilder: (context, gridViewIndex) {
                                                                                      final gridViewTopicRecord = gridViewTopicRecordList[gridViewIndex];
                                                                                      return Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                                                    _model.countGame = stackRoomRecord.selectedGameList.length;
                                                                                                    _model.countTopic = stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.selectedTopicIDList?.length;
                                                                                                    _model.selectedTopicList = stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull!.selectedTopicIDList.toList().cast<int>();
                                                                                                    _model.topicFoundStatus = 'notFound';
                                                                                                    _model.randomTopicStatus = true;
                                                                                                    while (_model.countTopic! > 0) {
                                                                                                      _model.updateSelectedGameListAtIndex(
                                                                                                        _model.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull!.selectedGameIndex,
                                                                                                        (e) => e
                                                                                                          ..updateSelectedTopicIDList(
                                                                                                            (e) => e.removeAt((_model.countTopic!) - 1),
                                                                                                          ),
                                                                                                      );
                                                                                                      _model.topicFoundStatus = 'found';
                                                                                                      _model.countTopic = (_model.countTopic!) - 1;
                                                                                                    }
                                                                                                    _model.updateSelectedGameListAtIndex(
                                                                                                      _model.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull!.selectedGameIndex,
                                                                                                      (e) => e
                                                                                                        ..updateSelectedTopicIDList(
                                                                                                          (e) => e.add(gridViewTopicRecord.topicID),
                                                                                                        ),
                                                                                                    );
                                                                                                    _model.randomTopicStatus = true;

                                                                                                    await widget!.room!.update({
                                                                                                      ...mapToFirestore(
                                                                                                        {
                                                                                                          'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                            _model.selectedGameList,
                                                                                                          ),
                                                                                                        },
                                                                                                      ),
                                                                                                    });
                                                                                                    _model.countGame = _model.countGame! + 1;
                                                                                                    safeSetState(() {});
                                                                                                  },
                                                                                                  child: ClipRRect(
                                                                                                    borderRadius: BorderRadius.circular(16.0),
                                                                                                    child: Container(
                                                                                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                      height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                        image: DecorationImage(
                                                                                                          fit: BoxFit.cover,
                                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                          image: Image.network(
                                                                                                            valueOrDefault<String>(
                                                                                                              gridViewTopicRecord.topicInfo.mainImage,
                                                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/y8i24cl1b5bt/Splash_Screen_(2)-min.jpg',
                                                                                                            ),
                                                                                                          ).image,
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(16.0),
                                                                                                        border: Border.all(
                                                                                                          color: (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.selectedTopicIDList?.contains(gridViewTopicRecord.topicID) == true) && (_model.randomTopicStatus == true) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).primaryText,
                                                                                                          width: 1.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                if ((stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.selectedTopicIDList?.contains(gridViewTopicRecord.topicID) == true) && (_model.randomTopicStatus == true))
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(1.0, -1.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsets.all(8.0),
                                                                                                      child: Container(
                                                                                                        width: 24.0,
                                                                                                        height: 24.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          boxShadow: [
                                                                                                            BoxShadow(
                                                                                                              blurRadius: 4.0,
                                                                                                              color: Color(0x33000000),
                                                                                                              offset: Offset(
                                                                                                                0.0,
                                                                                                                2.0,
                                                                                                              ),
                                                                                                            )
                                                                                                          ],
                                                                                                          shape: BoxShape.circle,
                                                                                                        ),
                                                                                                        child: Icon(
                                                                                                          Icons.check_sharp,
                                                                                                          color: FlutterFlowTheme.of(context).success,
                                                                                                          size: 18.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            height: 30.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getVariableText(
                                                                                                enText: () {
                                                                                                  if (gridViewTopicRecord.topicInfoManualTranslate.name.en != '') {
                                                                                                    return gridViewTopicRecord.topicInfoManualTranslate.name.en;
                                                                                                  } else if (gridViewTopicRecord.topicInfoTranslate.name.en != '') {
                                                                                                    return gridViewTopicRecord.topicInfoTranslate.name.en;
                                                                                                  } else {
                                                                                                    return gridViewTopicRecord.topicInfo.name;
                                                                                                  }
                                                                                                }(),
                                                                                                arText: () {
                                                                                                  if (gridViewTopicRecord.topicInfoManualTranslate.name.ar != '') {
                                                                                                    return gridViewTopicRecord.topicInfoManualTranslate.name.ar;
                                                                                                  } else if (gridViewTopicRecord.topicInfoTranslate.name.ar != '') {
                                                                                                    return gridViewTopicRecord.topicInfoTranslate.name.ar;
                                                                                                  } else {
                                                                                                    return gridViewTopicRecord.topicInfo.name;
                                                                                                  }
                                                                                                }(),
                                                                                              ),
                                                                                              textAlign: TextAlign.center,
                                                                                              maxLines: 2,
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.selectedTopicIDList?.contains(gridViewTopicRecord.topicID) == true) && (_model.randomTopicStatus == true) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).primaryText,
                                                                                                    fontSize: 12.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(height: 6.0)),
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(height: 16.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            e.selectedGameID ==
                                                                            currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                        .toList()
                                                                        .firstOrNull
                                                                        ?.gameSAUStep !=
                                                                    1)
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          width:
                                                                              0.5,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        children: [
                                                                          Stack(
                                                                            children: [
                                                                              if (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.gameSAUStep == 2)
                                                                                Stack(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsets.all(16.0),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          if (currentUserReference == mainGameItem.gameSAU.lastOrNull?.suspectUserRef)
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'un3dp1bq' /* You are the */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                    ),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          if (currentUserReference == mainGameItem.gameSAU.lastOrNull?.suspectUserRef)
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'vav61e4t' /* Suspect */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                                    fontSize: 24.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          if (currentUserReference != mainGameItem.gameSAU.lastOrNull?.suspectUserRef)
                                                                                            StreamBuilder<List<TopicQuestionRecord>>(
                                                                                              stream: queryTopicQuestionRecord(
                                                                                                queryBuilder: (topicQuestionRecord) => topicQuestionRecord
                                                                                                    .where(
                                                                                                      'question_status',
                                                                                                      isEqualTo: 'active',
                                                                                                    )
                                                                                                    .where(
                                                                                                      'question_ID',
                                                                                                      isEqualTo: mainGameItem.gameSAU.lastOrNull?.roundQuestionId,
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
                                                                                                List<TopicQuestionRecord> questionTopicQuestionRecordList = snapshot.data!;
                                                                                                // Return an empty Container when the item does not exist.
                                                                                                if (snapshot.data!.isEmpty) {
                                                                                                  return Container();
                                                                                                }
                                                                                                final questionTopicQuestionRecord = questionTopicQuestionRecordList.isNotEmpty ? questionTopicQuestionRecordList.first : null;

                                                                                                return Text(
                                                                                                  FFLocalizations.of(context).getVariableText(
                                                                                                    enText: () {
                                                                                                      if (questionTopicQuestionRecord?.questionInfoTranslateManual?.question?.en != '') {
                                                                                                        return questionTopicQuestionRecord?.questionInfoTranslateManual?.question?.en;
                                                                                                      } else if (questionTopicQuestionRecord?.questionInfoTranslate?.question?.en != '') {
                                                                                                        return questionTopicQuestionRecord?.questionInfoTranslate?.question?.en;
                                                                                                      } else {
                                                                                                        return questionTopicQuestionRecord?.questionInfo?.question;
                                                                                                      }
                                                                                                    }(),
                                                                                                    arText: () {
                                                                                                      if (questionTopicQuestionRecord?.questionInfoTranslateManual?.question?.ar != '') {
                                                                                                        return questionTopicQuestionRecord?.questionInfoTranslateManual?.question?.ar;
                                                                                                      } else if (questionTopicQuestionRecord?.questionInfoTranslate?.question?.ar != '') {
                                                                                                        return questionTopicQuestionRecord?.questionInfoTranslate?.question?.ar;
                                                                                                      } else {
                                                                                                        return questionTopicQuestionRecord?.questionInfo?.question;
                                                                                                      }
                                                                                                    }(),
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                                        font: GoogleFonts.almarai(
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 24.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                                      ),
                                                                                                );
                                                                                              },
                                                                                            ),
                                                                                        ].divide(SizedBox(height: 16.0)).addToStart(SizedBox(height: 24.0)).addToEnd(SizedBox(height: 24.0)),
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, -1.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(16.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'gkgtb3yc' /* Topic Screen */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                font: GoogleFonts.almarai(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              if (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.gameSAUStep == 3)
                                                                                Stack(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsets.all(16.0),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Text(
                                                                                            mainGameItem.gameSAU.lastOrNull!.voteUser.length > 0
                                                                                                ? '${mainGameItem.gameSAU.lastOrNull?.voteUser?.length?.toString()} / ${(mainGameItem.selectedGameUserList.where((e) => (e.roomUserNotificationSendStatus == 'send') || (e.roomUserNotificationSendStatus == 'stocker')).toList().length - 1).toString()}'
                                                                                                : (currentUserReference != mainGameItem.gameSAU.lastOrNull?.suspectUserRef
                                                                                                    ? FFLocalizations.of(context).getVariableText(
                                                                                                        enText: 'Please Vote...',
                                                                                                        arText: 'الرجاء التصويت...',
                                                                                                      )
                                                                                                    : FFLocalizations.of(context).getVariableText(
                                                                                                        enText: 'Please wait...',
                                                                                                        arText: 'انتظر من فضلك...',
                                                                                                      )),
                                                                                            style: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                                  font: GoogleFonts.almarai(
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                                  ),
                                                                                                  fontSize: 24.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                          GameTwoTimerWidget(
                                                                                            key: Key('Key7sy_${mainGameIndex}_of_${mainGame.length}'),
                                                                                            timeMS: functions.differenceInMilliseconds(getCurrentTimestamp, functions.getFeatureTimeViaAddHurMin(mainGameItem.gameSAUVoteStartedTime!, 0, 1)!)!,
                                                                                          ),
                                                                                          if (currentUserReference != mainGameItem.gameSAU.lastOrNull?.suspectUserRef)
                                                                                            Container(
                                                                                              height: 24.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Color(0x26EC4D41),
                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                                    child: StreamBuilder<List<TopicQuestionRecord>>(
                                                                                                      stream: queryTopicQuestionRecord(
                                                                                                        queryBuilder: (topicQuestionRecord) => topicQuestionRecord
                                                                                                            .where(
                                                                                                              'question_status',
                                                                                                              isEqualTo: 'active',
                                                                                                            )
                                                                                                            .where(
                                                                                                              'question_ID',
                                                                                                              isEqualTo: mainGameItem.gameSAU.lastOrNull?.roundQuestionId,
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
                                                                                                        List<TopicQuestionRecord> textTopicQuestionRecordList = snapshot.data!;
                                                                                                        // Return an empty Container when the item does not exist.
                                                                                                        if (snapshot.data!.isEmpty) {
                                                                                                          return Container();
                                                                                                        }
                                                                                                        final textTopicQuestionRecord = textTopicQuestionRecordList.isNotEmpty ? textTopicQuestionRecordList.first : null;

                                                                                                        return Text(
                                                                                                          FFLocalizations.of(context).getVariableText(
                                                                                                            enText: () {
                                                                                                              if (textTopicQuestionRecord?.questionInfoTranslate?.question?.en != '') {
                                                                                                                return textTopicQuestionRecord?.questionInfoTranslate?.question?.en;
                                                                                                              } else if (textTopicQuestionRecord?.questionInfoTranslateManual?.question?.en != '') {
                                                                                                                return textTopicQuestionRecord?.questionInfoTranslateManual?.question?.en;
                                                                                                              } else {
                                                                                                                return textTopicQuestionRecord?.questionInfo?.question;
                                                                                                              }
                                                                                                            }(),
                                                                                                            arText: () {
                                                                                                              if (textTopicQuestionRecord?.questionInfoTranslate?.question?.ar != '') {
                                                                                                                return textTopicQuestionRecord?.questionInfoTranslate?.question?.ar;
                                                                                                              } else if (textTopicQuestionRecord?.questionInfoTranslateManual?.question?.ar != '') {
                                                                                                                return textTopicQuestionRecord?.questionInfoTranslateManual?.question?.ar;
                                                                                                              } else {
                                                                                                                return textTopicQuestionRecord?.questionInfo?.question;
                                                                                                              }
                                                                                                            }(),
                                                                                                          ).maybeHandleOverflow(
                                                                                                            maxChars: 24,
                                                                                                            replacement: '…',
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                font: GoogleFonts.almarai(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                ),
                                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                                fontSize: 10.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                              ),
                                                                                                        );
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 4.0)),
                                                                                              ),
                                                                                            ),
                                                                                        ].divide(SizedBox(height: 16.0)).addToStart(SizedBox(height: 24.0)).addToEnd(SizedBox(height: 24.0)),
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, -1.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(16.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '35kp4tk9' /* Voting */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                font: GoogleFonts.almarai(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              if (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.gameSAUStep == 4)
                                                                                Stack(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsets.all(12.0),
                                                                                      child: StreamBuilder<List<UsersRecord>>(
                                                                                        stream: queryUsersRecord(
                                                                                          queryBuilder: (usersRecord) => usersRecord.where(
                                                                                            'uid',
                                                                                            isEqualTo: mainGameItem.gameSAU.lastOrNull?.voteWinnerUserUid,
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
                                                                                          List<UsersRecord> step4VoteResultUsersRecordList = snapshot.data!;
                                                                                          // Return an empty Container when the item does not exist.
                                                                                          if (snapshot.data!.isEmpty) {
                                                                                            return Container();
                                                                                          }
                                                                                          final step4VoteResultUsersRecord = step4VoteResultUsersRecordList.isNotEmpty ? step4VoteResultUsersRecordList.first : null;

                                                                                          return Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 40.0,
                                                                                                    height: 40.0,
                                                                                                    child: Stack(
                                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                      children: [
                                                                                                        ClipOval(
                                                                                                          child: Container(
                                                                                                            width: 40.0,
                                                                                                            height: 40.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              shape: BoxShape.circle,
                                                                                                            ),
                                                                                                            child: ClipRRect(
                                                                                                              borderRadius: BorderRadius.circular(100.0),
                                                                                                              child: Image.network(
                                                                                                                step4VoteResultUsersRecord?.photoUrl != null && step4VoteResultUsersRecord?.photoUrl != '' ? currentUserPhoto : 'https://ui-avatars.com/api/?name=${step4VoteResultUsersRecord?.displayName}&background=random&bold=true',
                                                                                                                width: 40.0,
                                                                                                                height: 40.0,
                                                                                                                fit: BoxFit.cover,
                                                                                                                alignment: Alignment(0.0, 0.0),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                step4VoteResultUsersRecord!.displayName,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.almarai(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                              Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color(0x26EC4D41),
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsets.all(8.0),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        '${mainGameItem.gameSAU.lastOrNull?.winnerVoteCount?.toString()}${FFLocalizations.of(context).getVariableText(
                                                                                                          enText: ' Votes',
                                                                                                          arText: 'الأصوات',
                                                                                                        )}',
                                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                              font: GoogleFonts.almarai(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ].divide(SizedBox(width: 4.0)),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  '5nry7y8y' /* Wanna see real suspect? */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.almarai(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                              Container(
                                                                                                height: 24.0,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color(0x26EC4D41),
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                ),
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                                      child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'sln8umtq' /* Suspect */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                              font: GoogleFonts.almarai(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                                              fontSize: 10.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ].divide(SizedBox(height: 6.0)).addToStart(SizedBox(height: 24.0)),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, -1.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 8.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'k79k4zhd' /* Result */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                font: GoogleFonts.almarai(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              if (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.gameSAUStep == 5)
                                                                                Stack(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsets.all(12.0),
                                                                                      child: StreamBuilder<UsersRecord>(
                                                                                        stream: UsersRecord.getDocument(mainGameItem.gameSAU.lastOrNull!.suspectUserRef!),
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

                                                                                          final step5SuspectUsersRecord = snapshot.data!;

                                                                                          return Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              ClipOval(
                                                                                                child: Container(
                                                                                                  width: 40.0,
                                                                                                  height: 40.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    shape: BoxShape.circle,
                                                                                                  ),
                                                                                                  child: ClipRRect(
                                                                                                    borderRadius: BorderRadius.circular(100.0),
                                                                                                    child: Image.network(
                                                                                                      step5SuspectUsersRecord.photoUrl != null && step5SuspectUsersRecord.photoUrl != '' ? currentUserPhoto : 'https://ui-avatars.com/api/?name=${step5SuspectUsersRecord.displayName}&background=random&bold=true',
                                                                                                      width: 60.0,
                                                                                                      height: 60.0,
                                                                                                      fit: BoxFit.cover,
                                                                                                      alignment: Alignment(0.0, 0.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                step5SuspectUsersRecord.displayName,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.almarai(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                              Container(
                                                                                                height: 24.0,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color(0x26EC4D41),
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                ),
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                                      child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'gs7ow44q' /* Suspect */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                              font: GoogleFonts.almarai(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                                              fontSize: 10.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ].divide(SizedBox(height: 16.0)).addToStart(SizedBox(height: 24.0)),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, -1.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 8.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'zmjd8qve' /* Result */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                font: GoogleFonts.almarai(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if ((stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                currentUserDocument
                                                                                    ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.gameSAUStarterUserref !=
                                                                        currentUserReference) &&
                                                                    (stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.gameSAUStep !=
                                                                        1))
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            0.5,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              12.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0x2567B5B0),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  '8m5jdsrc' /* Tips */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                      font: GoogleFonts.almarai(
                                                                                        fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              () {
                                                                                if (mainGameItem.gameSAUStep == 2) {
                                                                                  return (currentUserReference == mainGameItem.gameSAU.lastOrNull?.suspectUserRef
                                                                                      ? FFLocalizations.of(context).getVariableText(
                                                                                          enText: 'Answer like you know the Word observe everyone to guess the Word.',
                                                                                          arText: 'أجب وكأنك تعرف الكلمة، راقب الجميع لتخمين الكلمة.',
                                                                                        )
                                                                                      : FFLocalizations.of(context).getVariableText(
                                                                                          enText: 'Answer like you know the Word observe everyone to guess the Word.',
                                                                                          arText: 'أجب وكأنك تعرف الكلمة، راقب الجميع لتخمين الكلمة.',
                                                                                        ));
                                                                                } else if (mainGameItem.gameSAUStep == 3) {
                                                                                  return (currentUserReference == mainGameItem.gameSAU.lastOrNull?.suspectUserRef
                                                                                      ? FFLocalizations.of(context).getVariableText(
                                                                                          enText: 'Pretend to vote',
                                                                                          arText: 'تظاهر بالتصويت',
                                                                                        )
                                                                                      : FFLocalizations.of(context).getVariableText(
                                                                                          enText: 'The one who vote the correct suspect will get extra points',
                                                                                          arText: 'الشخص الذي يصوت للمشتبه به الصحيح سيحصل على نقاط إضافية',
                                                                                        ));
                                                                                } else {
                                                                                  return FFLocalizations.of(context).getVariableText(
                                                                                    enText: 'Real suspect will reveal next, the suspect has to guess the answer to get extra points.',
                                                                                    arText: 'سيتم الكشف عن المشتبه به الحقيقي لاحقًا، ويجب على المشتبه به تخمين الإجابة للحصول على نقاط إضافية.',
                                                                                  );
                                                                                }
                                                                              }(),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.almarai(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 8.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if ((stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                currentUserDocument
                                                                                    ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.gameSAUStarterUserref ==
                                                                        currentUserReference) &&
                                                                    (stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.gameSAUStep !=
                                                                        1))
                                                                  FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      if (stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.gameSAUStep ==
                                                                          2) {
                                                                        _model.selectedGameList = stackRoomRecord
                                                                            .selectedGameList
                                                                            .toList()
                                                                            .cast<SelectedGameListStruct>();
                                                                        _model.gameSAU = stackRoomRecord
                                                                            .selectedGameList
                                                                            .elementAtOrNull(mainGameItem.selectedGameIndex)!
                                                                            .gameSAU
                                                                            .toList()
                                                                            .cast<GameSAUStruct>();
                                                                        _model.roundIndex =
                                                                            stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.gameSAU.length -
                                                                                1;
                                                                        _model
                                                                            .updateGameSAUAtIndex(
                                                                          _model
                                                                              .roundIndex!,
                                                                          (e) => e
                                                                            ..voteStartTime =
                                                                                getCurrentTimestamp
                                                                            ..voteTimeLimit = 2,
                                                                        );
                                                                        _model
                                                                            .updateSelectedGameListAtIndex(
                                                                          mainGameItem
                                                                              .selectedGameIndex,
                                                                          (e) => e
                                                                            ..gameSAU =
                                                                                _model.gameSAU.toList()
                                                                            ..gameSAUStep =
                                                                                3
                                                                            ..gameSAUVoteStartedTime = getCurrentTimestamp,
                                                                        );

                                                                        await widget!
                                                                            .room!
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                _model.selectedGameList,
                                                                              ),
                                                                            },
                                                                          ),
                                                                        });
                                                                      } else {
                                                                        if (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.gameSAUStep ==
                                                                            3) {
                                                                          _model.selectedGameList = stackRoomRecord
                                                                              .selectedGameList
                                                                              .toList()
                                                                              .cast<SelectedGameListStruct>();
                                                                          _model.gameSAU = stackRoomRecord
                                                                              .selectedGameList
                                                                              .elementAtOrNull(mainGameItem.selectedGameIndex)!
                                                                              .gameSAU
                                                                              .toList()
                                                                              .cast<GameSAUStruct>();
                                                                          _model.roundIndex =
                                                                              stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.gameSAU.length - 1;
                                                                          if (_model.gameSAU.lastOrNull!.voteUser.length <=
                                                                              0) {
                                                                            await showDialog(
                                                                              context: context,
                                                                              builder: (alertDialogContext) {
                                                                                return WebViewAware(
                                                                                  child: AlertDialog(
                                                                                    content: Text(FFLocalizations.of(context).getVariableText(
                                                                                      enText: 'Please vote for Suspect.',
                                                                                      arText: 'يرجى التصويت للمشتبه به.',
                                                                                    )),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext),
                                                                                        child: Text(FFLocalizations.of(context).getVariableText(
                                                                                          enText: 'Ok',
                                                                                          arText: 'نعم',
                                                                                        )),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              },
                                                                            );
                                                                            return;
                                                                          }
                                                                          _model.voteUser = _model
                                                                              .gameSAU
                                                                              .lastOrNull!
                                                                              .voteUser
                                                                              .toList()
                                                                              .cast<GameSAUVoteUserStruct>();
                                                                          _model.selectedUserList = stackRoomRecord
                                                                              .selectedGameList
                                                                              .elementAtOrNull(mainGameItem.selectedGameIndex)!
                                                                              .selectedGameUserList
                                                                              .toList()
                                                                              .cast<RoomUserListStruct>();
                                                                          _model.countUser = stackRoomRecord
                                                                              .selectedGameList
                                                                              .elementAtOrNull(mainGameItem.selectedGameIndex)
                                                                              ?.selectedGameUserList
                                                                              ?.length;
                                                                          _model.voteResult =
                                                                              0;
                                                                          while (_model.countUser! >
                                                                              0) {
                                                                            if (_model.voteUser.where((e) => e.toUserRef == _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef).toList().length >
                                                                                _model.voteResult!) {
                                                                              _model.updateGameSAUAtIndex(
                                                                                _model.roundIndex!,
                                                                                (e) => e
                                                                                  ..voteWinnerUserUid = _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef?.id
                                                                                  ..winnerVoteCount = _model.voteUser.where((e) => e.toUserRef == _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef).toList().length,
                                                                              );
                                                                            }
                                                                            _model.voteResult = _model.voteUser.where((e) => e.toUserRef == _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef).toList().length > _model.voteResult!
                                                                                ? _model.voteUser.where((e) => e.toUserRef == _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef).toList().length
                                                                                : _model.voteResult;
                                                                            _model.countUser =
                                                                                (_model.countUser!) - 1;
                                                                          }
                                                                          _model
                                                                              .updateGameSAUAtIndex(
                                                                            _model.roundIndex!,
                                                                            (e) => e
                                                                              ..voteEndTime = getCurrentTimestamp,
                                                                          );
                                                                          _model
                                                                              .updateSelectedGameListAtIndex(
                                                                            mainGameItem.selectedGameIndex,
                                                                            (e) => e
                                                                              ..gameSAU = _model.gameSAU.toList()
                                                                              ..gameSAUStep = 4,
                                                                          );

                                                                          await widget!
                                                                              .room!
                                                                              .update({
                                                                            ...mapToFirestore(
                                                                              {
                                                                                'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                  _model.selectedGameList,
                                                                                ),
                                                                              },
                                                                            ),
                                                                          });
                                                                        } else {
                                                                          if (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.gameSAUStep ==
                                                                              4) {
                                                                            _model.selectedGameList =
                                                                                stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                            _model.gameSAU =
                                                                                stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.gameSAU.toList().cast<GameSAUStruct>();
                                                                            _model.roundIndex =
                                                                                stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.gameSAU.length - 1;
                                                                            _model.updateGameSAUAtIndex(
                                                                              _model.roundIndex!,
                                                                              (e) => e..suspectRevealTime = getCurrentTimestamp,
                                                                            );
                                                                            _model.updateSelectedGameListAtIndex(
                                                                              mainGameItem.selectedGameIndex,
                                                                              (e) => e
                                                                                ..gameSAU = _model.gameSAU.toList()
                                                                                ..gameSAUStep = 5,
                                                                            );

                                                                            await widget!.room!.update({
                                                                              ...mapToFirestore(
                                                                                {
                                                                                  'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                    _model.selectedGameList,
                                                                                  ),
                                                                                },
                                                                              ),
                                                                            });
                                                                          } else {
                                                                            if (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.gameSAUStep ==
                                                                                5) {
                                                                              _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                              _model.gameSAU = stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.gameSAU.toList().cast<GameSAUStruct>();
                                                                              _model.roundIndex = stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.gameSAU.length - 1;
                                                                              _model.voteUser = _model.gameSAU.lastOrNull!.voteUser.toList().cast<GameSAUVoteUserStruct>();
                                                                              _model.selectedUserList = stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.selectedGameUserList.where((e) => (e.roomUserNotificationSendStatus == 'send') || (e.roomUserNotificationSendStatus == 'stocker')).toList().cast<RoomUserListStruct>();
                                                                              _model.countUser = _model.gameSAU.lastOrNull?.voteUser?.length;
                                                                              _model.voteResult = 0;
                                                                              _model.roundSAUser = [];
                                                                              _model.voteCount = 0;
                                                                              while (_model.countUser! > 0) {
                                                                                if (_model.voteUser.elementAtOrNull((_model.countUser!) - 1)?.fromUserRef != mainGameItem.gameSAU.lastOrNull?.suspectUserRef) {
                                                                                  if (_model.voteUser.elementAtOrNull((_model.countUser!) - 1)?.toUserRef == mainGameItem.gameSAU.lastOrNull?.suspectUserRef) {
                                                                                    _model.addToRoundSAUser(GameSAURoundUserStruct(
                                                                                      roundUserRef: _model.voteUser.elementAtOrNull((_model.countUser!) - 1)?.fromUserRef,
                                                                                      roundPoints: 100,
                                                                                    ));
                                                                                    _model.voteCount = _model.voteCount! + 1;
                                                                                  } else {
                                                                                    _model.voteResult = (_model.voteResult!) + 100;
                                                                                  }
                                                                                }
                                                                                _model.countUser = (_model.countUser!) - 1;
                                                                              }
                                                                              _model.addToRoundSAUser(GameSAURoundUserStruct(
                                                                                roundUserRef: mainGameItem.gameSAU.lastOrNull?.suspectUserRef,
                                                                                roundPoints: _model.voteResult,
                                                                              ));
                                                                              _model.updateGameSAUAtIndex(
                                                                                _model.roundIndex!,
                                                                                (e) => e
                                                                                  ..suspectRevealTime = getCurrentTimestamp
                                                                                  ..roundEndAt = getCurrentTimestamp
                                                                                  ..roundStatus = 'complete'
                                                                                  ..roundResultTime = getCurrentTimestamp
                                                                                  ..winnerVoteCount = _model.voteCount
                                                                                  ..roundUserPoint = _model.roundSAUser.toList(),
                                                                              );
                                                                              _model.updateSelectedGameListAtIndex(
                                                                                mainGameItem.selectedGameIndex,
                                                                                (e) => e
                                                                                  ..gameSAU = _model.gameSAU.toList()
                                                                                  ..gameSAUStep = 6,
                                                                              );

                                                                              await widget!.room!.update({
                                                                                ...mapToFirestore(
                                                                                  {
                                                                                    'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                      _model.selectedGameList,
                                                                                    ),
                                                                                  },
                                                                                ),
                                                                              });
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    },
                                                                    text: () {
                                                                      if (stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) =>
                                                                                  e.selectedGameID ==
                                                                                  currentUserDocument
                                                                                      ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.gameSAUStep ==
                                                                          2) {
                                                                        return FFLocalizations.of(context)
                                                                            .getVariableText(
                                                                          enText:
                                                                              'Ask for vote',
                                                                          arText:
                                                                              'اطلب التصويت',
                                                                        );
                                                                      } else if (stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) =>
                                                                                  e.selectedGameID ==
                                                                                  currentUserDocument
                                                                                      ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.gameSAUStep ==
                                                                          3) {
                                                                        return FFLocalizations.of(context)
                                                                            .getVariableText(
                                                                          enText:
                                                                              'Announce Result',
                                                                          arText:
                                                                              'إعلان النتيجة',
                                                                        );
                                                                      } else if (stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) =>
                                                                                  e.selectedGameID ==
                                                                                  currentUserDocument
                                                                                      ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.gameSAUStep ==
                                                                          4) {
                                                                        return FFLocalizations.of(context)
                                                                            .getVariableText(
                                                                          enText:
                                                                              'Reveal the suspect',
                                                                          arText:
                                                                              'كشف المشتبه به',
                                                                        );
                                                                      } else if (stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.gameSAUStep ==
                                                                          5) {
                                                                        return FFLocalizations.of(context)
                                                                            .getVariableText(
                                                                          enText:
                                                                              'Announce Result',
                                                                          arText:
                                                                              'إعلان النتيجة',
                                                                        );
                                                                      } else {
                                                                        return 'Announce Result';
                                                                      }
                                                                    }(),
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      height:
                                                                          40.0,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              0.0),
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyLarge
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.almarai(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                          ),
                                                                      elevation:
                                                                          0.0,
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            0.5,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                    ),
                                                                  ),
                                                              ].divide(SizedBox(
                                                                  height: 8.0)),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                if ((stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                currentUserDocument
                                                                                    ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.gameSAUStarterUserref ==
                                                                        currentUserReference) &&
                                                                    (stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.gameSAUStep ==
                                                                        1))
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          16.0),
                                                                      child: StreamBuilder<
                                                                          List<
                                                                              UsersRecord>>(
                                                                        stream:
                                                                            queryUsersRecord(
                                                                          queryBuilder: (usersRecord) =>
                                                                              usersRecord.where(
                                                                            'status',
                                                                            isEqualTo:
                                                                                'Publish',
                                                                          ),
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
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
                                                                          List<UsersRecord>
                                                                              inviteUserListUsersRecordList =
                                                                              snapshot.data!;

                                                                          return Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                width: 0.5,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(16.0),
                                                                              child: SingleChildScrollView(
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 10.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).accent4,
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        border: Border.all(
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                        ),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(8.0),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                                                                    child: Text(
                                                                                                      FFLocalizations.of(context).getText(
                                                                                                        '4jn1lwl5' /* Invite players */,
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                            font: GoogleFonts.almarai(
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                            ),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 16.0),
                                                                                                    child: RichText(
                                                                                                      textScaler: MediaQuery.of(context).textScaler,
                                                                                                      text: TextSpan(
                                                                                                        children: [
                                                                                                          TextSpan(
                                                                                                            text: FFLocalizations.of(context).getText(
                                                                                                              'kuhz9yvs' /* Share the invite link or scan ... */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                                  font: GoogleFonts.almarai(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                                  ),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                                ),
                                                                                                          )
                                                                                                        ],
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.almarai(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                border: Border.all(
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  width: 0.5,
                                                                                                ),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsets.all(4.0),
                                                                                                child: ClipRRect(
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                  child: Image.network(
                                                                                                    valueOrDefault<String>(
                                                                                                      'https://api.qrserver.com/v1/create-qr-code/?data=${stackRoomRecord.roomCode.toString()} ${mainGameItem.selectedGameID.toString()}&size=350x350',
                                                                                                      'https://api.qrserver.com/v1/create-qr-code/?data=Vikram&size=350x350',
                                                                                                    ),
                                                                                                    width: 100.0,
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ].divide(SizedBox(width: 16.0)),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                '92hlxxbp' /* Players info & Status */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                    ),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                            RichText(
                                                                                              textScaler: MediaQuery.of(context).textScaler,
                                                                                              text: TextSpan(
                                                                                                children: [
                                                                                                  TextSpan(
                                                                                                    text: valueOrDefault<String>(
                                                                                                      stackRoomRecord.roomUserList.length.toString(),
                                                                                                      '0',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                          font: GoogleFonts.almarai(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                  TextSpan(
                                                                                                    text: FFLocalizations.of(context).getText(
                                                                                                      'xxo3kdhh' /*  Joined */,
                                                                                                    ),
                                                                                                    style: TextStyle(),
                                                                                                  )
                                                                                                ],
                                                                                                style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                      font: GoogleFonts.almarai(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                      ),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 8.0)),
                                                                                    ),
                                                                                    Container(
                                                                                      child: Builder(
                                                                                        builder: (context) {
                                                                                          final roomUserList1 = stackRoomRecord.roomUserList.where((e) => e.roomUserStatus == 'active').toList();
                                                                                          if (roomUserList1.isEmpty) {
                                                                                            return Center(
                                                                                              child: EmptyWidgetRoomWidget(),
                                                                                            );
                                                                                          }

                                                                                          return ListView.separated(
                                                                                            padding: EdgeInsets.zero,
                                                                                            primary: false,
                                                                                            shrinkWrap: true,
                                                                                            scrollDirection: Axis.vertical,
                                                                                            itemCount: roomUserList1.length,
                                                                                            separatorBuilder: (_, __) => SizedBox(height: 12.0),
                                                                                            itemBuilder: (context, roomUserList1Index) {
                                                                                              final roomUserList1Item = roomUserList1[roomUserList1Index];
                                                                                              return GameTwoUserWidget(
                                                                                                key: Key('Key1b5_${roomUserList1Index}_of_${roomUserList1.length}'),
                                                                                                index: roomUserList1Index,
                                                                                                gameSAUvoteStatus: false,
                                                                                                selectedGameIndex: mainGameItem.selectedGameIndex,
                                                                                                room: stackRoomRecord,
                                                                                                user: roomUserList1Item.roomUserRef!,
                                                                                                roomUser: roomUserList1Item,
                                                                                                gameUserRemove: stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.selectedGameUserList.where((e) => ((e.roomUserNotificationSendStatus == 'send') || (e.roomUserNotificationSendStatus == 'stocker')) && (e.roomUserRef == roomUserList1Item.roomUserRef)).toList().length > 0,
                                                                                                gameUserAdd: stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.selectedGameUserList?.where((e) => ((e.roomUserNotificationSendStatus == 'send') || (e.roomUserNotificationSendStatus == 'stocker')) && (e.roomUserRef == roomUserList1Item.roomUserRef)).toList()?.length == 0,
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                        },
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
                                                                  ),
                                                                if (stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            e.selectedGameID ==
                                                                            currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                        .toList()
                                                                        .firstOrNull
                                                                        ?.gameSAUStep !=
                                                                    1)
                                                                  Expanded(
                                                                    child: StreamBuilder<
                                                                        List<
                                                                            UsersRecord>>(
                                                                      stream:
                                                                          queryUsersRecord(
                                                                        queryBuilder:
                                                                            (usersRecord) =>
                                                                                usersRecord.where(
                                                                          'status',
                                                                          isEqualTo:
                                                                              'Publish',
                                                                        ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                        List<UsersRecord>
                                                                            mainUserListUsersRecordList =
                                                                            snapshot.data!;

                                                                        return Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                            border:
                                                                                Border.all(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              width: 0.5,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(16.0),
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  if (currentUserReference != mainGameItem.gameSAU.lastOrNull?.suspectUserRef)
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
                                                                                                  text: FFLocalizations.of(context).getText(
                                                                                                    'e09rt564' /* Who is the suspect? */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                        font: GoogleFonts.almarai(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                        ),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                      ),
                                                                                                )
                                                                                              ],
                                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                    ),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 8.0)),
                                                                                      ),
                                                                                    ),
                                                                                  Container(
                                                                                    child: Builder(
                                                                                      builder: (context) {
                                                                                        final inviteUserList = stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.selectedGameUserList?.where((e) => (e.roomUserNotificationSendStatus == 'send') || (e.roomUserNotificationSendStatus == 'stocker')).toList()?.toList() ?? [];
                                                                                        if (inviteUserList.isEmpty) {
                                                                                          return Center(
                                                                                            child: EmptyWidgetRoomWidget(),
                                                                                          );
                                                                                        }

                                                                                        return ListView.separated(
                                                                                          padding: EdgeInsets.zero,
                                                                                          primary: false,
                                                                                          shrinkWrap: true,
                                                                                          scrollDirection: Axis.vertical,
                                                                                          itemCount: inviteUserList.length,
                                                                                          separatorBuilder: (_, __) => SizedBox(height: 12.0),
                                                                                          itemBuilder: (context, inviteUserListIndex) {
                                                                                            final inviteUserListItem = inviteUserList[inviteUserListIndex];
                                                                                            return GameTwoUserWidget(
                                                                                              key: Key('Keye5g_${inviteUserListIndex}_of_${inviteUserList.length}'),
                                                                                              index: inviteUserListIndex,
                                                                                              gameSAUvoteStatus: (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.gameSAUStep == 3) && (mainGameItem.gameSAU.lastOrNull?.suspectUserRef != currentUserReference),
                                                                                              selectedGameIndex: mainGameItem.selectedGameIndex,
                                                                                              room: stackRoomRecord,
                                                                                              user: inviteUserListItem.roomUserRef!,
                                                                                              roomUser: inviteUserListItem,
                                                                                              gameUserRemove: false,
                                                                                              gameUserAdd: false,
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(height: 16.0)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 16.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            if ((stackRoomRecord
                                                        .selectedGameList
                                                        .where((e) =>
                                                            e.selectedGameID ==
                                                            currentUserDocument
                                                                ?.presentRoomGameInfo
                                                                ?.roomSelectedGameID)
                                                        .toList()
                                                        .firstOrNull
                                                        ?.gameSAUStep ==
                                                    1) &&
                                                (stackRoomRecord
                                                        .selectedGameList
                                                        .where((e) =>
                                                            e.selectedGameID ==
                                                            currentUserDocument
                                                                ?.presentRoomGameInfo
                                                                ?.roomSelectedGameID)
                                                        .toList()
                                                        .firstOrNull
                                                        ?.gameSAUStarterUserref ==
                                                    currentUserReference))
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24.0, 0.0, 24.0,
                                                          16.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      var _shouldSetState =
                                                          false;
                                                      _model.selectedGameList =
                                                          stackRoomRecord
                                                              .selectedGameList
                                                              .toList()
                                                              .cast<
                                                                  SelectedGameListStruct>();
                                                      _model.countGame =
                                                          stackRoomRecord
                                                              .selectedGameList
                                                              .length;
                                                      while (_model.countGame! >
                                                          0) {
                                                        if (_model
                                                                .selectedGameList
                                                                .elementAtOrNull(
                                                                    (_model.countGame!) -
                                                                        1)
                                                                ?.selectedGameID ==
                                                            currentUserDocument
                                                                ?.presentRoomGameInfo
                                                                ?.roomSelectedGameID) {
                                                          if (_model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)
                                                                  ?.selectedTopicIDList
                                                                  ?.length ==
                                                              _model
                                                                  .topicLimit) {
                                                            if (stackRoomRecord
                                                                    .selectedGameList
                                                                    .elementAtOrNull(
                                                                        mainGameItem
                                                                            .selectedGameIndex)!
                                                                    .selectedGameUserList
                                                                    .where((e) =>
                                                                        (e.roomUserNotificationSendStatus ==
                                                                            'send') ||
                                                                        (e.roomUserNotificationSendStatus ==
                                                                            'stocker'))
                                                                    .toList()
                                                                    .length >=
                                                                _model
                                                                    .userLimit!) {
                                                              _model.randomTopicIndex =
                                                                  random_data
                                                                      .randomInteger(
                                                                          0,
                                                                          (_model.topicLimit!) -
                                                                              1);
                                                              _model.selectedUserList = _model
                                                                  .selectedGameList
                                                                  .elementAtOrNull(
                                                                      (_model.countGame!) -
                                                                          1)!
                                                                  .selectedGameUserList
                                                                  .where((e) =>
                                                                      (e.roomUserNotificationSendStatus ==
                                                                          'send') ||
                                                                      (e.roomUserNotificationSendStatus ==
                                                                          'stocker'))
                                                                  .toList()
                                                                  .cast<
                                                                      RoomUserListStruct>();
                                                              _model.randomUserIndex = random_data.randomInteger(
                                                                  0,
                                                                  _model.selectedGameList
                                                                          .elementAtOrNull((_model.countGame!) -
                                                                              1)!
                                                                          .selectedGameUserList
                                                                          .where((e) =>
                                                                              (e.roomUserNotificationSendStatus == 'send') ||
                                                                              (e.roomUserNotificationSendStatus == 'stocker'))
                                                                          .toList()
                                                                          .length -
                                                                      1);
                                                              _model.topicsResult =
                                                                  await queryTopicRecordOnce(
                                                                queryBuilder:
                                                                    (topicRecord) =>
                                                                        topicRecord
                                                                            .where(
                                                                              'topic_status',
                                                                              isEqualTo: 'active',
                                                                            )
                                                                            .where(
                                                                              'topic_ID',
                                                                              isEqualTo: _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.selectedTopicIDList?.elementAtOrNull(_model.randomTopicIndex!),
                                                                            ),
                                                                singleRecord:
                                                                    true,
                                                              ).then((s) => s
                                                                      .firstOrNull);
                                                              _shouldSetState =
                                                                  true;
                                                              _model.topicQuestionResult =
                                                                  await queryTopicQuestionRecordOnce(
                                                                queryBuilder:
                                                                    (topicQuestionRecord) =>
                                                                        topicQuestionRecord
                                                                            .where(
                                                                              'question_status',
                                                                              isEqualTo: 'active',
                                                                            )
                                                                            .where(
                                                                              'topic_id',
                                                                              isEqualTo: _model.topicsResult?.topicID,
                                                                            ),
                                                              );
                                                              _shouldSetState =
                                                                  true;
                                                              _model.randomQuestionIndex =
                                                                  random_data.randomInteger(
                                                                      0,
                                                                      _model.topicQuestionResult!
                                                                              .length -
                                                                          1);
                                                              _model
                                                                  .updateSelectedGameListAtIndex(
                                                                (_model.countGame!) -
                                                                    1,
                                                                (e) => e
                                                                  ..gameSAUStep =
                                                                      2
                                                                  ..updateGameSAU(
                                                                    (e) => e.add(
                                                                        GameSAUStruct(
                                                                      roundID: _model
                                                                          .idmapResult1
                                                                          ?.roundId,
                                                                      roundStartAt:
                                                                          getCurrentTimestamp,
                                                                      roundStatus:
                                                                          'active',
                                                                      roundTopicId: _model
                                                                          .selectedGameList
                                                                          .elementAtOrNull((_model.countGame!) -
                                                                              1)
                                                                          ?.selectedTopicIDList
                                                                          ?.elementAtOrNull(
                                                                              _model.randomTopicIndex!),
                                                                      roundQuestionId: _model
                                                                          .topicQuestionResult
                                                                          ?.elementAtOrNull(
                                                                              _model.randomQuestionIndex!)
                                                                          ?.questionID,
                                                                      suspectUserRef: _model
                                                                          .selectedUserList
                                                                          .elementAtOrNull(
                                                                              _model.randomUserIndex!)
                                                                          ?.roomUserRef,
                                                                    )),
                                                                  )
                                                                  ..updateSelectedQuestionIDList(
                                                                    (e) => e.add(_model
                                                                        .topicQuestionResult!
                                                                        .elementAtOrNull(
                                                                            _model.randomQuestionIndex!)!
                                                                        .questionID),
                                                                  )
                                                                  ..updateSelectedQuestionList(
                                                                    (e) => e.add(
                                                                        SelectedQuestionListStruct(
                                                                      questionID: _model
                                                                          .topicQuestionResult
                                                                          ?.elementAtOrNull(
                                                                              _model.randomQuestionIndex!)
                                                                          ?.questionID,
                                                                      questionAnswerStatus:
                                                                          'show',
                                                                    )),
                                                                  ),
                                                              );
                                                              _model.idmapResult1 =
                                                                  await queryIDmapRecordOnce(
                                                                queryBuilder:
                                                                    (iDmapRecord) =>
                                                                        iDmapRecord
                                                                            .where(
                                                                  'type',
                                                                  isEqualTo:
                                                                      'Main',
                                                                ),
                                                                singleRecord:
                                                                    true,
                                                              ).then((s) => s
                                                                      .firstOrNull);
                                                              _shouldSetState =
                                                                  true;

                                                              await _model
                                                                  .idmapResult1!
                                                                  .reference
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'round_id':
                                                                        FieldValue
                                                                            .increment(1),
                                                                  },
                                                                ),
                                                              });

                                                              await widget!
                                                                  .room!
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'selected_game_list':
                                                                        getSelectedGameListListFirestoreData(
                                                                      _model
                                                                          .selectedGameList,
                                                                    ),
                                                                  },
                                                                ),
                                                              });
                                                              if (currentUserDocument
                                                                      ?.userSetting
                                                                      ?.isSoundstatus ==
                                                                  true) {
                                                                _model.soundPlayer ??=
                                                                    AudioPlayer();
                                                                if (_model
                                                                    .soundPlayer!
                                                                    .playing) {
                                                                  await _model
                                                                      .soundPlayer!
                                                                      .stop();
                                                                }
                                                                _model
                                                                    .soundPlayer!
                                                                    .setVolume(
                                                                        0.2);
                                                                _model
                                                                    .soundPlayer!
                                                                    .setAsset(
                                                                        'assets/audios/Spent_Coin_like_buying_game.mp3')
                                                                    .then((_) => _model
                                                                        .soundPlayer!
                                                                        .play());
                                                              }
                                                              _model.idmapGameoneResult =
                                                                  await queryIDmapRecordOnce(
                                                                queryBuilder:
                                                                    (iDmapRecord) =>
                                                                        iDmapRecord
                                                                            .where(
                                                                  'type',
                                                                  isEqualTo:
                                                                      'Main',
                                                                ),
                                                                singleRecord:
                                                                    true,
                                                              ).then((s) => s
                                                                      .firstOrNull);
                                                              _shouldSetState =
                                                                  true;

                                                              await WalletSpentRecord
                                                                  .collection
                                                                  .doc()
                                                                  .set(
                                                                      createWalletSpentRecordData(
                                                                    createdAt:
                                                                        getCurrentTimestamp,
                                                                    updatedAt:
                                                                        getCurrentTimestamp,
                                                                    walletSpentID: _model
                                                                        .idmapGameoneResult
                                                                        ?.walletSpentId,
                                                                    walletSpentStatus:
                                                                        'Deduct',
                                                                    walletSpentPoint:
                                                                        stackGameRecord
                                                                            ?.gamePoint,
                                                                    walletSpentRoomRef:
                                                                        stackRoomRecord
                                                                            .reference,
                                                                    walletSpentGameRef:
                                                                        stackGameRecord
                                                                            ?.reference,
                                                                    walletSpentUserRef:
                                                                        currentUserReference,
                                                                    walletSpentPrevPoint: (stackRoomRecord.roomType ==
                                                                                'solo') ||
                                                                            (stackRoomRecord.isRoomWalletStatus ==
                                                                                false)
                                                                        ? valueOrDefault(
                                                                            currentUserDocument
                                                                                ?.walletPoint,
                                                                            0)
                                                                        : stackRoomRecord
                                                                            .roomWalletTotalPoint,
                                                                    walletSpentPresentPoint: ((stackRoomRecord.roomType == 'solo') ||
                                                                                (stackRoomRecord.isRoomWalletStatus == false)
                                                                            ? valueOrDefault(currentUserDocument?.walletPoint, 0)
                                                                            : stackRoomRecord.roomWalletTotalPoint) -
                                                                        stackGameRecord!.gamePoint,
                                                                  ));
                                                              if ((stackRoomRecord
                                                                          .roomType ==
                                                                      'solo') ||
                                                                  (stackRoomRecord
                                                                          .isRoomWalletStatus ==
                                                                      false)) {
                                                                await currentUserReference!
                                                                    .update(
                                                                        createUsersRecordData(
                                                                  walletPoint: valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.walletPoint,
                                                                          0) -
                                                                      stackGameRecord!
                                                                          .gamePoint,
                                                                  walletSpent: valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.walletSpent,
                                                                          0) +
                                                                      stackGameRecord!
                                                                          .gamePoint,
                                                                ));
                                                              } else {
                                                                await stackRoomRecord
                                                                    .reference
                                                                    .update(
                                                                        createRoomRecordData(
                                                                  roomWalletTotalPoint: stackRoomRecord
                                                                          .roomWalletTotalPoint -
                                                                      stackGameRecord!
                                                                          .gamePoint,
                                                                ));
                                                              }

                                                              await _model
                                                                  .idmapGameoneResult!
                                                                  .reference
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'wallet_spent_id':
                                                                        FieldValue
                                                                            .increment(1),
                                                                  },
                                                                ),
                                                              });
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                              return;
                                                            } else {
                                                              await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return WebViewAware(
                                                                    child:
                                                                        AlertDialog(
                                                                      content: Text(
                                                                          FFLocalizations.of(context)
                                                                              .getVariableText(
                                                                        enText:
                                                                            'Please invite a USER\'s ( atleast 3)',
                                                                        arText:
                                                                            'يرجى دعوة مستخدم واحد (3 على الأقل)',
                                                                      )),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                          child:
                                                                              Text(FFLocalizations.of(context).getVariableText(
                                                                            enText:
                                                                                'Ok',
                                                                            arText:
                                                                                'نعم',
                                                                          )),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                              return;
                                                            }
                                                          } else {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return WebViewAware(
                                                                  child:
                                                                      AlertDialog(
                                                                    content: Text(
                                                                        FFLocalizations.of(context)
                                                                            .getVariableText(
                                                                      enText:
                                                                          'Please select Topics.',
                                                                      arText:
                                                                          'الرجاء تحديد المواضيع.',
                                                                    )),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                        child: Text(
                                                                            FFLocalizations.of(context).getVariableText(
                                                                          enText:
                                                                              'Ok',
                                                                          arText:
                                                                              'نعم',
                                                                        )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                            return;
                                                          }
                                                        }
                                                        _model
                                                            .countGame = (_model
                                                                .countGame!) -
                                                            1;
                                                      }
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                    },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'unrokp18' /* Start the game */,
                                                    ),
                                                    options: FFButtonOptions(
                                                      height: 45.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  32.0,
                                                                  0.0,
                                                                  32.0,
                                                                  0.0),
                                                      iconAlignment:
                                                          IconAlignment.start,
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .override(
                                                                font: GoogleFonts
                                                                    .almarai(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                      elevation: 0.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        width: 0.5,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (stackRoomRecord.selectedGameList
                                                    .where((e) =>
                                                        e.selectedGameID ==
                                                        currentUserDocument
                                                            ?.presentRoomGameInfo
                                                            ?.roomSelectedGameID)
                                                    .toList()
                                                    .firstOrNull
                                                    ?.gameSAUStep ==
                                                6)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        valueOrDefault<double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 48.0
                                                              : 16.0,
                                                          0.0,
                                                        ),
                                                        16.0,
                                                        valueOrDefault<double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode !=
                                                                  'en'
                                                              ? 48.0
                                                              : 16.0,
                                                          0.0,
                                                        ),
                                                        16.0),
                                                child:
                                                    StreamBuilder<UsersRecord>(
                                                  stream:
                                                      UsersRecord.getDocument(
                                                          mainGameItem
                                                              .gameSAU
                                                              .lastOrNull!
                                                              .suspectUserRef!),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 2.0,
                                                          height: 2.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0x00EC4D41),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    final step6UsersRecord =
                                                        snapshot.data!;

                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                width: 0.5,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          12.0,
                                                                          16.0,
                                                                          12.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          Stack(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                40.0,
                                                                            height:
                                                                                40.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              shape: BoxShape.circle,
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(100.0),
                                                                              child: Image.network(
                                                                                step6UsersRecord.photoUrl != null && step6UsersRecord.photoUrl != '' ? currentUserPhoto : 'https://ui-avatars.com/api/?name=${step6UsersRecord.displayName}&background=random&bold=true',
                                                                                width: 60.0,
                                                                                height: 60.0,
                                                                                fit: BoxFit.cover,
                                                                                alignment: Alignment(0.0, 0.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (mainGameItem
                                                                          .gameSAU
                                                                          .lastOrNull!
                                                                          .roundUserPoint
                                                                          .length >
                                                                      0)
                                                                    RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                step6UsersRecord.displayName,
                                                                            style:
                                                                                TextStyle(),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              'puf8pb40' /*  is the real suspect! with  */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                  font: GoogleFonts.almarai(
                                                                                    fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                  ),
                                                                                  fontSize: 18.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                valueOrDefault<String>(
                                                                              mainGameItem.gameSAU.lastOrNull?.roundUserPoint?.where((e) => e.roundUserRef == step6UsersRecord.reference).toList()?.firstOrNull?.roundPoints?.toString(),
                                                                              '0',
                                                                            ),
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              'l6chhjom' /*  points */,
                                                                            ),
                                                                            style:
                                                                                TextStyle(),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .override(
                                                                              font: GoogleFonts.almarai(
                                                                                fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                              ),
                                                                              fontSize: 18.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  if (mainGameItem
                                                                          .gameSAU
                                                                          .lastOrNull
                                                                          ?.roundUserPoint
                                                                          ?.length ==
                                                                      0)
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '8wf8ppt5' /* Well played, no one guessed yo... */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.almarai(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'lb34w8a2' /* if suspect guessed the word co... */,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.almarai(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  if ((mainGameItem
                                                                              .gameSAU
                                                                              .lastOrNull
                                                                              ?.roundAnswerRevealTime ==
                                                                          null) &&
                                                                      (stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.gameSAUStarterUserref ==
                                                                          currentUserReference))
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        _model.selectedGameList = stackRoomRecord
                                                                            .selectedGameList
                                                                            .toList()
                                                                            .cast<SelectedGameListStruct>();
                                                                        _model.countGame = stackRoomRecord
                                                                            .selectedGameList
                                                                            .length;
                                                                        while (_model.countGame! >
                                                                            0) {
                                                                          if (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.selectedGameID ==
                                                                              mainGameItem.selectedGameID) {
                                                                            _model.gameSAU =
                                                                                _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.gameSAU.toList().cast<GameSAUStruct>();
                                                                            _model.roundIndex =
                                                                                _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.gameSAU.length - 1;
                                                                            _model.roundSAUser =
                                                                                _model.gameSAU.lastOrNull!.roundUserPoint.toList().cast<GameSAURoundUserStruct>();
                                                                            _model.countUser =
                                                                                _model.gameSAU.lastOrNull?.roundUserPoint?.length;
                                                                            while (_model.countUser! >
                                                                                0) {
                                                                              if (step6UsersRecord.reference == _model.roundSAUser.elementAtOrNull((_model.countUser!) - 1)?.roundUserRef) {
                                                                                _model.updateRoundSAUserAtIndex(
                                                                                  (_model.countUser!) - 1,
                                                                                  (e) => e..roundPoints = 50 + _model.roundSAUser.elementAtOrNull((_model.countUser!) - 1)!.roundPoints,
                                                                                );
                                                                              }
                                                                              _model.countUser = (_model.countUser!) - 1;
                                                                            }
                                                                            _model.updateGameSAUAtIndex(
                                                                              _model.roundIndex!,
                                                                              (e) => e
                                                                                ..roundUserPoint = _model.roundSAUser.toList()
                                                                                ..roundAnswerRevealTime = getCurrentTimestamp,
                                                                            );
                                                                            break;
                                                                          }
                                                                          _model.countGame =
                                                                              (_model.countGame!) - 1;
                                                                        }
                                                                        _model
                                                                            .updateSelectedGameListAtIndex(
                                                                          (_model.countGame!) -
                                                                              1,
                                                                          (e) => e
                                                                            ..gameSAU =
                                                                                _model.gameSAU.toList(),
                                                                        );

                                                                        await widget!
                                                                            .room!
                                                                            .update({
                                                                          ...createRoomRecordData(
                                                                            roomUpdatedAt:
                                                                                getCurrentTimestamp,
                                                                          ),
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                _model.selectedGameList,
                                                                              ),
                                                                            },
                                                                          ),
                                                                        });
                                                                      },
                                                                      text: FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'cs4duaq0' /* Suspect guessed the word */,
                                                                      ),
                                                                      options:
                                                                          FFButtonOptions(
                                                                        height:
                                                                            32.0,
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            24.0,
                                                                            0.0,
                                                                            24.0,
                                                                            0.0),
                                                                        iconAlignment:
                                                                            IconAlignment.end,
                                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              font: GoogleFonts.almarai(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          width:
                                                                              0.5,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                    ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () {
                                                                            print('Button pressed ...');
                                                                          },
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            '8dz66itm' /* Share Result */,
                                                                          ),
                                                                          icon:
                                                                              Icon(
                                                                            Icons.ios_share_sharp,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                          options:
                                                                              FFButtonOptions(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
                                                                            height:
                                                                                45.0,
                                                                            padding:
                                                                                EdgeInsets.all(0.0),
                                                                            iconAlignment:
                                                                                IconAlignment.end,
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                  font: GoogleFonts.almarai(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                ),
                                                                            elevation:
                                                                                0.0,
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              width: 0.5,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if ((mainGameItem.gameSAU.length <
                                                                              3) &&
                                                                          (stackRoomRecord.selectedGameList.where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID).toList().firstOrNull?.gameSAUStarterUserref ==
                                                                              currentUserReference))
                                                                        Expanded(
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              var _shouldSetState = false;
                                                                              _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                              _model.countGame = stackRoomRecord.selectedGameList.length;
                                                                              _model.topicFoundStatus = 'notFound';
                                                                              while (_model.countGame! > 0) {
                                                                                if (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID) {
                                                                                  _model.randomTopicResult = await queryTopicRecordOnce(
                                                                                    queryBuilder: (topicRecord) => topicRecord
                                                                                        .where(
                                                                                          'topic_status',
                                                                                          isEqualTo: 'active',
                                                                                        )
                                                                                        .where(
                                                                                          'game_ID',
                                                                                          arrayContains: stackGameRecord?.gameID,
                                                                                        ),
                                                                                  );
                                                                                  _shouldSetState = true;
                                                                                  while (_model.topicFoundStatus == 'notFound') {
                                                                                    _model.countTopic = random_data.randomInteger(0, _model.randomTopicResult!.length - 1);
                                                                                    if (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.selectedTopicIDList?.contains(_model.randomTopicResult?.elementAtOrNull(_model.countTopic!)?.topicID) == false) {
                                                                                      _model.randomTopicQuestionResult = await queryTopicQuestionRecordOnce(
                                                                                        queryBuilder: (topicQuestionRecord) => topicQuestionRecord
                                                                                            .where(
                                                                                              'question_status',
                                                                                              isEqualTo: 'active',
                                                                                            )
                                                                                            .where(
                                                                                              'topic_id',
                                                                                              isEqualTo: _model.randomTopicResult?.elementAtOrNull(_model.countTopic!)?.topicID,
                                                                                            ),
                                                                                      );
                                                                                      _shouldSetState = true;
                                                                                      _model.questionFoundStatus = 'notFound';
                                                                                      _model.topicFoundStatus = 'found';
                                                                                      while (_model.questionFoundStatus == 'notFound') {
                                                                                        _model.questionRandomIndex = random_data.randomInteger(0, _model.randomTopicQuestionResult!.length - 1);
                                                                                        if (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.selectedQuestionIDList?.contains(_model.randomTopicQuestionResult?.elementAtOrNull(_model.questionRandomIndex!)?.questionID) == false) {
                                                                                          _model.idmapResultRound = await queryIDmapRecordOnce(
                                                                                            queryBuilder: (iDmapRecord) => iDmapRecord.where(
                                                                                              'type',
                                                                                              isEqualTo: 'Main',
                                                                                            ),
                                                                                            singleRecord: true,
                                                                                          ).then((s) => s.firstOrNull);
                                                                                          _shouldSetState = true;
                                                                                          _model.selectedUserList = _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.selectedGameUserList.where((e) => (e.roomUserNotificationSendStatus == 'send') || (e.roomUserNotificationSendStatus == 'stocker')).toList().cast<RoomUserListStruct>();
                                                                                          _model.randomUserIndex = random_data.randomInteger(0, _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.selectedGameUserList.where((e) => (e.roomUserNotificationSendStatus == 'send') || (e.roomUserNotificationSendStatus == 'stocker')).toList().length - 1);
                                                                                          _model.updateSelectedGameListAtIndex(
                                                                                            (_model.countGame!) - 1,
                                                                                            (e) => e
                                                                                              ..gameSAUStep = 2
                                                                                              ..updateGameSAU(
                                                                                                (e) => e.add(GameSAUStruct(
                                                                                                  roundID: _model.idmapResultRound?.roundId,
                                                                                                  roundStartAt: getCurrentTimestamp,
                                                                                                  roundStatus: 'active',
                                                                                                  roundTopicId: _model.randomTopicResult?.elementAtOrNull(_model.countTopic!)?.topicID,
                                                                                                  roundQuestionId: _model.randomTopicQuestionResult?.elementAtOrNull(_model.questionRandomIndex!)?.questionID,
                                                                                                  suspectUserRef: _model.selectedUserList.elementAtOrNull(_model.randomUserIndex!)?.roomUserRef,
                                                                                                )),
                                                                                              )
                                                                                              ..updateSelectedQuestionIDList(
                                                                                                (e) => e.add(_model.randomTopicQuestionResult!.elementAtOrNull(_model.questionRandomIndex!)!.questionID),
                                                                                              )
                                                                                              ..updateSelectedQuestionList(
                                                                                                (e) => e.add(SelectedQuestionListStruct(
                                                                                                  questionID: _model.randomTopicQuestionResult?.elementAtOrNull(_model.questionRandomIndex!)?.questionID,
                                                                                                  questionAnswerStatus: 'show',
                                                                                                )),
                                                                                              ),
                                                                                          );

                                                                                          await _model.idmapResultRound!.reference.update({
                                                                                            ...mapToFirestore(
                                                                                              {
                                                                                                'round_id': FieldValue.increment(1),
                                                                                              },
                                                                                            ),
                                                                                          });

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
                                                                                          if (_shouldSetState) safeSetState(() {});
                                                                                          return;
                                                                                        } else {
                                                                                          _model.questionFoundStatus = 'notFound';
                                                                                          _model.questionRandomIndex = random_data.randomInteger(0, _model.randomTopicQuestionResult!.length - 1);
                                                                                        }
                                                                                      }
                                                                                    } else {
                                                                                      _model.countTopic = random_data.randomInteger(0, _model.randomTopicResult!.length - 1);
                                                                                      _model.topicFoundStatus = 'notFound';
                                                                                    }
                                                                                  }
                                                                                  if (_shouldSetState) safeSetState(() {});
                                                                                  return;
                                                                                }
                                                                                _model.countGame = (_model.countGame!) - 1;
                                                                              }
                                                                              if (_shouldSetState)
                                                                                safeSetState(() {});
                                                                            },
                                                                            text: '${FFLocalizations.of(context).getVariableText(
                                                                              enText: 'Start ',
                                                                              arText: ' يبدأ',
                                                                            )}${mainGameItem.gameSAU.length == 1 ? FFLocalizations.of(context).getVariableText(
                                                                                enText: '2nd',
                                                                                arText: 'الثاني',
                                                                              ) : FFLocalizations.of(context).getVariableText(
                                                                                enText: '3rd',
                                                                                arText: 'الثالث',
                                                                              )}${FFLocalizations.of(context).getVariableText(
                                                                              enText: ' round',
                                                                              arText: 'دائري',
                                                                            )}',
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: MediaQuery.sizeOf(context).width * 1.0,
                                                                              height: 45.0,
                                                                              padding: EdgeInsets.all(0.0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    font: GoogleFonts.almarai(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                width: 0.5,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      if (stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.gameSAUStarterUserref ==
                                                                          currentUserReference)
                                                                        FlutterFlowIconButton(
                                                                          borderColor:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          borderRadius:
                                                                              8.0,
                                                                          borderWidth:
                                                                              0.5,
                                                                          buttonSize:
                                                                              45.0,
                                                                          fillColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          icon:
                                                                              Icon(
                                                                            Icons.home_rounded,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            _model.selectedGameList =
                                                                                stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                            _model.countGame =
                                                                                stackRoomRecord.selectedGameList.length;
                                                                            while (_model.countGame! >
                                                                                0) {
                                                                              if (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.selectedGameID == mainGameItem.selectedGameID) {
                                                                                _model.countUser = _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.selectedGameUserList?.length;
                                                                                _model.selectedUserList = _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.selectedGameUserList.toList().cast<RoomUserListStruct>();
                                                                                while (_model.countUser! > 0) {
                                                                                  _model.points = 0;
                                                                                  _model.roundCount = _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.gameSAU?.length;
                                                                                  _model.roundList = _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.gameSAU.toList().cast<GameSAUStruct>();
                                                                                  while (_model.roundCount! > 0) {
                                                                                    _model.roundUserList = _model.roundList.elementAtOrNull((_model.roundCount!) - 1)!.roundUserPoint.toList().cast<GameSAURoundUserStruct>();
                                                                                    _model.points = valueOrDefault<int>(
                                                                                          _model.points,
                                                                                          0,
                                                                                        ) +
                                                                                        valueOrDefault<int>(
                                                                                          _model.roundUserList.where((e) => e.roundUserRef == _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef).toList().firstOrNull?.roundPoints,
                                                                                          0,
                                                                                        );
                                                                                    _model.roundCount = (_model.roundCount!) - 1;
                                                                                  }
                                                                                  _model.addToFinalWinUserList(GameSAURoundUserStruct(
                                                                                    roundPoints: _model.points,
                                                                                    roundUserRef: _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef,
                                                                                  ));
                                                                                  _model.countUser = (_model.countUser!) - 1;
                                                                                }
                                                                                _model.updateSelectedGameListAtIndex(
                                                                                  (_model.countGame!) - 1,
                                                                                  (e) => e
                                                                                    ..gameEndTime = getCurrentTimestamp
                                                                                    ..gameResult = ResultInfoStruct(
                                                                                      createdAt: getCurrentTimestamp,
                                                                                      status: 'win',
                                                                                      point: _model.finalWinUserList.sortedList(keyOf: (e) => e.roundPoints, desc: true).firstOrNull?.roundPoints,
                                                                                      userRef: _model.finalWinUserList.sortedList(keyOf: (e) => e.roundPoints, desc: true).firstOrNull?.roundUserRef,
                                                                                    )
                                                                                    ..gameSAUFinalResult = _model.finalWinUserList.toList()
                                                                                    ..gameSAUStep = 7,
                                                                                );
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
                                                                                  'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                    _model.selectedGameList,
                                                                                  ),
                                                                                },
                                                                              ),
                                                                            });
                                                                            unawaited(
                                                                              () async {}(),
                                                                            );
                                                                          },
                                                                        ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            16.0)),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        8.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        if (mainGameItem
                                                                .gameSAU
                                                                .lastOrNull!
                                                                .roundUserPoint
                                                                .length >
                                                            0)
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            0.5,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              16.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                8.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                RichText(
                                                                                  textScaler: MediaQuery.of(context).textScaler,
                                                                                  text: TextSpan(
                                                                                    children: [
                                                                                      TextSpan(
                                                                                        text: FFLocalizations.of(context).getText(
                                                                                          'i5k0bg8e' /* Who Guessed Correctly   */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                              font: GoogleFonts.almarai(
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                              ),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                      TextSpan(
                                                                                        text: '${mainGameItem.gameSAU.lastOrNull?.voteUser?.length?.toString()} / ${mainGameItem.gameSAU.lastOrNull?.roundUserPoint?.sortedList(keyOf: (e) => e.roundPoints, desc: true)?.length?.toString()}',
                                                                                        style: TextStyle(
                                                                                          color: FlutterFlowTheme.of(context).tertiary,
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                          font: GoogleFonts.almarai(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: 18.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 8.0)),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Builder(
                                                                              builder: (context) {
                                                                                final winnerUserList = mainGameItem.gameSAU.lastOrNull?.roundUserPoint?.sortedList(keyOf: (e) => e.roundPoints, desc: true)?.toList() ?? [];
                                                                                if (winnerUserList.isEmpty) {
                                                                                  return Center(
                                                                                    child: EmptyWidgetRoomWidget(),
                                                                                  );
                                                                                }

                                                                                return ListView.separated(
                                                                                  padding: EdgeInsets.zero,
                                                                                  primary: false,
                                                                                  shrinkWrap: true,
                                                                                  scrollDirection: Axis.vertical,
                                                                                  itemCount: winnerUserList.length,
                                                                                  separatorBuilder: (_, __) => SizedBox(height: 16.0),
                                                                                  itemBuilder: (context, winnerUserListIndex) {
                                                                                    final winnerUserListItem = winnerUserList[winnerUserListIndex];
                                                                                    return StreamBuilder<UsersRecord>(
                                                                                      stream: UsersRecord.getDocument(winnerUserListItem.roundUserRef!),
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

                                                                                        final wrapUsersRecord = snapshot.data!;

                                                                                        return Wrap(
                                                                                          spacing: 0.0,
                                                                                          runSpacing: 0.0,
                                                                                          alignment: WrapAlignment.start,
                                                                                          crossAxisAlignment: WrapCrossAlignment.start,
                                                                                          direction: Axis.horizontal,
                                                                                          runAlignment: WrapAlignment.start,
                                                                                          verticalDirection: VerticalDirection.down,
                                                                                          clipBehavior: Clip.none,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: 40.0,
                                                                                                  height: 40.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    shape: BoxShape.circle,
                                                                                                  ),
                                                                                                  child: Align(
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        (winnerUserListIndex + 1).toString(),
                                                                                                        '0',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                            font: GoogleFonts.almarai(
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            wrapUsersRecord.displayName,
                                                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                  font: GoogleFonts.almarai(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                  ),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                          if (stackRoomRecord.roomCreatedUserRef == winnerUserListItem.roundUserRef)
                                                                                                            Icon(
                                                                                                              Icons.star_rounded,
                                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                                              size: 20.0,
                                                                                                            ),
                                                                                                        ].divide(SizedBox(width: 4.0)),
                                                                                                      ),
                                                                                                      Expanded(
                                                                                                        child: Row(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              '${FFLocalizations.of(context).getVariableText(
                                                                                                                enText: 'Player ID: ',
                                                                                                                arText: 'معرف اللاعب:',
                                                                                                              )}${wrapUsersRecord.userId.toString()}',
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.almarai(
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                            if (mainGameItem.gameSAU.lastOrNull?.suspectUserRef == winnerUserListItem.roundUserRef)
                                                                                                              Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0x26EC4D41),
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                ),
                                                                                                                child: Padding(
                                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                                                                                                  child: Row(
                                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                                    children: [
                                                                                                                      Text(
                                                                                                                        FFLocalizations.of(context).getText(
                                                                                                                          'qlbhb20k' /* Suspect */,
                                                                                                                        ),
                                                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                              font: GoogleFonts.almarai(
                                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                              ),
                                                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                                                              letterSpacing: 0.0,
                                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                            ),
                                                                                                                      ),
                                                                                                                    ].divide(SizedBox(width: 4.0)),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                          ].divide(SizedBox(width: 8.0)),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ].divide(SizedBox(height: 4.0)),
                                                                                                  ),
                                                                                                ),
                                                                                                Text(
                                                                                                  '+ ${winnerUserListItem.roundPoints.toString()}${FFLocalizations.of(context).getVariableText(
                                                                                                    enText: ' Points',
                                                                                                    arText: 'نقاط',
                                                                                                  )}',
                                                                                                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                        font: GoogleFonts.almarai(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                                                                        fontSize: 14.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ].divide(SizedBox(width: 8.0)),
                                                                                            ),
                                                                                          ],
                                                                                        );
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(height: 16.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ),
                                                      ].divide(SizedBox(
                                                          width: 16.0)),
                                                    );
                                                  },
                                                ),
                                              ),
                                            if (stackRoomRecord.selectedGameList
                                                    .where((e) =>
                                                        e.selectedGameID ==
                                                        currentUserDocument
                                                            ?.presentRoomGameInfo
                                                            ?.roomSelectedGameID)
                                                    .toList()
                                                    .firstOrNull
                                                    ?.gameSAUStep ==
                                                7)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        valueOrDefault<double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 48.0
                                                              : 16.0,
                                                          0.0,
                                                        ),
                                                        16.0,
                                                        valueOrDefault<double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode !=
                                                                  'en'
                                                              ? 48.0
                                                              : 16.0,
                                                          0.0,
                                                        ),
                                                        16.0),
                                                child:
                                                    StreamBuilder<UsersRecord>(
                                                  stream:
                                                      UsersRecord.getDocument(
                                                          mainGameItem
                                                              .gameResult
                                                              .userRef!),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 2.0,
                                                          height: 2.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0x00EC4D41),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    final step7UsersRecord =
                                                        snapshot.data!;

                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                width: 0.5,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          12.0,
                                                                          16.0,
                                                                          12.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          Stack(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                40.0,
                                                                            height:
                                                                                40.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              shape: BoxShape.circle,
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(100.0),
                                                                              child: Image.network(
                                                                                step7UsersRecord.photoUrl != null && step7UsersRecord.photoUrl != '' ? currentUserPhoto : 'https://ui-avatars.com/api/?name=${step7UsersRecord.displayName}&background=random&bold=true',
                                                                                width: 60.0,
                                                                                height: 60.0,
                                                                                fit: BoxFit.cover,
                                                                                alignment: Alignment(0.0, 0.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (mainGameItem
                                                                          .gameSAU
                                                                          .lastOrNull!
                                                                          .roundUserPoint
                                                                          .length >
                                                                      0)
                                                                    RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                step7UsersRecord.displayName,
                                                                            style:
                                                                                TextStyle(),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              'u6f6ifmh' /*  is winner with  */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                  font: GoogleFonts.almarai(
                                                                                    fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                  ),
                                                                                  fontSize: 18.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                valueOrDefault<String>(
                                                                              mainGameItem.gameResult.point.toString(),
                                                                              '0',
                                                                            ),
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              'k04nl1k9' /*  points */,
                                                                            ),
                                                                            style:
                                                                                TextStyle(),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .override(
                                                                              font: GoogleFonts.almarai(
                                                                                fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                              ),
                                                                              fontSize: 18.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () {
                                                                            print('Button pressed ...');
                                                                          },
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'ycrosudy' /* Share Result */,
                                                                          ),
                                                                          icon:
                                                                              Icon(
                                                                            Icons.ios_share_sharp,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                          options:
                                                                              FFButtonOptions(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
                                                                            height:
                                                                                45.0,
                                                                            padding:
                                                                                EdgeInsets.all(0.0),
                                                                            iconAlignment:
                                                                                IconAlignment.end,
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                  font: GoogleFonts.almarai(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                ),
                                                                            elevation:
                                                                                0.0,
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              width: 0.5,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      FlutterFlowIconButton(
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        borderRadius:
                                                                            8.0,
                                                                        borderWidth:
                                                                            0.5,
                                                                        buttonSize:
                                                                            45.0,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).primary,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .home_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).info,
                                                                          size:
                                                                              24.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          unawaited(
                                                                            () async {
                                                                              await FFAppState().currentUserRef!.update(createUsersRecordData(
                                                                                    presentRoomGameInfo: createPresentRoomGameInfoStruct(delete: true),
                                                                                  ));
                                                                            }(),
                                                                          );

                                                                          context
                                                                              .goNamed(
                                                                            HomeWidget.routeName,
                                                                            extra: <String,
                                                                                dynamic>{
                                                                              '__transition_info__': TransitionInfo(
                                                                                hasTransition: true,
                                                                                transitionType: PageTransitionType.fade,
                                                                                duration: Duration(milliseconds: 0),
                                                                              ),
                                                                            },
                                                                          );

                                                                          unawaited(
                                                                            () async {}(),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            16.0)),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        8.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        if (mainGameItem
                                                                .selectedGameUserList
                                                                .length >
                                                            0)
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            0.5,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              16.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                8.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                RichText(
                                                                                  textScaler: MediaQuery.of(context).textScaler,
                                                                                  text: TextSpan(
                                                                                    children: [
                                                                                      TextSpan(
                                                                                        text: FFLocalizations.of(context).getText(
                                                                                          '37jf7j6d' /* Final score of game */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                              font: GoogleFonts.almarai(
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                              ),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                            ),
                                                                                      )
                                                                                    ],
                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                          font: GoogleFonts.almarai(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: 18.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 8.0)),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Builder(
                                                                              builder: (context) {
                                                                                final winnerUserList = mainGameItem.gameSAUFinalResult.toList();
                                                                                if (winnerUserList.isEmpty) {
                                                                                  return Center(
                                                                                    child: EmptyWidgetRoomWidget(),
                                                                                  );
                                                                                }

                                                                                return ListView.separated(
                                                                                  padding: EdgeInsets.zero,
                                                                                  primary: false,
                                                                                  shrinkWrap: true,
                                                                                  scrollDirection: Axis.vertical,
                                                                                  itemCount: winnerUserList.length,
                                                                                  separatorBuilder: (_, __) => SizedBox(height: 16.0),
                                                                                  itemBuilder: (context, winnerUserListIndex) {
                                                                                    final winnerUserListItem = winnerUserList[winnerUserListIndex];
                                                                                    return StreamBuilder<UsersRecord>(
                                                                                      stream: UsersRecord.getDocument(winnerUserListItem.roundUserRef!),
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

                                                                                        final wrapUsersRecord = snapshot.data!;

                                                                                        return Wrap(
                                                                                          spacing: 0.0,
                                                                                          runSpacing: 0.0,
                                                                                          alignment: WrapAlignment.start,
                                                                                          crossAxisAlignment: WrapCrossAlignment.start,
                                                                                          direction: Axis.horizontal,
                                                                                          runAlignment: WrapAlignment.start,
                                                                                          verticalDirection: VerticalDirection.down,
                                                                                          clipBehavior: Clip.none,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: 40.0,
                                                                                                  height: 40.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    shape: BoxShape.circle,
                                                                                                  ),
                                                                                                  child: Align(
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        (winnerUserListIndex + 1).toString(),
                                                                                                        '0',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                            font: GoogleFonts.almarai(
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            wrapUsersRecord.displayName,
                                                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                                  font: GoogleFonts.almarai(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                  ),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                          if (stackRoomRecord.roomCreatedUserRef == wrapUsersRecord.reference)
                                                                                                            Icon(
                                                                                                              Icons.star_rounded,
                                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                                              size: 20.0,
                                                                                                            ),
                                                                                                        ].divide(SizedBox(width: 4.0)),
                                                                                                      ),
                                                                                                      Expanded(
                                                                                                        child: Row(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              '${FFLocalizations.of(context).getVariableText(
                                                                                                                enText: 'Player ID: ',
                                                                                                                arText: 'معرف اللاعب:',
                                                                                                              )}${wrapUsersRecord.userId.toString()}',
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.almarai(
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                            if (currentUserReference == winnerUserListItem.roundUserRef)
                                                                                                              Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Color(0x1AEC4D41),
                                                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                                                ),
                                                                                                                child: Padding(
                                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 2.0, 8.0, 2.0),
                                                                                                                  child: Text(
                                                                                                                    FFLocalizations.of(context).getText(
                                                                                                                      '82l8ifj4' /* You */,
                                                                                                                    ),
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          font: GoogleFonts.almarai(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                          ].divide(SizedBox(width: 8.0)),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ].divide(SizedBox(height: 4.0)),
                                                                                                  ),
                                                                                                ),
                                                                                                Text(
                                                                                                  '+ ${winnerUserListItem.roundPoints.toString()}${FFLocalizations.of(context).getVariableText(
                                                                                                    enText: ' Points',
                                                                                                    arText: 'نقاط',
                                                                                                  )}',
                                                                                                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                        font: GoogleFonts.almarai(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                                                                        fontSize: 14.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ].divide(SizedBox(width: 8.0)),
                                                                                            ),
                                                                                          ],
                                                                                        );
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(height: 16.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ),
                                                      ].divide(SizedBox(
                                                          width: 16.0)),
                                                    );
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
