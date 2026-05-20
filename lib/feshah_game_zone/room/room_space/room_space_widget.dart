import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/app_bar_room/app_bar_room_widget.dart';
import '/feshah/component/empty_widget_game/empty_widget_game_widget.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah/payment/point_list_private_wallet/point_list_private_wallet_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/game_grid/game_grid_widget.dart';
import '/feshah_game_zone/game_one/game_one_user/game_one_user_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'room_space_model.dart';
export 'room_space_model.dart';

class RoomSpaceWidget extends StatefulWidget {
  const RoomSpaceWidget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  static String routeName = 'RoomSpace';
  static String routePath = '/room_space';

  @override
  State<RoomSpaceWidget> createState() => _RoomSpaceWidgetState();
}

class _RoomSpaceWidgetState extends State<RoomSpaceWidget> {
  late RoomSpaceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RoomSpaceModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.unsetOrientation();
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
          preferredSize: Size.fromHeight(60.0),
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

                final appBarRoomRoomRecord = snapshot.data!;

                return wrapWithModel(
                  model: _model.appBarRoomModel,
                  updateCallback: () => safeSetState(() {}),
                  updateOnChange: true,
                  child: AppBarRoomWidget(
                    room: widget!.room!,
                    roomNormalNav: true,
                    roomAdminNav:
                        appBarRoomRoomRecord.isRoomWalletStatus == true,
                    backStatus: 'black',
                  ),
                );
              },
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
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
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x2568B5B0),
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Color(0xFF559895),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          child: Image.asset(
                                            'assets/images/Badge.png',
                                            width: 24.0,
                                            height: 24.0,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              '6ybj3krq' /* 0 Badges */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.almarai(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                  ),
                                                  color: Color(0xFF559895),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x26F9A0A4),
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Color(0xFFF9A0A4),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          child: Image.asset(
                                            'assets/images/users-01.png',
                                            width: 24.0,
                                            height: 24.0,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${stackRoomRecord.roomUserList.where((e) => e.roomUserStatus == 'active').toList().length.toString()}${FFLocalizations.of(context).getVariableText(
                                              enText: ' Players',
                                              arText: 'اللاعبين',
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.almarai(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                  ),
                                                  color: Color(0xFFF9A0A4),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    FFAppState().updateUserflowStruct(
                                      (e) => e..paymentProcessingTime = null,
                                    );
                                    _model.pointResultRoom =
                                        await queryPointRecordOnce(
                                      queryBuilder: (pointRecord) =>
                                          pointRecord.where(
                                        'point_status',
                                        isEqualTo: 'active',
                                      ),
                                    );
                                    if (_model.pointResultRoom!.length > 0) {
                                      FFAppState().updateUserflowStruct(
                                        (e) => e
                                          ..updatePaymentProcessingTime(
                                            (e) => e
                                              ..presentUserRef =
                                                  currentUserReference
                                              ..paymentPlanItem =
                                                  OrderCartItemStruct(
                                                type: 'points',
                                                planId: _model.pointResultRoom
                                                    ?.firstOrNull?.pointID,
                                                planInfo: _model.pointResultRoom
                                                    ?.firstOrNull?.mainInfo,
                                                quantity: 1,
                                                planPrice: _model
                                                    .pointResultRoom
                                                    ?.firstOrNull
                                                    ?.pointInfo
                                                    ?.price,
                                                totalPrice: _model
                                                    .pointResultRoom
                                                    ?.firstOrNull
                                                    ?.pointInfo
                                                    ?.price,
                                                planPoint: _model
                                                    .pointResultRoom
                                                    ?.firstOrNull
                                                    ?.pointInfo
                                                    ?.point,
                                                planRef: _model.pointResultRoom
                                                    ?.firstOrNull?.reference,
                                                planFor: 'room',
                                                roomRef: widget!.room,
                                              ),
                                          ),
                                      );
                                      safeSetState(() {});
                                      if (_model.walletClick == false) {
                                        _model.walletClick = true;
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          barrierColor: Color(0x9A000000),
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return WebViewAware(
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      PointListPrivateWalletWidget(
                                                    orderFor: 'room',
                                                    room: stackRoomRecord,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));

                                        _model.walletClick = false;
                                      }
                                    }

                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0x26F5C235),
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: Color(0xFFF5C235),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
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
                                          Expanded(
                                            child: StreamBuilder<UsersRecord>(
                                              stream: UsersRecord.getDocument(
                                                  stackRoomRecord
                                                      .roomCreatedUserRef!),
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

                                                final textUsersRecord =
                                                    snapshot.data!;

                                                return Text(
                                                  valueOrDefault<String>(
                                                    '${valueOrDefault<String>(
                                                      stackRoomRecord
                                                          .roomWalletTotalPoint
                                                          .toString(),
                                                      '0',
                                                    )}${FFLocalizations.of(context).getVariableText(
                                                      enText: ' Coins',
                                                      arText: ' عملات معدنية',
                                                    )}',
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.almarai(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            Color(0xFFF5C235),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontStyle,
                                                      ),
                                                );
                                              },
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 230.0,
                        decoration: BoxDecoration(),
                        child: StreamBuilder<List<GameRecord>>(
                          stream: queryGameRecord(
                            queryBuilder: (gameRecord) => gameRecord
                                .where(
                                  'game_status',
                                  isEqualTo: 'active',
                                )
                                .orderBy('game_ID'),
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
                            List<GameRecord> gameListGameRecordList =
                                snapshot.data!;
                            if (gameListGameRecordList.isEmpty) {
                              return Center(
                                child: EmptyWidgetGameWidget(),
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: gameListGameRecordList.length,
                              separatorBuilder: (_, __) => SizedBox(width: 8.0),
                              itemBuilder: (context, gameListIndex) {
                                final gameListGameRecord =
                                    gameListGameRecordList[gameListIndex];
                                return Container(
                                  width: MediaQuery.sizeOf(context).width <
                                          kBreakpointMedium
                                      ? 130.0
                                      : 150.0,
                                  decoration: BoxDecoration(),
                                  child: GameGridWidget(
                                    key: Key(
                                        'Keykt3_${gameListIndex}_of_${gameListGameRecordList.length}'),
                                    game: gameListGameRecord,
                                    playStatus: true,
                                    room: widget!.room,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 0.5,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
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
                                            'linhaktw' /* Players in Room */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                font: GoogleFonts.almarai(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                        RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  stackRoomRecord.roomUserList
                                                      .where((e) =>
                                                          e.roomUserStatus ==
                                                          'active')
                                                      .toList()
                                                      .length
                                                      .toString(),
                                                  '0',
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelSmall
                                                    .override(
                                                      font: GoogleFonts.almarai(
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
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
                                              TextSpan(
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'syntk1gt' /*  Joined */,
                                                ),
                                                style: TextStyle(),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  font: GoogleFonts.almarai(
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
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Builder(
                                          builder: (context) {
                                            final activeUserList =
                                                stackRoomRecord.roomUserList
                                                    .where((e) =>
                                                        e.roomUserStatus ==
                                                        'active')
                                                    .toList();
                                            if (activeUserList.isEmpty) {
                                              return Center(
                                                child: EmptyWidgetRoomWidget(),
                                              );
                                            }

                                            return ListView.separated(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: activeUserList.length,
                                              separatorBuilder: (_, __) =>
                                                  SizedBox(height: 12.0),
                                              itemBuilder: (context,
                                                  activeUserListIndex) {
                                                final activeUserListItem =
                                                    activeUserList[
                                                        activeUserListIndex];
                                                return StreamBuilder<
                                                    List<UsersRecord>>(
                                                  stream: queryUsersRecord(
                                                    queryBuilder:
                                                        (usersRecord) =>
                                                            usersRecord
                                                                .where(
                                                                  'status',
                                                                  isEqualTo:
                                                                      'Publish',
                                                                )
                                                                .where(
                                                                  'user_id',
                                                                  isEqualTo:
                                                                      activeUserListItem
                                                                          .roomUserId,
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
                                                    List<UsersRecord>
                                                        wrapUsersRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final wrapUsersRecord =
                                                        wrapUsersRecordList
                                                                .isNotEmpty
                                                            ? wrapUsersRecordList
                                                                .first
                                                            : null;

                                                    return Wrap(
                                                      spacing: 8.0,
                                                      runSpacing: 8.0,
                                                      alignment:
                                                          WrapAlignment.start,
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      direction:
                                                          Axis.horizontal,
                                                      runAlignment:
                                                          WrapAlignment.start,
                                                      verticalDirection:
                                                          VerticalDirection
                                                              .down,
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        GameOneUserWidget(
                                                          key: Key(
                                                              'Keymbu_${activeUserListIndex}_of_${activeUserList.length}'),
                                                          roomUser:
                                                              activeUserListItem,
                                                          user:
                                                              activeUserListItem
                                                                  .roomUserRef!,
                                                          index:
                                                              activeUserListIndex,
                                                          room: stackRoomRecord,
                                                          inviteStatus: false,
                                                          activeStatus: false,
                                                          addStatus: false,
                                                          selectedGameIndex: 0,
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
                                    ]
                                        .addToStart(SizedBox(height: 8.0))
                                        .addToEnd(SizedBox(height: 8.0)),
                                  ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
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
