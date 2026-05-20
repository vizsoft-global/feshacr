import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
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
import 'game_one_s3_model.dart';
export 'game_one_s3_model.dart';

class GameOneS3Widget extends StatefulWidget {
  const GameOneS3Widget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  static String routeName = 'GameOne-S3';
  static String routePath = '/Game1Result';

  @override
  State<GameOneS3Widget> createState() => _GameOneS3WidgetState();
}

class _GameOneS3WidgetState extends State<GameOneS3Widget> {
  late GameOneS3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameOneS3Model());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.setOrientation();
      if (currentUserDocument?.userSetting?.isSoundstatus != true) {
        return;
      }
      _model.soundPlayer1 ??= AudioPlayer();
      if (_model.soundPlayer1!.playing) {
        await _model.soundPlayer1!.stop();
      }
      _model.soundPlayer1!.setVolume(0.2);
      _model.soundPlayer1!
          .setAsset(
              'assets/audios/Win_the_game_(online-audio-converter.com).mp3')
          .then((_) => _model.soundPlayer1!.play());
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: StreamBuilder<RoomRecord>(
          stream: RoomRecord.getDocument(widget!.room!),
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
                                final selectGame = stackRoomRecord
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
                                  children: List.generate(selectGame.length,
                                      (selectGameIndex) {
                                    final selectGameItem =
                                        selectGame[selectGameIndex];
                                    return Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            50.0, 24.0, 50.0, 24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (selectGameItem
                                                    .gameResult.status ==
                                                'win')
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Container(
                                                              width: 80.0,
                                                              height: 80.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  valueOrDefault<
                                                                              int>(
                                                                            selectGameItem.gameResult.point,
                                                                            0,
                                                                          ) <
                                                                          0
                                                                      ? '0'
                                                                      : valueOrDefault<
                                                                          String>(
                                                                          selectGameItem
                                                                              .gameResult
                                                                              .point
                                                                              .toString(),
                                                                          '0',
                                                                        ),
                                                                  minFontSize:
                                                                      18.0,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .almarai(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .headlineMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontSize:
                                                                            24.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .headlineMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          if (FFLocalizations.of(
                                                                      context)
                                                                  .languageCode ==
                                                              'en')
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/Group_(10).png',
                                                                width: 24.0,
                                                                height: 24.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          if (FFLocalizations.of(
                                                                      context)
                                                                  .languageCode ==
                                                              'ar')
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/image-crown.png',
                                                                width: 24.0,
                                                                height: 24.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                selectGameItem
                                                                    .gameResult
                                                                    .teamInfo
                                                                    .name,
                                                                '0',
                                                              ),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                'lgmp4cu8' /*  win the game */,
                                                              ),
                                                              style:
                                                                  TextStyle(),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .almarai(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        '${FFLocalizations.of(context).getVariableText(
                                                          enText: 'with ',
                                                          arText: 'مع',
                                                        )}${valueOrDefault<int>(
                                                              selectGameItem
                                                                  .gameResult
                                                                  .point,
                                                              0,
                                                            ) < 0 ? '0' : valueOrDefault<String>(
                                                            selectGameItem
                                                                .gameResult
                                                                .point
                                                                .toString(),
                                                            '0',
                                                          )}${FFLocalizations.of(context).getVariableText(
                                                          enText:
                                                              ' points and a smile :)',
                                                          arText:
                                                              'نقاط وابتسامة :)',
                                                        )}',
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
                                                      ),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 55.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
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
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          36.0,
                                                                      height:
                                                                          36.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0x4DFFFFFF),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '6kx17662' /* A */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                font: GoogleFonts.almarai(
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          100.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Opacity(
                                                                            opacity:
                                                                                0.7,
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'lx88p4gf' /* Score */,
                                                                              ),
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
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                4.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<int>(
                                                                                        selectGameItem.teamInfo.firstOrNull?.totalResult,
                                                                                        0,
                                                                                      ) <
                                                                                      0
                                                                                  ? '0'
                                                                                  : valueOrDefault<String>(
                                                                                      selectGameItem.teamInfo.firstOrNull?.totalResult?.toString(),
                                                                                      '0',
                                                                                    ),
                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    font: GoogleFonts.almarai(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 2.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          8.0)),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'oxod0a7q' /* | */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
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
                                                                    fontSize:
                                                                        32.0,
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
                                                            Container(
                                                              height: 55.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: valueOrDefault<
                                                                            int>(
                                                                          selectGameItem
                                                                              .teamInfo
                                                                              .elementAtOrNull(1)
                                                                              ?.teamID,
                                                                          0,
                                                                        ) ==
                                                                        999
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
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
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          36.0,
                                                                      height:
                                                                          36.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0x4DFFFFFF),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'ws5r8bek' /* B */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                font: GoogleFonts.almarai(
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          100.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Opacity(
                                                                            opacity:
                                                                                0.7,
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                '7s86chng' /* Score */,
                                                                              ),
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
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                4.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<int>(
                                                                                        selectGameItem.teamInfo.elementAtOrNull(1)?.totalResult,
                                                                                        0,
                                                                                      ) <
                                                                                      0
                                                                                  ? '0'
                                                                                  : valueOrDefault<String>(
                                                                                      selectGameItem.teamInfo.elementAtOrNull(1)?.totalResult?.toString(),
                                                                                      '0',
                                                                                    ),
                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    font: GoogleFonts.almarai(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 2.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          8.0)),
                                                                ),
                                                              ),
                                                            ),
                                                            if (selectGameItem
                                                                    .teamInfo
                                                                    .length ==
                                                                3)
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'cttostvf' /* | */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .almarai(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      fontSize:
                                                                          32.0,
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
                                                            if (selectGameItem
                                                                    .teamInfo
                                                                    .length ==
                                                                3)
                                                              Container(
                                                                height: 55.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    width: 0.5,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          8.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            36.0,
                                                                        height:
                                                                            36.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0x4DFFFFFF),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'hfwb1st7' /* C */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                  font: GoogleFonts.almarai(
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            100.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Opacity(
                                                                              opacity: 0.7,
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  'iy38zgly' /* Score */,
                                                                                ),
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
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                valueOrDefault<int>(
                                                                                          selectGameItem.teamInfo.lastOrNull?.totalResult,
                                                                                          0,
                                                                                        ) <
                                                                                        0
                                                                                    ? '0'
                                                                                    : valueOrDefault<String>(
                                                                                        selectGameItem.teamInfo.lastOrNull?.totalResult?.toString(),
                                                                                        '0',
                                                                                      ),
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.almarai(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 2.0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            8.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                          ].divide(SizedBox(
                                                              width: 12.0)),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                _model.soundPlayer2 ??=
                                                                    AudioPlayer();
                                                                if (_model
                                                                    .soundPlayer2!
                                                                    .playing) {
                                                                  await _model
                                                                      .soundPlayer2!
                                                                      .stop();
                                                                }
                                                                _model
                                                                    .soundPlayer2!
                                                                    .setVolume(
                                                                        0.2);
                                                                _model
                                                                    .soundPlayer2!
                                                                    .setAsset(
                                                                        'assets/audios/Share_result_2.mp3')
                                                                    .then((_) => _model
                                                                        .soundPlayer2!
                                                                        .play());
                                                              },
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                't5qdsq7s' /* Share Result */,
                                                              ),
                                                              icon: Icon(
                                                                FFIcons.kfi11,
                                                                size: 15.0,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                width: 200.0,
                                                                height: 50.0,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            0.0),
                                                                iconAlignment:
                                                                    IconAlignment
                                                                        .end,
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                                textStyle: FlutterFlowTheme.of(
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      fontSize:
                                                                          14.0,
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
                                                          ),
                                                          if (stackRoomRecord
                                                                  .roomCreatedUserRef ==
                                                              currentUserReference)
                                                            Expanded(
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  await currentUserReference!
                                                                      .update(
                                                                          createUsersRecordData(
                                                                    presentRoomGameInfo:
                                                                        createPresentRoomGameInfoStruct(
                                                                            delete:
                                                                                true),
                                                                  ));
                                                                  if (stackRoomRecord
                                                                          .isRoomWalletStatus ==
                                                                      true) {
                                                                    context
                                                                        .goNamed(
                                                                      RoomSpaceWidget
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
                                                                  } else {
                                                                    context.goNamed(
                                                                        HomeWidget
                                                                            .routeName);
                                                                  }
                                                                },
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'yx5z9z7m' /* Next Game */,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: 200.0,
                                                                  height: 50.0,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                                  textStyle: FlutterFlowTheme.of(
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
                                                                  elevation:
                                                                      0.0,
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
                                                            ),
                                                          FlutterFlowIconButton(
                                                            borderColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            borderRadius: 8.0,
                                                            borderWidth: 0.5,
                                                            buttonSize: 50.0,
                                                            fillColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                            icon: Icon(
                                                              FFIcons.kfi9,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .info,
                                                              size: 24.0,
                                                            ),
                                                            showLoadingIndicator:
                                                                true,
                                                            onPressed:
                                                                () async {
                                                              _model.countGameList =
                                                                  stackRoomRecord
                                                                      .selectedGameList
                                                                      .length;
                                                              _model.selectedGameList =
                                                                  stackRoomRecord
                                                                      .selectedGameList
                                                                      .toList()
                                                                      .cast<
                                                                          SelectedGameListStruct>();
                                                              while (_model
                                                                      .countGameList! >
                                                                  0) {
                                                                if (_model
                                                                        .selectedGameList
                                                                        .elementAtOrNull(
                                                                            (_model.countGameList!) -
                                                                                1)
                                                                        ?.selectedGameID ==
                                                                    selectGameItem
                                                                        .selectedGameID) {
                                                                  _model.countUser = _model
                                                                      .selectedGameList
                                                                      .elementAtOrNull(
                                                                          (_model.countGameList!) -
                                                                              1)
                                                                      ?.selectedGameUserList
                                                                      ?.length;
                                                                  _model.selectedUserList = _model
                                                                      .selectedGameList
                                                                      .elementAtOrNull(
                                                                          (_model.countGameList!) -
                                                                              1)!
                                                                      .selectedGameUserList
                                                                      .toList()
                                                                      .cast<
                                                                          RoomUserListStruct>();
                                                                  _model.idmapResult1 =
                                                                      await queryIDmapRecordOnce(
                                                                    queryBuilder:
                                                                        (iDmapRecord) =>
                                                                            iDmapRecord.where(
                                                                      'type',
                                                                      isEqualTo:
                                                                          'Main',
                                                                    ),
                                                                    singleRecord:
                                                                        true,
                                                                  ).then((s) =>
                                                                          s.firstOrNull);
                                                                  while (_model
                                                                          .countUser! >
                                                                      0) {
                                                                    if (_model
                                                                            .selectedUserList
                                                                            .elementAtOrNull((_model.countUser!) -
                                                                                1)
                                                                            ?.roomUserStatus ==
                                                                        'active') {
                                                                      await GameHistoryRecord
                                                                          .collection
                                                                          .doc()
                                                                          .set(
                                                                              createGameHistoryRecordData(
                                                                            createdAt:
                                                                                getCurrentTimestamp,
                                                                            updatedAt:
                                                                                getCurrentTimestamp,
                                                                            gameHistoryID:
                                                                                _model.idmapResult1?.historyId,
                                                                            gameId:
                                                                                columnGameRecord?.gameID,
                                                                            userId:
                                                                                _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserId?.toString(),
                                                                            userRef:
                                                                                _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef,
                                                                            roomId:
                                                                                stackRoomRecord.roomID,
                                                                            resultInfo:
                                                                                createResultInfoStruct(
                                                                              status: 'tie',
                                                                              createdAt: getCurrentTimestamp,
                                                                              clearUnsetFields: false,
                                                                              create: true,
                                                                            ),
                                                                          ));
                                                                      unawaited(
                                                                        () async {
                                                                          await _model
                                                                              .selectedUserList
                                                                              .elementAtOrNull((_model.countUser!) - 1)!
                                                                              .roomUserRef!
                                                                              .update(createUsersRecordData(
                                                                                presentRoomGameInfo: createPresentRoomGameInfoStruct(delete: true),
                                                                              ));
                                                                        }(),
                                                                      );

                                                                      await _model
                                                                          .idmapResult1!
                                                                          .reference
                                                                          .update({
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'history_id':
                                                                                FieldValue.increment(1),
                                                                          },
                                                                        ),
                                                                      });
                                                                    }
                                                                    _model.countUser =
                                                                        (_model.countUser!) -
                                                                            1;
                                                                  }
                                                                }
                                                                _model.countGameList =
                                                                    (_model.countGameList!) -
                                                                        1;
                                                              }

                                                              await stackRoomRecord
                                                                  .reference
                                                                  .update({
                                                                ...createRoomRecordData(
                                                                  roomUpdatedAt:
                                                                      getCurrentTimestamp,
                                                                ),
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

                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                presentRoomGameInfo:
                                                                    createPresentRoomGameInfoStruct(
                                                                        delete:
                                                                            true),
                                                              ));

                                                              context.goNamed(
                                                                  HomeWidget
                                                                      .routeName);

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 16.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 16.0)),
                                                  ),
                                                ),
                                              ),
                                            if (selectGameItem
                                                    .gameResult.status ==
                                                'tie')
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (valueOrDefault<int>(
                                                                selectGameItem
                                                                    .teamInfo
                                                                    .length,
                                                                0,
                                                              ) ==
                                                              2
                                                          ? ((valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .firstOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) ==
                                                                  valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .lastOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  )) &&
                                                              (valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .firstOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) !=
                                                                  0))
                                                          : ((valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .firstOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) ==
                                                                  valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .lastOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  )) &&
                                                              (valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .elementAtOrNull(
                                                                            1)
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) ==
                                                                  valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .lastOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  )) &&
                                                              (valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .firstOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) !=
                                                                  0) &&
                                                              (valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .firstOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) ==
                                                                  valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .elementAtOrNull(
                                                                            1)
                                                                        ?.totalResult,
                                                                    0,
                                                                  ))))
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                  border: Border
                                                                      .all(
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
                                                                              8.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            44.0,
                                                                        height:
                                                                            44.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0x4DFFFFFF),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'yfr9f09g' /* A */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                  font: GoogleFonts.almarai(
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            80.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(4.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Opacity(
                                                                                opacity: 0.7,
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'yxu54j9q' /* Score */,
                                                                                  ),
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
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  valueOrDefault<int>(
                                                                                            selectGameItem.teamInfo.firstOrNull?.totalResult,
                                                                                            0,
                                                                                          ) <
                                                                                          0
                                                                                      ? '0'
                                                                                      : valueOrDefault<String>(
                                                                                          selectGameItem.teamInfo.firstOrNull?.totalResult?.toString(),
                                                                                          '0',
                                                                                        ),
                                                                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                        font: GoogleFonts.almarai(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                        ),
                                                                                        fontSize: 20.0,
                                                                                        letterSpacing: 2.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            8.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '3cxjlds5' /* VS */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .almarai(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontStyle,
                                                                      ),
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
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: valueOrDefault<
                                                                              int>(
                                                                            selectGameItem.teamInfo.elementAtOrNull(1)?.teamID,
                                                                            0,
                                                                          ) ==
                                                                          999
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                  border: Border
                                                                      .all(
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
                                                                              8.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            44.0,
                                                                        height:
                                                                            44.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0x4DFFFFFF),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'xsn8j6j4' /* B */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                  font: GoogleFonts.almarai(
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            80.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(4.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Opacity(
                                                                                opacity: 0.7,
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'k1n29tsd' /* Score */,
                                                                                  ),
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
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  valueOrDefault<int>(
                                                                                            selectGameItem.teamInfo.elementAtOrNull(1)?.totalResult,
                                                                                            0,
                                                                                          ) <
                                                                                          0
                                                                                      ? '0'
                                                                                      : valueOrDefault<String>(
                                                                                          selectGameItem.teamInfo.elementAtOrNull(1)?.totalResult?.toString(),
                                                                                          '0',
                                                                                        ),
                                                                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                        font: GoogleFonts.almarai(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                        ),
                                                                                        fontSize: 20.0,
                                                                                        letterSpacing: 2.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            8.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (selectGameItem
                                                                      .teamInfo
                                                                      .length ==
                                                                  3)
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'u8qa8d4s' /* VS */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .almarai(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              if (selectGameItem
                                                                      .teamInfo
                                                                      .length ==
                                                                  3)
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
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
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Container(
                                                                          width:
                                                                              44.0,
                                                                          height:
                                                                              44.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0x4DFFFFFF),
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'ygl32nb6' /* C */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    font: GoogleFonts.almarai(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              80.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(4.0),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Opacity(
                                                                                  opacity: 0.7,
                                                                                  child: Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      's2h8dtc2' /* Score */,
                                                                                    ),
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
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                  child: Text(
                                                                                    valueOrDefault<int>(
                                                                                              selectGameItem.teamInfo.lastOrNull?.totalResult,
                                                                                              0,
                                                                                            ) <
                                                                                            0
                                                                                        ? '0'
                                                                                        : valueOrDefault<String>(
                                                                                            selectGameItem.teamInfo.lastOrNull?.totalResult?.toString(),
                                                                                            '0',
                                                                                          ),
                                                                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                          font: GoogleFonts.almarai(
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                          ),
                                                                                          fontSize: 20.0,
                                                                                          letterSpacing: 2.0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 8.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ].divide(SizedBox(
                                                                width: 16.0)),
                                                          ),
                                                        ),
                                                      if (() {
                                                        if (selectGameItem
                                                                .teamInfo
                                                                .elementAtOrNull(
                                                                    1)
                                                                ?.teamID ==
                                                            999) {
                                                          return false;
                                                        } else if (valueOrDefault<
                                                                int>(
                                                              selectGameItem
                                                                  .teamInfo
                                                                  .length,
                                                              0,
                                                            ) ==
                                                            2) {
                                                          return ((valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .firstOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) ==
                                                                  valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .lastOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  )) &&
                                                              (valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .firstOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) !=
                                                                  0) &&
                                                              (selectGameItem
                                                                      .teamInfo
                                                                      .elementAtOrNull(
                                                                          1)
                                                                      ?.teamID !=
                                                                  999) &&
                                                              (selectGameItem
                                                                      .gameTieBreak !=
                                                                  'set'));
                                                        } else {
                                                          return ((valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .firstOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) ==
                                                                  valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .lastOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  )) &&
                                                              (valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .elementAtOrNull(
                                                                            1)
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) ==
                                                                  valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .lastOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  )) &&
                                                              (valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .firstOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) ==
                                                                  valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .elementAtOrNull(
                                                                            1)
                                                                        ?.totalResult,
                                                                    0,
                                                                  )) &&
                                                              (valueOrDefault<
                                                                      int>(
                                                                    selectGameItem
                                                                        .teamInfo
                                                                        .firstOrNull
                                                                        ?.totalResult,
                                                                    0,
                                                                  ) !=
                                                                  0) &&
                                                              (selectGameItem
                                                                      .gameTieBreak !=
                                                                  'set'));
                                                        }
                                                      }())
                                                        Text(
                                                          selectGameItem
                                                                      .gameTieBreak !=
                                                                  'set'
                                                              ? FFLocalizations
                                                                      .of(
                                                                          context)
                                                                  .getVariableText(
                                                                  enText:
                                                                      'It’s a tie! Let’s break the tie with a thrilling tie breaker round to find the winner!',
                                                                  arText:
                                                                      'انتهى التعادل! لنكسر التعادل بجولة فاصلة مثيرة لنعرف الفائز!',
                                                                )
                                                              : FFLocalizations
                                                                      .of(context)
                                                                  .getVariableText(
                                                                  enText:
                                                                      'It’s still a tie! No winner this time.',
                                                                  arText:
                                                                      'انها لا تزال التعادل! لا يوجد فائز هذه المرة.',
                                                                ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font: GoogleFonts
                                                                    .almarai(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      if (stackRoomRecord
                                                              .roomCreatedUserRef ==
                                                          currentUserReference)
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            if ((selectGameItem
                                                                        .teamInfo
                                                                        .elementAtOrNull(
                                                                            1)
                                                                        ?.teamID !=
                                                                    999) &&
                                                                (valueOrDefault<
                                                                            int>(
                                                                          selectGameItem
                                                                              .teamInfo
                                                                              .length,
                                                                          0,
                                                                        ) ==
                                                                        2
                                                                    ? ((valueOrDefault<
                                                                                int>(
                                                                              selectGameItem.teamInfo.firstOrNull?.totalResult,
                                                                              0,
                                                                            ) ==
                                                                            valueOrDefault<
                                                                                int>(
                                                                              selectGameItem.teamInfo.lastOrNull?.totalResult,
                                                                              0,
                                                                            )) &&
                                                                        (valueOrDefault<
                                                                                int>(
                                                                              selectGameItem.teamInfo.firstOrNull?.totalResult,
                                                                              0,
                                                                            ) !=
                                                                            0))
                                                                    : ((valueOrDefault<
                                                                                int>(
                                                                              selectGameItem.teamInfo.firstOrNull?.totalResult,
                                                                              0,
                                                                            ) ==
                                                                            valueOrDefault<
                                                                                int>(
                                                                              selectGameItem.teamInfo.lastOrNull?.totalResult,
                                                                              0,
                                                                            )) &&
                                                                        (valueOrDefault<
                                                                                int>(
                                                                              selectGameItem.teamInfo.elementAtOrNull(1)?.totalResult,
                                                                              0,
                                                                            ) ==
                                                                            valueOrDefault<
                                                                                int>(
                                                                              selectGameItem.teamInfo.lastOrNull?.totalResult,
                                                                              0,
                                                                            )) &&
                                                                        (valueOrDefault<
                                                                                int>(
                                                                              selectGameItem.teamInfo.firstOrNull?.totalResult,
                                                                              0,
                                                                            ) !=
                                                                            0) &&
                                                                        (valueOrDefault<
                                                                                int>(
                                                                              selectGameItem.teamInfo.firstOrNull?.totalResult,
                                                                              0,
                                                                            ) ==
                                                                            valueOrDefault<
                                                                                int>(
                                                                              selectGameItem.teamInfo.elementAtOrNull(1)?.totalResult,
                                                                              0,
                                                                            )))) &&
                                                                (selectGameItem
                                                                        .gameTieBreak !=
                                                                    'set'))
                                                              FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  _model.idmapNewRound =
                                                                      await queryIDmapRecordOnce(
                                                                    queryBuilder:
                                                                        (iDmapRecord) =>
                                                                            iDmapRecord.where(
                                                                      'type',
                                                                      isEqualTo:
                                                                          'Main',
                                                                    ),
                                                                    singleRecord:
                                                                        true,
                                                                  ).then((s) =>
                                                                          s.firstOrNull);
                                                                  _model.countGameList =
                                                                      stackRoomRecord
                                                                          .selectedGameList
                                                                          .length;
                                                                  _model.selectedGameList = stackRoomRecord
                                                                      .selectedGameList
                                                                      .toList()
                                                                      .cast<
                                                                          SelectedGameListStruct>();
                                                                  _model.tieTotalQuestionCount =
                                                                      0;
                                                                  while (_model
                                                                          .countGameList! >
                                                                      0) {
                                                                    if (_model
                                                                            .selectedGameList
                                                                            .elementAtOrNull((_model.countGameList!) -
                                                                                1)
                                                                            ?.selectedGameID ==
                                                                        selectGameItem
                                                                            .selectedGameID) {
                                                                      _model.countTopic = _model
                                                                          .selectedGameList
                                                                          .elementAtOrNull((_model.countGameList!) -
                                                                              1)
                                                                          ?.selectedTopicIDList
                                                                          ?.length;
                                                                      _model.selectedTopicIDlist = _model
                                                                          .selectedGameList
                                                                          .elementAtOrNull((_model.countGameList!) -
                                                                              1)!
                                                                          .selectedTopicIDList
                                                                          .toList()
                                                                          .cast<
                                                                              int>();
                                                                      while (_model
                                                                              .countTopic! >
                                                                          0) {
                                                                        if (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.gameTieTopicIDList?.contains(_model.selectedTopicIDlist.elementAtOrNull((_model.countTopic!) -
                                                                                1)) ==
                                                                            false) {
                                                                          _model.tieQuestionResult100 =
                                                                              await queryTopicQuestionRecordOnce(
                                                                            queryBuilder: (topicQuestionRecord) => topicQuestionRecord
                                                                                .where(
                                                                                  'question_status',
                                                                                  isEqualTo: 'active',
                                                                                )
                                                                                .where(
                                                                                  'topic_id',
                                                                                  isEqualTo: _model.selectedTopicIDlist.elementAtOrNull((_model.countTopic!) - 1),
                                                                                ),
                                                                          );
                                                                          _model
                                                                              .updateSelectedGameListAtIndex(
                                                                            (_model.countGameList!) -
                                                                                1,
                                                                            (e) => e
                                                                              ..updateGameTieTopicIDList(
                                                                                (e) => e.add(_model.selectedTopicIDlist.elementAtOrNull((_model.countTopic!) - 1)!),
                                                                              ),
                                                                          );
                                                                          _model.roundQuestionCount =
                                                                              null;
                                                                          _model.countQuestion = _model
                                                                              .tieQuestionResult100
                                                                              ?.length;
                                                                          while (_model.countQuestion! >
                                                                              0) {
                                                                            if (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)?.selectedQuestionIDList?.contains(_model.tieQuestionResult100?.elementAtOrNull((_model.countQuestion!) - 1)?.questionID) ==
                                                                                false) {
                                                                              if (_model.selectedGameList.elementAtOrNull((_model.countGameList!) - 1)!.gameTieQuestionBreak.length <= 80) {
                                                                                _model.updateSelectedGameListAtIndex(
                                                                                  (_model.countGameList!) - 1,
                                                                                  (e) => e
                                                                                    ..updateGameTieQuestionBreak(
                                                                                      (e) => e.add(GameTieQuestionBreakStruct(
                                                                                        createdAt: getCurrentTimestamp,
                                                                                        updatedAt: getCurrentTimestamp,
                                                                                        status: 'active',
                                                                                        roundID: _model.idmapNewRound?.roundId,
                                                                                        tieQuestionID: _model.tieQuestionResult100?.elementAtOrNull((_model.countQuestion!) - 1)?.questionID,
                                                                                        tieQuestionPoint: _model.tieQuestionResult100?.elementAtOrNull((_model.countQuestion!) - 1)?.questionPoint,
                                                                                        selectedQuestionList: SelectedQuestionListStruct(
                                                                                          questionID: _model.tieQuestionResult100?.elementAtOrNull((_model.countQuestion!) - 1)?.questionID,
                                                                                          questionAnswerStatus: 'hide',
                                                                                        ),
                                                                                      )),
                                                                                    ),
                                                                                );

                                                                                await _model.idmapNewRound!.reference.update({
                                                                                  ...mapToFirestore(
                                                                                    {
                                                                                      'round_id': FieldValue.increment(1),
                                                                                    },
                                                                                  ),
                                                                                });
                                                                              } else {
                                                                                break;
                                                                              }
                                                                            }
                                                                            _model.countQuestion =
                                                                                (_model.countQuestion!) - 1;
                                                                          }
                                                                        }
                                                                        _model.countTopic =
                                                                            (_model.countTopic!) -
                                                                                1;
                                                                      }
                                                                      break;
                                                                    }
                                                                    _model.countGameList =
                                                                        (_model.countGameList!) -
                                                                            1;
                                                                  }
                                                                  _model
                                                                      .updateSelectedGameListAtIndex(
                                                                    (_model.countGameList!) -
                                                                        1,
                                                                    (e) => e
                                                                      ..updateGameTieQuestionIDList(
                                                                        (e) => e.add(_model
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                selectGameItem.selectedGameID)
                                                                            .toList()
                                                                            .firstOrNull!
                                                                            .gameTieQuestionBreak
                                                                            .firstOrNull!
                                                                            .tieQuestionID),
                                                                      )
                                                                      ..updateSelectedQuestionIDList(
                                                                        (e) => e.add(_model
                                                                            .selectedGameList
                                                                            .where((e) =>
                                                                                e.selectedGameID ==
                                                                                selectGameItem.selectedGameID)
                                                                            .toList()
                                                                            .firstOrNull!
                                                                            .gameTieQuestionBreak
                                                                            .firstOrNull!
                                                                            .tieQuestionID),
                                                                      )
                                                                      ..updateSelectedQuestionList(
                                                                        (e) => e
                                                                            .add(SelectedQuestionListStruct(
                                                                          questionID: _model
                                                                              .selectedGameList
                                                                              .where((e) => e.selectedGameID == selectGameItem.selectedGameID)
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.gameTieQuestionBreak
                                                                              ?.firstOrNull
                                                                              ?.tieQuestionID,
                                                                          questionAnswerStatus:
                                                                              'hide',
                                                                        )),
                                                                      )
                                                                      ..gameResult =
                                                                          null
                                                                      ..updateGameTieInfo(
                                                                        (e) => e
                                                                          ..createdAt =
                                                                              getCurrentTimestamp
                                                                          ..updatedAt =
                                                                              getCurrentTimestamp
                                                                          ..status =
                                                                              'active',
                                                                      )
                                                                      ..presentTeamID =
                                                                          selectGameItem
                                                                              .gameTossWinTeamId
                                                                      ..presentTeamIndex =
                                                                          selectGameItem
                                                                              .gameTosswinTeamIndex
                                                                      ..gameTieBreakStatus =
                                                                          'SetWaitStart'
                                                                      ..gameTieBreak =
                                                                          'set',
                                                                  );

                                                                  await stackRoomRecord
                                                                      .reference
                                                                      .update({
                                                                    ...createRoomRecordData(
                                                                      roomUpdatedAt:
                                                                          getCurrentTimestamp,
                                                                    ),
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
                                                                    _model.soundPlayer3 ??=
                                                                        AudioPlayer();
                                                                    if (_model
                                                                        .soundPlayer3!
                                                                        .playing) {
                                                                      await _model
                                                                          .soundPlayer3!
                                                                          .stop();
                                                                    }
                                                                    _model
                                                                        .soundPlayer3!
                                                                        .setVolume(
                                                                            0.2);
                                                                    _model
                                                                        .soundPlayer3!
                                                                        .setAsset(
                                                                            'assets/audios/Tie_Breaker_Round.mp3')
                                                                        .then((_) => _model
                                                                            .soundPlayer3!
                                                                            .play());
                                                                  }

                                                                  context
                                                                      .goNamed(
                                                                    GameOneS2Widget
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
                                                                      'tieBreakStatus':
                                                                          serializeParam(
                                                                        true,
                                                                        ParamType
                                                                            .bool,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );

                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '12rlmve9' /* Play Tie Breaker */,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  height: 50.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          0.0,
                                                                          24.0,
                                                                          0.0),
                                                                  iconAlignment:
                                                                      IconAlignment
                                                                          .end,
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
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
                                                                  elevation:
                                                                      0.0,
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
                                                            FlutterFlowIconButton(
                                                              borderColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              borderRadius: 8.0,
                                                              borderWidth: 0.5,
                                                              buttonSize: 50.0,
                                                              fillColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                              icon: Icon(
                                                                FFIcons.kfi9,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                                size: 24.0,
                                                              ),
                                                              showLoadingIndicator:
                                                                  true,
                                                              onPressed:
                                                                  () async {
                                                                _model.countGameList =
                                                                    stackRoomRecord
                                                                        .selectedGameList
                                                                        .length;
                                                                _model.selectedGameList =
                                                                    stackRoomRecord
                                                                        .selectedGameList
                                                                        .toList()
                                                                        .cast<
                                                                            SelectedGameListStruct>();
                                                                while (_model
                                                                        .countGameList! >
                                                                    0) {
                                                                  if (_model
                                                                          .selectedGameList
                                                                          .elementAtOrNull((_model.countGameList!) -
                                                                              1)
                                                                          ?.selectedGameID ==
                                                                      selectGameItem
                                                                          .selectedGameID) {
                                                                    _model.countUser = _model
                                                                        .selectedGameList
                                                                        .elementAtOrNull(
                                                                            (_model.countGameList!) -
                                                                                1)
                                                                        ?.selectedGameUserList
                                                                        ?.length;
                                                                    _model.selectedUserList = _model
                                                                        .selectedGameList
                                                                        .elementAtOrNull(
                                                                            (_model.countGameList!) -
                                                                                1)!
                                                                        .selectedGameUserList
                                                                        .toList()
                                                                        .cast<
                                                                            RoomUserListStruct>();
                                                                    _model.idmapResult =
                                                                        await queryIDmapRecordOnce(
                                                                      queryBuilder:
                                                                          (iDmapRecord) =>
                                                                              iDmapRecord.where(
                                                                        'type',
                                                                        isEqualTo:
                                                                            'Main',
                                                                      ),
                                                                      singleRecord:
                                                                          true,
                                                                    ).then((s) =>
                                                                            s.firstOrNull);
                                                                    while (_model
                                                                            .countUser! >
                                                                        0) {
                                                                      if (_model
                                                                              .selectedUserList
                                                                              .elementAtOrNull((_model.countUser!) - 1)
                                                                              ?.roomUserStatus ==
                                                                          'active') {
                                                                        await GameHistoryRecord
                                                                            .collection
                                                                            .doc()
                                                                            .set(createGameHistoryRecordData(
                                                                              createdAt: getCurrentTimestamp,
                                                                              updatedAt: getCurrentTimestamp,
                                                                              gameHistoryID: _model.idmapResult?.historyId,
                                                                              gameId: columnGameRecord?.gameID,
                                                                              userId: _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserId?.toString(),
                                                                              userRef: _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)?.roomUserRef,
                                                                              roomId: stackRoomRecord.roomID,
                                                                              resultInfo: createResultInfoStruct(
                                                                                status: 'tie',
                                                                                createdAt: getCurrentTimestamp,
                                                                                clearUnsetFields: false,
                                                                                create: true,
                                                                              ),
                                                                            ));
                                                                        unawaited(
                                                                          () async {
                                                                            await _model.selectedUserList.elementAtOrNull((_model.countUser!) - 1)!.roomUserRef!.update(createUsersRecordData(
                                                                                  presentRoomGameInfo: createPresentRoomGameInfoStruct(delete: true),
                                                                                ));
                                                                          }(),
                                                                        );

                                                                        await _model
                                                                            .idmapResult!
                                                                            .reference
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'history_id': FieldValue.increment(1),
                                                                            },
                                                                          ),
                                                                        });
                                                                      }
                                                                      _model.countUser =
                                                                          (_model.countUser!) -
                                                                              1;
                                                                    }
                                                                  }
                                                                  _model.countGameList =
                                                                      (_model.countGameList!) -
                                                                          1;
                                                                }

                                                                await stackRoomRecord
                                                                    .reference
                                                                    .update({
                                                                  ...createRoomRecordData(
                                                                    roomUpdatedAt:
                                                                        getCurrentTimestamp,
                                                                  ),
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

                                                                await currentUserReference!
                                                                    .update(
                                                                        createUsersRecordData(
                                                                  presentRoomGameInfo:
                                                                      createPresentRoomGameInfoStruct(
                                                                          delete:
                                                                              true),
                                                                ));

                                                                context.goNamed(
                                                                    HomeWidget
                                                                        .routeName);

                                                                safeSetState(
                                                                    () {});
                                                              },
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 16.0)),
                                                        ),
                                                    ].divide(
                                                        SizedBox(height: 24.0)),
                                                  ),
                                                ),
                                              ),
                                          ].divide(SizedBox(height: 16.0)),
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
