import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_one/game_zone_team/game_zone_team_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_four_model.dart';
export 'game_four_model.dart';

class GameFourWidget extends StatefulWidget {
  const GameFourWidget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  static String routeName = 'GameFour';
  static String routePath = '/gamefour';

  @override
  State<GameFourWidget> createState() => _GameFourWidgetState();
}

class _GameFourWidgetState extends State<GameFourWidget> {
  late GameFourModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFourModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.setOrientation();
    });

    _model.teamATextController ??= TextEditingController();
    _model.teamAFocusNode ??= FocusNode();

    _model.teamBTextController ??= TextEditingController();
    _model.teamBFocusNode ??= FocusNode();

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
                            'v1e3ej0l' /* Questions */,
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
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
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
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
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
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 8.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'jdeadgf1' /* Create Teams */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                              if (responsiveVisibility(
                                                context: context,
                                                phone: false,
                                                tablet: false,
                                                tabletLandscape: false,
                                                desktop: false,
                                              ))
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
                                                      itemCount:
                                                          teamList.length,
                                                      separatorBuilder:
                                                          (_, __) => SizedBox(
                                                              height: 16.0),
                                                      itemBuilder: (context,
                                                          teamListIndex) {
                                                        final teamListItem =
                                                            teamList[
                                                                teamListIndex];
                                                        return Row(
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
                                                                  '${FFLocalizations.of(context).getVariableText(
                                                                    enText:
                                                                        'Team',
                                                                    arText:
                                                                        'فريق',
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
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
                                                                RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: teamListItem
                                                                            .teamInfo
                                                                            .name,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .override(
                                                                              font: GoogleFonts.almarai(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 20.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
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
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
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
                                                                  MainAxisSize
                                                                      .max,
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
                                                                            .cast<SelectedGameListStruct>();
                                                                        _model
                                                                            .updateSelectedGameListAtIndex(
                                                                          stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                              .toList()
                                                                              .firstOrNull!
                                                                              .selectedGameIndex,
                                                                          (e) => e
                                                                            ..updateTeamInfo(
                                                                              (e) => e.removeAt(teamListIndex),
                                                                            ),
                                                                        );

                                                                        await stackRoomRecord
                                                                            .reference
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                _model.selectedGameList,
                                                                              ),
                                                                            },
                                                                          ),
                                                                        });
                                                                        FFAppState()
                                                                            .addToTeamInputFields(1);
                                                                        FFAppState()
                                                                            .update(() {});
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'e92sxsry' /* Delete */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.almarai(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          14.0)),
                                                                ),
                                                              ],
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 8.0)),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              if (responsiveVisibility(
                                                context: context,
                                                phone: false,
                                                tablet: false,
                                                tabletLandscape: false,
                                                desktop: false,
                                              ))
                                                Builder(
                                                  builder: (context) {
                                                    final inputfileds =
                                                        FFAppState()
                                                            .teamInputFields
                                                            .toList();

                                                    return ListView.separated(
                                                      padding: EdgeInsets.zero,
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          inputfileds.length,
                                                      separatorBuilder:
                                                          (_, __) => SizedBox(
                                                              height: 12.0),
                                                      itemBuilder: (context,
                                                          inputfiledsIndex) {
                                                        final inputfiledsItem =
                                                            inputfileds[
                                                                inputfiledsIndex];
                                                        return GameZoneTeamWidget(
                                                          key: Key(
                                                              'Key56d_${inputfiledsIndex}_of_${inputfileds.length}'),
                                                          room: stackRoomRecord,
                                                          index:
                                                              inputfiledsIndex,
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
                                              Form(
                                                key: _model.formKey,
                                                autovalidateMode:
                                                    AutovalidateMode.disabled,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      controller: _model
                                                          .teamATextController,
                                                      focusNode:
                                                          _model.teamAFocusNode,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
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
                                                                  fontSize:
                                                                      14.0,
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
                                                            '${FFLocalizations.of(context).getVariableText(
                                                          enText: 'Enter team ',
                                                          arText:
                                                              'أدخل اسم الفريق',
                                                        )}${FFLocalizations.of(context).getVariableText(
                                                          enText: ' A ',
                                                          arText: ' أ ',
                                                        )}${FFLocalizations.of(context).getVariableText(
                                                          enText: ' Name',
                                                          arText: 'اسم',
                                                        )}',
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
                                                                  fontSize:
                                                                      14.0,
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
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
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
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .plusJakartaSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
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
                                                          .teamATextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                    TextFormField(
                                                      controller: _model
                                                          .teamBTextController,
                                                      focusNode:
                                                          _model.teamBFocusNode,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
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
                                                                  fontSize:
                                                                      14.0,
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
                                                            '${FFLocalizations.of(context).getVariableText(
                                                          enText: 'Enter team ',
                                                          arText:
                                                              'أدخل اسم الفريق',
                                                        )}${FFLocalizations.of(context).getVariableText(
                                                          enText: ' B ',
                                                          arText: ' ب ',
                                                        )}${FFLocalizations.of(context).getVariableText(
                                                          enText: ' Name',
                                                          arText: 'اسم',
                                                        )}',
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
                                                                  fontSize:
                                                                      14.0,
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
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
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
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .plusJakartaSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
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
                                                          .teamBTextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ]
                                                      .divide(SizedBox(
                                                          height: 12.0))
                                                      .addToStart(
                                                          SizedBox(height: 4.0))
                                                      .addToEnd(SizedBox(
                                                          height: 4.0)),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        var _shouldSetState =
                                                            false;
                                                        if (_model.formKey
                                                                    .currentState ==
                                                                null ||
                                                            !_model.formKey
                                                                .currentState!
                                                                .validate()) {
                                                          return;
                                                        }
                                                        if (_model
                                                                .teamATextController
                                                                .text ==
                                                            _model
                                                                .teamBTextController
                                                                .text) {
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
                                                                        'Team names must be different.',
                                                                    arText:
                                                                        'لقد تم تشكيل الفريق بالفعل.',
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
                                                          if (_shouldSetState)
                                                            safeSetState(() {});
                                                          return;
                                                        } else {
                                                          if (stackRoomRecord
                                                                  .selectedGameList
                                                                  .where((e) =>
                                                                      e.selectedGameID ==
                                                                      currentUserDocument
                                                                          ?.presentRoomGameInfo
                                                                          ?.roomSelectedGameID)
                                                                  .toList()
                                                                  .firstOrNull!
                                                                  .selectedTopicIDList
                                                                  .length <=
                                                              0) {
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
                                                                          'Please select style to start the game.',
                                                                      arText:
                                                                          'الرجاء تحديد النمط لبدء اللعبة.',
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

                                                        _model.selectedGameList =
                                                            stackRoomRecord
                                                                .selectedGameList
                                                                .toList()
                                                                .cast<
                                                                    SelectedGameListStruct>();
                                                        _model.count =
                                                            stackRoomRecord
                                                                .selectedGameList
                                                                .length;
                                                        _model.selectedTeamList = stackRoomRecord
                                                            .selectedGameList
                                                            .where((e) =>
                                                                e.selectedGameID ==
                                                                currentUserDocument
                                                                    ?.presentRoomGameInfo
                                                                    ?.roomSelectedGameID)
                                                            .toList()
                                                            .firstOrNull!
                                                            .teamInfo
                                                            .toList()
                                                            .cast<
                                                                TeamInfoStruct>();
                                                        _model.countTeam = stackRoomRecord
                                                            .selectedGameList
                                                            .where((e) =>
                                                                e.selectedGameID ==
                                                                currentUserDocument
                                                                    ?.presentRoomGameInfo
                                                                    ?.roomSelectedGameID)
                                                            .toList()
                                                            .firstOrNull
                                                            ?.teamInfo
                                                            ?.length;
                                                        while (_model
                                                                .selectedTeamList
                                                                .length <
                                                            _model.teamLimit!) {
                                                          _model.idmapTeamResult1 =
                                                              await queryIDmapRecordOnce(
                                                            queryBuilder:
                                                                (iDmapRecord) =>
                                                                    iDmapRecord
                                                                        .where(
                                                              'type',
                                                              isEqualTo: 'Main',
                                                            ),
                                                            singleRecord: true,
                                                          ).then((s) => s
                                                                  .firstOrNull);
                                                          _shouldSetState =
                                                              true;
                                                          _model
                                                              .addToSelectedTeamList(
                                                                  TeamInfoStruct(
                                                            createdAt:
                                                                getCurrentTimestamp,
                                                            updatedAt:
                                                                getCurrentTimestamp,
                                                            teamStatus:
                                                                'active',
                                                            teamID: _model
                                                                .idmapTeamResult1
                                                                ?.teamId,
                                                            teamInfo:
                                                                MainInfoStruct(
                                                              name: _model.selectedTeamList
                                                                          .length ==
                                                                      0
                                                                  ? _model
                                                                      .teamATextController
                                                                      .text
                                                                  : _model
                                                                      .teamBTextController
                                                                      .text,
                                                            ),
                                                            totalResult: 0,
                                                          ));

                                                          await _model
                                                              .idmapTeamResult1!
                                                              .reference
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'team_id':
                                                                    FieldValue
                                                                        .increment(
                                                                            1),
                                                              },
                                                            ),
                                                          });
                                                          _model.count =
                                                              (_model.count!) +
                                                                  1;
                                                        }
                                                        _model.topicQuestionResult =
                                                            await queryTopicQuestionRecordOnce(
                                                          queryBuilder:
                                                              (topicQuestionRecord) =>
                                                                  topicQuestionRecord
                                                                      .where(
                                                                        'topic_id',
                                                                        isEqualTo: stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.selectedTopicIDList
                                                                            ?.firstOrNull,
                                                                      )
                                                                      .where(
                                                                        'question_status',
                                                                        isEqualTo:
                                                                            'active',
                                                                      ),
                                                        );
                                                        _shouldSetState = true;
                                                        if (_model
                                                                .topicQuestionResult!
                                                                .length >
                                                            0) {
                                                          _model.selectedGameList =
                                                              stackRoomRecord
                                                                  .selectedGameList
                                                                  .toList()
                                                                  .cast<
                                                                      SelectedGameListStruct>();
                                                          _model.selectedQuestionList =
                                                              [];
                                                          _model.selectedTopicQuestionList =
                                                              await queryTopicQuestionRecordOnce(
                                                            queryBuilder:
                                                                (topicQuestionRecord) =>
                                                                    topicQuestionRecord
                                                                        .where(
                                                                          'question_status',
                                                                          isEqualTo:
                                                                              'active',
                                                                        )
                                                                        .where(
                                                                          'topic_id',
                                                                          isEqualTo: stackRoomRecord
                                                                              .selectedGameList
                                                                              .where((e) => e.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.selectedTopicIDList
                                                                              ?.firstOrNull,
                                                                        ),
                                                          );
                                                          _shouldSetState =
                                                              true;
                                                          if (functions
                                                                  .shuffleQuestions(_model
                                                                      .selectedTopicQuestionList!
                                                                      .toList())
                                                                  .unique((e) =>
                                                                      e.questionID)
                                                                  .take(10)
                                                                  .toList()
                                                                  .length >=
                                                              9) {
                                                            _model
                                                                .updateSelectedGameListAtIndex(
                                                              stackRoomRecord
                                                                  .selectedGameList
                                                                  .where((e) =>
                                                                      e.selectedGameID ==
                                                                      currentUserDocument
                                                                          ?.presentRoomGameInfo
                                                                          ?.roomSelectedGameID)
                                                                  .toList()
                                                                  .firstOrNull!
                                                                  .selectedGameIndex,
                                                              (e) => e
                                                                ..presentTeamID = _model
                                                                    .selectedTeamList
                                                                    .firstOrNull
                                                                    ?.teamID
                                                                ..presentTeamIndex =
                                                                    0
                                                                ..gameTossWinTeamId = _model
                                                                    .selectedTeamList
                                                                    .firstOrNull
                                                                    ?.teamID
                                                                ..gameTosswinTeamIndex =
                                                                    0
                                                                ..listedQuestionIDList = functions
                                                                    .shuffleQuestions(_model
                                                                        .selectedTopicQuestionList!
                                                                        .toList())
                                                                    .map((e) =>
                                                                        e.questionID)
                                                                    .toList()
                                                                    .take(10)
                                                                    .toList(),
                                                            );
                                                            _model
                                                                .updateSelectedGameListAtIndex(
                                                              stackRoomRecord
                                                                  .selectedGameList
                                                                  .where((e) =>
                                                                      e.selectedGameID ==
                                                                      currentUserDocument
                                                                          ?.presentRoomGameInfo
                                                                          ?.roomSelectedGameID)
                                                                  .toList()
                                                                  .firstOrNull!
                                                                  .selectedGameIndex,
                                                              (e) => e
                                                                ..teamInfo = _model
                                                                    .selectedTeamList
                                                                    .toList()
                                                                ..teamLimit = 2,
                                                            );
                                                            FFAppState().listedQuestionIDList = functions
                                                                .shuffleQuestions(_model
                                                                    .selectedTopicQuestionList!
                                                                    .toList())
                                                                .map((e) => e
                                                                    .questionID)
                                                                .toList()
                                                                .take(10)
                                                                .toList()
                                                                .cast<int>();

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
                                                                      columnGameRecord
                                                                          ?.gamePoint,
                                                                  walletSpentRoomRef:
                                                                      stackRoomRecord
                                                                          .reference,
                                                                  walletSpentGameRef:
                                                                      columnGameRecord
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
                                                                              (stackRoomRecord.isRoomWalletStatus ==
                                                                                  false)
                                                                          ? valueOrDefault(
                                                                              currentUserDocument
                                                                                  ?.walletPoint,
                                                                              0)
                                                                          : stackRoomRecord
                                                                              .roomWalletTotalPoint) -
                                                                      columnGameRecord!
                                                                          .gamePoint,
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
                                                                    columnGameRecord!
                                                                        .gamePoint,
                                                                walletSpent: valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.walletSpent,
                                                                        0) +
                                                                    columnGameRecord!
                                                                        .gamePoint,
                                                              ));
                                                            } else {
                                                              await stackRoomRecord
                                                                  .reference
                                                                  .update(
                                                                      createRoomRecordData(
                                                                roomWalletTotalPoint:
                                                                    stackRoomRecord
                                                                            .roomWalletTotalPoint -
                                                                        columnGameRecord!
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
                                                                          .increment(
                                                                              1),
                                                                },
                                                              ),
                                                            });

                                                            context.goNamed(
                                                              GameFourS1Widget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'room':
                                                                    serializeParam(
                                                                  widget!.room,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          }
                                                        } else {
                                                          if (_shouldSetState)
                                                            safeSetState(() {});
                                                          return;
                                                        }

                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                      },
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'wn0s224h' /* Start Game */,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width:
                                                            MediaQuery.sizeOf(
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
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          width: 0.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 16.0)),
                                              ),
                                            ].divide(SizedBox(height: 16.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
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
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
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
                                                          'assets/images/Group_237703-min.png',
                                                          width: 200.0,
                                                          height: 200.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        enText: () {
                                                          if (columnGameRecord
                                                                  ?.gameInfoManualTranslate
                                                                  ?.name
                                                                  ?.en !=
                                                              '') {
                                                            return columnGameRecord
                                                                ?.gameInfoManualTranslate
                                                                ?.name
                                                                ?.en;
                                                          } else if (columnGameRecord
                                                                  ?.gameInfoTranslate
                                                                  ?.name
                                                                  ?.en !=
                                                              '') {
                                                            return columnGameRecord
                                                                ?.gameInfoTranslate
                                                                ?.name
                                                                ?.en;
                                                          } else {
                                                            return columnGameRecord
                                                                ?.gameInfo
                                                                ?.name;
                                                          }
                                                        }(),
                                                        arText: () {
                                                          if (columnGameRecord
                                                                  ?.gameInfoManualTranslate
                                                                  ?.name
                                                                  ?.ar !=
                                                              '') {
                                                            return columnGameRecord
                                                                ?.gameInfoManualTranslate
                                                                ?.name
                                                                ?.ar;
                                                          } else if (columnGameRecord
                                                                  ?.gameInfoTranslate
                                                                  ?.name
                                                                  ?.ar !=
                                                              '') {
                                                            return columnGameRecord
                                                                ?.gameInfoTranslate
                                                                ?.name
                                                                ?.ar;
                                                          } else {
                                                            return columnGameRecord
                                                                ?.gameInfo
                                                                ?.name;
                                                          }
                                                        }(),
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
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
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                    tabletLandscape: false,
                                                    desktop: false,
                                                  ))
                                                    Expanded(
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          stackRoomRecord
                                                              .selectedGameList
                                                              .where((e) =>
                                                                  currentUserDocument
                                                                      ?.presentRoomGameInfo
                                                                      ?.roomSelectedGameID ==
                                                                  e.selectedGameID)
                                                              .toList()
                                                              .firstOrNull
                                                              ?.gameInfo
                                                              ?.name,
                                                          '-',
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
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
                                                  .fromSTEB(
                                                      0.0, 16.0, 0.0, 8.0),
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
                                                        'etazct7l' /* Pick a style */,
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
                                                    )
                                                  ],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.almarai(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            StreamBuilder<List<TopicRecord>>(
                                              stream: queryTopicRecord(
                                                queryBuilder: (topicRecord) =>
                                                    topicRecord
                                                        .where(
                                                          'game_ID',
                                                          arrayContains:
                                                              currentUserDocument
                                                                  ?.presentRoomGameInfo
                                                                  ?.roomGameId,
                                                        )
                                                        .where(
                                                          'topic_status',
                                                          isEqualTo: 'active',
                                                        )
                                                        .orderBy(
                                                            'topic_main_id'),
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
                                                    rowTopicRecordList =
                                                    snapshot.data!;

                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: List.generate(
                                                      rowTopicRecordList.length,
                                                      (rowIndex) {
                                                    final rowTopicRecord =
                                                        rowTopicRecordList[
                                                            rowIndex];
                                                    return Expanded(
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          _model.selectedGameList =
                                                              stackRoomRecord
                                                                  .selectedGameList
                                                                  .toList()
                                                                  .cast<
                                                                      SelectedGameListStruct>();
                                                          _model.count =
                                                              stackRoomRecord
                                                                  .selectedGameList
                                                                  .length;
                                                          _model.selectedTopicList =
                                                              [];
                                                          _model
                                                              .addToSelectedTopicList(
                                                                  rowTopicRecord
                                                                      .topicID);
                                                          _model
                                                              .updateSelectedGameListAtIndex(
                                                            stackRoomRecord
                                                                .selectedGameList
                                                                .where((e) =>
                                                                    e.selectedGameID ==
                                                                    currentUserDocument
                                                                        ?.presentRoomGameInfo
                                                                        ?.roomSelectedGameID)
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
                                                        },
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 45.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: () {
                                                              if (rowIndex ==
                                                                  0) {
                                                                return (stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            e.selectedGameID ==
                                                                            currentUserDocument
                                                                                ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                        .toList()
                                                                        .firstOrNull!
                                                                        .selectedTopicIDList
                                                                        .contains(rowTopicRecord
                                                                            .topicID)
                                                                    ? Color(
                                                                        0x913696D0)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary);
                                                              } else if (rowIndex ==
                                                                  1) {
                                                                return (stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            e.selectedGameID ==
                                                                            currentUserDocument
                                                                                ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                        .toList()
                                                                        .firstOrNull!
                                                                        .selectedTopicIDList
                                                                        .contains(rowTopicRecord
                                                                            .topicID)
                                                                    ? Color(
                                                                        0xBDD3AD45)
                                                                    : Color(
                                                                        0xFFD3AD45));
                                                              } else if (rowIndex ==
                                                                  3) {
                                                                return (stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            e.selectedGameID ==
                                                                            currentUserDocument
                                                                                ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                        .toList()
                                                                        .firstOrNull!
                                                                        .selectedTopicIDList
                                                                        .contains(rowTopicRecord
                                                                            .topicID)
                                                                    ? Color(
                                                                        0xBDC2185B)
                                                                    : Color(
                                                                        0xFFC2185B));
                                                              } else {
                                                                return (stackRoomRecord
                                                                        .selectedGameList
                                                                        .where((e) =>
                                                                            e.selectedGameID ==
                                                                            currentUserDocument
                                                                                ?.presentRoomGameInfo?.roomSelectedGameID)
                                                                        .toList()
                                                                        .firstOrNull!
                                                                        .selectedTopicIDList
                                                                        .contains(rowTopicRecord
                                                                            .topicID)
                                                                    ? Color(
                                                                        0xA967B5B0)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary);
                                                              }
                                                            }(),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          8.0,
                                                                          0.0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getVariableText(
                                                                  enText: () {
                                                                    if (rowTopicRecord
                                                                            .topicInfoManualTranslate
                                                                            .name
                                                                            .en !=
                                                                        '') {
                                                                      return rowTopicRecord
                                                                          .topicInfoManualTranslate
                                                                          .name
                                                                          .en;
                                                                    } else if (rowTopicRecord
                                                                            .topicInfoTranslate
                                                                            .name
                                                                            .en !=
                                                                        '') {
                                                                      return rowTopicRecord
                                                                          .topicInfoTranslate
                                                                          .name
                                                                          .en;
                                                                    } else {
                                                                      return rowTopicRecord
                                                                          .topicInfo
                                                                          .name;
                                                                    }
                                                                  }(),
                                                                  arText: () {
                                                                    if (rowTopicRecord
                                                                            .topicInfoManualTranslate
                                                                            .name
                                                                            .ar !=
                                                                        '') {
                                                                      return rowTopicRecord
                                                                          .topicInfoManualTranslate
                                                                          .name
                                                                          .ar;
                                                                    } else if (rowTopicRecord
                                                                            .topicInfoTranslate
                                                                            .name
                                                                            .ar !=
                                                                        '') {
                                                                      return rowTopicRecord
                                                                          .topicInfoTranslate
                                                                          .name
                                                                          .ar;
                                                                    } else {
                                                                      return rowTopicRecord
                                                                          .topicInfo
                                                                          .name;
                                                                    }
                                                                  }(),
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .almarai(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).divide(
                                                      SizedBox(width: 10.0)),
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
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
