import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/app_language/app_language_widget.dart';
import '/feshah/component/empty_widget_game/empty_widget_game_widget.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah/component/navbar/navbar_widget.dart';
import '/feshah/component/sponsor/sponsor_widget.dart';
import '/feshah/payment/point_list_private_wallet/point_list_private_wallet_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/game_grid/game_grid_widget.dart';
import '/feshah_game_zone/game/game_status_checker/game_status_checker_widget.dart';
import '/feshah_game_zone/main/home_q_r/home_q_r_widget.dart';
import '/feshah_game_zone/main/home_roomlist/home_roomlist_widget.dart';
import '/feshah_game_zone/main/home_sponsor/home_sponsor_widget.dart';
import '/feshah_game_zone/main/home_widget1/home_widget1_widget.dart';
import '/feshah_game_zone/main/home_widget2/home_widget2_widget.dart';
import '/feshah_game_zone/main/home_widget2_landscape/home_widget2_landscape_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_language_selector.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/walkthroughs/home.dart';
import 'dart:ui';
import 'dart:math' as math;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (loggedIn) {
        await actions.registerFcmTokenIfMissing();
        _model.presentUserAuth =
            await UsersRecord.getDocumentOnce(FFAppState().currentUserRef!);
        if ((_model.presentUserAuth != null) == true) {
          if ((FFAppState().walkStatus == false) &&
              (_model.presentUserAuth?.isWalkthroughStatus == false)) {
            safeSetState(
                () => _model.homeController = createPageWalkthrough(context));
            _model.homeController?.show(context: context);
          }
        }
        await actions.unsetOrientation();
      }
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
        backgroundColor: Color(0xFFFDF4EF),
        body: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          child: Stack(
            children: [
              wrapWithModel(
                model: _model.appLanguageModel,
                updateCallback: () => safeSetState(() {}),
                child: AppLanguageWidget(),
              ),
              wrapWithModel(
                model: _model.userStatusCheckerModel,
                updateCallback: () => safeSetState(() {}),
                child: UserStatusCheckerWidget(),
              ),
              wrapWithModel(
                model: _model.gameStatusCheckerModel,
                updateCallback: () => safeSetState(() {}),
                updateOnChange: true,
                child: GameStatusCheckerWidget(),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    bottom: 96.0,
                  ),
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      bottom: false,
                      minimum: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 6.0,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: Material(
                          elevation: 3.0,
                          shadowColor: const Color(0x33000000),
                          borderRadius: BorderRadius.circular(10.0),
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          child: SizedBox(
                            width: 128.0,
                            height: 44.0,
                            child: FlutterFlowLanguageSelector(
                              width: 128.0,
                              height: 44.0,
                              backgroundColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              dropdownIconColor: FlutterFlowTheme.of(context)
                                  .secondaryText,
                              borderRadius: 10.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              hideFlags: true,
                              flagSize: 24.0,
                              flagTextGap: 8.0,
                              currentLanguage:
                                  FFLocalizations.of(context).languageCode,
                              languages: FFLocalizations.languages(),
                              onChanged: (lang) =>
                                  setAppLanguage(context, lang),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                          valueOrDefault<double>(
                            functions.isLandscape(
                                    MediaQuery.sizeOf(context).width,
                                    MediaQuery.sizeOf(context).height)!
                                ? 16.0
                                : 12.0,
                            12.0,
                          ),
                          16.0,
                          16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (functions.getTimeOfDay() != 'hide')
                                  Text(
                                    () {
                                      if (functions.getTimeOfDay() ==
                                          'Morning') {
                                        return FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'Good Morning,',
                                          arText: 'صباح الخير',
                                        );
                                      } else if (functions.getTimeOfDay() ==
                                          'Afternoon') {
                                        return FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'Good Afternoon,',
                                          arText: 'مساء الخير',
                                        );
                                      } else if (functions.getTimeOfDay() ==
                                          'Evening') {
                                        return FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'Good Evening,',
                                          arText: 'مساء الخير',
                                        );
                                      } else {
                                        return '';
                                      }
                                    }(),
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
                                              .primary,
                                          fontSize: 12.0,
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
                                if (loggedIn)
                                  AuthUserStreamWidget(
                                    builder: (context) => Text(
                                      currentUserDisplayName,
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
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                              ].divide(SizedBox(height: 4.0)),
                            ),
                          ),
                          if (loggedIn)
                            FutureBuilder<int>(
                              future: queryNotificationRecordCount(
                                queryBuilder: (notificationRecord) =>
                                    notificationRecord
                                        .where(
                                          'to_userRef',
                                          isEqualTo: currentUserReference,
                                        )
                                        .where(
                                          'notification_status',
                                          isEqualTo: 'send',
                                        ),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 1.0,
                                      height: 1.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                int rowCount = snapshot.data!;

                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if ((rowCount > 0) &&
                                        (loggedIn
                                            ? (currentUserDocument?.userSetting
                                                    ?.isNotificationstatus ==
                                                true)
                                            : true))
                                      AuthUserStreamWidget(
                                        builder: (context) => Wrap(
                                          spacing: 0.0,
                                          runSpacing: 0.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          direction: Axis.horizontal,
                                          runAlignment: WrapAlignment.start,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          clipBehavior: Clip.none,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  NotificationWidget.routeName,
                                                  extra: <String, dynamic>{
                                                    '__transition_info__':
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                      duration: Duration(
                                                          milliseconds: 0),
                                                    ),
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                FFIcons.kfi28,
                                                color: rowCount > 0
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primary
                                                    : Color(0x00000000),
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          if ((isWeb == false) && loggedIn)
                            wrapWithModel(
                              model: _model.homeQRModel,
                              updateCallback: () => safeSetState(() {}),
                              child: HomeQRWidget(),
                            ).addWalkthrough(
                              containerTdx40i2i,
                              _model.homeController,
                            ),
                          if (loggedIn)
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                FFAppState().updateUserflowStruct(
                                  (e) => e..paymentProcessingTime = null,
                                );
                                _model.pointResult = await queryPointRecordOnce(
                                  queryBuilder: (pointRecord) =>
                                      pointRecord.where(
                                    'point_status',
                                    isEqualTo: 'active',
                                  ),
                                );
                                if (_model.pointResult!.length > 0) {
                                  FFAppState().updateUserflowStruct(
                                    (e) => e
                                      ..updatePaymentProcessingTime(
                                        (e) => e
                                          ..presentUserRef =
                                              currentUserReference
                                          ..paymentPlanItem =
                                              OrderCartItemStruct(
                                            type: 'points',
                                            planId: _model.pointResult
                                                ?.firstOrNull?.pointID,
                                            planInfo: _model.pointResult
                                                ?.firstOrNull?.mainInfo,
                                            quantity: 1,
                                            planPrice: _model.pointResult
                                                ?.firstOrNull?.pointInfo?.price,
                                            totalPrice: _model.pointResult
                                                ?.firstOrNull?.pointInfo?.price,
                                            planPoint: _model.pointResult
                                                ?.firstOrNull?.pointInfo?.point,
                                            planRef: _model.pointResult
                                                ?.firstOrNull?.reference,
                                            planFor: 'auth',
                                          ),
                                      ),
                                  );
                                  safeSetState(() {});
                                  if (_model.walletClickStatus == false) {
                                    _model.walletClickStatus = true;
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
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child:
                                                  PointListPrivateWalletWidget(
                                                orderFor: 'auth',
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));

                                    _model.walletClickStatus = false;
                                  }
                                }

                                safeSetState(() {});
                              },
                              child: Container(
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x19EC4D41),
                                      offset: Offset(
                                        0.0,
                                        5.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 8.0, 8.0, 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 8.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/Coin-min.png',
                                            width: 24.0,
                                            height: 24.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          '${valueOrDefault<String>(
                                            valueOrDefault(
                                                    currentUserDocument
                                                        ?.walletPoint,
                                                    0)
                                                .toString(),
                                            '0',
                                          )}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Gentona Medium',
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.navigate_next_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ).addWalkthrough(
                              containerY7guhce8,
                              _model.homeController,
                            ),
                        ].divide(SizedBox(width: 12.0)),
                      ),
                    ),
                    if (!functions.isLandscape(MediaQuery.sizeOf(context).width,
                        MediaQuery.sizeOf(context).height)!)
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
                            0.0,
                            16.0,
                            20.0),
                        child: wrapWithModel(
                          model: _model.homeSponsorModel,
                          updateCallback: () => safeSetState(() {}),
                          updateOnChange: true,
                          child: HomeSponsorWidget(),
                        ),
                      ),
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
                          0.0,
                          0.0,
                          12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SvgPicture.asset(
                              'assets/images/Vector_(20).svg',
                              width: 18.0,
                              height: 18.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              '3ces6fpx' /* Available games */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ].divide(SizedBox(width: 5.0)),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              valueOrDefault<double>(
                                functions.isLandscape(
                                        MediaQuery.sizeOf(context).width,
                                        MediaQuery.sizeOf(context).height)!
                                    ? 55.0
                                    : 16.0,
                                16.0,
                              ),
                              0.0,
                              valueOrDefault<double>(
                                functions.isLandscape(
                                        MediaQuery.sizeOf(context).width,
                                        MediaQuery.sizeOf(context).height)!
                                    ? 55.0
                                    : 16.0,
                                16.0,
                              ),
                              16.0),
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
                                  child: Container(
                                    height: 240.0,
                                    child: EmptyWidgetGameWidget(),
                                  ),
                                );
                              }

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: gameListGameRecordList.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 15.0),
                                itemBuilder: (context, gameListIndex) {
                                  final gameListGameRecord =
                                      gameListGameRecordList[gameListIndex];
                                  return Container(
                                    width: 130.0,
                                    decoration: BoxDecoration(),
                                    child: GameGridWidget(
                                      key: Key(
                                          'Keyyjv_${gameListIndex}_of_${gameListGameRecordList.length}'),
                                      game: gameListGameRecord,
                                      playStatus: true,
                                    ),
                                  );
                                },
                              ).addWalkthrough(
                                rowGaqv5mr1,
                                _model.homeController,
                              );
                            },
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
                      Container(
                        height:
                            MediaQuery.sizeOf(context).width < kBreakpointMedium
                                ? 233.0
                                : 270.0,
                        child: Stack(
                          children: [
                            StreamBuilder<List<GameRecord>>(
                              stream: queryGameRecord(
                                queryBuilder: (gameRecord) => gameRecord
                                    .where(
                                      'game_status',
                                      isEqualTo: 'active',
                                    )
                                    .orderBy('game_ID', descending: true),
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
                                List<GameRecord> carouselGameRecordList =
                                    snapshot.data!;

                                return Container(
                                  width: double.infinity,
                                  height: MediaQuery.sizeOf(context).width <
                                          kBreakpointMedium
                                      ? 233.0
                                      : 270.0,
                                  child: CarouselSlider.builder(
                                    itemCount: carouselGameRecordList.length,
                                    itemBuilder: (context, carouselIndex, _) {
                                      final carouselGameRecord =
                                          carouselGameRecordList[carouselIndex];
                                      return Container(
                                        width:
                                            MediaQuery.sizeOf(context).width <
                                                    kBreakpointMedium
                                                ? 130.0
                                                : 150.0,
                                        decoration: BoxDecoration(),
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: GameGridWidget(
                                            key: Key(
                                                'Key8dr_${carouselIndex}_of_${carouselGameRecordList.length}'),
                                            playStatus: true,
                                            game: carouselGameRecord,
                                          ),
                                        ),
                                      );
                                    },
                                    carouselController:
                                        _model.carouselController ??=
                                            CarouselSliderController(),
                                    options: CarouselOptions(
                                      initialPage: max(
                                          0,
                                          min(
                                              1,
                                              carouselGameRecordList.length -
                                                  1)),
                                      viewportFraction:
                                          MediaQuery.sizeOf(context).width <
                                                  kBreakpointMedium
                                              ? 0.36
                                              : 0.2,
                                      disableCenter: true,
                                      enlargeCenterPage: false,
                                      enlargeFactor: 0.0,
                                      enableInfiniteScroll: false,
                                      scrollDirection: Axis.horizontal,
                                      autoPlay: false,
                                      onPageChanged: (index, _) async {
                                        _model.carouselCurrentIndex = index;
                                        await _model.carouselController
                                            ?.previousPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FlutterFlowIconButton(
                                  borderRadius: 100.0,
                                  buttonSize: 40.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    Icons.chevron_left_rounded,
                                    color: FlutterFlowTheme.of(context).info,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    await _model.carouselController
                                        ?.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FlutterFlowIconButton(
                                  borderRadius: 100.0,
                                  buttonSize: 40.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    Icons.navigate_next_rounded,
                                    color: FlutterFlowTheme.of(context).info,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    await _model.carouselController?.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
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
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '6cb9a76c' /* Your Rooms */,
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
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                barrierColor: Color(0x9A000000),
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return WebViewAware(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child: Container(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.5,
                                                          child:
                                                              HomeWidget2Widget(
                                                            gameID: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            },
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '3otho1ws' /* View all */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    fontSize: 14.0,
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
                                    Expanded(
                                      child: StreamBuilder<List<RoomRecord>>(
                                        stream: queryRoomRecord(
                                          queryBuilder: (roomRecord) =>
                                              roomRecord
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
                                              containerRoomRecordList =
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
                                                    .toList();
                                                if (roomList.isEmpty) {
                                                  return Center(
                                                    child:
                                                        EmptyWidgetRoomWidget(),
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: roomList.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 8.0),
                                                  itemBuilder:
                                                      (context, roomListIndex) {
                                                    final roomListItem =
                                                        roomList[roomListIndex];
                                                    return HomeRoomlistWidget(
                                                      key: Key(
                                                          'Key4qt_${roomListIndex}_of_${roomList.length}'),
                                                      room: roomListItem,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 32.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.createaRoomModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: HomeWidget1Widget(
                                            buttonbackgroundcolor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            buttonicon: Icon(
                                              FFIcons.kfi15,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                            buttontext:
                                                FFLocalizations.of(context)
                                                    .getText(
                                              '63im02ij' /* Create Room */,
                                            ),
                                            type: 'create',
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.joinaRoomModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: HomeWidget1Widget(
                                            buttonbackgroundcolor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                            buttonicon: Icon(
                                              FFIcons.kfi16,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                            buttontext:
                                                FFLocalizations.of(context)
                                                    .getText(
                                              'mdo1otzr' /* Join Room */,
                                            ),
                                            type: 'join',
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                    if (!functions.isLandscape(MediaQuery.sizeOf(context).width,
                        MediaQuery.sizeOf(context).height)!)
                      SizedBox(
                        height: math.min(
                          MediaQuery.sizeOf(context).height * 0.42,
                          520.0,
                        ),
                        child: Stack(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Frame_1216126864_(1).png',
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: math.min(
                                    MediaQuery.sizeOf(context).height * 0.4,
                                    480.0,
                                  ),
                                  fit: BoxFit.contain,
                                  alignment: Alignment(0.0, 0.0),
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
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 16.0, 24.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'ousndss8' /* Play with friends */,
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
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '0g7tj9f0' /* The fun begins when you enter ... */,
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
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              if (loggedIn) {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  barrierColor:
                                                      Color(0x9A000000),
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return WebViewAware(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child: Container(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.5,
                                                            child:
                                                                HomeWidget2Widget(
                                                              gameID: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              } else {
                                                context.goNamed(
                                                    LoginWidget.routeName);
                                              }
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              'jhs7bh2c' /* View Rooms */,
                                            ),
                                            options: FFButtonOptions(
                                              height: 34.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.almarai(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ).addWalkthrough(
                                            buttonOw6ykdi0,
                                            _model.homeController,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8.0)),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                      ),
                    if (functions.isLandscape(MediaQuery.sizeOf(context).width,
                            MediaQuery.sizeOf(context).height) ??
                        true)
                      SizedBox(
                        height: math.min(
                          MediaQuery.sizeOf(context).height * 0.55,
                          520.0,
                        ),
                        child: Stack(
                            alignment: AlignmentDirectional(1.0, 1.0),
                            children: [
                              Opacity(
                                opacity: 0.7,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 60.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/Frame_1216126864_(1).png',
                                      width: MediaQuery.sizeOf(context).width *
                                          0.4,
                                      height: math.min(
                                        MediaQuery.sizeOf(context).height *
                                            0.45,
                                        420.0,
                                      ),
                                      fit: BoxFit.contain,
                                      alignment: Alignment(1.0, 1.0),
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
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  valueOrDefault<double>(
                                                    functions.isLandscape(
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .width,
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .height)!
                                                        ? 55.0
                                                        : 16.0,
                                                    16.0,
                                                  ),
                                                  0.0,
                                                  0.0,
                                                  80.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'grelvo4l' /* Play With Friends */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.almarai(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'ql2803y1' /* The fun begins when you enter ... */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 80.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
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
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child: Container(
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.85,
                                                        child:
                                                            HomeWidget2LandscapeWidget(
                                                          gameID: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'i9mn9opd' /* View Room */,
                                          ),
                                          options: FFButtonOptions(
                                            height: 34.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 0.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 100.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ),
                            ],
                          ),
                      ),
                    if (!functions.isLandscape(MediaQuery.sizeOf(context).width,
                        MediaQuery.sizeOf(context).height)!)
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 36.0,
                        decoration: BoxDecoration(),
                      ),
                  ],
                ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.navbarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: NavbarWidget(
                    navigation: 'home',
                  ),
                ).addWalkthrough(
                  container7a7xiv8s,
                  _model.homeController,
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
                tabletLandscape: false,
                desktop: false,
              ))
                Align(
                  alignment: AlignmentDirectional(-1.0, -0.7),
                  child: Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(valueOrDefault<double>(
                          FFLocalizations.of(context).languageCode != 'en'
                              ? 16.0
                              : 0.0,
                          0.0,
                        )),
                        topRight: Radius.circular(valueOrDefault<double>(
                          FFLocalizations.of(context).languageCode == 'en'
                              ? 16.0
                              : 0.0,
                          0.0,
                        )),
                        bottomLeft: Radius.circular(valueOrDefault<double>(
                          FFLocalizations.of(context).languageCode != 'en'
                              ? 16.0
                              : 0.0,
                          0.0,
                        )),
                        bottomRight: Radius.circular(valueOrDefault<double>(
                          FFLocalizations.of(context).languageCode == 'en'
                              ? 16.0
                              : 0.0,
                          0.0,
                        )),
                      ),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 0.5,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      children: [
                        if (FFLocalizations.of(context).languageCode == 'en')
                          Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showAlignedDialog(
                                  context: context,
                                  isGlobal: false,
                                  avoidOverflow: true,
                                  targetAnchor: AlignmentDirectional(-1.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  followerAnchor: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: WebViewAware(
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.9,
                                            child: SponsorWidget(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.keyboard_double_arrow_right_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 45.0,
                              ),
                            ),
                          ),
                        if (FFLocalizations.of(context).languageCode != 'en')
                          Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showAlignedDialog(
                                  context: context,
                                  isGlobal: false,
                                  avoidOverflow: true,
                                  targetAnchor: AlignmentDirectional(-1.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  followerAnchor: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: WebViewAware(
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.9,
                                            child: SponsorWidget(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.keyboard_double_arrow_left_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 45.0,
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
      ),
    );
  }

  TutorialCoachMark createPageWalkthrough(BuildContext context) =>
      TutorialCoachMark(
        targets: createWalkthroughTargets(context),
        onFinish: () async {
          safeSetState(() => _model.homeController = null);
          if (loggedIn) {
            _model.presentUserAuthCom =
                await UsersRecord.getDocumentOnce(FFAppState().currentUserRef!);
            if ((_model.presentUserAuthCom != null) == true) {
              if (FFAppState().walkStatus == false) {
                FFAppState().walkStatus = true;

                await FFAppState().currentUserRef!.update(createUsersRecordData(
                      isWalkthroughStatus: true,
                    ));
              }
            }
          }

          safeSetState(() {});
        },
        onSkip: () {
          () async {
            if (loggedIn) {
              _model.presentUserAuthSkip = await UsersRecord.getDocumentOnce(
                  FFAppState().currentUserRef!);
              if ((_model.presentUserAuthSkip != null) == true) {
                if (FFAppState().walkStatus == false) {
                  FFAppState().walkStatus = true;

                  await FFAppState()
                      .currentUserRef!
                      .update(createUsersRecordData(
                        isWalkthroughStatus: true,
                      ));
                }
              }
            }

            safeSetState(() {});
          }();
          return true;
        },
      );
}
