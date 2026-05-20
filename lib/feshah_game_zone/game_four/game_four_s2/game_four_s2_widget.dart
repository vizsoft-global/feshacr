import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_four/game_four_initial/game_four_initial_widget.dart';
import '/feshah_game_zone/game_four/game_four_tie_start/game_four_tie_start_widget.dart';
import '/feshah_game_zone/game_four/game_four_timer/game_four_timer_widget.dart';
import '/feshah_game_zone/game_four/game_four_user2/game_four_user2_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
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
import 'game_four_s2_model.dart';
export 'game_four_s2_model.dart';

class GameFourS2Widget extends StatefulWidget {
  const GameFourS2Widget({
    super.key,
    required this.room,
    bool? tieBreakStatus,
  }) : this.tieBreakStatus = tieBreakStatus ?? false;

  final DocumentReference? room;
  final bool tieBreakStatus;

  static String routeName = 'GameFour-S2';
  static String routePath = '/gamefour_s2';

  @override
  State<GameFourS2Widget> createState() => _GameFourS2WidgetState();
}

class _GameFourS2WidgetState extends State<GameFourS2Widget> {
  late GameFourS2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFourS2Model());

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
                              topicButtonStatus: false,
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
                              presentTeamInfoStatus: false,
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
                              backButtonText: widget!.tieBreakStatus == false
                                  ? 'Questions'
                                  : 'Back',
                              topicsQuestions:
                                  FFLocalizations.of(context).getText(
                                '8126de2i' /* Questions */,
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
                wrapWithModel(
                  model: _model.gameFourInitialModel,
                  updateCallback: () => safeSetState(() {}),
                  updateOnChange: true,
                  child: GameFourInitialWidget(
                    room: widget!.room!,
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
                                                  ? 55.0
                                                  : 16.0,
                                              0.0,
                                            ),
                                            16.0,
                                            valueOrDefault<double>(
                                              FFLocalizations.of(context)
                                                          .languageCode !=
                                                      'en'
                                                  ? 55.0
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
                                                                                  if (selectedGameIDItem.selectedQuestionList.where((e) => e.questionID == createTeamsTopicQuestionRecord?.questionID).toList().firstOrNull?.questionAnswerStatus != 'show')
                                                                                    Expanded(
                                                                                      child: GameFourTimerWidget(
                                                                                        key: Key('Keyh0k_${selectedGameIDIndex}_of_${selectedGameID.length}'),
                                                                                        timeMS: selectedGameIDItem.gameTieInfo.status == 'active' ? 85000 : 85000,
                                                                                        resetStatus: true,
                                                                                        startStatus: true,
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
                                                                                      color: selectedGameIDIndex == 0 ? Color(0x2D67B5B0) : Color(0x2E3696D0),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Text(
                                                                                            selectedGameIDItem.teamInfo.where((e) => e.teamID == selectedGameIDItem.presentTeamID).toList().firstOrNull!.teamInfo.name.maybeHandleOverflow(
                                                                                                  maxChars: 8,
                                                                                                  replacement: '…',
                                                                                                ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.almarai(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  fontSize: 12.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                          'https://api.qrserver.com/v1/create-qr-code/?data=${FFLocalizations.of(context).getVariableText(
                                                                                            enText: createTeamsTopicQuestionRecord?.questionInfo?.question,
                                                                                            arText: createTeamsTopicQuestionRecord?.questionInfo?.question,
                                                                                          )}&size=350x350',
                                                                                          'https://api.qrserver.com/v1/create-qr-code/?data=Vikram&size=350x350',
                                                                                        ),
                                                                                        fit: BoxFit.contain,
                                                                                      ),
                                                                                      allowRotation: true,
                                                                                      tag: valueOrDefault<String>(
                                                                                        'https://api.qrserver.com/v1/create-qr-code/?data=${FFLocalizations.of(context).getVariableText(
                                                                                          enText: createTeamsTopicQuestionRecord?.questionInfo?.question,
                                                                                          arText: createTeamsTopicQuestionRecord?.questionInfo?.question,
                                                                                        )}&size=350x350',
                                                                                        'https://api.qrserver.com/v1/create-qr-code/?data=Vikram&size=350x350' + '$selectedGameIDIndex',
                                                                                      ),
                                                                                      useHeroAnimation: true,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Hero(
                                                                                tag: valueOrDefault<String>(
                                                                                  'https://api.qrserver.com/v1/create-qr-code/?data=${FFLocalizations.of(context).getVariableText(
                                                                                    enText: createTeamsTopicQuestionRecord?.questionInfo?.question,
                                                                                    arText: createTeamsTopicQuestionRecord?.questionInfo?.question,
                                                                                  )}&size=350x350',
                                                                                  'https://api.qrserver.com/v1/create-qr-code/?data=Vikram&size=350x350' + '$selectedGameIDIndex',
                                                                                ),
                                                                                transitionOnUserGestures: true,
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    valueOrDefault<String>(
                                                                                      'https://api.qrserver.com/v1/create-qr-code/?data=${FFLocalizations.of(context).getVariableText(
                                                                                        enText: createTeamsTopicQuestionRecord?.questionInfo?.question,
                                                                                        arText: createTeamsTopicQuestionRecord?.questionInfo?.question,
                                                                                      )}&size=350x350',
                                                                                      'https://api.qrserver.com/v1/create-qr-code/?data=Vikram&size=350x350',
                                                                                    ),
                                                                                    width: 150.0,
                                                                                    height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        if (selectedGameIDItem.selectedQuestionList.where((e) => e.questionID == createTeamsTopicQuestionRecord?.questionID).toList().firstOrNull?.questionAnswerStatus ==
                                                                            'show')
                                                                          Text(
                                                                            '\"${FFLocalizations.of(context).getVariableText(
                                                                              enText: createTeamsTopicQuestionRecord?.questionInfo?.answer,
                                                                              arText: createTeamsTopicQuestionRecord?.questionInfo?.answer,
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
                                                                              'k2j3vqdo' /* View Answer */,
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
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Expanded(
                                                                                child: Builder(
                                                                                  builder: (context) {
                                                                                    final team = (stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.teamInfo?.toList() ?? []).take(3).toList();

                                                                                    return Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: List.generate(team.length, (teamIndex) {
                                                                                        final teamItem = team[teamIndex];
                                                                                        return Visibility(
                                                                                          visible: selectedGameIDItem.gameTieBreak == 'set' ? (selectedGameIDItem.presentTeamID == teamItem.teamID) : true,
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
                                                                                                                if ((selectedGameIDItem.teamInfo.length == 2 ? (selectedGameIDItem.gameTieBreakCompletedTeamIDList.length == 2) : (selectedGameIDItem.gameTieBreakCompletedTeamIDList.length == 3)) && (selectedGameIDItem.gameTieBreakCompletedTeamIDList.contains(selectedGameIDItem.presentTeamID) == true)) {
                                                                                                                  _model.countTeam = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length;
                                                                                                                  _model.selectedTeamList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.toList().cast<TeamInfoStruct>();
                                                                                                                  while (_model.countTeam! > 0) {
                                                                                                                    _model.pointWin = _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)!.totalResult + ((selectedGameIDItem.gameTieQuestionBreak.where((e) => (e.teamID == _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)?.teamID) && (e.status == 'win')).toList().length - selectedGameIDItem.gameTieQuestionBreak.where((e) => (e.teamID == _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)?.teamID) && (e.status == 'none')).toList().length));
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
                                                                                                    unawaited(
                                                                                                      () async {
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
                                                                                                      }(),
                                                                                                    );
                                                                                                    _model.scoreProceedStatus = 'Yes';

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
                                                                                                        unawaited(
                                                                                                          () async {
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
                                                                                                          }(),
                                                                                                        );
                                                                                                        unawaited(
                                                                                                          () async {
                                                                                                            await _model.idmapResult!.reference.update({
                                                                                                              ...mapToFirestore(
                                                                                                                {
                                                                                                                  'history_id': FieldValue.increment(1),
                                                                                                                },
                                                                                                              ),
                                                                                                            });
                                                                                                          }(),
                                                                                                        );
                                                                                                      }
                                                                                                      _model.countUser = (_model.countUser!) - 1;
                                                                                                    }
                                                                                                    unawaited(
                                                                                                      () async {
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
                                                                                                      }(),
                                                                                                    );
                                                                                                    _model.scoreProceedStatus = 'Yes';

                                                                                                    context.goNamed(
                                                                                                      GameFourS3Widget.routeName,
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
                                                                                                                GameFourS1Widget.routeName,
                                                                                                                queryParameters: {
                                                                                                                  'room': serializeParam(
                                                                                                                    stackRoomRecord.reference,
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
                                                                                                    if (teamIndex == 0) {
                                                                                                      return (selectedGameIDItem.presentTeamID == teamItem.teamID ? FlutterFlowTheme.of(context).tertiary : Color(0x8067B5B0));
                                                                                                    } else if (teamIndex == 1) {
                                                                                                      return (selectedGameIDItem.presentTeamID == teamItem.teamID ? FlutterFlowTheme.of(context).secondary : Color(0x7F3696D0));
                                                                                                    } else {
                                                                                                      return (selectedGameIDItem.presentTeamID == teamItem.teamID ? FlutterFlowTheme.of(context).primary : Color(0x7CEC4D41));
                                                                                                    }
                                                                                                  }(),
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                  border: Border.all(
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                ),
                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                                                                  child: Text(
                                                                                                    '${teamItem.teamInfo.name}'.maybeHandleOverflow(
                                                                                                      maxChars: 10,
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
                                                                                          return selectedGameIDItem.gameTieBreak == 'set' ? (selectedGameIDItem.presentTeamID == teamItem.teamID) : true;
                                                                                        },
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                                                              _model.idmapResultNone1 = await queryIDmapRecordOnce(
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
                                                                                                            if ((selectedGameIDItem.teamInfo.length == 2 ? (selectedGameIDItem.gameTieBreakCompletedTeamIDList.length == 2) : (selectedGameIDItem.gameTieBreakCompletedTeamIDList.length == 3)) && (selectedGameIDItem.gameTieBreakCompletedTeamIDList.contains(selectedGameIDItem.presentTeamID) == true)) {
                                                                                                              _model.countTeam = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.teamInfo?.length;
                                                                                                              _model.selectedTeamList = _model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.teamInfo.toList().cast<TeamInfoStruct>();
                                                                                                              while (_model.countTeam! > 0) {
                                                                                                                _model.pointWin = _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)!.totalResult + ((selectedGameIDItem.gameTieQuestionBreak.where((e) => (e.teamID == _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)?.teamID) && (e.status == 'win')).toList().length - selectedGameIDItem.gameTieQuestionBreak.where((e) => (e.teamID == _model.selectedTeamList.elementAtOrNull((_model.countTeam!) - 1)?.teamID) && (e.status == 'none')).toList().length));
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
                                                                                                          gameHistoryID: _model.idmapResultNone1?.historyId,
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

                                                                                                    await _model.idmapResultNone1!.reference.update({
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

                                                                                                context.goNamed(
                                                                                                  GameFourS3Widget.routeName,
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
                                                                                                      _model.scoreProceedStatus = 'Yes';

                                                                                                      context.goNamed(
                                                                                                        GameFourS1Widget.routeName,
                                                                                                        queryParameters: {
                                                                                                          'room': serializeParam(
                                                                                                            stackRoomRecord.reference,
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
                                                                                          child: Container(
                                                                                            height: 45.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: selectedGameIDItem.gameTieBreak == 'set'
                                                                                                  ? () {
                                                                                                      if (selectedGameIDItem.presentTeamIndex == 1) {
                                                                                                        return (selectedGameIDItem.presentTeamIndex == 1 ? FlutterFlowTheme.of(context).tertiary : Color(0x8067B5B0));
                                                                                                      } else if (selectedGameIDItem.presentTeamIndex == 0) {
                                                                                                        return (selectedGameIDItem.presentTeamIndex == 0 ? FlutterFlowTheme.of(context).secondary : Color(0x7F3696D0));
                                                                                                      } else {
                                                                                                        return (selectedGameIDItem.presentTeamIndex == 2 ? FlutterFlowTheme.of(context).primary : Color(0x7CEC4D41));
                                                                                                      }
                                                                                                    }()
                                                                                                  : FlutterFlowTheme.of(context).primaryText,
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                                                                child: Text(
                                                                                                  selectedGameIDItem.gameTieBreak == 'set'
                                                                                                      ? selectedGameIDItem.teamInfo.elementAtOrNull(selectedGameIDItem.presentTeamIndex == 1 ? 0 : 1)!.teamInfo.name
                                                                                                      : FFLocalizations.of(context)
                                                                                                          .getVariableText(
                                                                                                            enText: 'None',
                                                                                                            arText: 'لا أحد',
                                                                                                          )
                                                                                                          .maybeHandleOverflow(
                                                                                                            maxChars: 12,
                                                                                                            replacement: '…',
                                                                                                          ),
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
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
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
                                                          GameFourTieStartWidget(
                                                            key: Key(
                                                                'Keyjwt_${selectedGameIDIndex}_of_${selectedGameID.length}'),
                                                            selectedIndex:
                                                                selectedGameIDItem
                                                                    .selectedGameIndex,
                                                            room:
                                                                stackRoomRecord,
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
                                                    Builder(
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
                                                          separatorBuilder: (_,
                                                                  __) =>
                                                              SizedBox(
                                                                  height: 8.0),
                                                          itemBuilder: (context,
                                                              teamListIndex) {
                                                            final teamListItem =
                                                                teamList[
                                                                    teamListIndex];
                                                            return GameFourUser2Widget(
                                                              key: Key(
                                                                  'Keyh5d_${teamListIndex}_of_${teamList.length}'),
                                                              workStatus: stackRoomRecord
                                                                          .selectedGameList
                                                                          .where((e) =>
                                                                              currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                              e.selectedGameID)
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
                                                              doubleHelpLineStatus:
                                                                  false,
                                                              presentTeamID:
                                                                  selectedGameIDItem
                                                                      .presentTeamID,
                                                              selectedGameIndex:
                                                                  selectedGameIDItem
                                                                      .selectedGameIndex,
                                                              helpLineStatus:
                                                                  selectedGameIDItem
                                                                              .gameTieInfo
                                                                              .status ==
                                                                          'active'
                                                                      ? true
                                                                      : true,
                                                              teamInfo:
                                                                  teamListItem,
                                                              room:
                                                                  stackRoomRecord,
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 16.0)),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
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
