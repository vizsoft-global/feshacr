import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_five/game_five_input/game_five_input_widget.dart';
import '/feshah_game_zone/game_five/game_five_players/game_five_players_widget.dart';
import '/feshah_game_zone/game_five/game_five_timer/game_five_timer_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_five_model.dart';
export 'game_five_model.dart';

class GameFiveWidget extends StatefulWidget {
  const GameFiveWidget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  static String routeName = 'GameFive';
  static String routePath = '/GameFive';

  @override
  State<GameFiveWidget> createState() => _GameFiveWidgetState();
}

class _GameFiveWidgetState extends State<GameFiveWidget> {
  late GameFiveModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFiveModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {
          await actions.setOrientation();
        }(),
      );
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
                                      3,
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
                            Builder(
                              builder: (context) {
                                final mainGame = stackRoomRecord
                                    .selectedGameList
                                    .where((e) =>
                                        e.selectedGameID ==
                                        currentUserDocument?.presentRoomGameInfo
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
                                          if ((mainGameItem
                                                      .gameSAUStarterUserref !=
                                                  currentUserReference) &&
                                              (mainGameItem.gameSAUStep == 1))
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
                                                                  'lfu46ktw' /* Add players in space */,
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
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyLarge
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              RichText(
                                                                textScaler: MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                                text: TextSpan(
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
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.almarai(
                                                                              fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                          ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '8x1fnz04' /*  People Available */,
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
                                                              shrinkWrap: true,
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
                                                              itemBuilder: (context,
                                                                  activeUserListIndex) {
                                                                final activeUserListItem =
                                                                    activeUserList[
                                                                        activeUserListIndex];
                                                                return GameFivePlayersWidget(
                                                                  key: Key(
                                                                      'Keycfc_${activeUserListIndex}_of_${activeUserList.length}'),
                                                                  index:
                                                                      activeUserListIndex,
                                                                  gameSAUvoteStatus:
                                                                      false,
                                                                  selectedGameIndex:
                                                                      mainGameItem
                                                                          .selectedGameIndex,
                                                                  gameUserRemove:
                                                                      false,
                                                                  gameUserAdd:
                                                                      false,
                                                                  roomUser:
                                                                      activeUserListItem,
                                                                  user: activeUserListItem
                                                                      .roomUserRef!,
                                                                  room:
                                                                      stackRoomRecord,
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if ((mainGameItem
                                                      .gameSAUStarterUserref ==
                                                  currentUserReference) &&
                                              (mainGameItem.gameSAUStep == 1))
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
                                                                  FFLocalizations.of(context)
                                                                              .languageCode ==
                                                                          'en'
                                                                      ? 48.0
                                                                      : 16.0,
                                                                  0.0,
                                                                ),
                                                                16.0,
                                                                valueOrDefault<
                                                                    double>(
                                                                  FFLocalizations.of(context)
                                                                              .languageCode !=
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
                                                        if (stackRoomRecord
                                                                .roomType ==
                                                            'solo')
                                                          Expanded(
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
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
                                                                        children:
                                                                            [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children:
                                                                                [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'grk3mrdj' /* Manual player */,
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
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                                                                child: Text(
                                                                                  '${mainGameItem.selectedGameUserList.length.toString()}${FFLocalizations.of(context).getVariableText(
                                                                                    enText: ' Players added',
                                                                                    arText: ' تمت إضافة اللاعبين',
                                                                                  )}',
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        font: GoogleFonts.almarai(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 8.0)),
                                                                          ),
                                                                          Form(
                                                                            key:
                                                                                _model.formKey,
                                                                            autovalidateMode:
                                                                                AutovalidateMode.disabled,
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                GameFiveInputWidget(
                                                                                  key: Key('Keybed_${mainGameIndex}_of_${mainGame.length}'),
                                                                                  selectedGameIndex: mainGameItem.selectedGameIndex,
                                                                                  room: stackRoomRecord,
                                                                                ),
                                                                              ].divide(SizedBox(height: 12.0)).addToStart(SizedBox(height: 4.0)).addToEnd(SizedBox(height: 4.0)),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(height: 16.0)),
                                                                      ),
                                                                    ),
                                                                  ),
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
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'mucv66vx' /* Need 2 - 10 players to play th... */,
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
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 8.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        8.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              if (stackRoomRecord
                                                                      .roomType !=
                                                                  'solo')
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
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
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'uc1qg55i' /* Need 2 - 10 players to play th... */,
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
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 8.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (stackRoomRecord
                                                                      .roomType !=
                                                                  'solo')
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            16.0),
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
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              if (responsiveVisibility(
                                                                                context: context,
                                                                                phone: false,
                                                                                tablet: false,
                                                                                tabletLandscape: false,
                                                                                desktop: false,
                                                                              ))
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
                                                                                                    'cgs9ve9c' /* Invite players */,
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
                                                                                                          'dn8o807j' /* Share the invite link or scan ... */,
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
                                                                                          'dnjwtq8h' /* Add players in space */,
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
                                                                                                'l3yxw3kn' /*  Players */,
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
                                                                                decoration: BoxDecoration(),
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
                                                                                        return GameFivePlayersWidget(
                                                                                          key: Key('Keyc06_${roomUserList1Index}_of_${roomUserList1.length}'),
                                                                                          index: roomUserList1Index,
                                                                                          gameSAUvoteStatus: false,
                                                                                          selectedGameIndex: mainGameItem.selectedGameIndex,
                                                                                          gameUserRemove: mainGameItem.selectedGameUserList.where((e) => ((e.roomUserNotificationSendStatus == 'send') || (e.roomUserNotificationSendStatus == 'stocker')) && (e.roomUserRef == roomUserList1Item.roomUserRef)).toList().length > 0,
                                                                                          gameUserAdd: mainGameItem.selectedGameUserList.where((e) => ((e.roomUserNotificationSendStatus == 'send') || (e.roomUserNotificationSendStatus == 'stocker')) && (e.roomUserRef == roomUserList1Item.roomUserRef)).toList().length == 0,
                                                                                          roomUser: roomUserList1Item,
                                                                                          user: roomUserList1Item.roomUserRef!,
                                                                                          room: stackRoomRecord,
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
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (stackRoomRecord
                                                                      .roomType ==
                                                                  'solo')
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
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children:
                                                                              [
                                                                            if (currentUserReference !=
                                                                                mainGameItem.gameSAU.lastOrNull?.suspectUserRef)
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
                                                                                              'gjs356kt' /* Players Info */,
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
                                                                                  final inviteUserList = mainGameItem.selectedGameUserList.toList();
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
                                                                                      return GameFivePlayersWidget(
                                                                                        key: Key('Key9cy_${inviteUserListIndex}_of_${inviteUserList.length}'),
                                                                                        index: inviteUserListIndex,
                                                                                        gameSAUvoteStatus: false,
                                                                                        selectedGameIndex: mainGameItem.selectedGameIndex,
                                                                                        gameUserRemove: true,
                                                                                        gameUserAdd: false,
                                                                                        roomUser: inviteUserListItem,
                                                                                        user: inviteUserListItem.roomUserRef!,
                                                                                        room: stackRoomRecord,
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
                                                                ),
                                                            ].divide(SizedBox(
                                                                height: 8.0)),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 16.0)),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 16.0)),
                                            ),
                                          if ((mainGameItem
                                                      .gameSAUStarterUserref ==
                                                  currentUserReference) &&
                                              (mainGameItem.gameSAUStep == 1))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 16.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    var _shouldSetState = false;
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
                                                    _model.teamInfo = [];
                                                    while (
                                                        _model.countGame! > 0) {
                                                      if (_model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGame!) -
                                                                      1)
                                                              ?.selectedGameID ==
                                                          currentUserDocument
                                                              ?.presentRoomGameInfo
                                                              ?.roomSelectedGameID) {
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
                                                            _model.userLimit!) {
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
                                                                      .length -
                                                                  1);
                                                          _model.topicsResult =
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
                                                                          arrayContains: _model
                                                                              .selectedGameList
                                                                              .elementAtOrNull((_model.countGame!) - 1)
                                                                              ?.gameId,
                                                                        ),
                                                          );
                                                          _shouldSetState =
                                                              true;
                                                          if (_model
                                                                  .topicsResult!
                                                                  .length >
                                                              0) {
                                                            _model.selectedTopicList = _model
                                                                .topicsResult!
                                                                .map((e) =>
                                                                    e.topicID)
                                                                .toList()
                                                                .take(_model
                                                                    .topicLimit!)
                                                                .toList()
                                                                .cast<int>();
                                                            _model.topicCount =
                                                                _model
                                                                    .topicLimit;
                                                            if (_model
                                                                    .selectedTopicList
                                                                    .length ==
                                                                _model
                                                                    .topicLimit) {
                                                              while (_model
                                                                      .topicCount! >
                                                                  0) {
                                                                _model.topicQuestionResult =
                                                                    await queryTopicQuestionRecordOnce(
                                                                  queryBuilder: (topicQuestionRecord) =>
                                                                      topicQuestionRecord
                                                                          .where(
                                                                            'question_status',
                                                                            isEqualTo:
                                                                                'active',
                                                                          )
                                                                          .where(
                                                                            'topic_id',
                                                                            isEqualTo:
                                                                                _model.topicsResult?.elementAtOrNull((_model.topicCount!) - 1)?.topicID,
                                                                          ),
                                                                );
                                                                _shouldSetState =
                                                                    true;
                                                                _model.topicQuestionCount =
                                                                    _model
                                                                        .topicQuestionResult
                                                                        ?.length;
                                                                while (_model
                                                                        .topicQuestionCount! >
                                                                    0) {
                                                                  if (stackRoomRecord.roomAttendedQuestionList.contains(_model
                                                                          .topicQuestionResult
                                                                          ?.elementAtOrNull((_model.topicQuestionCount!) -
                                                                              1)
                                                                          ?.questionID) ==
                                                                      false) {
                                                                    if (_model
                                                                            .topicCount ==
                                                                        5) {
                                                                      if (_model
                                                                              .selectedGameList
                                                                              .elementAtOrNull(mainGameItem
                                                                                  .selectedGameIndex)!
                                                                              .selectedQuestionIDList
                                                                              .length >=
                                                                          (mainGameItem.selectedGameUserList.where((e) => e.roomUserNotificationSendStatus == 'send').toList().length *
                                                                              1)) {
                                                                        break;
                                                                      }
                                                                    } else {
                                                                      if (_model
                                                                              .topicCount ==
                                                                          4) {
                                                                        if (_model.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.selectedQuestionIDList.length >=
                                                                            (mainGameItem.selectedGameUserList.where((e) => e.roomUserNotificationSendStatus == 'send').toList().length *
                                                                                2)) {
                                                                          break;
                                                                        }
                                                                      } else {
                                                                        if (_model.topicCount ==
                                                                            3) {
                                                                          if (_model.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.selectedQuestionIDList.length >=
                                                                              (mainGameItem.selectedGameUserList.where((e) => e.roomUserNotificationSendStatus == 'send').toList().length * 3)) {
                                                                            break;
                                                                          }
                                                                        } else {
                                                                          if (_model.topicCount ==
                                                                              2) {
                                                                            if (_model.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.selectedQuestionIDList.length >=
                                                                                (mainGameItem.selectedGameUserList.where((e) => e.roomUserNotificationSendStatus == 'send').toList().length * 4)) {
                                                                              break;
                                                                            }
                                                                          } else {
                                                                            if (_model.topicCount ==
                                                                                1) {
                                                                              if (_model.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.selectedQuestionIDList.length >= (mainGameItem.selectedGameUserList.where((e) => e.roomUserNotificationSendStatus == 'send').toList().length * 5)) {
                                                                                break;
                                                                              }
                                                                            } else {
                                                                              break;
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }

                                                                    _model
                                                                        .updateSelectedGameListAtIndex(
                                                                      (_model.countGame!) -
                                                                          1,
                                                                      (e) => e
                                                                        ..updateSelectedQuestionIDList(
                                                                          (e) => e.add(_model
                                                                              .topicQuestionResult!
                                                                              .elementAtOrNull((_model.topicQuestionCount!) - 1)!
                                                                              .questionID),
                                                                        ),
                                                                    );
                                                                    _model.addToQuestionListID(_model
                                                                        .topicQuestionResult!
                                                                        .elementAtOrNull(
                                                                            (_model.topicQuestionCount!) -
                                                                                1)!
                                                                        .questionID);
                                                                  }
                                                                  _model.topicQuestionCount =
                                                                      (_model.topicQuestionCount!) -
                                                                          1;
                                                                }
                                                                _model.topicCount =
                                                                    (_model.topicCount!) -
                                                                        1;
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
                                                                          FFLocalizations.of(context)
                                                                              .getVariableText(
                                                                        enText:
                                                                            'There are no THREE (3) topics in the game you selected. ',
                                                                        arText:
                                                                            'لا توجد ثلاثة (3) مواضيع في اللعبة التي حددتها.',
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
                                                                          'There are no topics in the game you selected.',
                                                                      arText:
                                                                          'لا توجد مواضيع في اللعبة التي حددتها.',
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

                                                          _model.addToTeamInfo(
                                                              TeamInfoStruct(
                                                            createdAt:
                                                                getCurrentTimestamp,
                                                            updatedAt:
                                                                getCurrentTimestamp,
                                                            teamStatus:
                                                                'active',
                                                            teamID: 0,
                                                            teamInfo:
                                                                MainInfoStruct(
                                                              name:
                                                                  'Wrong Answer',
                                                            ),
                                                          ));
                                                          _model.addToTeamInfo(
                                                              TeamInfoStruct(
                                                            createdAt:
                                                                getCurrentTimestamp,
                                                            updatedAt:
                                                                getCurrentTimestamp,
                                                            teamStatus:
                                                                'active',
                                                            teamID: 1,
                                                            teamInfo:
                                                                MainInfoStruct(
                                                              name:
                                                                  'Right Answer',
                                                            ),
                                                          ));
                                                          _model.idmapResult1 =
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
                                                              .updateSelectedGameListAtIndex(
                                                            (_model.countGame!) -
                                                                1,
                                                            (e) => e
                                                              ..gameSAUStep = 2
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
                                                                      .selectedTopicList
                                                                      .firstOrNull,
                                                                  roundQuestionId: stackRoomRecord
                                                                      .selectedGameList
                                                                      .elementAtOrNull(
                                                                          mainGameItem
                                                                              .selectedGameIndex)
                                                                      ?.selectedQuestionIDList
                                                                      ?.firstOrNull,
                                                                  roundPlayerIndex:
                                                                      0,
                                                                  roundQuestionIndex:
                                                                      0,
                                                                )),
                                                              )
                                                              ..updateSelectedQuestionList(
                                                                (e) => e.add(
                                                                    SelectedQuestionListStruct(
                                                                  questionID: _model
                                                                      .selectedGameList
                                                                      .elementAtOrNull(
                                                                          mainGameItem
                                                                              .selectedGameIndex)
                                                                      ?.selectedQuestionIDList
                                                                      ?.firstOrNull,
                                                                  questionAnswerStatus:
                                                                      'hide',
                                                                )),
                                                              )
                                                              ..selectedTopicIDList =
                                                                  _model
                                                                      .selectedTopicList
                                                                      .toList()
                                                              ..teamLimit = 2
                                                              ..teamInfo =
                                                                  _model
                                                                      .teamInfo
                                                                      .toList()
                                                              ..teamCount = 2
                                                              ..selectedGameUserList =
                                                                  mainGameItem
                                                                      .selectedGameUserList
                                                                      .where((e) =>
                                                                          e.roomUserNotificationSendStatus ==
                                                                          'send')
                                                                      .toList(),
                                                          );

                                                          await _model
                                                              .idmapResult1!
                                                              .reference
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'round_id':
                                                                    FieldValue
                                                                        .increment(
                                                                            1),
                                                              },
                                                            ),
                                                          });

                                                          await widget!.room!
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
                                                            _model.soundPlayer!
                                                                .setVolume(0.2);
                                                            _model.soundPlayer!
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
                                                              isEqualTo: 'Main',
                                                            ),
                                                            singleRecord: true,
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
                                                                walletSpentPresentPoint: ((stackRoomRecord.roomType ==
                                                                                'solo') ||
                                                                            (stackRoomRecord.isRoomWalletStatus ==
                                                                                false)
                                                                        ? valueOrDefault(
                                                                            currentUserDocument
                                                                                ?.walletPoint,
                                                                            0)
                                                                        : stackRoomRecord
                                                                            .roomWalletTotalPoint) -
                                                                    stackGameRecord!
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
                                                              roomWalletTotalPoint:
                                                                  stackRoomRecord
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
                                                                        .increment(
                                                                            1),
                                                              },
                                                            ),
                                                          });
                                                          safeSetState(() {});
                                                          if (_shouldSetState)
                                                            safeSetState(() {});
                                                          return;
                                                        } else {
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
                                                                        'Please invite a USER\'s ( atleast 2)',
                                                                    arText:
                                                                        'يرجى دعوة مستخدم واحد (2 على الأقل)',
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
                                                        }
                                                      }
                                                      _model.countGame =
                                                          (_model.countGame!) -
                                                              1;
                                                    }
                                                    if (_shouldSetState)
                                                      safeSetState(() {});
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'j6pshwpi' /* Start the game */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    height: 45.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(32.0, 0.0,
                                                                32.0, 0.0),
                                                    iconAlignment:
                                                        IconAlignment.start,
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
                                                          font: GoogleFonts
                                                              .almarai(
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
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
                                          if (mainGameItem.gameSAUStep == 2)
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
                                                                  FFLocalizations.of(context)
                                                                              .languageCode ==
                                                                          'en'
                                                                      ? 48.0
                                                                      : 16.0,
                                                                  0.0,
                                                                ),
                                                                16.0,
                                                                valueOrDefault<
                                                                    double>(
                                                                  FFLocalizations.of(context)
                                                                              .languageCode !=
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
                                                          flex: 2,
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                1.0,
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
                                                                  EdgeInsets
                                                                      .all(
                                                                          16.0),
                                                              child: StreamBuilder<
                                                                  List<
                                                                      TopicQuestionRecord>>(
                                                                stream:
                                                                    queryTopicQuestionRecord(
                                                                  queryBuilder:
                                                                      (topicQuestionRecord) =>
                                                                          topicQuestionRecord
                                                                              .where(
                                                                    'question_ID',
                                                                    isEqualTo: mainGameItem
                                                                        .gameSAU
                                                                        .lastOrNull
                                                                        ?.roundQuestionId,
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
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(
                                                                            FlutterFlowTheme.of(context).primary,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<TopicQuestionRecord>
                                                                      columnTopicQuestionRecordList =
                                                                      snapshot
                                                                          .data!;
                                                                  // Return an empty Container when the item does not exist.
                                                                  if (snapshot
                                                                      .data!
                                                                      .isEmpty) {
                                                                    return Container();
                                                                  }
                                                                  final columnTopicQuestionRecord = columnTopicQuestionRecordList
                                                                          .isNotEmpty
                                                                      ? columnTopicQuestionRecordList
                                                                          .first
                                                                      : null;

                                                                  return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children:
                                                                            [
                                                                          Expanded(
                                                                            child:
                                                                                GameFiveTimerWidget(
                                                                              key: Key('Keyme9_${mainGameIndex}_of_${mainGame.length}'),
                                                                              timeMS: 10000,
                                                                              resetStatus: true,
                                                                              startStatus: true,
                                                                              value: 1,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                StreamBuilder<List<TopicRecord>>(
                                                                              stream: queryTopicRecord(
                                                                                queryBuilder: (topicRecord) => topicRecord.where(
                                                                                  'topic_ID',
                                                                                  isEqualTo: mainGameItem.selectedTopicIDList.firstOrNull,
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
                                                                                    enText: 'Question ${(mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1).toString()}',
                                                                                    arText: 'سؤال ${(mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1).toString()}',
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
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Container(
                                                                                  height: 35.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0x1867B5B0),
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 0.0, 4.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'zjnlfaib' /* Round */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.almarai(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).tertiary,
                                                                                                  fontSize: 12.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 40.0,
                                                                                          height: 40.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                            shape: BoxShape.circle,
                                                                                          ),
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                mainGameItem.gameSAU.length.toString(),
                                                                                                '0',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.almarai(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
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
                                                                      Expanded(
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children:
                                                                              [
                                                                            StreamBuilder<List<TopicRecord>>(
                                                                              stream: queryTopicRecord(
                                                                                queryBuilder: (topicRecord) => topicRecord.where(
                                                                                  'topic_ID',
                                                                                  isEqualTo: mainGameItem.selectedTopicIDList.elementAtOrNull(mainGameItem.gameSAU.length - 1),
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
                                                                                List<TopicRecord> containerTopicRecordList = snapshot.data!;
                                                                                // Return an empty Container when the item does not exist.
                                                                                if (snapshot.data!.isEmpty) {
                                                                                  return Container();
                                                                                }
                                                                                final containerTopicRecord = containerTopicRecordList.isNotEmpty ? containerTopicRecordList.first : null;

                                                                                return Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0x1AEC4D41),
                                                                                    borderRadius: BorderRadius.circular(6.0),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(12.0),
                                                                                    child: RichText(
                                                                                      textScaler: MediaQuery.of(context).textScaler,
                                                                                      text: TextSpan(
                                                                                        children: [
                                                                                          TextSpan(
                                                                                            text: FFLocalizations.of(context).getText(
                                                                                              'jwhofi8j' /* Category   */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                  font: GoogleFonts.almarai(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                          TextSpan(
                                                                                            text: FFLocalizations.of(context).getVariableText(
                                                                                              enText: () {
                                                                                                if (containerTopicRecord?.topicInfoManualTranslate?.name?.en != '') {
                                                                                                  return containerTopicRecord?.topicInfoManualTranslate?.name?.en;
                                                                                                } else if (containerTopicRecord?.topicInfoTranslate?.name?.en != '') {
                                                                                                  return containerTopicRecord?.topicInfoTranslate?.name?.en;
                                                                                                } else {
                                                                                                  return containerTopicRecord?.topicInfo?.name;
                                                                                                }
                                                                                              }(),
                                                                                              arText: () {
                                                                                                if (containerTopicRecord?.topicInfoManualTranslate?.name?.ar != '') {
                                                                                                  return containerTopicRecord?.topicInfoManualTranslate?.name?.ar;
                                                                                                } else if (containerTopicRecord?.topicInfoTranslate?.name?.ar != '') {
                                                                                                  return containerTopicRecord?.topicInfoTranslate?.name?.ar;
                                                                                                } else {
                                                                                                  return containerTopicRecord?.topicInfo?.name;
                                                                                                }
                                                                                              }(),
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                  font: GoogleFonts.almarai(
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
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
                                                                                );
                                                                              },
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getVariableText(
                                                                                  enText: () {
                                                                                    if (columnTopicQuestionRecord?.questionInfoTranslateManual?.question?.en != '') {
                                                                                      return columnTopicQuestionRecord?.questionInfoTranslateManual?.question?.en;
                                                                                    } else if (columnTopicQuestionRecord?.questionInfoTranslate?.question?.en != '') {
                                                                                      return columnTopicQuestionRecord?.questionInfoTranslate?.question?.en;
                                                                                    } else {
                                                                                      return columnTopicQuestionRecord?.questionInfo?.questionInfo?.name;
                                                                                    }
                                                                                  }(),
                                                                                  arText: () {
                                                                                    if (columnTopicQuestionRecord?.questionInfoTranslateManual?.question?.ar != '') {
                                                                                      return columnTopicQuestionRecord?.questionInfoTranslateManual?.question?.ar;
                                                                                    } else if (columnTopicQuestionRecord?.questionInfoTranslate?.question?.ar != '') {
                                                                                      return columnTopicQuestionRecord?.questionInfoTranslate?.question?.ar;
                                                                                    } else {
                                                                                      return columnTopicQuestionRecord?.questionInfo?.questionInfo?.name;
                                                                                    }
                                                                                  }(),
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                                style: FlutterFlowTheme.of(context).displayLarge.override(
                                                                                      font: GoogleFonts.almarai(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).displayLarge.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      fontSize: FFLocalizations.of(context).languageCode == 'en' ? 120.0 : 72.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).displayLarge.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: 95.0,
                                                                              decoration: BoxDecoration(),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      '1spcbxya' /* For */,
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
                                                                                  ),
                                                                                  Text(
                                                                                    mainGameItem.selectedGameUserList.elementAtOrNull(mainGameItem.gameSAU.lastOrNull!.roundPlayerIndex)!.roomUserInfo.userName,
                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                          font: GoogleFonts.almarai(
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ].divide(SizedBox(height: 2.0)),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 8.0)),
                                                                        ),
                                                                      ),
                                                                      Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final teamList = mainGameItem
                                                                              .teamInfo
                                                                              .toList();

                                                                          return Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children:
                                                                                List.generate(teamList.length, (teamListIndex) {
                                                                              final teamListItem = teamList[teamListIndex];
                                                                              return InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  var _shouldSetState = false;
                                                                                  if (mainGameItem.gameSAUStarterUserref != currentUserReference) {
                                                                                    if (_shouldSetState) safeSetState(() {});
                                                                                    return;
                                                                                  }
                                                                                  _model.selectedGameList = stackRoomRecord.selectedGameList.toList().cast<SelectedGameListStruct>();
                                                                                  _model.countGame = stackRoomRecord.selectedGameList.length;
                                                                                  while (_model.countGame! > 0) {
                                                                                    if (_model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)?.selectedGameID == currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID) {
                                                                                      _model.gameSAU = _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.gameSAU.toList().cast<GameSAUStruct>();
                                                                                      _model.selectedUserList = _model.selectedGameList.elementAtOrNull((_model.countGame!) - 1)!.selectedGameUserList.toList().cast<RoomUserListStruct>();
                                                                                      if (teamListItem.teamID != 0) {
                                                                                        _model.selectedUserEarnPoint = mainGameItem.selectedGameUserList.elementAtOrNull(mainGameItem.gameSAU.lastOrNull!.roundPlayerIndex)!.roomUserPoints + columnTopicQuestionRecord!.questionPoint;
                                                                                        _model.updateSelectedUserListAtIndex(
                                                                                          _model.gameSAU.lastOrNull!.roundPlayerIndex,
                                                                                          (e) => e
                                                                                            ..roomUserPoints = _model.selectedUserEarnPoint
                                                                                            ..roomUserUpdatedTime = getCurrentTimestamp,
                                                                                        );
                                                                                      }
                                                                                      if (mainGameItem.selectedGameUserList.length >
                                                                                          () {
                                                                                            if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 3) {
                                                                                              return (((mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1) / 3).floor());
                                                                                            } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 2) {
                                                                                              return (((mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1) / 2).floor());
                                                                                            } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 4) {
                                                                                              return (((mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1) / 4).floor());
                                                                                            } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 5) {
                                                                                              return (((mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1) / 5).floor());
                                                                                            } else {
                                                                                              return (mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1);
                                                                                            }
                                                                                          }()) {
                                                                                        _model.updateSelectedGameListAtIndex(
                                                                                          (_model.countGame!) - 1,
                                                                                          (e) => e
                                                                                            ..gameSAUStep = 2
                                                                                            ..updateGameSAU(
                                                                                              (e) => e[mainGameItem.gameSAU.length - 1]
                                                                                                ..roundQuestionId = mainGameItem.selectedQuestionIDList.elementAtOrNull(_model.gameSAU.lastOrNull!.roundPlayerIndex + 1)
                                                                                                ..roundQuestionIndex = _model.gameSAU.lastOrNull!.roundQuestionIndex + 1
                                                                                                ..roundPlayerIndex = _model.gameSAU.lastOrNull!.roundPlayerIndex + 1,
                                                                                            )
                                                                                            ..updateSelectedQuestionList(
                                                                                              (e) => e.add(SelectedQuestionListStruct(
                                                                                                questionID: mainGameItem.selectedQuestionIDList.elementAtOrNull(_model.gameSAU.lastOrNull!.roundPlayerIndex + 1),
                                                                                                questionAnswerStatus: 'hide',
                                                                                              )),
                                                                                            ),
                                                                                        );

                                                                                        await widget!.room!.update({
                                                                                          ...mapToFirestore(
                                                                                            {
                                                                                              'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                _model.selectedGameList,
                                                                                              ),
                                                                                              'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                columnTopicQuestionRecord?.questionID
                                                                                              ]),
                                                                                            },
                                                                                          ),
                                                                                        });
                                                                                        FFAppState().updateUserflowStruct(
                                                                                          (e) => e..timmerStatus = 'set',
                                                                                        );
                                                                                        safeSetState(() {});
                                                                                        if (_shouldSetState) safeSetState(() {});
                                                                                        return;
                                                                                      } else {
                                                                                        if (mainGameItem.selectedGameUserList.length <=
                                                                                            () {
                                                                                              if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 3) {
                                                                                                return (((mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1) / 3).floor());
                                                                                              } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 2) {
                                                                                                return (((mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1) / 2).floor());
                                                                                              } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 4) {
                                                                                                return (((mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1) / 4).floor());
                                                                                              } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 5) {
                                                                                                return (((mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1) / 5).floor());
                                                                                              } else {
                                                                                                return (mainGameItem.gameSAU.lastOrNull!.roundQuestionIndex + 1);
                                                                                              }
                                                                                            }()) {
                                                                                          if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)!.gameSAU.length < 5) {
                                                                                            _model.idmapRoundRightResult1 = await queryIDmapRecordOnce(
                                                                                              queryBuilder: (iDmapRecord) => iDmapRecord.where(
                                                                                                'type',
                                                                                                isEqualTo: 'Main',
                                                                                              ),
                                                                                              singleRecord: true,
                                                                                            ).then((s) => s.firstOrNull);
                                                                                            _shouldSetState = true;
                                                                                            _model.updateSelectedGameListAtIndex(
                                                                                              (_model.countGame!) - 1,
                                                                                              (e) => e
                                                                                                ..gameSAUStep = 2
                                                                                                ..updateGameSAU(
                                                                                                  (e) => e.add(GameSAUStruct(
                                                                                                    roundID: _model.idmapRoundRightResult1?.roundId,
                                                                                                    roundStartAt: getCurrentTimestamp,
                                                                                                    roundStatus: 'active',
                                                                                                    roundTopicId: _model.selectedTopicList.elementAtOrNull(() {
                                                                                                      if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 1) {
                                                                                                        return 1;
                                                                                                      } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 2) {
                                                                                                        return 2;
                                                                                                      } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 3) {
                                                                                                        return 3;
                                                                                                      } else {
                                                                                                        return 4;
                                                                                                      }
                                                                                                    }()),
                                                                                                    roundQuestionId: stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.selectedQuestionIDList?.elementAtOrNull(() {
                                                                                                      if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 1) {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 1);
                                                                                                      } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 2) {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 2);
                                                                                                      } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 3) {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 3);
                                                                                                      } else {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 4);
                                                                                                      }
                                                                                                    }()),
                                                                                                    roundPlayerIndex: 0,
                                                                                                    roundQuestionIndex: () {
                                                                                                      if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 1) {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 1);
                                                                                                      } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 2) {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 2);
                                                                                                      } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 3) {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 3);
                                                                                                      } else {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 4);
                                                                                                      }
                                                                                                    }(),
                                                                                                  )),
                                                                                                )
                                                                                                ..updateSelectedQuestionList(
                                                                                                  (e) => e.add(SelectedQuestionListStruct(
                                                                                                    questionID: stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.selectedQuestionIDList?.elementAtOrNull(() {
                                                                                                      if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 1) {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 1);
                                                                                                      } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 2) {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 2);
                                                                                                      } else if (stackRoomRecord.selectedGameList.elementAtOrNull(mainGameItem.selectedGameIndex)?.gameSAU?.length == 3) {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 3);
                                                                                                      } else {
                                                                                                        return (mainGameItem.selectedGameUserList.length * 4);
                                                                                                      }
                                                                                                    }()),
                                                                                                    questionAnswerStatus: 'hide',
                                                                                                  )),
                                                                                                ),
                                                                                            );

                                                                                            await _model.idmapRoundRightResult1!.reference.update({
                                                                                              ...mapToFirestore(
                                                                                                {
                                                                                                  'round_id': FieldValue.increment(1),
                                                                                                },
                                                                                              ),
                                                                                            });

                                                                                            await widget!.room!.update({
                                                                                              ...mapToFirestore(
                                                                                                {
                                                                                                  'selected_game_list': getSelectedGameListListFirestoreData(
                                                                                                    _model.selectedGameList,
                                                                                                  ),
                                                                                                  'room_attended_question_list': FieldValue.arrayUnion([
                                                                                                    columnTopicQuestionRecord?.questionID
                                                                                                  ]),
                                                                                                },
                                                                                              ),
                                                                                            });
                                                                                            FFAppState().updateUserflowStruct(
                                                                                              (e) => e..timmerStatus = 'set',
                                                                                            );
                                                                                            safeSetState(() {});
                                                                                            if (_shouldSetState) safeSetState(() {});
                                                                                            return;
                                                                                          } else {
                                                                                            _model.updateSelectedGameListAtIndex(
                                                                                              (_model.countGame!) - 1,
                                                                                              (e) => e
                                                                                                ..gameSAUStep = 3
                                                                                                ..updateGameResult(
                                                                                                  (e) => e..status = 'win',
                                                                                                )
                                                                                                ..gameEndTime = getCurrentTimestamp,
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
                                                                                            _model.idmapRoundExitResult1 = await queryIDmapRecordOnce(
                                                                                              queryBuilder: (iDmapRecord) => iDmapRecord.where(
                                                                                                'type',
                                                                                                isEqualTo: 'Main',
                                                                                              ),
                                                                                              singleRecord: true,
                                                                                            ).then((s) => s.firstOrNull);
                                                                                            _shouldSetState = true;
                                                                                            if (stackRoomRecord.roomType == 'solo') {
                                                                                              await GameHistoryRecord.collection.doc().set(createGameHistoryRecordData(
                                                                                                    createdAt: getCurrentTimestamp,
                                                                                                    updatedAt: getCurrentTimestamp,
                                                                                                    gameHistoryID: _model.idmapRoundExitResult1?.historyId,
                                                                                                    gameId: stackGameRecord?.gameID,
                                                                                                    userId: mainGameItem.selectedGameUserList.firstOrNull?.roomUserId?.toString(),
                                                                                                    userRef: mainGameItem.selectedGameUserList.firstOrNull?.roomUserRef,
                                                                                                    roomId: stackRoomRecord.roomID,
                                                                                                    resultInfo: createResultInfoStruct(
                                                                                                      createdAt: getCurrentTimestamp,
                                                                                                      status: 'win',
                                                                                                      clearUnsetFields: false,
                                                                                                      create: true,
                                                                                                    ),
                                                                                                    sessionId: currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID,
                                                                                                  ));

                                                                                              await _model.idmapRoundExitResult1!.reference.update({
                                                                                                ...mapToFirestore(
                                                                                                  {
                                                                                                    'history_id': FieldValue.increment(1),
                                                                                                  },
                                                                                                ),
                                                                                              });
                                                                                            } else {
                                                                                              _model.countUser = mainGameItem.selectedGameUserList.length;
                                                                                              _model.selectedUserList = mainGameItem.selectedGameUserList.toList().cast<RoomUserListStruct>();
                                                                                              while (_model.countUser! > 0) {
                                                                                                if (_model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserStatus == 'active') {
                                                                                                  _model.gameHistoryResult1 = await queryGameHistoryRecordOnce(
                                                                                                    queryBuilder: (gameHistoryRecord) => gameHistoryRecord
                                                                                                        .where(
                                                                                                          'user_ref',
                                                                                                          isEqualTo: _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef,
                                                                                                        )
                                                                                                        .where(
                                                                                                          'session_id',
                                                                                                          isEqualTo: mainGameItem.selectedGameID,
                                                                                                        ),
                                                                                                  );
                                                                                                  _shouldSetState = true;
                                                                                                  if (_model.gameHistoryResult1?.length == 0) {
                                                                                                    await GameHistoryRecord.collection.doc().set(createGameHistoryRecordData(
                                                                                                          createdAt: getCurrentTimestamp,
                                                                                                          updatedAt: getCurrentTimestamp,
                                                                                                          gameHistoryID: _model.idmapRoundExitResult1?.historyId,
                                                                                                          gameId: stackGameRecord?.gameID,
                                                                                                          userId: mainGameItem.selectedGameUserList.firstOrNull?.roomUserId?.toString(),
                                                                                                          userRef: mainGameItem.selectedGameUserList.firstOrNull?.roomUserRef,
                                                                                                          roomId: stackRoomRecord.roomID,
                                                                                                          resultInfo: createResultInfoStruct(
                                                                                                            createdAt: getCurrentTimestamp,
                                                                                                            status: 'win',
                                                                                                            clearUnsetFields: false,
                                                                                                            create: true,
                                                                                                          ),
                                                                                                          sessionId: currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID,
                                                                                                        ));

                                                                                                    await _model.idmapRoundExitResult1!.reference.update({
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

                                                                                            FFAppState().updateUserflowStruct(
                                                                                              (e) => e..timmerStatus = 'set',
                                                                                            );
                                                                                            safeSetState(() {});
                                                                                            if (_shouldSetState) safeSetState(() {});
                                                                                            return;
                                                                                          }
                                                                                        }
                                                                                      }
                                                                                    }
                                                                                    _model.countGame = (_model.countGame!) - 1;
                                                                                  }
                                                                                  if (_shouldSetState) safeSetState(() {});
                                                                                },
                                                                                child: Container(
                                                                                  width: 150.0,
                                                                                  height: 45.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: teamListItem.teamID == 0 ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).tertiary,
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                    border: Border.all(
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      width: 0.5,
                                                                                    ),
                                                                                  ),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Text(
                                                                                      teamListIndex == 0
                                                                                          ? FFLocalizations.of(context).getVariableText(
                                                                                              enText: 'Wrong Answer',
                                                                                              arText: 'إجابة خاطئة',
                                                                                            )
                                                                                          : FFLocalizations.of(context).getVariableText(
                                                                                              enText: 'Right Answer',
                                                                                              arText: 'الإجابة الصحيحة',
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
                                                                              );
                                                                            }).divide(SizedBox(width: 16.0)),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            8.0)),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            width: 100.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
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
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
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
                                                                              FFLocalizations.of(context).getText(
                                                                                'lby46oej' /* Score */,
                                                                              ),
                                                                              textAlign: TextAlign.center,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.almarai(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Divider(
                                                                    height: 2.0,
                                                                    thickness:
                                                                        1.0,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                                      child:
                                                                          Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final winnerUserList = mainGameItem
                                                                              .selectedGameUserList
                                                                              .where((e) => e.roomUserStatus == 'active')
                                                                              .toList();
                                                                          if (winnerUserList
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
                                                                                winnerUserList.length,
                                                                            separatorBuilder: (_, __) =>
                                                                                SizedBox(height: 16.0),
                                                                            itemBuilder:
                                                                                (context, winnerUserListIndex) {
                                                                              final winnerUserListItem = winnerUserList[winnerUserListIndex];
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
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 30.0,
                                                                                          height: 30.0,
                                                                                          decoration: BoxDecoration(
                                                                                            shape: BoxShape.circle,
                                                                                            border: Border.all(
                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                            ),
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
                                                                                                    fontSize: 14.0,
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
                                                                                                    winnerUserListItem.roomUserInfo.userName,
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
                                                                                                ].divide(SizedBox(width: 4.0)),
                                                                                              ),
                                                                                            ].divide(SizedBox(height: 4.0)),
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          '+ ${winnerUserListItem.roomUserPoints.toString()}${FFLocalizations.of(context).getVariableText(
                                                                                            enText: ' Points',
                                                                                            arText: 'نقاط',
                                                                                          )}',
                                                                                          style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                font: GoogleFonts.almarai(
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                                fontSize: 14.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 8.0)),
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
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        12.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 16.0)),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 16.0)),
                                            ),
                                          if (mainGameItem.gameSAUStep == 3)
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      if (mainGameItem
                                                              .selectedGameUserList
                                                              .where((e) =>
                                                                  e.roomUserNotificationSendStatus ==
                                                                  'send')
                                                              .toList()
                                                              .length >
                                                          1)
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
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        12.0,
                                                                        24.0,
                                                                        12.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child: Stack(
                                                                    alignment:
                                                                        AlignmentDirectional(
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
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(100.0),
                                                                          child:
                                                                              Image.network(
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/7fnvxvk9w0jj/Frame_2087324742.png',
                                                                            width:
                                                                                60.0,
                                                                            height:
                                                                                60.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            alignment:
                                                                                Alignment(0.0, 0.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                                  child: Text(
                                                                    mainGameItem
                                                                        .selectedGameUserList
                                                                        .sortedList(
                                                                            keyOf: (e) =>
                                                                                e.roomUserPoints,
                                                                            desc: true)
                                                                        .firstOrNull!
                                                                        .roomUserInfo
                                                                        .userName,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.almarai(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontStyle,
                                                                        ),
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
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'qszo9mt2' /* is the winner now! with  */,
                                                                        ),
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
                                                                      TextSpan(
                                                                        text: mainGameItem
                                                                            .selectedGameUserList
                                                                            .sortedList(
                                                                                keyOf: (e) => e.roomUserPoints,
                                                                                desc: true)
                                                                            .firstOrNull!
                                                                            .roomUserPoints
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'usgswag3' /*  points */,
                                                                        ),
                                                                        style:
                                                                            TextStyle(),
                                                                      )
                                                                    ],
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.almarai(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              18.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontStyle,
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
                                                                          print(
                                                                              'Button pressed ...');
                                                                        },
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'w394j0z1' /* Share Result */,
                                                                        ),
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .ios_share_sharp,
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
                                                                    ),
                                                                    if (stackRoomRecord
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                currentUserDocument?.presentRoomGameInfo?.roomSelectedGameID)
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
                                                                          Icons
                                                                              .home_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).info,
                                                                          size:
                                                                              24.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          if (mainGameItem.gameSAUStarterUserref ==
                                                                              currentUserReference) {
                                                                            await widget!.room!.update(createRoomRecordData(
                                                                              roomUpdatedAt: getCurrentTimestamp,
                                                                            ));
                                                                          }

                                                                          await currentUserReference!
                                                                              .update(createUsersRecordData(
                                                                            presentRoomGameInfo:
                                                                                createPresentRoomGameInfoStruct(delete: true),
                                                                          ));

                                                                          context
                                                                              .goNamed(HomeWidget.routeName);
                                                                        },
                                                                      ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          16.0)),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 8.0)),
                                                            ),
                                                          ),
                                                        ),
                                                      if (((List<int> var1) {
                                                            return var1.every(
                                                                (n) => n == 0);
                                                          }(mainGameItem
                                                              .selectedGameUserList
                                                              .where((e) =>
                                                                  e.roomUserNotificationSendStatus ==
                                                                  'send')
                                                              .toList()
                                                              .map((e) => e
                                                                  .roomUserPoints)
                                                              .toList())) ==
                                                          true)
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
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        12.0,
                                                                        24.0,
                                                                        12.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    FlutterFlowIconButton(
                                                                      borderColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryText,
                                                                      borderRadius:
                                                                          8.0,
                                                                      borderWidth:
                                                                          0.5,
                                                                      buttonSize:
                                                                          45.0,
                                                                      fillColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .home_rounded,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .info,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        if (mainGameItem.gameSAUStarterUserref ==
                                                                            currentUserReference) {
                                                                          await widget!
                                                                              .room!
                                                                              .update(createRoomRecordData(
                                                                            roomUpdatedAt:
                                                                                getCurrentTimestamp,
                                                                          ));
                                                                        }

                                                                        await currentUserReference!
                                                                            .update(createUsersRecordData(
                                                                          presentRoomGameInfo:
                                                                              createPresentRoomGameInfoStruct(delete: true),
                                                                        ));

                                                                        context.goNamed(
                                                                            HomeWidget.routeName);
                                                                      },
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          16.0)),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 8.0)),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                if (mainGameItem
                                                        .selectedGameUserList
                                                        .where((e) =>
                                                            e.roomUserNotificationSendStatus ==
                                                            'send')
                                                        .toList()
                                                        .length >
                                                    1)
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
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
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        16.0,
                                                                        24.0,
                                                                        12.0),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children:
                                                                              [
                                                                            RichText(
                                                                              textScaler: MediaQuery.of(context).textScaler,
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: FFLocalizations.of(context).getText(
                                                                                      '9f5tyrl2' /* Scores */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                          font: GoogleFonts.almarai(
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                        ),
                                                                                  )
                                                                                ],
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.almarai(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 8.0)),
                                                                        ),
                                                                      ),
                                                                      Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final winnerUserList = mainGameItem
                                                                              .selectedGameUserList
                                                                              .where((e) => e.roomUserNotificationSendStatus == 'send')
                                                                              .toList()
                                                                              .sortedList(keyOf: (e) => e.roomUserPoints, desc: true)
                                                                              .toList();
                                                                          if (winnerUserList
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
                                                                                winnerUserList.length,
                                                                            separatorBuilder: (_, __) =>
                                                                                SizedBox(height: 16.0),
                                                                            itemBuilder:
                                                                                (context, winnerUserListIndex) {
                                                                              final winnerUserListItem = winnerUserList[winnerUserListIndex];
                                                                              return Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 40.0,
                                                                                    height: 40.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      shape: BoxShape.circle,
                                                                                      border: Border.all(
                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                      ),
                                                                                    ),
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(100.0),
                                                                                      child: Image.network(
                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/7fnvxvk9w0jj/Frame_2087324742.png',
                                                                                        width: 60.0,
                                                                                        height: 60.0,
                                                                                        fit: BoxFit.cover,
                                                                                        alignment: Alignment(0.0, 0.0),
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
                                                                                    Container(
                                                                                      width: 40.0,
                                                                                      height: 40.0,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                        border: Border.all(
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                        ),
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
                                                                                              winnerUserListItem.roomUserInfo.userName,
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
                                                                                          ].divide(SizedBox(width: 4.0)),
                                                                                        ),
                                                                                      ].divide(SizedBox(height: 4.0)),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    '${winnerUserListItem.roomUserPoints.toString()}${FFLocalizations.of(context).getVariableText(
                                                                                      enText: ' Points',
                                                                                      arText: 'نقاط',
                                                                                    )}',
                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                          font: GoogleFonts.almarai(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).tertiary,
                                                                                          fontSize: 16.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 8.0)),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            16.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 16.0)),
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
