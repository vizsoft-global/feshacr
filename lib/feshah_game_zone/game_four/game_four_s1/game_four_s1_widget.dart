import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_four/game_four_auto_exit/game_four_auto_exit_widget.dart';
import '/feshah_game_zone/game_four/game_four_questions/game_four_questions_widget.dart';
import '/feshah_game_zone/game_four/game_four_user1/game_four_user1_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_four_s1_model.dart';
export 'game_four_s1_model.dart';

class GameFourS1Widget extends StatefulWidget {
  const GameFourS1Widget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  static String routeName = 'GameFour-S1';
  static String routePath = '/gamefour_s1';

  @override
  State<GameFourS1Widget> createState() => _GameFourS1WidgetState();
}

class _GameFourS1WidgetState extends State<GameFourS1Widget> {
  late GameFourS1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFourS1Model());

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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              backButtonStatus: false,
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
                              topicsQuestions:
                                  FFLocalizations.of(context).getText(
                                '8e4mo9yc' /* Questions */,
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
                AuthUserStreamWidget(
                  builder: (context) => wrapWithModel(
                    model: _model.gameFourAutoExitModel,
                    updateCallback: () => safeSetState(() {}),
                    updateOnChange: true,
                    child: GameFourAutoExitWidget(
                      selectedGameID: currentUserDocument!
                          .presentRoomGameInfo.roomSelectedGameID,
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
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                            tablet: false,
                            tabletLandscape: false,
                            desktop: false,
                          ))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    FFLocalizations.of(context).languageCode ==
                                            'en'
                                        ? 55.0
                                        : 16.0,
                                    0.0,
                                  ),
                                  16.0,
                                  valueOrDefault<double>(
                                    FFLocalizations.of(context).languageCode !=
                                            'en'
                                        ? 55.0
                                        : 16.0,
                                    0.0,
                                  ),
                                  0.0),
                              child: StreamBuilder<List<TopicQuestionRecord>>(
                                stream: queryTopicQuestionRecord(
                                  queryBuilder: (topicQuestionRecord) =>
                                      topicQuestionRecord
                                          .where(
                                            'question_status',
                                            isEqualTo: 'active',
                                          )
                                          .whereIn(
                                              'question_ID',
                                              FFAppState()
                                                  .listedQuestionIDList),
                                  limit: 10,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 2.0,
                                        height: 2.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Color(0x00EC4D41),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<TopicQuestionRecord>
                                      gridViewTopicQuestionRecordList =
                                      snapshot.data!;

                                  return GridView.builder(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                      childAspectRatio: 1.5,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        gridViewTopicQuestionRecordList.length,
                                    itemBuilder: (context, gridViewIndex) {
                                      final gridViewTopicQuestionRecord =
                                          gridViewTopicQuestionRecordList[
                                              gridViewIndex];
                                      return GameFourQuestionsWidget(
                                        key: Key(
                                            'Keydhp_${gridViewIndex}_of_${gridViewTopicQuestionRecordList.length}'),
                                        selectedGameID: currentUserDocument
                                            ?.presentRoomGameInfo
                                            ?.roomSelectedGameID,
                                        gameID: columnGameRecord!.gameID,
                                        questionID: gridViewTopicQuestionRecord
                                            .questionID,
                                        room: stackRoomRecord,
                                        index: gridViewIndex,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                valueOrDefault<double>(
                                  FFLocalizations.of(context).languageCode ==
                                          'en'
                                      ? 55.0
                                      : 16.0,
                                  0.0,
                                ),
                                16.0,
                                valueOrDefault<double>(
                                  FFLocalizations.of(context).languageCode !=
                                          'en'
                                      ? 55.0
                                      : 16.0,
                                  0.0,
                                ),
                                0.0),
                            child: Builder(
                              builder: (context) {
                                final listedQuestion = stackRoomRecord
                                        .selectedGameList
                                        .where((e) =>
                                            e.selectedGameID ==
                                            currentUserDocument
                                                ?.presentRoomGameInfo
                                                ?.roomSelectedGameID)
                                        .toList()
                                        .firstOrNull
                                        ?.listedQuestionIDList
                                        ?.toList() ??
                                    [];

                                return GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 1.5,
                                  ),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listedQuestion.length,
                                  itemBuilder: (context, listedQuestionIndex) {
                                    final listedQuestionItem =
                                        listedQuestion[listedQuestionIndex];
                                    return StreamBuilder<
                                        List<TopicQuestionRecord>>(
                                      stream: queryTopicQuestionRecord(
                                        queryBuilder: (topicQuestionRecord) =>
                                            topicQuestionRecord.where(
                                          'question_ID',
                                          isEqualTo: listedQuestionItem,
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
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color(0x00EC4D41),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<TopicQuestionRecord>
                                            gameFourQuestionsTopicQuestionRecordList =
                                            snapshot.data!;
                                        final gameFourQuestionsTopicQuestionRecord =
                                            gameFourQuestionsTopicQuestionRecordList
                                                    .isNotEmpty
                                                ? gameFourQuestionsTopicQuestionRecordList
                                                    .first
                                                : null;

                                        return GameFourQuestionsWidget(
                                          key: Key(
                                              'Keyfy5_${listedQuestionIndex}_of_${listedQuestion.length}'),
                                          selectedGameID: currentUserDocument
                                              ?.presentRoomGameInfo
                                              ?.roomSelectedGameID,
                                          gameID: columnGameRecord!.gameID,
                                          questionID: listedQuestionItem,
                                          room: stackRoomRecord,
                                          index: listedQuestionIndex,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 90.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(
                          height: 1.0,
                          thickness: 0.5,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 4.0, 24.0, 4.0),
                          child: AuthUserStreamWidget(
                            builder: (context) => Builder(
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

                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(teamList.length,
                                      (teamListIndex) {
                                    final teamListItem =
                                        teamList[teamListIndex];
                                    return GameFourUser1Widget(
                                      key: Key(
                                          'Key64a_${teamListIndex}_of_${teamList.length}'),
                                      workStatus: true,
                                      selectedGameID: currentUserDocument
                                          ?.presentRoomGameInfo
                                          ?.roomSelectedGameID,
                                      doubleHelpLineStatus: false,
                                      presentTeamID: stackRoomRecord
                                          .selectedGameList
                                          .where((e) =>
                                              currentUserDocument
                                                  ?.presentRoomGameInfo
                                                  ?.roomSelectedGameID ==
                                              e.selectedGameID)
                                          .toList()
                                          .firstOrNull!
                                          .presentTeamID,
                                      selectedGameIndex: stackRoomRecord
                                          .selectedGameList
                                          .where((e) =>
                                              currentUserDocument
                                                  ?.presentRoomGameInfo
                                                  ?.roomSelectedGameID ==
                                              e.selectedGameID)
                                          .toList()
                                          .firstOrNull!
                                          .presentTeamIndex,
                                      helpLineStatus: false,
                                      index: teamListIndex,
                                      room: stackRoomRecord,
                                      teamInfo: teamListItem,
                                    );
                                  }).divide(SizedBox(width: 8.0)),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
