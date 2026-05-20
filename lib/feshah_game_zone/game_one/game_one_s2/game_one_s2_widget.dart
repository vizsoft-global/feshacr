import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_one/game_one_initial/game_one_initial_widget.dart';
import '/feshah_game_zone/game_one/game_one_tie_start/game_one_tie_start_widget.dart';
import '/feshah_game_zone/game_one/game_one_timer/game_one_timer_widget.dart';
import '/feshah_game_zone/game_one/game_one_video/game_one_video_widget.dart';
import '/feshah_game_zone/game_one/game_team_user/game_team_user_widget.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_one_s2_model.dart';
export 'game_one_s2_model.dart';

class GameOneS2Widget extends StatefulWidget {
  const GameOneS2Widget({
    super.key,
    required this.room,
    bool? tieBreakStatus,
  }) : this.tieBreakStatus = tieBreakStatus ?? false;

  final DocumentReference? room;
  final bool tieBreakStatus;

  static String routeName = 'GameOne-S2';
  static String routePath = '/gameone_s2';

  @override
  State<GameOneS2Widget> createState() => _GameOneS2WidgetState();
}

class _GameOneS2WidgetState extends State<GameOneS2Widget> {
  late GameOneS2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameOneS2Model());

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: StreamBuilder<RoomRecord>(
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

                final columnRoomRecord = snapshot.data!;

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AuthUserStreamWidget(
                      builder: (context) => StreamBuilder<List<GameRecord>>(
                        stream: queryGameRecord(
                          queryBuilder: (gameRecord) => gameRecord.where(
                            'game_ID',
                            isEqualTo: currentUserDocument
                                ?.presentRoomGameInfo?.roomGameId,
                          ),
                          singleRecord: true,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          List<GameRecord> appBarGameGameRecordList =
                              snapshot.data!;
                          final appBarGameGameRecord =
                              appBarGameGameRecordList.isNotEmpty
                                  ? appBarGameGameRecordList.first
                                  : null;

                          return wrapWithModel(
                            model: _model.appBarGameModel,
                            updateCallback: () => safeSetState(() {}),
                            updateOnChange: true,
                            child: AppBarGameWidget(
                              backButtonStatus: widget!.tieBreakStatus == false
                                  ? true
                                  : false,
                              topicButtonStatus: columnRoomRecord
                                          .selectedGameList
                                          .where((e) =>
                                              e.selectedGameID ==
                                              currentUserDocument
                                                  ?.presentRoomGameInfo
                                                  ?.roomSelectedGameID)
                                          .toList()
                                          .firstOrNull
                                          ?.gameTieBreak ==
                                      'set'
                                  ? false
                                  : true,
                              exitButtonStatus: true,
                              selectedGameID: currentUserDocument
                                  ?.presentRoomGameInfo?.roomSelectedGameID,
                              room: widget!.room,
                              pageTitle:
                                  FFLocalizations.of(context).getVariableText(
                                enText: () {
                                  if (appBarGameGameRecord
                                          ?.gameInfoManualTranslate?.name?.en !=
                                      '') {
                                    return appBarGameGameRecord
                                        ?.gameInfoManualTranslate?.name?.en;
                                  } else if (appBarGameGameRecord
                                          ?.gameInfoTranslate?.name?.en !=
                                      '') {
                                    return appBarGameGameRecord
                                        ?.gameInfoTranslate?.name?.en;
                                  } else {
                                    return appBarGameGameRecord?.gameInfo?.name;
                                  }
                                }(),
                                arText: () {
                                  if (appBarGameGameRecord
                                          ?.gameInfoManualTranslate?.name?.ar !=
                                      '') {
                                    return appBarGameGameRecord
                                        ?.gameInfoManualTranslate?.name?.ar;
                                  } else if (appBarGameGameRecord
                                          ?.gameInfoTranslate?.name?.ar !=
                                      '') {
                                    return appBarGameGameRecord
                                        ?.gameInfoTranslate?.name?.ar;
                                  } else {
                                    return appBarGameGameRecord?.gameInfo?.name;
                                  }
                                }(),
                              ),
                              presentTeamInfoStatus: (columnRoomRecord
                                              .selectedGameList
                                              .where((e) =>
                                                  e.selectedGameID ==
                                                  currentUserDocument
                                                      ?.presentRoomGameInfo
                                                      ?.roomSelectedGameID)
                                              .toList()
                                              .firstOrNull
                                              ?.teamInfo
                                              ?.elementAtOrNull(1))
                                          ?.teamID ==
                                      999
                                  ? false
                                  : (columnRoomRecord.selectedGameList
                                              .where((e) =>
                                                  e.selectedGameID ==
                                                  currentUserDocument
                                                      ?.presentRoomGameInfo
                                                      ?.roomSelectedGameID)
                                              .toList()
                                              .length >
                                          0
                                      ? true
                                      : false),
                              presentTeamID: columnRoomRecord.selectedGameList
                                  .where((e) =>
                                      e.selectedGameID ==
                                      currentUserDocument?.presentRoomGameInfo
                                          ?.roomSelectedGameID)
                                  .toList()
                                  .firstOrNull
                                  ?.presentTeamID,
                              teamInfo: columnRoomRecord.selectedGameList
                                  .where((e) =>
                                      e.selectedGameID ==
                                      currentUserDocument?.presentRoomGameInfo
                                          ?.roomSelectedGameID)
                                  .toList()
                                  .firstOrNull
                                  ?.teamInfo,
                              backButtonText:
                                  FFLocalizations.of(context).getText(
                                'ds4x8bbe' /* Topics */,
                              ),
                              topicsQuestions:
                                  FFLocalizations.of(context).getText(
                                '5x0ro4bk' /* Topics */,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
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
                if ((stackRoomRecord.selectedGameList
                            .where((e) =>
                                currentUserDocument
                                    ?.presentRoomGameInfo?.roomSelectedGameID ==
                                e.selectedGameID)
                            .toList()
                            .firstOrNull
                            ?.gameResult
                            ?.status ==
                        'win') ||
                    (stackRoomRecord.selectedGameList
                            .where((e) =>
                                currentUserDocument
                                    ?.presentRoomGameInfo?.roomSelectedGameID ==
                                e.selectedGameID)
                            .toList()
                            .firstOrNull
                            ?.gameResult
                            ?.status ==
                        'tie'))
                  AuthUserStreamWidget(
                    builder: (context) => wrapWithModel(
                      model: _model.gameOneInitialModel,
                      updateCallback: () => safeSetState(() {}),
                      updateOnChange: true,
                      child: GameOneInitialWidget(
                        room: widget!.room!,
                      ),
                    ),
                  ),
                AuthUserStreamWidget(
                  builder: (context) => StreamBuilder<List<GameRecord>>(
                    stream: queryGameRecord(
                      queryBuilder: (gameRecord) => gameRecord
                          .where(
                            'game_status',
                            isEqualTo: 'active',
                          )
                          .where(
                            'game_ID',
                            isEqualTo: stackRoomRecord.selectedGameList
                                .where((e) =>
                                    currentUserDocument?.presentRoomGameInfo
                                        ?.roomSelectedGameID ==
                                    e.selectedGameID)
                                .toList()
                                .firstOrNull
                                ?.gameId,
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
                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final columnGameRecord = columnGameRecordList.isNotEmpty
                          ? columnGameRecordList.first
                          : null;

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                final selectedGameID = stackRoomRecord
                                    .selectedGameList
                                    .where((e) =>
                                        currentUserDocument?.presentRoomGameInfo
                                            ?.roomSelectedGameID ==
                                        e.selectedGameID)
                                    .toList()
                                    .take(1)
                                    .toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(selectedGameID.length,
                                      (selectedGameIDIndex) {
                                    final selectedGameIDItem =
                                        selectedGameID[selectedGameIDIndex];
                                    return Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            valueOrDefault<double>(
                                              FFLocalizations.of(context)
                                                          .languageCode ==
                                                      'en'
                                                  ? 48.0
                                                  : 16.0,
                                              0.0,
                                            ),
                                            16.0,
                                            valueOrDefault<double>(
                                              FFLocalizations.of(context)
                                                          .languageCode !=
                                                      'en'
                                                  ? 48.0
                                                  : 16.0,
                                              0.0,
                                            ),
                                            16.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Stack(
                                                      children: [
                                                        if (selectedGameIDItem
                                                                    .gameTieBreakStatus !=
                                                                ''
                                                            ? (selectedGameIDItem
                                                                    .gameTieBreakStatus ==
                                                                'start')
                                                            : (selectedGameIDItem
                                                                    .selectedQuestionList
                                                                    .length >
                                                                0))
                                                          StreamBuilder<
                                                              List<
                                                                  TopicQuestionRecord>>(
                                                            stream:
                                                                queryTopicQuestionRecord(
                                                              queryBuilder:
                                                                  (topicQuestionRecord) =>
                                                                      topicQuestionRecord
                                                                          .where(
                                                                            'question_ID',
                                                                            isEqualTo: stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.gameTieInfo?.status == 'active'
                                                                                ? stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.gameTieQuestionIDList?.lastOrNull
                                                                                : stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.selectedQuestionList?.lastOrNull?.questionID,
                                                                          )
                                                                          .where(
                                                                            'question_status',
                                                                            isEqualTo:
                                                                                'active',
                                                                          ),
                                                              singleRecord:
                                                                  true,
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 2.0,
                                                                    height: 2.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        Color(
                                                                            0x00EC4D41),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<TopicQuestionRecord>
                                                                  createTeamsTopicQuestionRecordList =
                                                                  snapshot
                                                                      .data!;
                                                              // Return an empty Container when the item does not exist.
                                                              if (snapshot.data!
                                                                  .isEmpty) {
                                                                return Container();
                                                              }
                                                              final createTeamsTopicQuestionRecord =
                                                                  createTeamsTopicQuestionRecordList
                                                                          .isNotEmpty
                                                                      ? createTeamsTopicQuestionRecordList
                                                                          .first
                                                                      : null;

                                                              return ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      width:
                                                                          0.5,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            12.0,
                                                                            8.0,
                                                                            12.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children:
                                                                          [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children:
                                                                              [
                                                                            Expanded(
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  if ((selectedGameIDItem.selectedQuestionList.where((e) => e.questionID == createTeamsTopicQuestionRecord?.questionID).toList().firstOrNull?.questionAnswerStatus != 'show') && (selectedGameIDItem.gameTieInfo.status != 'active'))
                                                                                    Expanded(
                                                                                      child: GameOneTimerWidget(
                                                                                        key: Key('Keyb84_${selectedGameIDIndex}_of_${selectedGameID.length}'),
                                                                                        timeMS: selectedGameIDItem.gameTieInfo.status == 'active'
                                                                                            ? valueOrDefault<int>(
                                                                                                createTeamsTopicQuestionRecord!.questionInfo.timeForResultInMin * 60 * 1000,
                                                                                                30000,
                                                                                              )
                                                                                            : valueOrDefault<int>(
                                                                                                createTeamsTopicQuestionRecord!.questionInfo.timeForResultInMin * 60 * 1000,
                                                                                                30000,
                                                                                              ),
                                                                                        resetStatus: false,
                                                                                        startStatus: false,
                                                                                      ),
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: StreamBuilder<List<TopicRecord>>(
                                                                                stream: queryTopicRecord(
                                                                                  queryBuilder: (topicRecord) => topicRecord.where(
                                                                                    'topic_ID',
                                                                                    isEqualTo: createTeamsTopicQuestionRecord?.topicId,
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
                                                                                  List<TopicRecord> textTopicRecordList = snapshot.data!;
                                                                                  // Return an empty Container when the item does not exist.
                                                                                  if (snapshot.data!.isEmpty) {
                                                                                    return Container();
                                                                                  }
                                                                                  final textTopicRecord = textTopicRecordList.isNotEmpty ? textTopicRecordList.first : null;

                                                                                  return AutoSizeText(
                                                                                    FFLocalizations.of(context).getVariableText(
                                                                                      enText: () {
                                                                                        if (textTopicRecord?.topicInfoManualTranslate?.name?.en != '') {
                                                                                          return textTopicRecord?.topicInfoManualTranslate?.name?.en;
                                                                                        } else if (textTopicRecord?.topicInfoTranslate?.name?.en != '') {
                                                                                          return textTopicRecord?.topicInfoTranslate?.name?.en;
                                                                                        } else {
                                                                                          return textTopicRecord?.topicInfo?.name;
                                                                                        }
                                                                                      }(),
                                                                                      arText: () {
                                                                                        if (textTopicRecord?.topicInfoManualTranslate?.name?.ar != '') {
                                                                                          return textTopicRecord?.topicInfoManualTranslate?.name?.ar;
                                                                                        } else if (textTopicRecord?.topicInfoTranslate?.name?.ar != '') {
                                                                                          return textTopicRecord?.topicInfoTranslate?.name?.ar;
                                                                                        } else {
                                                                                          return textTopicRecord?.topicInfo?.name;
                                                                                        }
                                                                                      }(),
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                    minFontSize: 8.0,
                                                                                    style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                          font: GoogleFonts.almarai(
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                        ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  FlutterFlowIconButton(
                                                                                    borderRadius: 8.0,
                                                                                    buttonSize: 35.0,
                                                                                    fillColor: Color(0x263696D0),
                                                                                    icon: Icon(
                                                                                      FFIcons.kfi29,
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      size: 16.0,
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      print('IconButton pressed ...');
                                                                                    },
                                                                                  ),
                                                                                  Container(
                                                                                    height: 35.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0x26F9CF58),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Icon(
                                                                                            FFIcons.kfi6,
                                                                                            color: FlutterFlowTheme.of(context).warning,
                                                                                            size: 16.0,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Text(
                                                                                              '${selectedGameIDItem.gameTieBreak == 'set' ? '100' : createTeamsTopicQuestionRecord?.questionPoint?.toString()} Pts',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).warning,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 4.0)),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 8.0)),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 8.0)),
                                                                        ),
                                                                        if (selectedGameIDItem.selectedQuestionList.where((e) => e.questionID == createTeamsTopicQuestionRecord?.questionID).toList().firstOrNull?.questionAnswerStatus !=
                                                                            'show')
                                                                          Expanded(
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      FFLocalizations.of(context).getVariableText(
                                                                                        enText: () {
                                                                                          if (createTeamsTopicQuestionRecord?.questionInfoTranslateManual?.question?.en != '') {
                                                                                            return createTeamsTopicQuestionRecord?.questionInfoTranslateManual?.question?.en;
                                                                                          } else if (createTeamsTopicQuestionRecord?.questionInfoTranslate?.question?.en != '') {
                                                                                            return createTeamsTopicQuestionRecord?.questionInfoTranslate?.question?.en;
                                                                                          } else {
                                                                                            return createTeamsTopicQuestionRecord?.questionInfo?.question;
                                                                                          }
                                                                                        }(),
                                                                                        arText: () {
                                                                                          if (createTeamsTopicQuestionRecord?.questionInfoTranslateManual?.question?.ar != '') {
                                                                                            return createTeamsTopicQuestionRecord?.questionInfoTranslateManual?.question?.ar;
                                                                                          } else if (createTeamsTopicQuestionRecord?.questionInfoTranslate?.question?.ar != '') {
                                                                                            return createTeamsTopicQuestionRecord?.questionInfoTranslate?.question?.ar;
                                                                                          } else {
                                                                                            return createTeamsTopicQuestionRecord?.questionInfo?.question;
                                                                                          }
                                                                                        }(),
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                            font: GoogleFonts.almarai(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                            ),
                                                                                            fontSize: 20.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        if (selectedGameIDItem.selectedQuestionList.where((e) => e.questionID == createTeamsTopicQuestionRecord?.questionID).toList().firstOrNull?.questionAnswerStatus !=
                                                                            'show')
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Stack(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    children: [
                                                                                      if (createTeamsTopicQuestionRecord?.questionType == 'Audio')
                                                                                        FlutterFlowAudioPlayer(
                                                                                          audio: Audio.network(
                                                                                            createTeamsTopicQuestionRecord!.questionInfo.questionInfo.audioUrl,
                                                                                            metas: Metas(
                                                                                              title: 'Audio',
                                                                                            ),
                                                                                          ),
                                                                                          titleTextStyle: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                font: GoogleFonts.almarai(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                ),
                                                                                                fontSize: 16.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                              ),
                                                                                          playbackDurationTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                font: GoogleFonts.almarai(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                ),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                              ),
                                                                                          fillColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          playbackButtonColor: FlutterFlowTheme.of(context).primary,
                                                                                          activeTrackColor: FlutterFlowTheme.of(context).primary,
                                                                                          inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                                                                                          elevation: 0.0,
                                                                                          playInBackground: PlayInBackground.disabledRestoreOnForeground,
                                                                                        ),
                                                                                      if (createTeamsTopicQuestionRecord?.questionType == 'Video')
                                                                                        Builder(
                                                                                          builder: (context) => FFButtonWidget(
                                                                                            onPressed: () async {
                                                                                              await showDialog(
                                                                                                context: context,
                                                                                                builder: (dialogContext) {
                                                                                                  return Dialog(
                                                                                                    elevation: 0,
                                                                                                    insetPadding: EdgeInsets.zero,
                                                                                                    backgroundColor: Colors.transparent,
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                    child: WebViewAware(
                                                                                                      child: GestureDetector(
                                                                                                        onTap: () {
                                                                                                          FocusScope.of(dialogContext).unfocus();
                                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                                        },
                                                                                                        child: Container(
                                                                                                          width: 500.0,
                                                                                                          child: GameOneVideoWidget(
                                                                                                            video: createTeamsTopicQuestionRecord!.questionInfo.questionInfo.videoUrl,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                              );
                                                                                            },
                                                                                            text: FFLocalizations.of(context).getText(
                                                                                              'fqt0cv58' /* View Video */,
                                                                                            ),
                                                                                            options: FFButtonOptions(
                                                                                              height: 45.0,
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                              textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    fontSize: 14.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
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
                                                                                      if (createTeamsTopicQuestionRecord?.questionType == 'Image')
                                                                                        InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            await Navigator.push(
                                                                                              context,
                                                                                              PageTransition(
                                                                                                type: PageTransitionType.fade,
                                                                                                child: FlutterFlowExpandedImageView(
                                                                                                  image: Image.network(
                                                                                                    valueOrDefault<String>(
                                                                                                      createTeamsTopicQuestionRecord?.questionInfo?.questionInfo?.mainImage,
                                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/y8i24cl1b5bt/Splash_Screen_(2)-min.jpg',
                                                                                                    ),
                                                                                                    fit: BoxFit.contain,
                                                                                                  ),
                                                                                                  allowRotation: true,
                                                                                                  tag: valueOrDefault<String>(
                                                                                                    createTeamsTopicQuestionRecord?.questionInfo?.questionInfo?.mainImage,
                                                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/y8i24cl1b5bt/Splash_Screen_(2)-min.jpg' + '$selectedGameIDIndex',
                                                                                                  ),
                                                                                                  useHeroAnimation: true,
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                          child: Hero(
                                                                                            tag: valueOrDefault<String>(
                                                                                              createTeamsTopicQuestionRecord?.questionInfo?.questionInfo?.mainImage,
                                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/y8i24cl1b5bt/Splash_Screen_(2)-min.jpg' + '$selectedGameIDIndex',
                                                                                            ),
                                                                                            transitionOnUserGestures: true,
                                                                                            child: ClipRRect(
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                              child: Image.network(
                                                                                                valueOrDefault<String>(
                                                                                                  createTeamsTopicQuestionRecord?.questionInfo?.questionInfo?.mainImage,
                                                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/y8i24cl1b5bt/Splash_Screen_(2)-min.jpg',
                                                                                                ),
                                                                                                width: 150.0,
                                                                                                height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                                fit: BoxFit.contain,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  createTeamsTopicQuestionRecord!.questionInfo.questionInfo.mainDescription,
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
                                                                              ].divide(SizedBox(height: 8.0)),
                                                                            ),
                                                                          ),
                                                                        if (selectedGameIDItem.selectedQuestionList.where((e) => e.questionID == createTeamsTopicQuestionRecord?.questionID).toList().firstOrNull?.questionAnswerStatus ==
                                                                            'show')
                                                                          Text(
                                                                            '\"${FFLocalizations.of(context).getVariableText(
                                                                              enText: () {
                                                                                if (createTeamsTopicQuestionRecord?.questionInfoTranslateManual?.answer?.en != '') {
                                                                                  return createTeamsTopicQuestionRecord?.questionInfoTranslateManual?.answer?.en;
                                                                                } else if (createTeamsTopicQuestionRecord?.questionInfoTranslate?.answer?.en != '') {
                                                                                  return createTeamsTopicQuestionRecord?.questionInfoTranslate?.answer?.en;
                                                                                } else {
                                                                                  return createTeamsTopicQuestionRecord?.questionInfo?.answer;
                                                                                }
                                                                              }(),
                                                                              arText: () {
                                                                                if (createTeamsTopicQuestionRecord?.questionInfoTranslateManual?.answer?.ar != '') {
                                                                                  return createTeamsTopicQuestionRecord?.questionInfoTranslateManual?.answer?.ar;
                                                                                } else if (createTeamsTopicQuestionRecord?.questionInfoTranslate?.answer?.ar != '') {
                                                                                  return createTeamsTopicQuestionRecord?.questionInfoTranslate?.answer?.ar;
                                                                                } else {
                                                                                  return createTeamsTopicQuestionRecord?.questionInfo?.answer;
                                                                                }
                                                                              }(),
                                                                            )}\"',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                  font: GoogleFonts.almarai(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                  ),
                                                                                  fontSize: 20.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                        if (selectedGameIDItem.selectedQuestionList.where((e) => e.questionID == createTeamsTopicQuestionRecord?.questionID).toList().firstOrNull?.questionAnswerStatus !=
                                                                            'show')
                                                                          FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                              _model.countGameList = stackRoomRecord.selectedGameList.length;
                                                                              _model.questionStatus = 'notFound';
                                                                              while (_model.countGameList! > 0) {
                                                                                if (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedGameID == selectedGameIDItem.selectedGameID) {
                                                                                  _model.countQuestion = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedQuestionList?.length;
                                                                                  _model.selectedQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedQuestionList.toList().cast<SelectedQuestionListStruct>();
                                                                                  while (_model.countQuestion! > 0) {
                                                                                    if (_model.selectedQuestionList.elementAtOrNull((_model.countQuestion!) - 1)?.questionID == createTeamsTopicQuestionRecord?.questionID) {
                                                                                      _model.questionStatus = 'found';
                                                                                      _model.updateSelectedGameListAtIndex(
                                                                                        (_model.countGameList!) - 1,
                                                                                        (e) => e
                                                                                          ..updateSelectedQuestionList(
                                                                                            (e) => e[(_model.countQuestion!) - 1]..questionAnswerStatus = 'show',
                                                                                          ),
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
                                                                                      return;
                                                                                    }
                                                                                    _model.countQuestion = (_model.countQuestion!) - 1;
                                                                                  }
                                                                                }
                                                                                _model.countGameList = (_model.countGameList!) - 1;
                                                                              }
                                                                            },
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              '0efjodv4' /* View Answer */,
                                                                            ),
                                                                            options:
                                                                                FFButtonOptions(
                                                                              height: 45.0,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    font: GoogleFonts.almarai(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
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
                                                                        if (selectedGameIDItem.selectedQuestionList.where((e) => e.questionID == createTeamsTopicQuestionRecord?.questionID).toList().firstOrNull?.questionAnswerStatus ==
                                                                            'show')
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children:
                                                                                [
                                                                              Expanded(
                                                                                child: Builder(
                                                                                  builder: (context) {
                                                                                    final team = (stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.teamInfo?.toList() ?? []).take(3).toList();

                                                                                    return Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: List.generate(team.length, (teamIndex) {
                                                                                        final teamItem = team[teamIndex];
                                                                                        return Visibility(
                                                                                          visible: selectedGameIDItem.gameTieInfo.status == 'active' ? (selectedGameIDItem.presentTeamID == teamItem.teamID) : true,
                                                                                          child: Expanded(
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                var _shouldSetState = false;
                                                                                                if (_model.scoreProceedStatus == 'Yes') {
                                                                                                  _model.scoreProceedStatus = 'No';
                                                                                                } else {
                                                                                                  if (_shouldSetState) safeSetState(() {});
                                                                                                  return;
                                                                                                }

                                                                                                if (selectedGameIDItem.gameTieInfo.status == 'active') {
                                                                                                  _model.idmapResult = await queryIDmapRecordOnce(
                                                                                                    queryBuilder: (iDmapRecord) => iDmapRecord.where(
                                                                                                      'type',
                                                                                                      isEqualTo: 'Main',
                                                                                                    ),
                                                                                                    singleRecord: true,
                                                                                                  ).then((s) => s.firstOrNull);
                                                                                                  _shouldSetState = true;
                                                                                                  _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                                                  _model.countGameList = stackRoomRecord.selectedGameList.length;
                                                                                                  while (_model.countGameList! > 0) {
                                                                                                    if (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedGameID == selectedGameIDItem.selectedGameID) {
                                                                                                      _model.countQuestion = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedQuestionList?.length;
                                                                                                      _model.selectedQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedQuestionList.toList().cast<SelectedQuestionListStruct>();
                                                                                                      while (_model.countQuestion! > 0) {
                                                                                                        if (_model.selectedQuestionList.elementAtOrNull((_model.countQuestion!) - 1)?.questionID == createTeamsTopicQuestionRecord?.questionID) {
                                                                                                          _model.updateSelectedGameListAtIndex(
                                                                                                            (_model.countGameList!) - 1,
                                                                                                            (e) => e
                                                                                                              ..updateSelectedQuestionList(
                                                                                                                (e) => e[(_model.countQuestion!) - 1]
                                                                                                                  ..questionAnswerStatus = 'show'
                                                                                                                  ..updateResultInfo(
                                                                                                                    (e) => e
                                                                                                                      ..status = 'win'
                                                                                                                      ..teamID = teamItem.teamID
                                                                                                                      ..point = createTeamsTopicQuestionRecord?.questionPoint
                                                                                                                      ..createdAt = getCurrentTimestamp
                                                                                                                      ..teamInfo = teamItem.teamInfo,
                                                                                                                  ),
                                                                                                              )
                                                                                                              ..updateSelectedQuestionIDList(
                                                                                                                (e) => e.add(createTeamsTopicQuestionRecord!.questionID),
                                                                                                              ),
                                                                                                          );
                                                                                                          _model.tieQuestionCount = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.gameTieQuestionBreak?.length;
                                                                                                          _model.tieQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.gameTieQuestionBreak.toList().cast<GameTieQuestionBreakStruct>();
                                                                                                          while (_model.tieQuestionCount! > 0) {
                                                                                                            if (_model.tieQuestionList.elementAtOrNull((_model.tieQuestionCount!) - 1)?.tieQuestionID == _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.gameTieQuestionIDList?.lastOrNull) {
                                                                                                              _model.updateSelectedGameListAtIndex(
                                                                                                                (_model.countGameList!) - 1,
                                                                                                                (e) => e
                                                                                                                  ..updateGameTieQuestionBreak(
                                                                                                                    (e) => e[(_model.tieQuestionCount!) - 1]
                                                                                                                      ..updatedAt = getCurrentTimestamp
                                                                                                                      ..status = 'win'
                                                                                                                      ..teamID = teamItem.teamID,
                                                                                                                  ),
                                                                                                              );
                                                                                                              _model.tieQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.gameTieQuestionBreak.toList().cast<GameTieQuestionBreakStruct>();
                                                                                                              if ((functions.calculateTimeDifferenceInMinutes(_model.selectedGameList.elementAtOrNull(selectedGameIDItem.selectedGameIndex)!.gameTieBreakStartTime!, getCurrentTimestamp)! >= 1) || (selectedGameIDItem.gameTieQuestionBreak.where((e) => e.teamID == selectedGameIDItem.presentTeamID).toList().length == ((selectedGameIDItem.gameTieQuestionBreak.length / selectedGameIDItem.teamInfo.length).floor()))) {
                                                                                                                _model.updateSelectedGameListAtIndex(
                                                                                                                  (_model.countGameList!) - 1,
                                                                                                                  (e) => e
                                                                                                                    ..updateGameTieBreakCompletedTeamIDList(
                                                                                                                      (e) => e.add(selectedGameIDItem.presentTeamID),
                                                                                                                    ),
                                                                                                                );
                                                                                                                if ((selectedGameIDItem.gameTieBreakCompletedTeamIDList.contains(selectedGameIDItem.teamInfo
                                                                                                                            .elementAtOrNull(selectedGameIDItem.teamInfo.length == 2
                                                                                                                                ? (selectedGameIDItem.presentTeamIndex == 1 ? 0 : 1)
                                                                                                                                : () {
                                                                                                                                    if (selectedGameIDItem.presentTeamIndex == 0) {
                                                                                                                                      return 1;
                                                                                                                                    } else if (selectedGameIDItem.presentTeamIndex == 1) {
                                                                                                                                      return 2;
                                                                                                                                    } else {
                                                                                                                                      return 0;
                                                                                                                                    }
                                                                                                                                  }())
                                                                                                                            ?.teamID) ==
                                                                                                                        true) &&
                                                                                                                    (selectedGameIDItem.teamInfo.length == 2 ? (selectedGameIDItem.gameTieBreakCompletedTeamIDList.length == 2) : (selectedGameIDItem.gameTieBreakCompletedTeamIDList.length == 3))) {
                                                                                                                  _model.countTeam = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length;
                                                                                                                  _model.selectedTeamList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.toList().cast<TeamInfoStruct>();
                                                                                                                  while (_model.countTeam! > 0) {
                                                                                                                    _model.pointWin = _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)!.totalResult + ((selectedGameIDItem.gameTieQuestionBreak.where((e) => (e.teamID == _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)?.teamID) && (e.status == 'win')).toList().length - selectedGameIDItem.gameTieQuestionBreak.where((e) => (e.teamID == _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)?.teamID) && (e.status == 'none')).toList().length) * 100);
                                                                                                                    _model.updateSelectedGameListAtIndex(
                                                                                                                      (_model.countGameList!) - 1,
                                                                                                                      (e) => e
                                                                                                                        ..updateTeamInfo(
                                                                                                                          (e) => e[(_model.countTeam!) - 1]..totalResult = _model.pointWin,
                                                                                                                        ),
                                                                                                                    );
                                                                                                                    _model.countTeam = (_model.countTeam!) - 1;
                                                                                                                  }
                                                                                                                } else {
                                                                                                                  _model.updateSelectedGameListAtIndex(
                                                                                                                    (_model.countGameList!) - 1,
                                                                                                                    (e) => e
                                                                                                                      ..presentTeamIndex = selectedGameIDItem.teamInfo.length == 2
                                                                                                                          ? (selectedGameIDItem.presentTeamIndex == 1 ? 0 : 1)
                                                                                                                          : () {
                                                                                                                              if (selectedGameIDItem.presentTeamIndex == 0) {
                                                                                                                                return 1;
                                                                                                                              } else if (selectedGameIDItem.presentTeamIndex == 1) {
                                                                                                                                return 2;
                                                                                                                              } else {
                                                                                                                                return 0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                  );
                                                                                                                  _model.updateSelectedGameListAtIndex(
                                                                                                                    (_model.countGameList!) - 1,
                                                                                                                    (e) => e..presentTeamID = selectedGameIDItem.teamInfo.elementAtOrNull(_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.presentTeamIndex)?.teamID,
                                                                                                                  );
                                                                                                                  _model.updateSelectedGameListAtIndex(
                                                                                                                    (_model.countGameList!) - 1,
                                                                                                                    (e) => e
                                                                                                                      ..updateGameTieQuestionIDList(
                                                                                                                        (e) => e.add(_model.tieQuestionList.where((e) => e.status == 'active').toList().sortedList(keyOf: (e) => e.roundID, desc: false).firstOrNull!.tieQuestionID),
                                                                                                                      )
                                                                                                                      ..updateSelectedQuestionList(
                                                                                                                        (e) => e.add(SelectedQuestionListStruct(
                                                                                                                          questionID: _model.tieQuestionList.where((e) => e.status == 'active').toList().sortedList(keyOf: (e) => e.roundID, desc: false).firstOrNull?.tieQuestionID,
                                                                                                                          questionAnswerStatus: 'hide',
                                                                                                                        )),
                                                                                                                      )
                                                                                                                      ..gameTieBreakStatus = 'SetWaitStart'
                                                                                                                      ..gameTieBreakStartTime = null,
                                                                                                                  );

                                                                                                                  await widget!.room!.update({
                                                                                                                    ...createRoomRecordData(
                                                                                                                      roomUpdatedAt: getCurrentTimestamp,
                                                                                                                    ),
                                                                                                                    ...mapToFirestore(
                                                                                                                      {
                                                                                                                        'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                                          _model.selectedGameList,
                                                                                                                        ),
                                                                                                                        'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                                          createTeamsTopicQuestionRecord?.questionID
                                                                                                                        ]),
                                                                                                                      },
                                                                                                                    ),
                                                                                                                  });
                                                                                                                  _model.scoreProceedStatus = 'Yes';
                                                                                                                  _model.countQuestion = (_model.countGameList!) + 1;
                                                                                                                  safeSetState(() {});
                                                                                                                  if (_shouldSetState) safeSetState(() {});
                                                                                                                  return;
                                                                                                                }
                                                                                                              } else {
                                                                                                                _model.updateSelectedGameListAtIndex(
                                                                                                                  (_model.countGameList!) - 1,
                                                                                                                  (e) => e
                                                                                                                    ..updateGameTieQuestionIDList(
                                                                                                                      (e) => e.add(_model.tieQuestionList.where((e) => e.status == 'active').toList().sortedList(keyOf: (e) => e.roundID, desc: false).firstOrNull!.tieQuestionID),
                                                                                                                    )
                                                                                                                    ..updateSelectedQuestionList(
                                                                                                                      (e) => e.add(SelectedQuestionListStruct(
                                                                                                                        questionID: _model.tieQuestionList.where((e) => e.status == 'active').toList().sortedList(keyOf: (e) => e.roundID, desc: false).firstOrNull?.tieQuestionID,
                                                                                                                        questionAnswerStatus: 'hide',
                                                                                                                      )),
                                                                                                                    ),
                                                                                                                );

                                                                                                                await widget!.room!.update({
                                                                                                                  ...createRoomRecordData(
                                                                                                                    roomUpdatedAt: getCurrentTimestamp,
                                                                                                                  ),
                                                                                                                  ...mapToFirestore(
                                                                                                                    {
                                                                                                                      'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                                        _model.selectedGameList,
                                                                                                                      ),
                                                                                                                      'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                                        createTeamsTopicQuestionRecord?.questionID
                                                                                                                      ]),
                                                                                                                    },
                                                                                                                  ),
                                                                                                                });
                                                                                                                _model.scoreProceedStatus = 'Yes';
                                                                                                                _model.countQuestion = (_model.countGameList!) + 1;
                                                                                                                safeSetState(() {});
                                                                                                                if (_shouldSetState) safeSetState(() {});
                                                                                                                return;
                                                                                                              }
                                                                                                            }
                                                                                                            _model.tieQuestionCount = (_model.tieQuestionCount!) - 1;
                                                                                                          }
                                                                                                          break;
                                                                                                        }
                                                                                                        _model.countQuestion = (_model.countQuestion!) - 1;
                                                                                                      }
                                                                                                      break;
                                                                                                    }
                                                                                                    _model.countGameList = (_model.countGameList!) - 1;
                                                                                                  }
                                                                                                  if (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length == 2 ? (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.totalResult == _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.totalResult) : ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.totalResult == _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.totalResult) || (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.totalResult == (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.elementAtOrNull(1))?.totalResult) || ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.elementAtOrNull(1))?.totalResult == _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.totalResult))) {
                                                                                                    _model.tieQuestionCount = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.gameTieQuestionBreak?.length;
                                                                                                    _model.tieQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.gameTieQuestionBreak.toList().cast<GameTieQuestionBreakStruct>();
                                                                                                    while (_model.tieQuestionCount! > 0) {
                                                                                                      _model.selectedQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedQuestionList.toList().cast<SelectedQuestionListStruct>();
                                                                                                      _model.countQuestion = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedQuestionList?.length;
                                                                                                      while (_model.countQuestion! > 0) {
                                                                                                        if (_model.selectedQuestionList.elementAtOrNull((_model.countQuestion!) - 1)?.questionID == _model.tieQuestionList.elementAtOrNull((_model.tieQuestionCount!) - 1)?.tieQuestionID) {
                                                                                                          _model.updateSelectedGameListAtIndex(
                                                                                                            (_model.countGameList!) - 1,
                                                                                                            (e) => e
                                                                                                              ..updateSelectedQuestionList(
                                                                                                                (e) => e.removeAt((_model.countQuestion!) - 1),
                                                                                                              )
                                                                                                              ..updateSelectedQuestionIDList(
                                                                                                                (e) => e.remove(_model.selectedQuestionList.elementAtOrNull((_model.countQuestion!) - 1)?.questionID),
                                                                                                              ),
                                                                                                          );
                                                                                                        }
                                                                                                        _model.countQuestion = (_model.countQuestion!) - 1;
                                                                                                      }
                                                                                                      _model.tieQuestionCount = (_model.tieQuestionCount!) - 1;
                                                                                                    }
                                                                                                    _model.updateSelectedGameListAtIndex(
                                                                                                      (_model.countGameList!) - 1,
                                                                                                      (e) => e
                                                                                                        ..gameTieInfo = null
                                                                                                        ..presentTeamID = null
                                                                                                        ..presentTeamIndex = null
                                                                                                        ..updateGameResult(
                                                                                                          (e) => e..status = 'tie',
                                                                                                        )
                                                                                                        ..gameTieTopicIDList = []
                                                                                                        ..gameTieQuestionBreak = []
                                                                                                        ..gameTieQuestionIDList = []
                                                                                                        ..gameTieBreakStatus = null
                                                                                                        ..gameTieBreakStartTime = null
                                                                                                        ..gameTieBreakCompletedTeamIDList = [],
                                                                                                    );

                                                                                                    await widget!.room!.update({
                                                                                                      ...createRoomRecordData(
                                                                                                        roomUpdatedAt: getCurrentTimestamp,
                                                                                                      ),
                                                                                                      ...mapToFirestore(
                                                                                                        {
                                                                                                          'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                            _model.selectedGameList,
                                                                                                          ),
                                                                                                          'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                            createTeamsTopicQuestionRecord?.questionID
                                                                                                          ]),
                                                                                                        },
                                                                                                      ),
                                                                                                    });
                                                                                                    _model.scoreProceedStatus = 'Yes';
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
                                                                                                    _model.updateSelectedGameListAtIndex(
                                                                                                      (_model.countGameList!) - 1,
                                                                                                      (e) => e
                                                                                                        ..gameEndTime = getCurrentTimestamp
                                                                                                        ..gameResult = ResultInfoStruct(
                                                                                                          status: 'win',
                                                                                                          createdAt: getCurrentTimestamp,
                                                                                                          teamID: _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length == 2
                                                                                                              ? (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult ? _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.teamID : _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.teamID)
                                                                                                              : () {
                                                                                                                  if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                                    return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.teamID;
                                                                                                                  } else if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                                    return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.teamID;
                                                                                                                  } else {
                                                                                                                    return (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.elementAtOrNull(1))?.teamID;
                                                                                                                  }
                                                                                                                }(),
                                                                                                          teamInfo: _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length == 2
                                                                                                              ? (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult ? _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.teamInfo : _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.teamInfo)
                                                                                                              : () {
                                                                                                                  if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                                    return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.teamInfo;
                                                                                                                  } else if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                                    return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.teamInfo;
                                                                                                                  } else {
                                                                                                                    return (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.elementAtOrNull(1))?.teamInfo;
                                                                                                                  }
                                                                                                                }(),
                                                                                                          point: _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length == 2
                                                                                                              ? (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult ? _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.totalResult : _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.totalResult)
                                                                                                              : () {
                                                                                                                  if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                                    return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.totalResult;
                                                                                                                  } else if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                                    return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.totalResult;
                                                                                                                  } else {
                                                                                                                    return (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.elementAtOrNull(1))?.totalResult;
                                                                                                                  }
                                                                                                                }(),
                                                                                                        ),
                                                                                                    );
                                                                                                    _model.countUser = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedGameUserList?.length;
                                                                                                    _model.selectedUserList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedGameUserList.toList().cast<RoomUserListStruct>();
                                                                                                    _model.tieQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.gameTieQuestionBreak.toList().cast<GameTieQuestionBreakStruct>();
                                                                                                    _model.countUser = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedGameUserList?.length;
                                                                                                    _model.selectedUserList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedGameUserList.toList().cast<RoomUserListStruct>();
                                                                                                    while (_model.countUser! > 0) {
                                                                                                      if (_model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserStatus == 'active') {
                                                                                                        await GameHistoryRecord.collection.doc().set(createGameHistoryRecordData(
                                                                                                              createdAt: getCurrentTimestamp,
                                                                                                              updatedAt: getCurrentTimestamp,
                                                                                                              gameHistoryID: _model.idmapResult?.historyId,
                                                                                                              gameId: columnGameRecord?.gameID,
                                                                                                              userId: _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserId?.toString(),
                                                                                                              userRef: _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef,
                                                                                                              roomId: stackRoomRecord.roomID,
                                                                                                              resultInfo: updateResultInfoStruct(
                                                                                                                ResultInfoStruct(
                                                                                                                  status: 'win',
                                                                                                                  createdAt: getCurrentTimestamp,
                                                                                                                ),
                                                                                                                clearUnsetFields: false,
                                                                                                                create: true,
                                                                                                              ),
                                                                                                            ));

                                                                                                        await _model.idmapResult!.reference.update({
                                                                                                          ...mapToFirestore(
                                                                                                            {
                                                                                                              'history_id': FieldValue.increment(1),
                                                                                                            },
                                                                                                          ),
                                                                                                        });
                                                                                                      }
                                                                                                      _model.countUser = (_model.countUser!) - 1;
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
                                                                                                          'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                            createTeamsTopicQuestionRecord?.questionID
                                                                                                          ]),
                                                                                                        },
                                                                                                      ),
                                                                                                    });
                                                                                                    _model.scoreProceedStatus = 'Yes';
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

                                                                                                    if (_shouldSetState) safeSetState(() {});
                                                                                                    return;
                                                                                                  }
                                                                                                } else {
                                                                                                  _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                                                  _model.countGameList = stackRoomRecord.selectedGameList.length;
                                                                                                  while (_model.countGameList! > 0) {
                                                                                                    if (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedGameID == selectedGameIDItem.selectedGameID) {
                                                                                                      _model.countQuestion = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedQuestionList?.length;
                                                                                                      _model.selectedQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedQuestionList.toList().cast<SelectedQuestionListStruct>();
                                                                                                      while (_model.countQuestion! > 0) {
                                                                                                        if (_model.selectedQuestionList.elementAtOrNull((_model.countQuestion!) - 1)?.questionID == createTeamsTopicQuestionRecord?.questionID) {
                                                                                                          _model.updateSelectedGameListAtIndex(
                                                                                                            (_model.countGameList!) - 1,
                                                                                                            (e) => e
                                                                                                              ..updateSelectedQuestionList(
                                                                                                                (e) => e[(_model.countQuestion!) - 1]
                                                                                                                  ..questionAnswerStatus = 'show'
                                                                                                                  ..updateResultInfo(
                                                                                                                    (e) => e
                                                                                                                      ..status = 'win'
                                                                                                                      ..teamID = teamItem.teamID
                                                                                                                      ..point = createTeamsTopicQuestionRecord?.questionPoint
                                                                                                                      ..createdAt = getCurrentTimestamp
                                                                                                                      ..teamInfo = teamItem.teamInfo,
                                                                                                                  ),
                                                                                                              )
                                                                                                              ..updateSelectedQuestionIDList(
                                                                                                                (e) => e.add(createTeamsTopicQuestionRecord!.questionID),
                                                                                                              ),
                                                                                                          );
                                                                                                          _model.selectedTeamList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.toList().cast<TeamInfoStruct>();
                                                                                                          _model.countTeam = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length;
                                                                                                          while (_model.countTeam! > 0) {
                                                                                                            if (_model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)?.teamID == teamItem.teamID) {
                                                                                                              _model.pointWin = selectedGameIDItem.teamInfo.elementAtOrNull((_model.countTeam!) - 1)!.totalResult + createTeamsTopicQuestionRecord!.questionPoint;
                                                                                                              _model.updateSelectedGameListAtIndex(
                                                                                                                (_model.countGameList!) - 1,
                                                                                                                (e) => e
                                                                                                                  ..presentTeamIndex = selectedGameIDItem.teamInfo.length == 2
                                                                                                                      ? (selectedGameIDItem.presentTeamIndex == 1 ? 0 : 1)
                                                                                                                      : () {
                                                                                                                          if (selectedGameIDItem.presentTeamIndex == 0) {
                                                                                                                            return 1;
                                                                                                                          } else if (selectedGameIDItem.presentTeamIndex == 1) {
                                                                                                                            return 2;
                                                                                                                          } else {
                                                                                                                            return 0;
                                                                                                                          }
                                                                                                                        }(),
                                                                                                              );
                                                                                                              _model.updateSelectedGameListAtIndex(
                                                                                                                (_model.countGameList!) - 1,
                                                                                                                (e) => e
                                                                                                                  ..updateTeamInfo(
                                                                                                                    (e) => e[(_model.countTeam!) - 1]..totalResult = _model.pointWin,
                                                                                                                  )
                                                                                                                  ..presentTeamID = selectedGameIDItem.teamInfo.elementAtOrNull(_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.presentTeamIndex)?.teamID,
                                                                                                              );
                                                                                                              _model.teamStatus = 'found';

                                                                                                              await widget!.room!.update({
                                                                                                                ...mapToFirestore(
                                                                                                                  {
                                                                                                                    'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                                      _model.selectedGameList,
                                                                                                                    ),
                                                                                                                    'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                                      createTeamsTopicQuestionRecord?.questionID
                                                                                                                    ]),
                                                                                                                  },
                                                                                                                ),
                                                                                                              });

                                                                                                              context.goNamed(
                                                                                                                GameOneS1Widget.routeName,
                                                                                                                queryParameters: {
                                                                                                                  'room': serializeParam(
                                                                                                                    widget!.room,
                                                                                                                    ParamType.DocumentReference,
                                                                                                                  ),
                                                                                                                }.withoutNulls,
                                                                                                              );

                                                                                                              if (_shouldSetState) safeSetState(() {});
                                                                                                              return;
                                                                                                            }
                                                                                                            _model.countTeam = (_model.countTeam!) - 1;
                                                                                                          }
                                                                                                        }
                                                                                                        _model.countQuestion = (_model.countQuestion!) - 1;
                                                                                                      }
                                                                                                      break;
                                                                                                    }
                                                                                                    _model.countGameList = (_model.countGameList!) - 1;
                                                                                                  }
                                                                                                }

                                                                                                if (_shouldSetState) safeSetState(() {});
                                                                                              },
                                                                                              child: Container(
                                                                                                height: 45.0,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: () {
                                                                                                    if (selectedGameIDItem.gameTieInfo.status == 'active') {
                                                                                                      return FlutterFlowTheme.of(context).tertiary;
                                                                                                    } else if (selectedGameIDItem.teamInfo.where((e) => e.teamID == 999).toList().length > 0) {
                                                                                                      return (teamItem.teamID == 999 ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).tertiary);
                                                                                                    } else {
                                                                                                      return () {
                                                                                                        if (teamIndex == 0) {
                                                                                                          return (selectedGameIDItem.presentTeamID == teamItem.teamID ? FlutterFlowTheme.of(context).primary : Color(0x7FEC4D41));
                                                                                                        } else if (teamIndex == 1) {
                                                                                                          return (selectedGameIDItem.presentTeamID == teamItem.teamID ? FlutterFlowTheme.of(context).secondary : Color(0x7F3696D0));
                                                                                                        } else {
                                                                                                          return (selectedGameIDItem.presentTeamID == teamItem.teamID ? FlutterFlowTheme.of(context).tertiary : Color(0x8067B5B0));
                                                                                                        }
                                                                                                      }();
                                                                                                    }
                                                                                                  }(),
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                  border: Border.all(
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    width: 0.5,
                                                                                                  ),
                                                                                                ),
                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                                                                  child: Text(
                                                                                                    () {
                                                                                                      if (selectedGameIDItem.gameTieInfo.status == 'active') {
                                                                                                        return FFLocalizations.of(context).getVariableText(
                                                                                                          enText: 'Right Answer',
                                                                                                          arText: 'الإجابة الصحيحة',
                                                                                                        );
                                                                                                      } else if (selectedGameIDItem.teamInfo.where((e) => e.teamID == 999).toList().length == 1) {
                                                                                                        return (teamItem.teamID == 999
                                                                                                            ? FFLocalizations.of(context).getVariableText(
                                                                                                                enText: 'Wrong Answer',
                                                                                                                arText: 'إجابة خاطئة',
                                                                                                              )
                                                                                                            : FFLocalizations.of(context).getVariableText(
                                                                                                                enText: 'Right Answer',
                                                                                                                arText: 'الإجابة الصحيحة',
                                                                                                              ));
                                                                                                      } else {
                                                                                                        return '${teamItem.teamInfo.name}';
                                                                                                      }
                                                                                                    }()
                                                                                                        .maybeHandleOverflow(
                                                                                                      maxChars: 15,
                                                                                                      replacement: '…',
                                                                                                    ),
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.almarai(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      }).divide(
                                                                                        SizedBox(width: 16.0),
                                                                                        filterFn: (teamIndex) {
                                                                                          final teamItem = team[teamIndex];
                                                                                          return selectedGameIDItem.gameTieInfo.status == 'active' ? (selectedGameIDItem.presentTeamID == teamItem.teamID) : true;
                                                                                        },
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              if ((selectedGameIDItem.teamInfo.where((e) => e.teamID == 999).toList().length == 0) || (selectedGameIDItem.gameTieInfo.status == 'active') ? true : false)
                                                                                FFButtonWidget(
                                                                                  onPressed: () async {
                                                                                    var _shouldSetState = false;
                                                                                    if (_model.scoreProceedStatus == 'Yes') {
                                                                                      _model.scoreProceedStatus = 'No';
                                                                                    } else {
                                                                                      if (_shouldSetState) safeSetState(() {});
                                                                                      return;
                                                                                    }

                                                                                    if (currentUserDocument?.userSetting?.isSoundstatus == true) {
                                                                                      _model.soundPlayer ??= AudioPlayer();
                                                                                      if (_model.soundPlayer!.playing) {
                                                                                        await _model.soundPlayer!.stop();
                                                                                      }
                                                                                      _model.soundPlayer!.setVolume(0.2);
                                                                                      _model.soundPlayer!.setAsset('assets/audios/Wrong_Answer___Failed.mp3').then((_) => _model.soundPlayer!.play());
                                                                                    }
                                                                                    if (selectedGameIDItem.gameTieInfo.status == 'active') {
                                                                                      _model.idmapResultNone = await queryIDmapRecordOnce(
                                                                                        queryBuilder: (iDmapRecord) => iDmapRecord.where(
                                                                                          'type',
                                                                                          isEqualTo: 'Main',
                                                                                        ),
                                                                                        singleRecord: true,
                                                                                      ).then((s) => s.firstOrNull);
                                                                                      _shouldSetState = true;
                                                                                      _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                                      _model.countGameList = stackRoomRecord.selectedGameList.length;
                                                                                      while (_model.countGameList! > 0) {
                                                                                        if (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedGameID == selectedGameIDItem.selectedGameID) {
                                                                                          _model.countQuestion = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedQuestionList?.length;
                                                                                          _model.selectedQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedQuestionList.toList().cast<SelectedQuestionListStruct>();
                                                                                          while (_model.countQuestion! > 0) {
                                                                                            if (_model.selectedQuestionList.elementAtOrNull((_model.countQuestion!) - 1)?.questionID == createTeamsTopicQuestionRecord?.questionID) {
                                                                                              _model.updateSelectedGameListAtIndex(
                                                                                                (_model.countGameList!) - 1,
                                                                                                (e) => e
                                                                                                  ..updateSelectedQuestionList(
                                                                                                    (e) => e[(_model.countQuestion!) - 1]
                                                                                                      ..questionAnswerStatus = 'show'
                                                                                                      ..updateResultInfo(
                                                                                                        (e) => e
                                                                                                          ..status = 'none'
                                                                                                          ..point = createTeamsTopicQuestionRecord?.questionPoint
                                                                                                          ..createdAt = getCurrentTimestamp,
                                                                                                      ),
                                                                                                  )
                                                                                                  ..updateSelectedQuestionIDList(
                                                                                                    (e) => e.add(createTeamsTopicQuestionRecord!.questionID),
                                                                                                  ),
                                                                                              );
                                                                                              _model.tieQuestionCount = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.gameTieQuestionBreak?.length;
                                                                                              _model.tieQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.gameTieQuestionBreak.toList().cast<GameTieQuestionBreakStruct>();
                                                                                              while (_model.tieQuestionCount! > 0) {
                                                                                                if (_model.tieQuestionList.elementAtOrNull((_model.tieQuestionCount!) - 1)?.tieQuestionID == _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.gameTieQuestionIDList?.lastOrNull) {
                                                                                                  _model.updateSelectedGameListAtIndex(
                                                                                                    (_model.countGameList!) - 1,
                                                                                                    (e) => e
                                                                                                      ..updateGameTieQuestionBreak(
                                                                                                        (e) => e[(_model.tieQuestionCount!) - 1]
                                                                                                          ..updatedAt = getCurrentTimestamp
                                                                                                          ..status = 'none'
                                                                                                          ..teamID = selectedGameIDItem.presentTeamID,
                                                                                                      ),
                                                                                                  );
                                                                                                  _model.tieQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.gameTieQuestionBreak.toList().cast<GameTieQuestionBreakStruct>();
                                                                                                  if ((functions.calculateTimeDifferenceInMinutes(_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.gameTieBreakStartTime!, getCurrentTimestamp)! >= 1) || (selectedGameIDItem.gameTieQuestionBreak.where((e) => e.teamID == selectedGameIDItem.presentTeamID).toList().length == ((selectedGameIDItem.gameTieQuestionBreak.length / selectedGameIDItem.teamInfo.length).floor()))) {
                                                                                                    _model.updateSelectedGameListAtIndex(
                                                                                                      (_model.countGameList!) - 1,
                                                                                                      (e) => e
                                                                                                        ..updateGameTieBreakCompletedTeamIDList(
                                                                                                          (e) => e.add(selectedGameIDItem.presentTeamID),
                                                                                                        ),
                                                                                                    );
                                                                                                    if ((selectedGameIDItem.gameTieBreakCompletedTeamIDList.contains(selectedGameIDItem.teamInfo
                                                                                                                .elementAtOrNull(selectedGameIDItem.teamInfo.length == 2
                                                                                                                    ? (selectedGameIDItem.presentTeamIndex == 1 ? 0 : 1)
                                                                                                                    : () {
                                                                                                                        if (selectedGameIDItem.presentTeamIndex == 0) {
                                                                                                                          return 1;
                                                                                                                        } else if (selectedGameIDItem.presentTeamIndex == 1) {
                                                                                                                          return 2;
                                                                                                                        } else {
                                                                                                                          return 0;
                                                                                                                        }
                                                                                                                      }())
                                                                                                                ?.teamID) ==
                                                                                                            true) &&
                                                                                                        (selectedGameIDItem.teamInfo.length == 2 ? (selectedGameIDItem.gameTieBreakCompletedTeamIDList.length == 2) : (selectedGameIDItem.gameTieBreakCompletedTeamIDList.length == 3))) {
                                                                                                      _model.countTeam = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length;
                                                                                                      _model.selectedTeamList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.toList().cast<TeamInfoStruct>();
                                                                                                      while (_model.countTeam! > 0) {
                                                                                                        _model.pointWin = _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)!.totalResult + ((selectedGameIDItem.gameTieQuestionBreak.where((e) => (e.teamID == _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)?.teamID) && (e.status == 'win')).toList().length - selectedGameIDItem.gameTieQuestionBreak.where((e) => (e.teamID == _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)?.teamID) && (e.status == 'none')).toList().length) * 100);
                                                                                                        _model.updateSelectedGameListAtIndex(
                                                                                                          (_model.countGameList!) - 1,
                                                                                                          (e) => e
                                                                                                            ..updateTeamInfo(
                                                                                                              (e) => e[(_model.countTeam!) - 1]..totalResult = _model.pointWin,
                                                                                                            ),
                                                                                                        );
                                                                                                        _model.countTeam = (_model.countTeam!) - 1;
                                                                                                      }
                                                                                                    } else {
                                                                                                      _model.updateSelectedGameListAtIndex(
                                                                                                        (_model.countGameList!) - 1,
                                                                                                        (e) => e
                                                                                                          ..presentTeamIndex = selectedGameIDItem.teamInfo.length == 2
                                                                                                              ? (selectedGameIDItem.presentTeamIndex == 1 ? 0 : 1)
                                                                                                              : () {
                                                                                                                  if (selectedGameIDItem.presentTeamIndex == 0) {
                                                                                                                    return 1;
                                                                                                                  } else if (selectedGameIDItem.presentTeamIndex == 1) {
                                                                                                                    return 2;
                                                                                                                  } else {
                                                                                                                    return 0;
                                                                                                                  }
                                                                                                                }(),
                                                                                                      );
                                                                                                      _model.updateSelectedGameListAtIndex(
                                                                                                        (_model.countGameList!) - 1,
                                                                                                        (e) => e..presentTeamID = selectedGameIDItem.teamInfo.elementAtOrNull(_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.presentTeamIndex)?.teamID,
                                                                                                      );
                                                                                                      _model.updateSelectedGameListAtIndex(
                                                                                                        (_model.countGameList!) - 1,
                                                                                                        (e) => e
                                                                                                          ..updateGameTieQuestionIDList(
                                                                                                            (e) => e.add(_model.tieQuestionList.where((e) => e.status == 'active').toList().sortedList(keyOf: (e) => e.roundID, desc: false).firstOrNull!.tieQuestionID),
                                                                                                          )
                                                                                                          ..updateSelectedQuestionList(
                                                                                                            (e) => e.add(SelectedQuestionListStruct(
                                                                                                              questionID: _model.tieQuestionList.where((e) => e.status == 'active').toList().sortedList(keyOf: (e) => e.roundID, desc: false).firstOrNull?.tieQuestionID,
                                                                                                              questionAnswerStatus: 'hide',
                                                                                                            )),
                                                                                                          )
                                                                                                          ..gameTieBreakStatus = 'SetWaitStart'
                                                                                                          ..gameTieBreakStartTime = null,
                                                                                                      );

                                                                                                      await widget!.room!.update({
                                                                                                        ...createRoomRecordData(
                                                                                                          roomUpdatedAt: getCurrentTimestamp,
                                                                                                        ),
                                                                                                        ...mapToFirestore(
                                                                                                          {
                                                                                                            'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                              _model.selectedGameList,
                                                                                                            ),
                                                                                                            'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                              createTeamsTopicQuestionRecord?.questionID
                                                                                                            ]),
                                                                                                          },
                                                                                                        ),
                                                                                                      });
                                                                                                      _model.scoreProceedStatus = 'Yes';
                                                                                                      _model.countQuestion = (_model.countGameList!) + 1;
                                                                                                      safeSetState(() {});
                                                                                                      if (_shouldSetState) safeSetState(() {});
                                                                                                      return;
                                                                                                    }
                                                                                                  } else {
                                                                                                    _model.updateSelectedGameListAtIndex(
                                                                                                      (_model.countGameList!) - 1,
                                                                                                      (e) => e
                                                                                                        ..updateGameTieQuestionIDList(
                                                                                                          (e) => e.add(_model.tieQuestionList.where((e) => e.status == 'active').toList().sortedList(keyOf: (e) => e.roundID, desc: false).firstOrNull!.tieQuestionID),
                                                                                                        )
                                                                                                        ..updateSelectedQuestionList(
                                                                                                          (e) => e.add(SelectedQuestionListStruct(
                                                                                                            questionID: _model.tieQuestionList.where((e) => e.status == 'active').toList().sortedList(keyOf: (e) => e.roundID, desc: false).firstOrNull?.tieQuestionID,
                                                                                                            questionAnswerStatus: 'hide',
                                                                                                          )),
                                                                                                        ),
                                                                                                    );

                                                                                                    await widget!.room!.update({
                                                                                                      ...createRoomRecordData(
                                                                                                        roomUpdatedAt: getCurrentTimestamp,
                                                                                                      ),
                                                                                                      ...mapToFirestore(
                                                                                                        {
                                                                                                          'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                            _model.selectedGameList,
                                                                                                          ),
                                                                                                          'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                            createTeamsTopicQuestionRecord?.questionID
                                                                                                          ]),
                                                                                                        },
                                                                                                      ),
                                                                                                    });
                                                                                                    _model.scoreProceedStatus = 'Yes';
                                                                                                    _model.countQuestion = (_model.countGameList!) + 1;
                                                                                                    safeSetState(() {});
                                                                                                    if (_shouldSetState) safeSetState(() {});
                                                                                                    return;
                                                                                                  }
                                                                                                }
                                                                                                _model.tieQuestionCount = (_model.tieQuestionCount!) - 1;
                                                                                              }
                                                                                              break;
                                                                                            }
                                                                                            _model.countQuestion = (_model.countQuestion!) - 1;
                                                                                          }
                                                                                          break;
                                                                                        }
                                                                                        _model.countGameList = (_model.countGameList!) - 1;
                                                                                      }
                                                                                      if (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length == 2 ? (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.totalResult == _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.totalResult) : ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.totalResult == _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.totalResult) || (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.totalResult == (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.elementAtOrNull(1))?.totalResult) || ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.elementAtOrNull(1))?.totalResult == _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.totalResult))) {
                                                                                        _model.tieQuestionCount = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.gameTieQuestionBreak?.length;
                                                                                        _model.tieQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.gameTieQuestionBreak.toList().cast<GameTieQuestionBreakStruct>();
                                                                                        while (_model.tieQuestionCount! > 0) {
                                                                                          _model.selectedQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedQuestionList.toList().cast<SelectedQuestionListStruct>();
                                                                                          _model.countQuestion = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedQuestionList?.length;
                                                                                          while (_model.countQuestion! > 0) {
                                                                                            if (_model.selectedQuestionList.elementAtOrNull((_model.countQuestion!) - 1)?.questionID == _model.tieQuestionList.elementAtOrNull((_model.tieQuestionCount!) - 1)?.tieQuestionID) {
                                                                                              _model.updateSelectedGameListAtIndex(
                                                                                                (_model.countGameList!) - 1,
                                                                                                (e) => e
                                                                                                  ..updateSelectedQuestionList(
                                                                                                    (e) => e.removeAt((_model.countQuestion!) - 1),
                                                                                                  )
                                                                                                  ..updateSelectedQuestionIDList(
                                                                                                    (e) => e.remove(_model.selectedQuestionList.elementAtOrNull((_model.countQuestion!) - 1)?.questionID),
                                                                                                  ),
                                                                                              );
                                                                                            }
                                                                                            _model.countQuestion = (_model.countQuestion!) - 1;
                                                                                          }
                                                                                          _model.tieQuestionCount = (_model.tieQuestionCount!) - 1;
                                                                                        }
                                                                                        _model.updateSelectedGameListAtIndex(
                                                                                          (_model.countGameList!) - 1,
                                                                                          (e) => e
                                                                                            ..gameTieInfo = null
                                                                                            ..presentTeamID = null
                                                                                            ..presentTeamIndex = null
                                                                                            ..updateGameResult(
                                                                                              (e) => e..status = 'tie',
                                                                                            )
                                                                                            ..gameTieTopicIDList = []
                                                                                            ..gameTieQuestionBreak = []
                                                                                            ..gameTieQuestionIDList = []
                                                                                            ..gameTieBreakStatus = null
                                                                                            ..gameTieBreakStartTime = null
                                                                                            ..gameTieBreakCompletedTeamIDList = [],
                                                                                        );

                                                                                        await widget!.room!.update({
                                                                                          ...createRoomRecordData(
                                                                                            roomUpdatedAt: getCurrentTimestamp,
                                                                                          ),
                                                                                          ...mapToFirestore(
                                                                                            {
                                                                                              'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                _model.selectedGameList,
                                                                                              ),
                                                                                              'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                createTeamsTopicQuestionRecord?.questionID
                                                                                              ]),
                                                                                            },
                                                                                          ),
                                                                                        });
                                                                                        _model.scoreProceedStatus = 'Yes';
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
                                                                                        _model.updateSelectedGameListAtIndex(
                                                                                          (_model.countGameList!) - 1,
                                                                                          (e) => e
                                                                                            ..gameEndTime = getCurrentTimestamp
                                                                                            ..gameResult = ResultInfoStruct(
                                                                                              status: 'win',
                                                                                              createdAt: getCurrentTimestamp,
                                                                                              teamID: _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length == 2
                                                                                                  ? (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult ? _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.teamID : _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.teamID)
                                                                                                  : () {
                                                                                                      if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                        return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.teamID;
                                                                                                      } else if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                        return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.teamID;
                                                                                                      } else {
                                                                                                        return (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.elementAtOrNull(1))?.teamID;
                                                                                                      }
                                                                                                    }(),
                                                                                              teamInfo: _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length == 2
                                                                                                  ? (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult ? _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.teamInfo : _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.teamInfo)
                                                                                                  : () {
                                                                                                      if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                        return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.teamInfo;
                                                                                                      } else if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                        return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.teamInfo;
                                                                                                      } else {
                                                                                                        return (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.elementAtOrNull(1))?.teamInfo;
                                                                                                      }
                                                                                                    }(),
                                                                                              point: _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length == 2
                                                                                                  ? (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult ? _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.totalResult : _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.totalResult)
                                                                                                  : () {
                                                                                                      if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                        return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.firstOrNull?.totalResult;
                                                                                                      } else if ((_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.firstOrNull!.totalResult) && (_model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.lastOrNull!.totalResult > _model.selectedGameList.elementAtOrNull((_model.countTeam!) - 1)!.teamInfo.elementAtOrNull(1)!.totalResult)) {
                                                                                                        return _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.lastOrNull?.totalResult;
                                                                                                      } else {
                                                                                                        return (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.elementAtOrNull(1))?.totalResult;
                                                                                                      }
                                                                                                    }(),
                                                                                            ),
                                                                                        );
                                                                                        _model.countUser = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedGameUserList?.length;
                                                                                        _model.selectedUserList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedGameUserList.toList().cast<RoomUserListStruct>();
                                                                                        _model.tieQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.gameTieQuestionBreak.toList().cast<GameTieQuestionBreakStruct>();
                                                                                        _model.countUser = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedGameUserList?.length;
                                                                                        _model.selectedUserList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedGameUserList.toList().cast<RoomUserListStruct>();
                                                                                        while (_model.countUser! > 0) {
                                                                                          if (_model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserStatus == 'active') {
                                                                                            await GameHistoryRecord.collection.doc().set(createGameHistoryRecordData(
                                                                                                  createdAt: getCurrentTimestamp,
                                                                                                  updatedAt: getCurrentTimestamp,
                                                                                                  gameHistoryID: _model.idmapResultNone?.historyId,
                                                                                                  gameId: columnGameRecord?.gameID,
                                                                                                  userId: _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserId?.toString(),
                                                                                                  userRef: _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef,
                                                                                                  roomId: stackRoomRecord.roomID,
                                                                                                  resultInfo: updateResultInfoStruct(
                                                                                                    ResultInfoStruct(
                                                                                                      status: 'win',
                                                                                                      createdAt: getCurrentTimestamp,
                                                                                                    ),
                                                                                                    clearUnsetFields: false,
                                                                                                    create: true,
                                                                                                  ),
                                                                                                ));

                                                                                            await _model.idmapResultNone!.reference.update({
                                                                                              ...mapToFirestore(
                                                                                                {
                                                                                                  'history_id': FieldValue.increment(1),
                                                                                                },
                                                                                              ),
                                                                                            });
                                                                                          }
                                                                                          _model.countUser = (_model.countUser!) - 1;
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
                                                                                              'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                createTeamsTopicQuestionRecord?.questionID
                                                                                              ]),
                                                                                            },
                                                                                          ),
                                                                                        });
                                                                                        _model.scoreProceedStatus = 'Yes';
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

                                                                                        if (_shouldSetState) safeSetState(() {});
                                                                                        return;
                                                                                      }
                                                                                    } else {
                                                                                      _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                                      _model.countGameList = stackRoomRecord.selectedGameList.length;
                                                                                      _model.teamStatus = 'notFound';
                                                                                      while (_model.countGameList! > 0) {
                                                                                        if (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedGameID == selectedGameIDItem.selectedGameID) {
                                                                                          _model.countQuestion = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedQuestionList?.length;
                                                                                          _model.selectedQuestionList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.selectedQuestionList.toList().cast<SelectedQuestionListStruct>();
                                                                                          while (_model.countQuestion! > 0) {
                                                                                            if (_model.selectedQuestionList.elementAtOrNull((_model.countQuestion!) - 1)?.questionID == createTeamsTopicQuestionRecord?.questionID) {
                                                                                              _model.updateSelectedGameListAtIndex(
                                                                                                (_model.countGameList!) - 1,
                                                                                                (e) => e
                                                                                                  ..presentTeamIndex = selectedGameIDItem.teamInfo.length == 2
                                                                                                      ? (selectedGameIDItem.presentTeamIndex == 1 ? 0 : 1)
                                                                                                      : () {
                                                                                                          if (selectedGameIDItem.presentTeamIndex == 0) {
                                                                                                            return 1;
                                                                                                          } else if (selectedGameIDItem.presentTeamIndex == 1) {
                                                                                                            return 2;
                                                                                                          } else {
                                                                                                            return 0;
                                                                                                          }
                                                                                                        }(),
                                                                                              );
                                                                                              _model.questionStatus = 'found';
                                                                                              _model.updateSelectedGameListAtIndex(
                                                                                                (_model.countGameList!) - 1,
                                                                                                (e) => e
                                                                                                  ..updateSelectedQuestionList(
                                                                                                    (e) => e[(_model.countQuestion!) - 1]
                                                                                                      ..updateResultInfo(
                                                                                                        (e) => e
                                                                                                          ..status = 'none'
                                                                                                          ..createdAt = getCurrentTimestamp,
                                                                                                      ),
                                                                                                  )
                                                                                                  ..updateSelectedQuestionIDList(
                                                                                                    (e) => e.add(createTeamsTopicQuestionRecord!.questionID),
                                                                                                  )
                                                                                                  ..presentTeamID = selectedGameIDItem.teamInfo.elementAtOrNull(_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.presentTeamIndex)?.teamID,
                                                                                              );

                                                                                              await widget!.room!.update({
                                                                                                ...mapToFirestore(
                                                                                                  {
                                                                                                    'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                      _model.selectedGameList,
                                                                                                    ),
                                                                                                    'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                      createTeamsTopicQuestionRecord?.questionID
                                                                                                    ]),
                                                                                                  },
                                                                                                ),
                                                                                              });

                                                                                              context.goNamed(
                                                                                                GameOneS1Widget.routeName,
                                                                                                queryParameters: {
                                                                                                  'room': serializeParam(
                                                                                                    widget!.room,
                                                                                                    ParamType.DocumentReference,
                                                                                                  ),
                                                                                                }.withoutNulls,
                                                                                              );

                                                                                              if (_shouldSetState) safeSetState(() {});
                                                                                              return;
                                                                                            }
                                                                                            _model.countQuestion = (_model.countQuestion!) - 1;
                                                                                          }
                                                                                        }
                                                                                        _model.countGameList = (_model.countGameList!) - 1;
                                                                                      }
                                                                                    }

                                                                                    if (_shouldSetState) safeSetState(() {});
                                                                                  },
                                                                                  text: selectedGameIDItem.gameTieInfo.status == 'active'
                                                                                      ? FFLocalizations.of(context).getVariableText(
                                                                                          enText: 'Wrong Answer',
                                                                                          arText: 'إجابة خاطئة',
                                                                                        )
                                                                                      : FFLocalizations.of(context).getVariableText(
                                                                                          enText: 'None',
                                                                                          arText: 'لا أحد',
                                                                                        ),
                                                                                  options: FFButtonOptions(
                                                                                    height: 45.0,
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                    color: selectedGameIDItem.gameTieInfo.status == 'active' ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).primaryText,
                                                                                    textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                          font: GoogleFonts.almarai(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          fontSize: 14.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
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
                                                                            ].divide(SizedBox(width: 14.0)),
                                                                          ),
                                                                      ].divide(SizedBox(
                                                                              height: 8.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        if (selectedGameIDItem
                                                                .gameTieBreakStatus ==
                                                            'SetWaitStart')
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child:
                                                                GameOneTieStartWidget(
                                                              key: Key(
                                                                  'Key6dn_${selectedGameIDIndex}_of_${selectedGameID.length}'),
                                                              selectedIndex:
                                                                  selectedGameIDItem
                                                                      .selectedGameIndex,
                                                              room:
                                                                  stackRoomRecord,
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: Builder(
                                                        builder: (context) {
                                                          final teamList = (stackRoomRecord
                                                                      .selectedGameList
                                                                      .where((e) =>
                                                                          currentUserDocument
                                                                              ?.presentRoomGameInfo
                                                                              ?.roomSelectedGameID ==
                                                                          e.selectedGameID)
                                                                      .toList()
                                                                      .firstOrNull
                                                                      ?.teamInfo
                                                                      ?.toList() ??
                                                                  [])
                                                              .take(3)
                                                              .toList();

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                teamList.length,
                                                            separatorBuilder:
                                                                (_, __) =>
                                                                    SizedBox(
                                                                        height:
                                                                            8.0),
                                                            itemBuilder: (context,
                                                                teamListIndex) {
                                                              final teamListItem =
                                                                  teamList[
                                                                      teamListIndex];
                                                              return Visibility(
                                                                visible: selectedGameIDItem
                                                                            .gameTieInfo
                                                                            .status ==
                                                                        'active'
                                                                    ? (selectedGameIDItem
                                                                            .presentTeamID ==
                                                                        teamListItem
                                                                            .teamID)
                                                                    : true,
                                                                child:
                                                                    GameTeamUserWidget(
                                                                  key: Key(
                                                                      'Keyesu_${teamListIndex}_of_${teamList.length}'),
                                                                  workStatus: stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.gameTieInfo
                                                                              ?.status ==
                                                                          'active'
                                                                      ? false
                                                                      : true,
                                                                  selectedGameID:
                                                                      currentUserDocument
                                                                          ?.presentRoomGameInfo
                                                                          ?.roomSelectedGameID,
                                                                  index:
                                                                      teamListIndex,
                                                                  room:
                                                                      stackRoomRecord,
                                                                  teamInfo:
                                                                      teamListItem,
                                                                  doubleHelpLineStatus:
                                                                      false,
                                                                  presentTeamID:
                                                                      selectedGameIDItem
                                                                          .presentTeamID,
                                                                  selectedGameIndex:
                                                                      selectedGameIDItem
                                                                          .selectedGameIndex,
                                                                  helpLineStatus:
                                                                      selectedGameIDItem.gameTieInfo.status ==
                                                                              'active'
                                                                          ? true
                                                                          : true,
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    if (selectedGameIDItem
                                                            .gameTieInfo
                                                            .status ==
                                                        'active')
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            8.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'z29f309n' /* Tie Breaker Score */,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.almarai(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if ((selectedGameIDItem.gameTieBreakStatus ==
                                                                            'start') &&
                                                                        (stackRoomRecord.roomCreatedUserRef ==
                                                                            currentUserReference))
                                                                      Expanded(
                                                                        child:
                                                                            GameOneTimerWidget(
                                                                          key: Key(
                                                                              'Keyfjw_${selectedGameIDIndex}_of_${selectedGameID.length}'),
                                                                          timeMS:
                                                                              valueOrDefault<int>(
                                                                            functions.differenceInMilliseconds(getCurrentTimestamp,
                                                                                functions.getFeatureTimeViaAddHurMin(selectedGameIDItem.gameTieBreakStartTime!, 0, 1)!),
                                                                            60000,
                                                                          ),
                                                                          resetStatus:
                                                                              false,
                                                                          startStatus:
                                                                              false,
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(
                                                              height: 2.0,
                                                              thickness: 1.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          8.0,
                                                                          16.0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) {
                                                                  final gameTieBreakQuestion = selectedGameIDItem
                                                                      .gameTieQuestionBreak
                                                                      .where((e) =>
                                                                          e.teamID ==
                                                                          selectedGameIDItem
                                                                              .presentTeamID)
                                                                      .toList();

                                                                  return ListView
                                                                      .separated(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    primary:
                                                                        false,
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        gameTieBreakQuestion
                                                                            .length,
                                                                    separatorBuilder: (_,
                                                                            __) =>
                                                                        SizedBox(
                                                                            height:
                                                                                8.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                            gameTieBreakQuestionIndex) {
                                                                      final gameTieBreakQuestionItem =
                                                                          gameTieBreakQuestion[
                                                                              gameTieBreakQuestionIndex];
                                                                      return Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children:
                                                                            [
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                                                              child: Text(
                                                                                'Q. ${(gameTieBreakQuestionIndex + 1).toString()}',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.almarai(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                StreamBuilder<List<TopicQuestionRecord>>(
                                                                              stream: queryTopicQuestionRecord(
                                                                                queryBuilder: (topicQuestionRecord) => topicQuestionRecord.where(
                                                                                  'question_ID',
                                                                                  isEqualTo: gameTieBreakQuestionItem.tieQuestionID,
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
                                                                                  '${FFLocalizations.of(context).getVariableText(
                                                                                    enText: () {
                                                                                      if (textTopicQuestionRecord?.questionInfoTranslateManual?.question?.en != '') {
                                                                                        return textTopicQuestionRecord?.questionInfoTranslateManual?.question?.en;
                                                                                      } else if (textTopicQuestionRecord?.questionInfoTranslate?.question?.en != '') {
                                                                                        return textTopicQuestionRecord?.questionInfoTranslate?.question?.en;
                                                                                      } else {
                                                                                        return textTopicQuestionRecord?.questionInfo?.question;
                                                                                      }
                                                                                    }(),
                                                                                    arText: () {
                                                                                      if (textTopicQuestionRecord?.questionInfoTranslateManual?.question?.ar != '') {
                                                                                        return textTopicQuestionRecord?.questionInfoTranslateManual?.question?.ar;
                                                                                      } else if (textTopicQuestionRecord?.questionInfoTranslate?.question?.ar != '') {
                                                                                        return textTopicQuestionRecord?.questionInfoTranslate?.question?.ar;
                                                                                      } else {
                                                                                        return textTopicQuestionRecord?.questionInfo?.question;
                                                                                      }
                                                                                    }(),
                                                                                  )} - ${FFLocalizations.of(context).getVariableText(
                                                                                    enText: () {
                                                                                      if (textTopicQuestionRecord?.questionInfoTranslateManual?.answer?.en != '') {
                                                                                        return textTopicQuestionRecord?.questionInfoTranslateManual?.answer?.en;
                                                                                      } else if (textTopicQuestionRecord?.questionInfoTranslate?.answer?.en != '') {
                                                                                        return textTopicQuestionRecord?.questionInfoTranslate?.answer?.en;
                                                                                      } else {
                                                                                        return textTopicQuestionRecord?.questionInfo?.answer;
                                                                                      }
                                                                                    }(),
                                                                                    arText: () {
                                                                                      if (textTopicQuestionRecord?.questionInfoTranslateManual?.answer?.ar != '') {
                                                                                        return textTopicQuestionRecord?.questionInfoTranslateManual?.answer?.ar;
                                                                                      } else if (textTopicQuestionRecord?.questionInfoTranslate?.answer?.ar != '') {
                                                                                        return textTopicQuestionRecord?.questionInfoTranslate?.answer?.ar;
                                                                                      } else {
                                                                                        return textTopicQuestionRecord?.questionInfo?.answer;
                                                                                      }
                                                                                    }(),
                                                                                  )}'
                                                                                      .maybeHandleOverflow(
                                                                                    maxChars: 32,
                                                                                    replacement: '…',
                                                                                  ),
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
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Stack(
                                                                            children: [
                                                                              if (gameTieBreakQuestionItem.status == 'win')
                                                                                Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                                                                    child: Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'o11acu9a' /* correct */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.almarai(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            fontSize: 10.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if (gameTieBreakQuestionItem.status == 'none')
                                                                                Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                                                                    child: Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        '5y20g4xw' /* wrong */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.almarai(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            fontSize: 10.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ].divide(SizedBox(width: 8.0)),
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
                                                  ].divide(
                                                      SizedBox(height: 16.0)),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
