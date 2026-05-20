import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_one/game_one_user/game_one_user_widget.dart';
import '/feshah_game_zone/game_one/game_zone_team/game_zone_team_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
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
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_one_copy_model.dart';
export 'game_one_copy_model.dart';

class GameOneCopyWidget extends StatefulWidget {
  const GameOneCopyWidget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  static String routeName = 'GameOneCopy';
  static String routePath = '/gameone_copy';

  @override
  State<GameOneCopyWidget> createState() => _GameOneCopyWidgetState();
}

class _GameOneCopyWidgetState extends State<GameOneCopyWidget>
    with TickerProviderStateMixin {
  late GameOneCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameOneCopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.setOrientation();
    });

    _model.nameTextController ??= TextEditingController();
    _model.nameFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

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
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: Column(
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
                          room: widget!.room,
                          backButtonStatus: FFAppState().gameZoneSteps == 2,
                          topicButtonStatus: false,
                          exitButtonStatus: true,
                          selectedGameID: currentUserDocument
                              ?.presentRoomGameInfo?.roomSelectedGameID,
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
                          backButtonFrom:
                              FFAppState().gameZoneSteps == 2 ? '2' : 'default',
                          topicsQuestions: FFLocalizations.of(context).getText(
                            'x6ubljwy' /* Topics */,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            actions: [],
            centerTitle: true,
            elevation: 2.0,
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
                                    currentUserDocument?.presentRoomGameInfo
                                        ?.roomSelectedGameID ==
                                    e.selectedGameID)
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
                      List<GameRecord> columnGameRecordList = snapshot.data!;
                      final columnGameRecord = columnGameRecordList.isNotEmpty
                          ? columnGameRecordList.first
                          : null;

                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    functions.isLandscape(
                                            MediaQuery.sizeOf(context).width,
                                            MediaQuery.sizeOf(context).height)!
                                        ? 55.0
                                        : 16.0,
                                    16.0,
                                  ),
                                  16.0,
                                  16.0,
                                  0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (FFAppState().gameZoneSteps == 1)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '9qlmwt1t' /* Create Teams */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyLarge
                                                    .override(
                                                      font: GoogleFonts.almarai(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                              child: FlutterFlowChoiceChips(
                                                options: [
                                                  ChipData(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'p3ngenkw' /* 1 */,
                                                      ),
                                                      Icons.person),
                                                  ChipData(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'mwpok757' /* 2 */,
                                                      ),
                                                      Icons.group),
                                                  ChipData(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '1qphk54k' /* 3 */,
                                                      ),
                                                      Icons.groups_rounded)
                                                ],
                                                onChanged: (val) async {
                                                  safeSetState(() =>
                                                      _model.choiceChipsValue =
                                                          val?.firstOrNull);
                                                  FFAppState().teamInputFields =
                                                      [];
                                                  if ((_model.choiceChipsValue ==
                                                          '2') ||
                                                      (_model.choiceChipsValue ==
                                                          '2')) {
                                                    if (stackRoomRecord
                                                            .selectedGameList
                                                            .where((e) =>
                                                                currentUserDocument
                                                                    ?.presentRoomGameInfo
                                                                    ?.roomSelectedGameID ==
                                                                e.selectedGameID)
                                                            .toList()
                                                            .firstOrNull
                                                            ?.teamInfo
                                                            ?.length !=
                                                        2) {
                                                      if (stackRoomRecord
                                                              .selectedGameList
                                                              .where((e) =>
                                                                  currentUserDocument
                                                                      ?.presentRoomGameInfo
                                                                      ?.roomSelectedGameID ==
                                                                  e.selectedGameID)
                                                              .toList()
                                                              .firstOrNull
                                                              ?.teamInfo
                                                              ?.length ==
                                                          1) {
                                                        FFAppState()
                                                            .addToTeamInputFields(
                                                                0);
                                                      } else {
                                                        FFAppState()
                                                            .addToTeamInputFields(
                                                                1);
                                                        FFAppState()
                                                            .addToTeamInputFields(
                                                                1);
                                                      }
                                                    }
                                                  } else {
                                                    if ((_model.choiceChipsValue ==
                                                            '1') ||
                                                        (_model.choiceChipsValue ==
                                                            '1')) {
                                                      if (stackRoomRecord
                                                              .selectedGameList
                                                              .where((e) =>
                                                                  currentUserDocument
                                                                      ?.presentRoomGameInfo
                                                                      ?.roomSelectedGameID ==
                                                                  e.selectedGameID)
                                                              .toList()
                                                              .firstOrNull
                                                              ?.teamInfo
                                                              ?.length !=
                                                          1) {
                                                        FFAppState()
                                                            .addToTeamInputFields(
                                                                0);
                                                      }
                                                    } else {
                                                      if (stackRoomRecord
                                                              .selectedGameList
                                                              .where((e) =>
                                                                  currentUserDocument
                                                                      ?.presentRoomGameInfo
                                                                      ?.roomSelectedGameID ==
                                                                  e.selectedGameID)
                                                              .toList()
                                                              .firstOrNull
                                                              ?.teamInfo
                                                              ?.length !=
                                                          3) {
                                                        if (stackRoomRecord
                                                                .selectedGameList
                                                                .where((e) =>
                                                                    currentUserDocument
                                                                        ?.presentRoomGameInfo
                                                                        ?.roomSelectedGameID ==
                                                                    e.selectedGameID)
                                                                .toList()
                                                                .firstOrNull
                                                                ?.teamInfo
                                                                ?.length ==
                                                            2) {
                                                          FFAppState()
                                                              .addToTeamInputFields(
                                                                  0);
                                                        } else {
                                                          if (stackRoomRecord
                                                                  .selectedGameList
                                                                  .where((e) =>
                                                                      currentUserDocument
                                                                          ?.presentRoomGameInfo
                                                                          ?.roomSelectedGameID ==
                                                                      e.selectedGameID)
                                                                  .toList()
                                                                  .firstOrNull
                                                                  ?.teamInfo
                                                                  ?.length ==
                                                              1) {
                                                            FFAppState()
                                                                .addToTeamInputFields(
                                                                    0);
                                                            FFAppState()
                                                                .addToTeamInputFields(
                                                                    1);
                                                          } else {
                                                            FFAppState()
                                                                .addToTeamInputFields(
                                                                    0);
                                                            FFAppState()
                                                                .addToTeamInputFields(
                                                                    1);
                                                            FFAppState()
                                                                .addToTeamInputFields(
                                                                    2);
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }

                                                  _model.teamLimit = () {
                                                    if (_model
                                                            .choiceChipsValue ==
                                                        '2') {
                                                      return 2;
                                                    } else if (_model
                                                            .choiceChipsValue ==
                                                        '1') {
                                                      return 1;
                                                    } else {
                                                      return 3;
                                                    }
                                                  }();
                                                  _model.selectedGameList =
                                                      stackRoomRecord
                                                          .selectedGameList
                                                          .toList()
                                                          .cast<
                                                              SelectedGameListStruct>();
                                                  _model.countTeam = stackRoomRecord
                                                      .selectedGameList
                                                      .where((e) =>
                                                          currentUserDocument
                                                              ?.presentRoomGameInfo
                                                              ?.roomSelectedGameID ==
                                                          e.selectedGameID)
                                                      .toList()
                                                      .firstOrNull
                                                      ?.teamInfo
                                                      ?.length;
                                                  _model.selectedTeamList =
                                                      stackRoomRecord
                                                          .selectedGameList
                                                          .where((e) =>
                                                              currentUserDocument
                                                                  ?.presentRoomGameInfo
                                                                  ?.roomSelectedGameID ==
                                                              e.selectedGameID)
                                                          .toList()
                                                          .firstOrNull!
                                                          .teamInfo
                                                          .toList()
                                                          .cast<
                                                              TeamInfoStruct>();
                                                  _model.count = stackRoomRecord
                                                      .selectedGameList.length;
                                                  while (
                                                      _model.countTeam! > 0) {
                                                    if (_model.selectedTeamList
                                                            .length <
                                                        _model.teamLimit!) {
                                                      break;
                                                    } else {
                                                      _model.removeAtIndexFromSelectedTeamList(
                                                          (_model.countTeam!) -
                                                              1);
                                                    }

                                                    _model.count =
                                                        (_model.countTeam!) - 1;
                                                  }
                                                  _model
                                                      .updateSelectedGameListAtIndex(
                                                    stackRoomRecord
                                                        .selectedGameList
                                                        .where((e) =>
                                                            currentUserDocument
                                                                ?.presentRoomGameInfo
                                                                ?.roomSelectedGameID ==
                                                            e.selectedGameID)
                                                        .toList()
                                                        .firstOrNull!
                                                        .selectedGameIndex,
                                                    (e) => e
                                                      ..teamInfo = _model
                                                          .selectedTeamList
                                                          .toList(),
                                                  );

                                                  await stackRoomRecord
                                                      .reference
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
                                                },
                                                selectedChipStyle: ChipStyle(
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.almarai(
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
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
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
                                                  iconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                  iconSize: 24.0,
                                                  labelPadding:
                                                      EdgeInsets.all(4.0),
                                                  elevation: 0.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  borderWidth: 0.5,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                unselectedChipStyle: ChipStyle(
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.almarai(
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
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
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
                                                  iconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  iconSize: 24.0,
                                                  labelPadding:
                                                      EdgeInsets.all(4.0),
                                                  elevation: 0.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  borderWidth: 0.5,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                chipSpacing: 16.0,
                                                rowSpacing: 16.0,
                                                multiselect: false,
                                                initialized:
                                                    _model.choiceChipsValue !=
                                                        null,
                                                alignment: WrapAlignment.center,
                                                controller: _model
                                                        .choiceChipsValueController ??=
                                                    FormFieldController<
                                                        List<String>>(
                                                  [
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'xydp2fi3' /* 2 */,
                                                    )
                                                  ],
                                                ),
                                                wrapped: true,
                                              ),
                                            ),
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

                                                return ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: teamList.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 16.0),
                                                  itemBuilder:
                                                      (context, teamListIndex) {
                                                    final teamListItem =
                                                        teamList[teamListIndex];
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${FFLocalizations.of(context).getVariableText(
                                                                enText: 'Team',
                                                                arText: 'فريق',
                                                              )} ${() {
                                                                if (teamListIndex ==
                                                                    0) {
                                                                  return 'A';
                                                                } else if (teamListIndex ==
                                                                    1) {
                                                                  return 'B';
                                                                } else {
                                                                  return 'C';
                                                                }
                                                              }()}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .almarai(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            RichText(
                                                              textScaler:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: teamListItem
                                                                        .teamInfo
                                                                        .name,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.almarai(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              20.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  )
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .almarai(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 4.0)),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    _model.selectedGameList = stackRoomRecord
                                                                        .selectedGameList
                                                                        .toList()
                                                                        .cast<
                                                                            SelectedGameListStruct>();
                                                                    _model
                                                                        .updateSelectedGameListAtIndex(
                                                                      stackRoomRecord
                                                                          .selectedGameList
                                                                          .where((e) =>
                                                                              currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                              e.selectedGameID)
                                                                          .toList()
                                                                          .firstOrNull!
                                                                          .selectedGameIndex,
                                                                      (e) => e
                                                                        ..updateTeamInfo(
                                                                          (e) =>
                                                                              e.removeAt(teamListIndex),
                                                                        ),
                                                                    );

                                                                    await stackRoomRecord
                                                                        .reference
                                                                        .update({
                                                                      ...mapToFirestore(
                                                                        {
                                                                          'selected_game_list':
                                                                              getSelectedGameListListFirestoreData(
                                                                            _model.selectedGameList,
                                                                          ),
                                                                        },
                                                                      ),
                                                                    });
                                                                    FFAppState()
                                                                        .addToTeamInputFields(
                                                                            1);
                                                                    FFAppState()
                                                                        .update(
                                                                            () {});
                                                                  },
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '5l4lverp' /* Delete */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.almarai(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 14.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 8.0)),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final inputfileds = FFAppState()
                                                    .teamInputFields
                                                    .toList()
                                                    .take(3)
                                                    .toList();

                                                return ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: inputfileds.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 12.0),
                                                  itemBuilder: (context,
                                                      inputfiledsIndex) {
                                                    final inputfiledsItem =
                                                        inputfileds[
                                                            inputfiledsIndex];
                                                    return GameZoneTeamWidget(
                                                      key: Key(
                                                          'Keymof_${inputfiledsIndex}_of_${inputfileds.length}'),
                                                      room: stackRoomRecord,
                                                      index: inputfiledsIndex,
                                                      selectedIndex: stackRoomRecord
                                                          .selectedGameList
                                                          .where((e) =>
                                                              currentUserDocument
                                                                  ?.presentRoomGameInfo
                                                                  ?.roomSelectedGameID ==
                                                              e.selectedGameID)
                                                          .toList()
                                                          .firstOrNull
                                                          ?.selectedGameIndex,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      if (_model.teamLimit ==
                                                          2) {
                                                        if (valueOrDefault<int>(
                                                              stackRoomRecord
                                                                  .selectedGameList
                                                                  .where((e) =>
                                                                      currentUserDocument
                                                                          ?.presentRoomGameInfo
                                                                          ?.roomSelectedGameID ==
                                                                      e.selectedGameID)
                                                                  .toList()
                                                                  .firstOrNull
                                                                  ?.teamInfo
                                                                  ?.length,
                                                              0,
                                                            ) !=
                                                            2) {
                                                          await showDialog(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return WebViewAware(
                                                                child:
                                                                    AlertDialog(
                                                                  content: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getVariableText(
                                                                    enText:
                                                                        'Please save your team names to start.',
                                                                    arText:
                                                                        'الرجاء حفظ أسماء فريقك للبدء.',
                                                                  )),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                      child: Text(
                                                                          FFLocalizations.of(context)
                                                                              .getVariableText(
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
                                                          return;
                                                        }
                                                      } else {
                                                        if (_model.teamLimit ==
                                                            3) {
                                                          if (valueOrDefault<
                                                                  int>(
                                                                stackRoomRecord
                                                                    .selectedGameList
                                                                    .where((e) =>
                                                                        currentUserDocument
                                                                            ?.presentRoomGameInfo
                                                                            ?.roomSelectedGameID ==
                                                                        e.selectedGameID)
                                                                    .toList()
                                                                    .firstOrNull
                                                                    ?.teamInfo
                                                                    ?.length,
                                                                0,
                                                              ) !=
                                                              3) {
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
                                                                          'Please save your team names to start.',
                                                                      arText:
                                                                          'الرجاء حفظ أسماء فريقك للبدء.',
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
                                                            return;
                                                          }
                                                        } else {
                                                          if (_model
                                                                  .teamLimit ==
                                                              1) {
                                                            if (valueOrDefault<
                                                                    int>(
                                                                  stackRoomRecord
                                                                      .selectedGameList
                                                                      .where((e) =>
                                                                          currentUserDocument
                                                                              ?.presentRoomGameInfo
                                                                              ?.roomSelectedGameID ==
                                                                          e.selectedGameID)
                                                                      .toList()
                                                                      .firstOrNull
                                                                      ?.teamInfo
                                                                      ?.length,
                                                                  0,
                                                                ) !=
                                                                1) {
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
                                                                            'Please save your team names to start.',
                                                                        arText:
                                                                            'الرجاء حفظ أسماء فريقك للبدء.',
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
                                                              return;
                                                            }
                                                          }
                                                        }
                                                      }

                                                      _model.widgetStatus =
                                                          'player';
                                                      FFAppState()
                                                          .gameZoneSteps = 2;
                                                      FFAppState()
                                                          .update(() {});
                                                    },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      '1hpvdt63' /* Next */,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: 50.0,
                                                      padding:
                                                          EdgeInsets.all(0.0),
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
                                                                          .w600,
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
                                                                        .w600,
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
                                              ].divide(SizedBox(width: 16.0)),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'xyadhkfp' /* Players can play as one team a... */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.almarai(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ),
                                  if (FFAppState().gameZoneSteps == 2)
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'puuwwqoc' /* Choose Topic */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font: GoogleFonts
                                                                    .almarai(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        RichText(
                                                          textScaler:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '7bi25ttd' /* Choose  */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .almarai(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    _model.topicLimit ==
                                                                            3
                                                                        ? '3'
                                                                        : '6',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .almarai(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              TextSpan(
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '2t98int0' /*  Topics to start the game */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .almarai(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                              )
                                                            ],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .almarai(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 4.0)),
                                                    ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      _model.selectedGameList =
                                                          stackRoomRecord
                                                              .selectedGameList
                                                              .toList()
                                                              .cast<
                                                                  SelectedGameListStruct>();
                                                      _model.selectedTopicStatus =
                                                          'notFound';
                                                      _model.count = stackRoomRecord
                                                          .selectedGameList
                                                          .where((e) =>
                                                              currentUserDocument
                                                                  ?.presentRoomGameInfo
                                                                  ?.roomSelectedGameID ==
                                                              e.selectedGameID)
                                                          .toList()
                                                          .firstOrNull
                                                          ?.selectedTopicIDList
                                                          ?.length;
                                                      _model.selectedTopicList = stackRoomRecord
                                                          .selectedGameList
                                                          .where((e) =>
                                                              currentUserDocument
                                                                  ?.presentRoomGameInfo
                                                                  ?.roomSelectedGameID ==
                                                              e.selectedGameID)
                                                          .toList()
                                                          .firstOrNull!
                                                          .selectedTopicIDList
                                                          .toList()
                                                          .cast<int>();
                                                      if (stackRoomRecord
                                                              .selectedGameList
                                                              .where((e) =>
                                                                  currentUserDocument
                                                                      ?.presentRoomGameInfo
                                                                      ?.roomSelectedGameID ==
                                                                  e.selectedGameID)
                                                              .toList()
                                                              .firstOrNull!
                                                              .selectedTopicIDList
                                                              .length >
                                                          _model.topicLimit!) {
                                                        while (_model
                                                                .selectedTopicList
                                                                .length !=
                                                            _model.topicLimit) {
                                                          _model.removeAtIndexFromSelectedTopicList(
                                                              _model.selectedTopicList
                                                                      .length -
                                                                  1);
                                                        }
                                                      } else {
                                                        _model.topicResult =
                                                            await queryTopicRecordOnce(
                                                          queryBuilder:
                                                              (topicRecord) =>
                                                                  topicRecord
                                                                      .where(
                                                                        'topic_status',
                                                                        isEqualTo:
                                                                            'active',
                                                                      )
                                                                      .where(
                                                                        'game_ID',
                                                                        arrayContains: stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                                e.selectedGameID)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.gameId,
                                                                      ),
                                                        );
                                                        while (_model
                                                                .selectedTopicList
                                                                .length !=
                                                            _model.topicLimit) {
                                                          _model.selectedTopicStatus =
                                                              'notFound';
                                                          _model.count = _model
                                                              .selectedTopicList
                                                              .length;
                                                          _model.randomIndex =
                                                              random_data.randomInteger(
                                                                  0,
                                                                  _model.topicResult!
                                                                          .length -
                                                                      1);
                                                          while (_model.count! >
                                                              0) {
                                                            if (_model
                                                                    .selectedTopicList
                                                                    .elementAtOrNull(
                                                                        (_model.count!) -
                                                                            1) ==
                                                                _model
                                                                    .topicResult
                                                                    ?.elementAtOrNull(
                                                                        _model
                                                                            .randomIndex!)
                                                                    ?.topicID) {
                                                              _model.selectedTopicStatus =
                                                                  'found';
                                                              break;
                                                            }
                                                            _model
                                                                .count = (_model
                                                                    .count!) -
                                                                1;
                                                          }
                                                          if ((_model.selectedTopicStatus ==
                                                                  'notFound') &&
                                                              (stackRoomRecord
                                                                      .selectedGameList
                                                                      .where((e) =>
                                                                          currentUserDocument
                                                                              ?.presentRoomGameInfo
                                                                              ?.roomSelectedGameID ==
                                                                          e.selectedGameID)
                                                                      .toList()
                                                                      .firstOrNull!
                                                                      .selectedTopicIDList
                                                                      .length <
                                                                  _model.topicLimit!)) {
                                                            _model.addToSelectedTopicList(_model
                                                                .topicResult!
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .randomIndex!)!
                                                                .topicID);
                                                          }
                                                        }
                                                      }

                                                      _model
                                                          .updateSelectedGameListAtIndex(
                                                        stackRoomRecord
                                                            .selectedGameList
                                                            .where((e) =>
                                                                currentUserDocument
                                                                    ?.presentRoomGameInfo
                                                                    ?.roomSelectedGameID ==
                                                                e.selectedGameID)
                                                            .toList()
                                                            .firstOrNull!
                                                            .selectedGameIndex,
                                                        (e) => e
                                                          ..selectedTopicIDList =
                                                              _model
                                                                  .selectedTopicList
                                                                  .toList(),
                                                      );

                                                      await stackRoomRecord
                                                          .reference
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

                                                      safeSetState(() {});
                                                    },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'jp0g7mp3' /* Random */,
                                                    ),
                                                    icon: Icon(
                                                      Icons.shuffle_rounded,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      height: 30.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  8.0,
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
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        valueOrDefault<String>(
                                                          ((_model
                                                                      .topicLimit!) -
                                                                  valueOrDefault<
                                                                      int>(
                                                                    stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                            e.selectedGameID)
                                                                        .toList()
                                                                        .firstOrNull
                                                                        ?.selectedTopicIDList
                                                                        ?.length,
                                                                    0,
                                                                  ))
                                                              .toString(),
                                                          '0',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .almarai(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '8pp40n36' /* remaining */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .almarai(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 4.0)),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 8.0),
                                                child: FlutterFlowChoiceChips(
                                                  options: [
                                                    ChipData(FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'vlrjwjug' /* 3 Topics */,
                                                    )),
                                                    ChipData(FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'weaxqgxp' /* 6 Topics */,
                                                    ))
                                                  ],
                                                  onChanged: (val) async {
                                                    safeSetState(() => _model
                                                            .topicsChipsValue =
                                                        val?.firstOrNull);
                                                    _model.selectedGameList =
                                                        stackRoomRecord
                                                            .selectedGameList
                                                            .toList()
                                                            .cast<
                                                                SelectedGameListStruct>();
                                                    _model.count = stackRoomRecord
                                                        .selectedGameList
                                                        .where((e) =>
                                                            currentUserDocument
                                                                ?.presentRoomGameInfo
                                                                ?.roomSelectedGameID ==
                                                            e.selectedGameID)
                                                        .toList()
                                                        .firstOrNull
                                                        ?.selectedTopicIDList
                                                        ?.length;
                                                    _model.selectedTopicList =
                                                        stackRoomRecord
                                                            .selectedGameList
                                                            .where((e) =>
                                                                currentUserDocument
                                                                    ?.presentRoomGameInfo
                                                                    ?.roomSelectedGameID ==
                                                                e.selectedGameID)
                                                            .toList()
                                                            .firstOrNull!
                                                            .selectedTopicIDList
                                                            .toList()
                                                            .cast<int>();
                                                    _model.topicLimit =
                                                        _model.topicsChipsValue ==
                                                                '3 Topics'
                                                            ? 3
                                                            : 6;
                                                    while (_model.count! > 0) {
                                                      if (_model
                                                              .selectedGameList
                                                              .elementAtOrNull(stackRoomRecord
                                                                  .selectedGameList
                                                                  .where((e) =>
                                                                      currentUserDocument
                                                                          ?.presentRoomGameInfo
                                                                          ?.roomSelectedGameID ==
                                                                      e.selectedGameID)
                                                                  .toList()
                                                                  .firstOrNull!
                                                                  .selectedGameIndex)!
                                                              .selectedTopicIDList
                                                              .length >
                                                          _model.topicLimit!) {
                                                        _model
                                                            .updateSelectedGameListAtIndex(
                                                          stackRoomRecord
                                                              .selectedGameList
                                                              .where((e) =>
                                                                  currentUserDocument
                                                                      ?.presentRoomGameInfo
                                                                      ?.roomSelectedGameID ==
                                                                  e.selectedGameID)
                                                              .toList()
                                                              .firstOrNull!
                                                              .selectedGameIndex,
                                                          (e) => e
                                                            ..updateSelectedTopicIDList(
                                                              (e) => e.remove(_model
                                                                  .selectedTopicList
                                                                  .elementAtOrNull(
                                                                      (_model.count!) -
                                                                          1)),
                                                            ),
                                                        );
                                                      } else {
                                                        break;
                                                      }

                                                      _model.count =
                                                          (_model.count!) - 1;
                                                    }

                                                    await widget!.room!.update({
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
                                                  },
                                                  selectedChipStyle: ChipStyle(
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    textStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .almarai(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
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
                                                    iconColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                    iconSize: 24.0,
                                                    labelPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 4.0,
                                                                8.0, 4.0),
                                                    elevation: 0.0,
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    borderWidth: 0.5,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  unselectedChipStyle:
                                                      ChipStyle(
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    textStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .almarai(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
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
                                                    iconColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    iconSize: 24.0,
                                                    labelPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 4.0,
                                                                8.0, 4.0),
                                                    elevation: 0.0,
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    borderWidth: 0.5,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  chipSpacing: 16.0,
                                                  rowSpacing: 16.0,
                                                  multiselect: false,
                                                  initialized:
                                                      _model.topicsChipsValue !=
                                                          null,
                                                  alignment:
                                                      WrapAlignment.center,
                                                  controller: _model
                                                          .topicsChipsValueController ??=
                                                      FormFieldController<
                                                          List<String>>(
                                                    [
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ycnro8r3' /* 3 Topics */,
                                                      )
                                                    ],
                                                  ),
                                                  wrapped: true,
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            if (stackRoomRecord
                                                                    .selectedGameList
                                                                    .where((e) =>
                                                                        currentUserDocument
                                                                            ?.presentRoomGameInfo
                                                                            ?.roomSelectedGameID ==
                                                                        e.selectedGameID)
                                                                    .toList()
                                                                    .firstOrNull
                                                                    ?.selectedTopicIDList
                                                                    ?.length ==
                                                                _model.topicLimit) {
                                                              if (columnGameRecord
                                                                      ?.gameID ==
                                                                  1001) {
                                                                if (stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                            e.selectedGameID)
                                                                        .toList()
                                                                        .firstOrNull
                                                                        ?.teamInfo
                                                                        ?.length ==
                                                                    1) {
                                                                  _model.selectedGameList = stackRoomRecord
                                                                      .selectedGameList
                                                                      .toList()
                                                                      .cast<
                                                                          SelectedGameListStruct>();
                                                                  _model
                                                                      .updateSelectedGameListAtIndex(
                                                                    stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                            e.selectedGameID)
                                                                        .toList()
                                                                        .firstOrNull!
                                                                        .selectedGameIndex,
                                                                    (e) => e
                                                                      ..updateTeamInfo(
                                                                        (e) => e
                                                                            .add(TeamInfoStruct(
                                                                          createdAt:
                                                                              getCurrentTimestamp,
                                                                          updatedAt:
                                                                              getCurrentTimestamp,
                                                                          teamStatus:
                                                                              'active',
                                                                          teamID:
                                                                              999,
                                                                          teamInfo:
                                                                              MainInfoStruct(
                                                                            name:
                                                                                'Computer',
                                                                          ),
                                                                          totalResult:
                                                                              0,
                                                                        )),
                                                                      )
                                                                      ..teamLimit =
                                                                          _model
                                                                              .teamLimit
                                                                      ..gameTossWinTeamId = stackRoomRecord
                                                                          .selectedGameList
                                                                          .lastOrNull
                                                                          ?.teamInfo
                                                                          ?.firstOrNull
                                                                          ?.teamID
                                                                      ..gameTosswinTeamIndex =
                                                                          0
                                                                      ..presentTeamID = stackRoomRecord
                                                                          .selectedGameList
                                                                          .lastOrNull
                                                                          ?.teamInfo
                                                                          ?.firstOrNull
                                                                          ?.teamID
                                                                      ..presentTeamIndex =
                                                                          0,
                                                                  );

                                                                  await stackRoomRecord
                                                                      .reference
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
                                                                }
                                                                FFAppState()
                                                                    .gameZoneSteps = 4;

                                                                context.goNamed(
                                                                  GameOneS1Widget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'room':
                                                                        serializeParam(
                                                                      widget!
                                                                          .room,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              }
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
                                                                          '${FFLocalizations.of(context).getVariableText(
                                                                        enText:
                                                                            ' Please select remaining topics. (',
                                                                        arText:
                                                                            'الرجاء تحديد المواضيع المتبقية.',
                                                                      )}${valueOrDefault<String>(
                                                                        ((_model.topicLimit!) -
                                                                                valueOrDefault<int>(
                                                                                  stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.selectedTopicIDList?.length,
                                                                                  0,
                                                                                ))
                                                                            .toString(),
                                                                        '0',
                                                                      )})'),
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
                                                              return;
                                                            }
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'na7wv1xz' /* Start the game */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                1.0,
                                                            height: 50.0,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                            e
                                                                                .selectedGameID)
                                                                        .toList()
                                                                        .firstOrNull
                                                                        ?.selectedTopicIDList
                                                                        ?.length ==
                                                                    _model
                                                                        .topicLimit
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
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
                                                                      color: stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.selectedTopicIDList?.length ==
                                                                              _model
                                                                                  .topicLimit
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryBackground
                                                                          : FlutterFlowTheme.of(context)
                                                                              .secondaryText,
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyLarge
                                                                          .fontStyle,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              width: 0.5,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: StreamBuilder<
                                                    List<TopicRecord>>(
                                                  stream: queryTopicRecord(
                                                    queryBuilder:
                                                        (topicRecord) =>
                                                            topicRecord
                                                                .where(
                                                                  'topic_status',
                                                                  isEqualTo:
                                                                      'active',
                                                                )
                                                                .where(
                                                                  'game_ID',
                                                                  arrayContains: stackRoomRecord
                                                                      .selectedGameList
                                                                      .where((e) =>
                                                                          currentUserDocument
                                                                              ?.presentRoomGameInfo
                                                                              ?.roomSelectedGameID ==
                                                                          e.selectedGameID)
                                                                      .toList()
                                                                      .firstOrNull
                                                                      ?.gameId,
                                                                ),
                                                  ),
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
                                                    List<TopicRecord>
                                                        gridViewTopicRecordList =
                                                        snapshot.data!;

                                                    return GridView.builder(
                                                      padding: EdgeInsets.zero,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width <
                                                                kBreakpointMedium
                                                            ? 3
                                                            : 7,
                                                        crossAxisSpacing: 8.0,
                                                        mainAxisSpacing: 8.0,
                                                        childAspectRatio: 0.75,
                                                      ),
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          gridViewTopicRecordList
                                                              .length,
                                                      itemBuilder: (context,
                                                          gridViewIndex) {
                                                        final gridViewTopicRecord =
                                                            gridViewTopicRecordList[
                                                                gridViewIndex];
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child: Stack(
                                                                children: [
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      _model.selectedGameList = stackRoomRecord
                                                                          .selectedGameList
                                                                          .toList()
                                                                          .cast<
                                                                              SelectedGameListStruct>();
                                                                      _model.selectedTopicStatus =
                                                                          'notFound';
                                                                      _model.count = stackRoomRecord
                                                                          .selectedGameList
                                                                          .where((e) =>
                                                                              currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                              e.selectedGameID)
                                                                          .toList()
                                                                          .firstOrNull
                                                                          ?.selectedTopicIDList
                                                                          ?.length;
                                                                      _model.selectedTopicList = stackRoomRecord
                                                                          .selectedGameList
                                                                          .where((e) =>
                                                                              currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                              e.selectedGameID)
                                                                          .toList()
                                                                          .firstOrNull!
                                                                          .selectedTopicIDList
                                                                          .toList()
                                                                          .cast<int>();
                                                                      while (_model
                                                                              .count! >
                                                                          0) {
                                                                        if (_model.selectedTopicList.elementAtOrNull((_model.count!) -
                                                                                1) ==
                                                                            gridViewTopicRecord.topicID) {
                                                                          _model
                                                                              .updateSelectedGameListAtIndex(
                                                                            stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull!.selectedGameIndex,
                                                                            (e) => e
                                                                              ..updateSelectedTopicIDList(
                                                                                (e) => e.remove(gridViewTopicRecord.topicID),
                                                                              ),
                                                                          );
                                                                          _model.selectedTopicStatus =
                                                                              'found';
                                                                          break;
                                                                        }
                                                                        _model.count =
                                                                            (_model.count!) -
                                                                                1;
                                                                      }
                                                                      if ((_model.selectedTopicStatus ==
                                                                              'notFound') &&
                                                                          (stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull!.selectedTopicIDList.length <
                                                                              _model.topicLimit!)) {
                                                                        _model
                                                                            .updateSelectedGameListAtIndex(
                                                                          stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID)
                                                                              .toList()
                                                                              .firstOrNull!
                                                                              .selectedGameIndex,
                                                                          (e) => e
                                                                            ..updateSelectedTopicIDList(
                                                                              (e) => e.add(gridViewTopicRecord.topicID),
                                                                            ),
                                                                        );
                                                                      }

                                                                      await stackRoomRecord
                                                                          .reference
                                                                          .update({
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'selected_game_list':
                                                                                getSelectedGameListListFirestoreData(
                                                                              _model.selectedGameList,
                                                                            ),
                                                                          },
                                                                        ),
                                                                      });
                                                                    },
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            1.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          image:
                                                                              DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            image:
                                                                                Image.network(
                                                                              valueOrDefault<String>(
                                                                                gridViewTopicRecord.topicInfo.mainImage,
                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/y8i24cl1b5bt/Splash_Screen_(2)-min.jpg',
                                                                              ),
                                                                            ).image,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                          border:
                                                                              Border.all(
                                                                            color: stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.selectedTopicIDList?.contains(gridViewTopicRecord.topicID) == true
                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (stackRoomRecord
                                                                          .selectedGameList
                                                                          .where((e) =>
                                                                              currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                              e.selectedGameID)
                                                                          .toList()
                                                                          .firstOrNull
                                                                          ?.selectedTopicIDList
                                                                          ?.contains(gridViewTopicRecord.topicID) ==
                                                                      true)
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1.0,
                                                                              -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              24.0,
                                                                          height:
                                                                              24.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
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
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Icon(
                                                                            Icons.check_sharp,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).success,
                                                                            size:
                                                                                18.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 30.0,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getVariableText(
                                                                  enText: () {
                                                                    if (gridViewTopicRecord
                                                                            .topicInfoManualTranslate
                                                                            .name
                                                                            .en !=
                                                                        '') {
                                                                      return gridViewTopicRecord
                                                                          .topicInfoManualTranslate
                                                                          .name
                                                                          .en;
                                                                    } else if (gridViewTopicRecord
                                                                            .topicInfoTranslate
                                                                            .name
                                                                            .en !=
                                                                        '') {
                                                                      return gridViewTopicRecord
                                                                          .topicInfoTranslate
                                                                          .name
                                                                          .en;
                                                                    } else {
                                                                      return gridViewTopicRecord
                                                                          .topicInfo
                                                                          .name;
                                                                    }
                                                                  }(),
                                                                  arText: () {
                                                                    if (gridViewTopicRecord
                                                                            .topicInfoManualTranslate
                                                                            .name
                                                                            .ar !=
                                                                        '') {
                                                                      return gridViewTopicRecord
                                                                          .topicInfoManualTranslate
                                                                          .name
                                                                          .ar;
                                                                    } else if (gridViewTopicRecord
                                                                            .topicInfoTranslate
                                                                            .name
                                                                            .ar !=
                                                                        '') {
                                                                      return gridViewTopicRecord
                                                                          .topicInfoTranslate
                                                                          .name
                                                                          .ar;
                                                                    } else {
                                                                      return gridViewTopicRecord
                                                                          .topicInfo
                                                                          .name;
                                                                    }
                                                                  }(),
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 2,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .almarai(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.selectedTopicIDList?.contains(gridViewTopicRecord.topicID) ==
                                                                              true
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primary
                                                                          : FlutterFlowTheme.of(context)
                                                                              .primaryText,
                                                                      fontSize:
                                                                          13.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 6.0)),
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
                                  if (FFAppState().gameZoneSteps == 3)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child: Image.asset(
                                                          'assets/images/think.png',
                                                          width: 200.0,
                                                          height: 200.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      stackRoomRecord
                                                          .selectedGameList
                                                          .where((e) =>
                                                              currentUserDocument
                                                                  ?.presentRoomGameInfo
                                                                  ?.roomSelectedGameID ==
                                                              e.selectedGameID)
                                                          .toList()
                                                          .firstOrNull!
                                                          .gameInfo
                                                          .name,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyLarge
                                                          .override(
                                                            font: GoogleFonts
                                                                .almarai(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    FFIcons.kfi50,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 20.0,
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                            ),
                                            Divider(
                                              height: 2.0,
                                              thickness: 1.0,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        's33aoh1r' /* Available teams */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .almarai(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    )
                                                  ],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.almarai(
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
                                                        letterSpacing: 0.0,
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
                                                ),
                                              ),
                                            ),
                                            if (responsiveVisibility(
                                              context: context,
                                              phone: false,
                                              tablet: false,
                                              tabletLandscape: false,
                                              desktop: false,
                                            ))
                                              Stack(
                                                children: [
                                                  TextFormField(
                                                    controller: _model
                                                        .nameTextController,
                                                    focusNode:
                                                        _model.nameFocusNode,
                                                    autofocus: false,
                                                    autofillHints: [
                                                      AutofillHints.email
                                                    ],
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .almarai(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintText:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                        'jyhif53w' /* Team ‘B’ name here... */,
                                                      ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .almarai(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  100.0,
                                                                  0.0),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .plusJakartaSans(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                    maxLength: 30,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .enforced,
                                                    buildCounter: (context,
                                                            {required currentLength,
                                                            required isFocused,
                                                            maxLength}) =>
                                                        null,
                                                    validator: _model
                                                        .nameTextControllerValidator
                                                        .asValidator(context),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              '^[a-zA-z\\s]+\$'))
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, -1.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  16.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'zzw1w8rz' /* Save */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .almarai(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final teamList2 = (stackRoomRecord
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
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: List.generate(
                                                        teamList2.length,
                                                        (teamList2Index) {
                                                      final teamList2Item =
                                                          teamList2[
                                                              teamList2Index];
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          FFButtonWidget(
                                                            onPressed: () {
                                                              print(
                                                                  'Button pressed ...');
                                                            },
                                                            text: 'Team ${() {
                                                              if (teamList2Index ==
                                                                  0) {
                                                                return 'A';
                                                              } else if (teamList2Index ==
                                                                  1) {
                                                                return 'B';
                                                              } else {
                                                                return 'C';
                                                              }
                                                            }()}',
                                                            options:
                                                                FFButtonOptions(
                                                              height: 50.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          0.0,
                                                                          24.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .warning,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .almarai(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                width: 0.5,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                          ),
                                                          Text(
                                                            teamList2Item
                                                                .teamInfo.name,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .almarai(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 6.0)),
                                                      );
                                                    }).divide(
                                                        SizedBox(width: 16.0)),
                                                  );
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  if (columnGameRecord
                                                          ?.gameID ==
                                                      1001) {
                                                    context.pushNamed(
                                                      GameOneS1Widget.routeName,
                                                      queryParameters: {
                                                        'room': serializeParam(
                                                          widget!.room,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  }
                                                },
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'dqo6443w' /* Start the game */,
                                                ),
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 55.0,
                                                  padding: EdgeInsets.all(0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.almarai(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
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
                                          ].divide(SizedBox(height: 8.0)),
                                        ),
                                      ),
                                    ),
                                  if (FFAppState().gameZoneSteps == 3)
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 16.0),
                                        child: StreamBuilder<List<UsersRecord>>(
                                          stream: queryUsersRecord(
                                            queryBuilder: (usersRecord) =>
                                                usersRecord.where(
                                              'status',
                                              isEqualTo: 'Publish',
                                            ),
                                          ),
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
                                            List<UsersRecord>
                                                step3BUsersRecordList =
                                                snapshot.data!;

                                            return Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'brhaoc2g' /* Players Info */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .almarai(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyLarge
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            RichText(
                                                              textScaler:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: valueOrDefault<
                                                                        String>(
                                                                      stackRoomRecord
                                                                          .selectedGameList
                                                                          .where((e) =>
                                                                              currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID ==
                                                                              e.selectedGameID)
                                                                          .toList()
                                                                          .firstOrNull
                                                                          ?.selectedGameUserList
                                                                          ?.length
                                                                          ?.toString(),
                                                                      '0 ',
                                                                    ),
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
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
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
                                                                  TextSpan(
                                                                    text: FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'ux7g7kgr' /* Joined */,
                                                                    ),
                                                                    style:
                                                                        TextStyle(),
                                                                  )
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .almarai(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
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
                                                      ].divide(
                                                          SizedBox(width: 8.0)),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 400.0,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                Alignment(
                                                                    0.0, 0),
                                                            child: TabBar(
                                                              labelColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              unselectedLabelColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .almarai(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                              unselectedLabelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .almarai(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                              indicatorColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              indicatorWeight:
                                                                  1.0,
                                                              tabs: [
                                                                Tab(
                                                                  text: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'sktboya0' /* Active */,
                                                                  ),
                                                                ),
                                                                Tab(
                                                                  text: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'getc8whw' /* Viewer */,
                                                                  ),
                                                                ),
                                                              ],
                                                              controller: _model
                                                                  .tabBarController,
                                                              onTap: (i) async {
                                                                [
                                                                  () async {},
                                                                  () async {}
                                                                ][i]();
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: TabBarView(
                                                              controller: _model
                                                                  .tabBarController,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final activeUserList =
                                                                              stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.selectedGameUserList?.toList() ?? [];
                                                                          if (activeUserList
                                                                              .isEmpty) {
                                                                            return Center(
                                                                              child: EmptyWidgetRoomWidget(),
                                                                            );
                                                                          }

                                                                          return ListView
                                                                              .separated(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            primary:
                                                                                false,
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            itemCount:
                                                                                activeUserList.length,
                                                                            separatorBuilder: (_, __) =>
                                                                                SizedBox(height: 12.0),
                                                                            itemBuilder:
                                                                                (context, activeUserListIndex) {
                                                                              final activeUserListItem = activeUserList[activeUserListIndex];
                                                                              return Wrap(
                                                                                spacing: 8.0,
                                                                                runSpacing: 8.0,
                                                                                alignment: WrapAlignment.start,
                                                                                crossAxisAlignment: WrapCrossAlignment.start,
                                                                                direction: Axis.horizontal,
                                                                                runAlignment: WrapAlignment.start,
                                                                                verticalDirection: VerticalDirection.down,
                                                                                clipBehavior: Clip.none,
                                                                                children: [
                                                                                  if (activeUserListItem.roomUserStatus == 'active')
                                                                                    InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        var _shouldSetState = false;
                                                                                        _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                                        _model.count = stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.selectedGameUserList?.length;
                                                                                        _model.selectedGameUserList = stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull!.selectedGameUserList.toList().cast<RoomUserListStruct>();
                                                                                        _model.selectedUserStatus = 'notFound';
                                                                                        while (_model.count! > 0) {
                                                                                          if ((_model.selectedGameUserList.elementAtOrNull((_model.count!) - 1)?.roomUserRef == activeUserListItem.roomUserRef) && (_model.selectedGameUserList.elementAtOrNull((_model.count!) - 1)?.roomUserNotificationSendStatus == '')) {
                                                                                            _model.updateSelectedGameListAtIndex(
                                                                                              stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull!.selectedGameIndex,
                                                                                              (e) => e
                                                                                                ..updateSelectedGameUserList(
                                                                                                  (e) => e[(_model.count!) - 1]..roomUserNotificationSendStatus = 'send',
                                                                                                ),
                                                                                            );
                                                                                            _model.selectedUserStatus = 'found';
                                                                                            break;
                                                                                          }
                                                                                          _model.count = (_model.count!) - 1;
                                                                                        }
                                                                                        if (_model.selectedUserStatus == 'notFound') {
                                                                                          await showDialog(
                                                                                            context: context,
                                                                                            builder: (alertDialogContext) {
                                                                                              return WebViewAware(
                                                                                                child: AlertDialog(
                                                                                                  content: Text(FFLocalizations.of(context).getVariableText(
                                                                                                    enText: 'Already added in game.',
                                                                                                    arText: 'تمت إضافته بالفعل إلى اللعبة.',
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
                                                                                          if (_shouldSetState) safeSetState(() {});
                                                                                          return;
                                                                                        }
                                                                                        if (_model.selectedUserStatus == 'found') {
                                                                                          _model.idmapNotificationResult2 = await queryIDmapRecordOnce(
                                                                                            queryBuilder: (iDmapRecord) => iDmapRecord.where(
                                                                                              'type',
                                                                                              isEqualTo: 'Main',
                                                                                            ),
                                                                                            singleRecord: true,
                                                                                          ).then((s) => s.firstOrNull);
                                                                                          _shouldSetState = true;

                                                                                          await NotificationRecord.collection.doc().set(createNotificationRecordData(
                                                                                                createdAt: getCurrentTimestamp,
                                                                                                updatedAt: getCurrentTimestamp,
                                                                                                notificationID: _model.idmapNotificationResult2?.notificationId,
                                                                                                notificationStatus: 'send',
                                                                                                toUserRef: activeUserListItem.roomUserRef,
                                                                                                fromUserRef: currentUserReference,
                                                                                                notificationType: 'game_invite',
                                                                                                gameInfo: updateGameInfoStruct(
                                                                                                  GameInfoStruct(
                                                                                                    roomId: stackRoomRecord.roomID,
                                                                                                    roomInfo: stackRoomRecord.roomMainInfo,
                                                                                                    gameID: columnGameRecord?.gameID,
                                                                                                    gameInfo: columnGameRecord?.gameInfo,
                                                                                                    gameInviteTime: getCurrentTimestamp,
                                                                                                    gameInviteStatus: 'game_invite',
                                                                                                    fromUserId: valueOrDefault(currentUserDocument?.userId, 0),
                                                                                                    fromUserRef: currentUserReference,
                                                                                                    roomUserSelectedGameId: valueOrDefault<int>(
                                                                                                      stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.selectedGameID,
                                                                                                      0,
                                                                                                    ),
                                                                                                    fromUserName: currentUserDisplayName,
                                                                                                  ),
                                                                                                  clearUnsetFields: false,
                                                                                                  create: true,
                                                                                                ),
                                                                                              ));

                                                                                          await _model.idmapNotificationResult2!.reference.update({
                                                                                            ...mapToFirestore(
                                                                                              {
                                                                                                'notification_id': FieldValue.increment(1),
                                                                                              },
                                                                                            ),
                                                                                          });
                                                                                        }

                                                                                        await stackRoomRecord.reference.update({
                                                                                          ...mapToFirestore(
                                                                                            {
                                                                                              'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                _model.selectedGameList,
                                                                                              ),
                                                                                            },
                                                                                          ),
                                                                                        });
                                                                                        if (_shouldSetState) safeSetState(() {});
                                                                                      },
                                                                                      child: GameOneUserWidget(
                                                                                        key: Key('Keyaly_${activeUserListIndex}_of_${activeUserList.length}'),
                                                                                        roomUser: activeUserListItem,
                                                                                        user: activeUserListItem.roomUserRef!,
                                                                                        index: activeUserListIndex,
                                                                                        room: stackRoomRecord,
                                                                                        inviteStatus: false,
                                                                                        activeStatus: false,
                                                                                        addStatus: false,
                                                                                        selectedGameIndex: 0,
                                                                                      ),
                                                                                    ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ]
                                                                      .addToStart(SizedBox(
                                                                          height:
                                                                              8.0))
                                                                      .addToEnd(SizedBox(
                                                                          height:
                                                                              8.0)),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final inviteUserList =
                                                                              stackRoomRecord.selectedGameList.where((e) => currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID == e.selectedGameID).toList().firstOrNull?.selectedGameUserList?.toList() ?? [];
                                                                          if (inviteUserList
                                                                              .isEmpty) {
                                                                            return Center(
                                                                              child: EmptyWidgetRoomWidget(),
                                                                            );
                                                                          }

                                                                          return ListView
                                                                              .separated(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            primary:
                                                                                false,
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            itemCount:
                                                                                inviteUserList.length,
                                                                            separatorBuilder: (_, __) =>
                                                                                SizedBox(height: 12.0),
                                                                            itemBuilder:
                                                                                (context, inviteUserListIndex) {
                                                                              final inviteUserListItem = inviteUserList[inviteUserListIndex];
                                                                              return Wrap(
                                                                                spacing: 8.0,
                                                                                runSpacing: 8.0,
                                                                                alignment: WrapAlignment.start,
                                                                                crossAxisAlignment: WrapCrossAlignment.start,
                                                                                direction: Axis.horizontal,
                                                                                runAlignment: WrapAlignment.start,
                                                                                verticalDirection: VerticalDirection.down,
                                                                                clipBehavior: Clip.none,
                                                                                children: [
                                                                                  if (inviteUserListItem.roomUserNotificationSendStatus != '')
                                                                                    GameOneUserWidget(
                                                                                      key: Key('Keyj6t_${inviteUserListIndex}_of_${inviteUserList.length}'),
                                                                                      roomUser: inviteUserListItem,
                                                                                      user: inviteUserListItem.roomUserRef!,
                                                                                      index: inviteUserListIndex,
                                                                                      room: stackRoomRecord,
                                                                                      inviteStatus: false,
                                                                                      activeStatus: false,
                                                                                      addStatus: true,
                                                                                      selectedGameIndex: 0,
                                                                                    ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ]
                                                                      .addToStart(SizedBox(
                                                                          height:
                                                                              8.0))
                                                                      .addToEnd(SizedBox(
                                                                          height:
                                                                              8.0)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 8.0)),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
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
    );
  }
}
