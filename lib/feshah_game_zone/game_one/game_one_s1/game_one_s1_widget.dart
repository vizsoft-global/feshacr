import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_one/game_one_topics/game_one_topics_widget.dart';
import '/feshah_game_zone/game_one/game_one_toss/game_one_toss_widget.dart';
import '/feshah_game_zone/game_one/game_team_user/game_team_user_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_one_s1_model.dart';
export 'game_one_s1_model.dart';

class GameOneS1Widget extends StatefulWidget {
  const GameOneS1Widget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  static String routeName = 'GameOne-S1';
  static String routePath = '/gameone_s1';

  @override
  State<GameOneS1Widget> createState() => _GameOneS1WidgetState();
}

class _GameOneS1WidgetState extends State<GameOneS1Widget> {
  late GameOneS1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameOneS1Model());

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
                              topicsQuestions:
                                  FFLocalizations.of(context).getText(
                                'qz7um0sa' /* Topics */,
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
                      final columnGameRecord = columnGameRecordList.isNotEmpty
                          ? columnGameRecordList.first
                          : null;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                final selectedGameList = stackRoomRecord
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
                                  children:
                                      List.generate(selectedGameList.length,
                                          (selectedGameListIndex) {
                                    final selectedGameListItem =
                                        selectedGameList[selectedGameListIndex];
                                    return Expanded(
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        children: [
                                          if (selectedGameListItem
                                                  .presentTeamID ==
                                              0)
                                            GameOneTossWidget(
                                              key: Key(
                                                  'Keyhej_${selectedGameListIndex}_of_${selectedGameList.length}'),
                                              selectedIndex:
                                                  selectedGameListItem
                                                      .selectedGameIndex,
                                              room: widget!.room!,
                                            ),
                                          if (selectedGameListItem
                                                  .presentTeamID !=
                                              0)
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                valueOrDefault<
                                                                    double>(
                                                                  FFLocalizations.of(context)
                                                                              .languageCode ==
                                                                          'en'
                                                                      ? 40.0
                                                                      : 8.0,
                                                                  0.0,
                                                                ),
                                                                0.0,
                                                                valueOrDefault<
                                                                    double>(
                                                                  FFLocalizations.of(context)
                                                                              .languageCode !=
                                                                          'en'
                                                                      ? 40.0
                                                                      : 8.0,
                                                                  0.0,
                                                                ),
                                                                0.0),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final topicList1 = stackRoomRecord
                                                                .selectedGameList
                                                                .where((e) =>
                                                                    currentUserDocument
                                                                        ?.presentRoomGameInfo
                                                                        ?.roomSelectedGameID ==
                                                                    e.selectedGameID)
                                                                .toList()
                                                                .firstOrNull
                                                                ?.selectedTopicIDList
                                                                ?.toList() ??
                                                            [];

                                                        return GridView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            childAspectRatio: stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            e.selectedGameID ==
                                                                            currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                        .toList()
                                                                        .firstOrNull
                                                                        ?.selectedTopicIDList
                                                                        ?.length ==
                                                                    3
                                                                ? 1.3
                                                                : 2.4,
                                                          ),
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              topicList1.length,
                                                          itemBuilder: (context,
                                                              topicList1Index) {
                                                            final topicList1Item =
                                                                topicList1[
                                                                    topicList1Index];
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            4.0,
                                                                            4.0,
                                                                            4.0),
                                                                    child:
                                                                        GameOneTopicsWidget(
                                                                      key: Key(
                                                                          'Keyw3f_${topicList1Index}_of_${topicList1.length}'),
                                                                      selectedGameID: stackRoomRecord
                                                                          .selectedGameList
                                                                          .where((e) =>
                                                                              currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                              e.selectedGameID)
                                                                          .toList()
                                                                          .firstOrNull
                                                                          ?.selectedGameID,
                                                                      gameID: stackRoomRecord
                                                                          .selectedGameList
                                                                          .where((e) =>
                                                                              currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                              e.selectedGameID)
                                                                          .toList()
                                                                          .firstOrNull!
                                                                          .gameId,
                                                                      topicID:
                                                                          topicList1Item,
                                                                      room:
                                                                          stackRoomRecord,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                  child: StreamBuilder<
                                                                      List<
                                                                          TopicRecord>>(
                                                                    stream:
                                                                        queryTopicRecord(
                                                                      queryBuilder: (topicRecord) => topicRecord
                                                                          .where(
                                                                            'topic_status',
                                                                            isEqualTo:
                                                                                'active',
                                                                          )
                                                                          .where(
                                                                            'topic_ID',
                                                                            isEqualTo:
                                                                                topicList1Item,
                                                                          ),
                                                                      singleRecord:
                                                                          true,
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
                                                                            width:
                                                                                2.0,
                                                                            height:
                                                                                2.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                Color(0x00EC4D41),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<TopicRecord>
                                                                          textTopicRecordList =
                                                                          snapshot
                                                                              .data!;
                                                                      final textTopicRecord = textTopicRecordList
                                                                              .isNotEmpty
                                                                          ? textTopicRecordList
                                                                              .first
                                                                          : null;

                                                                      return AutoSizeText(
                                                                        FFLocalizations.of(context)
                                                                            .getVariableText(
                                                                          enText:
                                                                              () {
                                                                            if (textTopicRecord?.topicInfoManualTranslate?.name?.en != null &&
                                                                                textTopicRecord?.topicInfoManualTranslate?.name?.en != '') {
                                                                              return textTopicRecord?.topicInfoManualTranslate?.name?.en;
                                                                            } else if (textTopicRecord?.topicInfoTranslate?.name?.en != null && textTopicRecord?.topicInfoTranslate?.name?.en != '') {
                                                                              return textTopicRecord?.topicInfoTranslate?.name?.en;
                                                                            } else {
                                                                              return textTopicRecord?.topicInfo?.name;
                                                                            }
                                                                          }(),
                                                                          arText:
                                                                              () {
                                                                            if (textTopicRecord?.topicInfoManualTranslate?.name?.ar != null &&
                                                                                textTopicRecord?.topicInfoManualTranslate?.name?.ar != '') {
                                                                              return textTopicRecord?.topicInfoManualTranslate?.name?.ar;
                                                                            } else if (textTopicRecord?.topicInfoTranslate?.name?.ar != null && textTopicRecord?.topicInfoTranslate?.name?.ar != '') {
                                                                              return textTopicRecord?.topicInfoTranslate?.name?.ar;
                                                                            } else {
                                                                              return textTopicRecord?.topicInfo?.name;
                                                                            }
                                                                          }(),
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        minFontSize:
                                                                            8.0,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.almarai(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 13.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    );
                                  }),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AuthUserStreamWidget(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(teamList.length,
                                          (teamListIndex) {
                                        final teamListItem =
                                            teamList[teamListIndex];
                                        return GameTeamUserWidget(
                                          key: Key(
                                              'Keyn7o_${teamListIndex}_of_${teamList.length}'),
                                          teamInfo: teamListItem,
                                          workStatus: true,
                                          selectedGameID: currentUserDocument
                                              ?.presentRoomGameInfo
                                              ?.roomSelectedGameID,
                                          room: stackRoomRecord,
                                          index: teamListIndex,
                                          doubleHelpLineStatus: true,
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
                                                  e.selectedGameID ==
                                                  currentUserDocument
                                                      ?.presentRoomGameInfo
                                                      ?.roomSelectedGameID)
                                              .toList()
                                              .firstOrNull!
                                              .selectedGameIndex,
                                          helpLineStatus: false,
                                        );
                                      }).divide(SizedBox(width: 8.0)),
                                    );
                                  },
                                ),
                              ),
                            ].divide(SizedBox(width: 16.0)),
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
