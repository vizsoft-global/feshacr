import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah/component/app_bar_default/app_bar_default_widget.dart';
import '/feshah/component/empty_widget_gamehistory/empty_widget_gamehistory_widget.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah/component/empty_widget_transaction/empty_widget_transaction_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/main/home_roomlist/home_roomlist_widget.dart';
import '/feshah_game_zone/main/home_widget2/home_widget2_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'my_feshah_model.dart';
export 'my_feshah_model.dart';

class MyFeshahWidget extends StatefulWidget {
  const MyFeshahWidget({super.key});

  static String routeName = 'MyFeshah';
  static String routePath = '/myfeshah';

  @override
  State<MyFeshahWidget> createState() => _MyFeshahWidgetState();
}

class _MyFeshahWidgetState extends State<MyFeshahWidget> {
  late MyFeshahModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyFeshahModel());

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
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.appBarDefaultModel,
                  updateCallback: () => safeSetState(() {}),
                  child: AppBarDefaultWidget(
                    pageTitle: FFLocalizations.of(context).getText(
                      '4z0vb3l7' /* My Feshah */,
                    ),
                    notificationNavStatus: true,
                    backNavStatus: true,
                  ),
                ),
              ],
            ),
            actions: [],
            centerTitle: true,
            elevation: 1.0,
          ),
        ),
        body: Stack(
          children: [
            wrapWithModel(
              model: _model.userStatusCheckerModel,
              updateCallback: () => safeSetState(() {}),
              child: UserStatusCheckerWidget(),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  valueOrDefault<double>(
                    functions.isLandscape(MediaQuery.sizeOf(context).width,
                            MediaQuery.sizeOf(context).height)!
                        ? 55.0
                        : 16.0,
                    16.0,
                  ),
                  16.0,
                  16.0,
                  0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primaryText,
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Coin-min.png',
                                  width: 32.0,
                                  height: 32.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'vj1s00wk' /* Your */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.almarai(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .warning,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'dc6g3i75' /* Wallet Balance */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 4.0)),
                                ),
                              ),
                              AuthUserStreamWidget(
                                builder: (context) => Text(
                                  '${valueOrDefault(currentUserDocument?.walletPoint, 0).toString()}${FFLocalizations.of(context).getVariableText(
                                    enText: ' Coins',
                                    arText: 'عملات معدنية',
                                  )}',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        font: GoogleFonts.almarai(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontStyle,
                                        ),
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(width: 12.0)),
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
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 0.5,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'pzaizia6' /* Your Room */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.almarai(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                                StreamBuilder<List<RoomRecord>>(
                                  stream: queryRoomRecord(
                                    queryBuilder: (roomRecord) => roomRecord
                                        .where(
                                          'room_status',
                                          isEqualTo: 'active',
                                        )
                                        .orderBy('room_created_at',
                                            descending: true),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<RoomRecord> containerRoomRecordList =
                                        snapshot.data!;

                                    return Container(
                                      decoration: BoxDecoration(),
                                      child: Builder(
                                        builder: (context) {
                                          final roomList = containerRoomRecordList
                                              .where((e) =>
                                                  (e.roomUserList
                                                          .where((e) =>
                                                              (e.roomUserRef ==
                                                                  currentUserReference) &&
                                                              (e.roomUserStatus ==
                                                                  'active'))
                                                          .toList()
                                                          .length >
                                                      0) &&
                                                  (e.roomType != 'solo'))
                                              .toList()
                                              .take(5)
                                              .toList();
                                          if (roomList.isEmpty) {
                                            return Center(
                                              child: EmptyWidgetRoomWidget(),
                                            );
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              0,
                                              8.0,
                                            ),
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: roomList.length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 8.0),
                                            itemBuilder:
                                                (context, roomListIndex) {
                                              final roomListItem =
                                                  roomList[roomListIndex];
                                              return HomeRoomlistWidget(
                                                key: Key(
                                                    'Key6vo_${roomListIndex}_of_${roomList.length}'),
                                                room: roomListItem,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primaryText,
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'ys97b8ea' /* Your Game History */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.almarai(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                              StreamBuilder<List<GameHistoryRecord>>(
                                stream: queryGameHistoryRecord(
                                  queryBuilder: (gameHistoryRecord) =>
                                      gameHistoryRecord
                                          .where(
                                            'user_ref',
                                            isEqualTo: currentUserReference,
                                          )
                                          .orderBy('created_at',
                                              descending: true),
                                  limit: 5,
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
                                  List<GameHistoryRecord>
                                      listViewGameHistoryRecordList =
                                      snapshot.data!;
                                  if (listViewGameHistoryRecordList.isEmpty) {
                                    return EmptyWidgetGamehistoryWidget();
                                  }

                                  return ListView.separated(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        listViewGameHistoryRecordList.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 8.0),
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewGameHistoryRecord =
                                          listViewGameHistoryRecordList[
                                              listViewIndex];
                                      return StreamBuilder<List<GameRecord>>(
                                        stream: queryGameRecord(
                                          queryBuilder: (gameRecord) =>
                                              gameRecord
                                                  .where(
                                                    'game_ID',
                                                    isEqualTo:
                                                        listViewGameHistoryRecord
                                                            .gameId,
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
                                          List<GameRecord>
                                              containerGameRecordList =
                                              snapshot.data!;
                                          // Return an empty Container when the item does not exist.
                                          if (snapshot.data!.isEmpty) {
                                            return Container();
                                          }
                                          final containerGameRecord =
                                              containerGameRecordList.isNotEmpty
                                                  ? containerGameRecordList
                                                      .first
                                                  : null;

                                          return Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: StreamBuilder<
                                                  List<RoomRecord>>(
                                                stream: queryRoomRecord(
                                                  queryBuilder: (roomRecord) =>
                                                      roomRecord.where(
                                                    'room_ID',
                                                    isEqualTo:
                                                        listViewGameHistoryRecord
                                                            .roomId,
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
                                                  List<RoomRecord>
                                                      rowRoomRecordList =
                                                      snapshot.data!;
                                                  final rowRoomRecord =
                                                      rowRoomRecordList
                                                              .isNotEmpty
                                                          ? rowRoomRecordList
                                                              .first
                                                          : null;

                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 40.0,
                                                        height: 40.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                            child:
                                                                Image.network(
                                                              containerGameRecord!
                                                                  .gameInfo
                                                                  .mainImage,
                                                              width: 200.0,
                                                              height: 200.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                                                                  .getVariableText(
                                                                enText: () {
                                                                  if (containerGameRecord
                                                                          ?.gameInfoManualTranslate
                                                                          ?.name
                                                                          ?.en !=
                                                                      '') {
                                                                    return containerGameRecord
                                                                        ?.gameInfoManualTranslate
                                                                        ?.name
                                                                        ?.en;
                                                                  } else if (containerGameRecord
                                                                          ?.gameInfoTranslate
                                                                          ?.name
                                                                          ?.en !=
                                                                      '') {
                                                                    return containerGameRecord
                                                                        ?.gameInfoTranslate
                                                                        ?.name
                                                                        ?.en;
                                                                  } else {
                                                                    return containerGameRecord
                                                                        ?.gameInfo
                                                                        ?.name;
                                                                  }
                                                                }(),
                                                                arText: () {
                                                                  if (containerGameRecord
                                                                          ?.gameInfoManualTranslate
                                                                          ?.name
                                                                          ?.ar !=
                                                                      '') {
                                                                    return containerGameRecord
                                                                        ?.gameInfoManualTranslate
                                                                        ?.name
                                                                        ?.ar;
                                                                  } else if (containerGameRecord
                                                                          ?.gameInfoTranslate
                                                                          ?.name
                                                                          ?.ar !=
                                                                      '') {
                                                                    return containerGameRecord
                                                                        ?.gameInfoTranslate
                                                                        ?.name
                                                                        ?.en;
                                                                  } else {
                                                                    return containerGameRecord
                                                                        ?.gameInfo
                                                                        ?.name;
                                                                  }
                                                                }(),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .almarai(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            if (((rowRoomRecord
                                                                            ?.roomType ==
                                                                        'solo') ||
                                                                    (listViewGameHistoryRecord
                                                                            .resultInfo
                                                                            .status ==
                                                                        'tie')) &&
                                                                responsiveVisibility(
                                                                  context:
                                                                      context,
                                                                  phone: false,
                                                                  tablet: false,
                                                                  tabletLandscape:
                                                                      false,
                                                                  desktop:
                                                                      false,
                                                                ))
                                                              Text(
                                                                '${dateTimeFormat(
                                                                  "d/M h:mm a",
                                                                  listViewGameHistoryRecord
                                                                      .createdAt,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                )} | ${listViewGameHistoryRecord.resultInfo.status} | ${rowRoomRecord?.roomType}',
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
                                                                      fontSize:
                                                                          10.0,
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
                                                            Text(
                                                              '${dateTimeFormat(
                                                                "d/M h:mm a",
                                                                listViewGameHistoryRecord
                                                                    .createdAt,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              )} | ${listViewGameHistoryRecord.resultInfo.teamInfo.name} ${(listViewGameHistoryRecord.resultInfo.status == 'exited') || (listViewGameHistoryRecord.resultInfo.status == 'tie') ? '' : FFLocalizations.of(context).getVariableText(
                                                                  enText:
                                                                      'team has',
                                                                  arText:
                                                                      'الفريق لديه',
                                                                )} ${listViewGameHistoryRecord.resultInfo.status}${rowRoomRecord?.roomType == 'solo' ? ' | ' : ' '}${rowRoomRecord?.roomType == 'solo' ? 'solo' : ' '}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
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
                                                                    fontSize:
                                                                        10.0,
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
                                                          ].divide(SizedBox(
                                                              height: 4.0)),
                                                        ),
                                                      ),
                                                      if (rowRoomRecord
                                                              ?.roomType !=
                                                          'solo')
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            if (rowRoomRecord
                                                                    ?.roomType ==
                                                                'solo') {
                                                              context.goNamed(
                                                                  HomeWidget
                                                                      .routeName);
                                                            } else {
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                barrierColor: Color(
                                                                    0x9A000000),
                                                                enableDrag:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return WebViewAware(
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.5,
                                                                          child:
                                                                              HomeWidget2Widget(
                                                                            gameID:
                                                                                listViewGameHistoryRecord.gameId,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            }
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'vku6mm4r' /* Play Again */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            height: 28.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        8.0,
                                                                        0.0,
                                                                        8.0,
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
                                                                .primaryBackground,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
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
                                                    ].divide(
                                                        SizedBox(width: 8.0)),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primaryText,
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'u1yfuqe4' /* Your Transactions */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.almarai(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                              StreamBuilder<List<OrderRecord>>(
                                stream: queryOrderRecord(
                                  queryBuilder: (orderRecord) => orderRecord
                                      .where(
                                        'order_userRef',
                                        isEqualTo: currentUserReference,
                                      )
                                      .orderBy('created_at', descending: true),
                                  limit: 5,
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
                                  List<OrderRecord> listViewOrderRecordList =
                                      snapshot.data!;
                                  if (listViewOrderRecordList.isEmpty) {
                                    return EmptyWidgetTransactionWidget();
                                  }

                                  return ListView.separated(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: listViewOrderRecordList.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 8.0),
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewOrderRecord =
                                          listViewOrderRecordList[
                                              listViewIndex];
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 8.0, 0.0),
                                                child: Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
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
                                                          BorderRadius.circular(
                                                              0.0),
                                                      child: Image.asset(
                                                        'assets/images/yhgsr_.png',
                                                        width: 200.0,
                                                        height: 200.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 8.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        listViewOrderRecord
                                                            .orderCartItem
                                                            .planInfo
                                                            .name,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodySmall
                                                            .override(
                                                              font: GoogleFonts
                                                                  .almarai(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            dateTimeFormat(
                                                              "d/M h:mm a",
                                                              listViewOrderRecord
                                                                  .updatedAt!,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                                                          Text(
                                                            () {
                                                              if (listViewOrderRecord
                                                                      .orderStatus ==
                                                                  'CAPTURED') {
                                                                return FFLocalizations.of(
                                                                        context)
                                                                    .getVariableText(
                                                                  enText:
                                                                      'SUCCESS',
                                                                  arText:
                                                                      'نجاح',
                                                                );
                                                              } else if (listViewOrderRecord
                                                                      .orderStatus ==
                                                                  'FAILED') {
                                                                return FFLocalizations.of(
                                                                        context)
                                                                    .getVariableText(
                                                                  enText:
                                                                      'FAILED',
                                                                  arText: 'فشل',
                                                                );
                                                              } else {
                                                                return FFLocalizations.of(
                                                                        context)
                                                                    .getVariableText(
                                                                  enText:
                                                                      'CANCELLED',
                                                                  arText:
                                                                      'تم الإلغاء',
                                                                );
                                                              }
                                                            }(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                                                          Stack(
                                                            children: [
                                                              if (listViewOrderRecord
                                                                      .orderStatus !=
                                                                  'CAPTURED')
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          2.0),
                                                                  child: Icon(
                                                                    FFIcons
                                                                        .kfi12,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    size: 10.0,
                                                                  ),
                                                                ),
                                                              if (listViewOrderRecord
                                                                      .orderStatus ==
                                                                  'CAPTURED')
                                                                Icon(
                                                                  FFIcons.kfi42,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                                  size: 10.0,
                                                                ),
                                                            ],
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 6.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 4.0)),
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child: Image.asset(
                                                  'assets/images/Coin-min.png',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        4.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    listViewOrderRecord
                                                        .orderCartItem.planPoint
                                                        .toString(),
                                                    '0',
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
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
