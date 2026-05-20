import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/alert_information/alert_information_widget.dart';
import '/feshah/payment/coupon/coupon_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'point_list_private_wallet_model.dart';
export 'point_list_private_wallet_model.dart';

class PointListPrivateWalletWidget extends StatefulWidget {
  const PointListPrivateWalletWidget({
    super.key,
    required this.orderFor,
    this.room,
  });

  final String? orderFor;
  final RoomRecord? room;

  @override
  State<PointListPrivateWalletWidget> createState() =>
      _PointListPrivateWalletWidgetState();
}

class _PointListPrivateWalletWidgetState
    extends State<PointListPrivateWalletWidget> {
  late PointListPrivateWalletModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PointListPrivateWalletModel());

    _model.authWalletTextController ??= TextEditingController();
    _model.authWalletFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<SettingsRecord>>(
      stream: querySettingsRecord(
        queryBuilder: (settingsRecord) => settingsRecord.where(
          'type',
          isEqualTo: 'Company',
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
        List<SettingsRecord> stackSettingsRecordList = snapshot.data!;
        final stackSettingsRecord = stackSettingsRecordList.isNotEmpty
            ? stackSettingsRecordList.first
            : null;

        return Stack(
          children: [
            if (_model.myfathooraPayment == 'hide')
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                child: StreamBuilder<List<PointRecord>>(
                  stream: queryPointRecord(
                    queryBuilder: (pointRecord) => pointRecord
                        .where(
                          'point_status',
                          isEqualTo: 'active',
                        )
                        .orderBy('point_ID', descending: true),
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
                    List<PointRecord> planListPointRecordList = snapshot.data!;

                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFF9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.0),
                            topRight: Radius.circular(32.0),
                          ),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 16.0, 8.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_model.authWalletTextFiledStatus == false)
                                    Wrap(
                                      spacing: 0.0,
                                      runSpacing: 0.0,
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      direction: Axis.horizontal,
                                      runAlignment: WrapAlignment.start,
                                      verticalDirection: VerticalDirection.down,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 20.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    valueOrDefault<String>(
                                                      widget!.orderFor == 'auth'
                                                          ? FFLocalizations.of(
                                                                  context)
                                                              .getVariableText(
                                                              enText:
                                                                  'Recharge your wallet',
                                                              arText:
                                                                  'اشحن محفظتك',
                                                            )
                                                          : FFLocalizations.of(
                                                                  context)
                                                              .getVariableText(
                                                              enText:
                                                                  'Recharge your room wallet',
                                                              arText:
                                                                  'قم بشحن محفظة غرفتك',
                                                            ),
                                                      '0',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .almarai(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 4.0,
                                                                0.0, 0.0),
                                                    child: RichText(
                                                      textScaler:
                                                          MediaQuery.of(context)
                                                              .textScaler,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '0otnulfu' /* Balance:  */,
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
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
                                                                valueOrDefault<
                                                                    String>(
                                                              widget!.orderFor ==
                                                                      'auth'
                                                                  ? valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.walletPoint,
                                                                          0)
                                                                      .toString()
                                                                  : widget!.room
                                                                      ?.roomWalletTotalPoint
                                                                      ?.toString(),
                                                              '0',
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
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
                                                          TextSpan(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '00i9651g' /*  Coins */,
                                                            ),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          )
                                                        ],
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
                                                                      .primary,
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
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 145.0,
                                          decoration: BoxDecoration(),
                                          child: Builder(
                                            builder: (context) {
                                              final planList =
                                                  planListPointRecordList
                                                      .toList();

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: planList.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(width: 12.0),
                                                itemBuilder:
                                                    (context, planListIndex) {
                                                  final planListItem =
                                                      planList[planListIndex];
                                                  return Stack(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, -1.0),
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    16.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            FFAppState()
                                                                .updateUserflowStruct(
                                                              (e) => e
                                                                ..updatePaymentProcessingTime(
                                                                  (e) => e
                                                                    ..presentUserRef =
                                                                        currentUserReference
                                                                    ..paymentPlanItem =
                                                                        OrderCartItemStruct(
                                                                      type:
                                                                          'points',
                                                                      planId: planListItem
                                                                          .pointID,
                                                                      planInfo:
                                                                          planListItem
                                                                              .mainInfo,
                                                                      quantity:
                                                                          1,
                                                                      planPrice: planListItem
                                                                          .pointInfo
                                                                          .price,
                                                                      totalPrice: planListItem
                                                                          .pointInfo
                                                                          .price,
                                                                      planPoint: planListItem
                                                                          .pointInfo
                                                                          .point,
                                                                      planRef:
                                                                          planListItem
                                                                              .reference,
                                                                      planFor:
                                                                          widget!
                                                                              .orderFor,
                                                                      roomRef: widget!
                                                                          .room
                                                                          ?.reference,
                                                                    ),
                                                                ),
                                                            );
                                                            safeSetState(() {});
                                                          },
                                                          child: Container(
                                                            width: 80.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              border:
                                                                  Border.all(
                                                                color: planListItem
                                                                            .pointID ==
                                                                        FFAppState()
                                                                            .userflow
                                                                            .paymentProcessingTime
                                                                            .paymentPlanItem
                                                                            .planId
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText
                                                                    : Color(
                                                                        0xFFF8D168),
                                                                width: 0.5,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            2.0),
                                                                    child: Text(
                                                                      planListItem
                                                                          .pointInfo
                                                                          .point
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.almarai(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'xfjiq1zy' /* COINS */,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.almarai(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
                                                                            8.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0.0),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/Coins-min.png',
                                                                        width:
                                                                            32.0,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${planListItem.pointInfo.price.toString()} KD',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.almarai(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        if (stackSettingsRecord
                                                ?.settingsInappPurchaseStatus ==
                                            false)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 20.0, 0.0, 12.0),
                                            child: wrapWithModel(
                                              model: _model.couponModel,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: CouponWidget(),
                                            ),
                                          ),
                                        if (stackSettingsRecord
                                                ?.settingsCompanyInfo
                                                ?.companyPointPurchaseStatus ==
                                            true)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 16.0, 0.0, 16.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (responsiveVisibility(
                                                  context: context,
                                                  phone: false,
                                                  tablet: false,
                                                  tabletLandscape: false,
                                                  desktop: false,
                                                ))
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  4.0,
                                                                  0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () {
                                                          print(
                                                              'Makepayment pressed ...');
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'irnw52ri' /* Make payment */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 500.0,
                                                          height: 50.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconAlignment:
                                                              IconAlignment
                                                                  .start,
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Gentona Medium',
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
                                                                  ),
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
                                                                      12.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                Expanded(
                                                  child: Builder(
                                                    builder: (context) =>
                                                        Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  4.0,
                                                                  0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          var _shouldSetState =
                                                              false;
                                                          if (FFAppState()
                                                                  .userflow
                                                                  .paymentProcessingTime
                                                                  .paymentPlanItem
                                                                  .totalPrice >
                                                              0.0) {
                                                            if (_model
                                                                    .payButtonStatus ==
                                                                'continue') {
                                                              _model.payButtonStatus =
                                                                  'done';
                                                              _model.forPaymentResult1 =
                                                                  await querySettingsRecordOnce(
                                                                queryBuilder:
                                                                    (settingsRecord) =>
                                                                        settingsRecord
                                                                            .where(
                                                                  'type',
                                                                  isEqualTo:
                                                                      'Company',
                                                                ),
                                                                singleRecord:
                                                                    true,
                                                              ).then((s) => s
                                                                      .firstOrNull);
                                                              _shouldSetState =
                                                                  true;
                                                              if (_model
                                                                      .forPaymentResult1!
                                                                      .settingsPaymentInfo
                                                                      .where((e) =>
                                                                          e.isPrimaryStatus ==
                                                                          true)
                                                                      .toList()
                                                                      .length >
                                                                  0) {
                                                                _model.idMapResultOrder1 =
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
                                                                if ((_model.forPaymentResult1
                                                                            ?.settingsInappPurchaseStatus ==
                                                                        true) &&
                                                                    isiOS) {
                                                                  final isEntitled =
                                                                      await revenue_cat
                                                                              .isEntitled('coins') ??
                                                                          false;
                                                                  if (!isEntitled) {
                                                                    await revenue_cat
                                                                        .loadOfferings();
                                                                  }

                                                                  if (!isEntitled) {
                                                                    _model.didPurchased = await revenue_cat.purchasePackage(revenue_cat
                                                                        .offerings!
                                                                        .current!
                                                                        .weekly!
                                                                        .identifier);
                                                                    _shouldSetState =
                                                                        true;
                                                                    if (_model
                                                                        .didPurchased!) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .clearSnackBars();
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            FFLocalizations.of(context).getVariableText(
                                                                              enText: 'Please wait while we process..',
                                                                              arText: 'يرجى الانتظار بينما نقوم بمعالجة..',
                                                                            ),
                                                                            style:
                                                                                TextStyle(
                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                            ),
                                                                          ),
                                                                          duration:
                                                                              Duration(milliseconds: 2000),
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).success,
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            FFLocalizations.of(context).getVariableText(
                                                                              enText: 'Purchase failed. Please try again.',
                                                                              arText: 'فشلت عملية الشراء. يُرجى المحاولة مرة أخرى.',
                                                                            ),
                                                                            style:
                                                                                TextStyle(
                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                            ),
                                                                          ),
                                                                          duration:
                                                                              Duration(milliseconds: 4000),
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                        ),
                                                                      );
                                                                      if (_shouldSetState)
                                                                        safeSetState(
                                                                            () {});
                                                                      return;
                                                                    }
                                                                  }

                                                                  var orderRecordReference1 =
                                                                      OrderRecord
                                                                          .collection
                                                                          .doc();
                                                                  await orderRecordReference1
                                                                      .set(
                                                                          createOrderRecordData(
                                                                    orderStatus:
                                                                        'Initialization',
                                                                    createdAt:
                                                                        getCurrentTimestamp,
                                                                    orderID: _model
                                                                        .idMapResultOrder1
                                                                        ?.orderId,
                                                                    orderUserRef:
                                                                        currentUserReference,
                                                                    orderAmount: FFAppState()
                                                                        .userflow
                                                                        .paymentProcessingTime
                                                                        .paymentPlanItem
                                                                        .totalPrice,
                                                                    orderCartItem:
                                                                        updateOrderCartItemStruct(
                                                                      FFAppState()
                                                                          .userflow
                                                                          .paymentProcessingTime
                                                                          .paymentPlanItem,
                                                                      clearUnsetFields:
                                                                          false,
                                                                      create:
                                                                          true,
                                                                    ),
                                                                    orderUserMainInfo:
                                                                        updateOrderUserMainInfoStruct(
                                                                      OrderUserMainInfoStruct(
                                                                        userEmail:
                                                                            currentUserEmail,
                                                                        userId:
                                                                            currentUserUid,
                                                                        userName:
                                                                            currentUserDisplayName,
                                                                        userPhone:
                                                                            currentPhoneNumber,
                                                                        userRole: valueOrDefault(
                                                                            currentUserDocument?.userRole,
                                                                            ''),
                                                                      ),
                                                                      clearUnsetFields:
                                                                          false,
                                                                      create:
                                                                          true,
                                                                    ),
                                                                    updatedAt:
                                                                        getCurrentTimestamp,
                                                                    orderType:
                                                                        'private',
                                                                  ));
                                                                  _model.orderIosNew =
                                                                      OrderRecord.getDocumentFromData(
                                                                          createOrderRecordData(
                                                                            orderStatus:
                                                                                'Initialization',
                                                                            createdAt:
                                                                                getCurrentTimestamp,
                                                                            orderID:
                                                                                _model.idMapResultOrder1?.orderId,
                                                                            orderUserRef:
                                                                                currentUserReference,
                                                                            orderAmount:
                                                                                FFAppState().userflow.paymentProcessingTime.paymentPlanItem.totalPrice,
                                                                            orderCartItem:
                                                                                updateOrderCartItemStruct(
                                                                              FFAppState().userflow.paymentProcessingTime.paymentPlanItem,
                                                                              clearUnsetFields: false,
                                                                              create: true,
                                                                            ),
                                                                            orderUserMainInfo:
                                                                                updateOrderUserMainInfoStruct(
                                                                              OrderUserMainInfoStruct(
                                                                                userEmail: currentUserEmail,
                                                                                userId: currentUserUid,
                                                                                userName: currentUserDisplayName,
                                                                                userPhone: currentPhoneNumber,
                                                                                userRole: valueOrDefault(currentUserDocument?.userRole, ''),
                                                                              ),
                                                                              clearUnsetFields: false,
                                                                              create: true,
                                                                            ),
                                                                            updatedAt:
                                                                                getCurrentTimestamp,
                                                                            orderType:
                                                                                'private',
                                                                          ),
                                                                          orderRecordReference1);
                                                                  _shouldSetState =
                                                                      true;
                                                                  FFAppState()
                                                                      .updateUserflowStruct(
                                                                    (e) => e
                                                                      ..updatePaymentProcessingTime(
                                                                        (e) => e
                                                                          ..presentUserRef =
                                                                              currentUserReference
                                                                          ..paymentPlanItem = FFAppState()
                                                                              .userflow
                                                                              .paymentProcessingTime
                                                                              .paymentPlanItem
                                                                          ..orderId = _model
                                                                              .idMapResultOrder1
                                                                              ?.orderId
                                                                          ..paymentProcessesStatus =
                                                                              'initialize',
                                                                      ),
                                                                  );

                                                                  await _model
                                                                      .idMapResultOrder1!
                                                                      .reference
                                                                      .update({
                                                                    ...mapToFirestore(
                                                                      {
                                                                        'order_id':
                                                                            FieldValue.increment(1),
                                                                      },
                                                                    ),
                                                                  });

                                                                  await _model
                                                                      .orderIosNew!
                                                                      .reference
                                                                      .update(
                                                                          createOrderRecordData(
                                                                    orderStatus:
                                                                        'Capture',
                                                                    updatedAt:
                                                                        getCurrentTimestamp,
                                                                    orderPaymentInfo:
                                                                        updateOrderPaymentInfoStruct(
                                                                      OrderPaymentInfoStruct(
                                                                        orderPaymentId:
                                                                            'ios_inapp',
                                                                        orderPaymentMethod:
                                                                            'ios_inapp',
                                                                        orderPaymentType:
                                                                            'ios_inapp',
                                                                      ),
                                                                      clearUnsetFields:
                                                                          false,
                                                                    ),
                                                                  ));
                                                                  if (_model
                                                                          .orderIosNew
                                                                          ?.orderCartItem
                                                                          ?.planFor ==
                                                                      'auth') {
                                                                    _model
                                                                        .wallet = FFAppState()
                                                                            .userflow
                                                                            .paymentProcessingTime
                                                                            .paymentPlanItem
                                                                            .planPoint +
                                                                        valueOrDefault(
                                                                            currentUserDocument?.walletPoint,
                                                                            0);
                                                                  } else {
                                                                    _model.presentRoomResult =
                                                                        await RoomRecord.getDocumentOnce(widget!
                                                                            .room!
                                                                            .reference);
                                                                    _shouldSetState =
                                                                        true;
                                                                    _model
                                                                        .wallet = _model
                                                                            .presentRoomResult!
                                                                            .roomWalletTotalPoint +
                                                                        valueOrDefault(
                                                                            currentUserDocument?.walletPoint,
                                                                            0);
                                                                  }

                                                                  _model.idmapWalletCredit =
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
                                                                            .idmapWalletCredit
                                                                            ?.walletSpentId,
                                                                        walletSpentStatus:
                                                                            'Credit',
                                                                        walletSpentPoint: FFAppState()
                                                                            .userflow
                                                                            .paymentProcessingTime
                                                                            .paymentPlanItem
                                                                            .planPoint,
                                                                        walletSpentUserRef:
                                                                            currentUserReference,
                                                                        walletSpentPrevPoint: valueOrDefault(
                                                                            currentUserDocument?.walletPoint,
                                                                            0),
                                                                        walletSpentPresentPoint:
                                                                            FFAppState().userflow.paymentProcessingTime.paymentPlanItem.planPoint +
                                                                                valueOrDefault(currentUserDocument?.walletPoint, 0),
                                                                      ));
                                                                  if (_model
                                                                          .orderIosNew
                                                                          ?.orderCartItem
                                                                          ?.planFor ==
                                                                      'auth') {
                                                                    await currentUserReference!
                                                                        .update(
                                                                            createUsersRecordData(
                                                                      walletPoint:
                                                                          _model
                                                                              .wallet,
                                                                    ));
                                                                  } else {
                                                                    await widget!
                                                                        .room!
                                                                        .reference
                                                                        .update(
                                                                            createRoomRecordData(
                                                                      roomWalletTotalPoint:
                                                                          _model
                                                                              .wallet,
                                                                    ));
                                                                  }

                                                                  if (FFAppState()
                                                                          .userflow
                                                                          .paymentProcessingTime
                                                                          .paymentPlanItem
                                                                          .couponStatus ==
                                                                      true) {
                                                                    await FFAppState()
                                                                        .userflow
                                                                        .paymentProcessingTime
                                                                        .paymentPlanItem
                                                                        .couponInfo
                                                                        .couponRef!
                                                                        .update({
                                                                      ...mapToFirestore(
                                                                        {
                                                                          'coupon_member_limit':
                                                                              FieldValue.increment(-(1)),
                                                                        },
                                                                      ),
                                                                    });
                                                                  }

                                                                  await _model
                                                                      .idmapWalletCredit!
                                                                      .reference
                                                                      .update({
                                                                    ...mapToFirestore(
                                                                      {
                                                                        'wallet_spent_id':
                                                                            FieldValue.increment(1),
                                                                      },
                                                                    ),
                                                                  });

                                                                  context.goNamed(
                                                                      SuccessWidget
                                                                          .routeName);

                                                                  if (_shouldSetState)
                                                                    safeSetState(
                                                                        () {});
                                                                  return;
                                                                } else {
                                                                  if (_model
                                                                          .forPaymentResult1
                                                                          ?.settingsPaymentInfo
                                                                          ?.where((e) =>
                                                                              e.isPrimaryStatus ==
                                                                              true)
                                                                          .toList()
                                                                          ?.firstOrNull
                                                                          ?.paymentName ==
                                                                      'upayment') {
                                                                    _model.paymentUpaymentResult1 =
                                                                        await UpaymentGroup
                                                                            .chargeCall
                                                                            .call(
                                                                      url: _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.isProductionStatus ==
                                                                              true
                                                                          ? 'uapi'
                                                                          : 'sandboxapi',
                                                                      orderId: _model
                                                                          .idMapResultOrder1
                                                                          ?.orderId
                                                                          ?.toString(),
                                                                      programPrice: FFAppState()
                                                                          .userflow
                                                                          .paymentProcessingTime
                                                                          .paymentPlanItem
                                                                          .totalPrice
                                                                          .toString(),
                                                                      programRef: FFAppState()
                                                                          .userflow
                                                                          .paymentProcessingTime
                                                                          .paymentPlanItem
                                                                          .planRef
                                                                          ?.id,
                                                                      programTitle: FFAppState()
                                                                          .userflow
                                                                          .paymentProcessingTime
                                                                          .paymentPlanItem
                                                                          .planInfo
                                                                          .name,
                                                                      customerId:
                                                                          currentUserUid,
                                                                      customerName:
                                                                          currentUserDisplayName,
                                                                      customerEmail:
                                                                          currentUserEmail,
                                                                      customerPhone:
                                                                          valueOrDefault<
                                                                              String>(
                                                                        currentPhoneNumber,
                                                                        '+96598765432',
                                                                      ),
                                                                      returnURL:
                                                                          'https://appfeshah.flutterflow.app/verify?orderid=${_model.idMapResultOrder1?.orderId?.toString()}',
                                                                      cancelURL:
                                                                          'https://appfeshah.flutterflow.app/verify?orderid=${_model.idMapResultOrder1?.orderId?.toString()}',
                                                                      notificationURL:
                                                                          'https://hook.us1.make.com/p7og7qm3g9v7amn2rdx6odh24brwvypj?project=feshah&&paymenttype=upayment',
                                                                      aPIkey: _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.isProductionStatus ==
                                                                              true
                                                                          ? _model
                                                                              .forPaymentResult1
                                                                              ?.settingsPaymentInfo
                                                                              ?.where((e) =>
                                                                                  e.isPrimaryStatus ==
                                                                                  true)
                                                                              .toList()
                                                                              ?.firstOrNull
                                                                              ?.productionSecretKey
                                                                          : _model
                                                                              .forPaymentResult1
                                                                              ?.settingsPaymentInfo
                                                                              ?.where((e) => e.isPrimaryStatus == true)
                                                                              .toList()
                                                                              ?.firstOrNull
                                                                              ?.testSecretKey,
                                                                    );

                                                                    _shouldSetState =
                                                                        true;
                                                                    if ((_model
                                                                            .paymentUpaymentResult1
                                                                            ?.succeeded ??
                                                                        true)) {
                                                                      FFAppState()
                                                                          .updateUserflowStruct(
                                                                        (e) => e
                                                                          ..updatePaymentProcessingTime(
                                                                            (e) => e
                                                                              ..presentUserRef = currentUserReference
                                                                              ..paymentPlanItem = FFAppState().userflow.paymentProcessingTime.paymentPlanItem
                                                                              ..orderId = _model.idMapResultOrder1?.orderId
                                                                              ..paymentProcessesStatus = 'initialize'
                                                                              ..paymentBaseUrl = _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.isProductionStatus == true ? 'uapi' : 'sandboxapi'
                                                                              ..mainPaymentUrl = UpaymentGroup.chargeCall
                                                                                  .chargeLink(
                                                                                    (_model.paymentUpaymentResult1?.jsonBody ?? ''),
                                                                                  )
                                                                                  .toString()
                                                                              ..paymentUrl = UpaymentGroup.chargeCall
                                                                                  .chargeLink(
                                                                                    (_model.paymentUpaymentResult1?.jsonBody ?? ''),
                                                                                  )
                                                                                  .toString()
                                                                              ..paymentType = _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.paymentName
                                                                              ..secretKey = _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.isProductionStatus == true ? _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.productionSecretKey : _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.testSecretKey,
                                                                          ),
                                                                      );

                                                                      var orderRecordReference2 = OrderRecord
                                                                          .collection
                                                                          .doc();
                                                                      await orderRecordReference2
                                                                          .set(
                                                                              createOrderRecordData(
                                                                        orderStatus:
                                                                            'Initialization',
                                                                        createdAt:
                                                                            getCurrentTimestamp,
                                                                        orderID: _model
                                                                            .idMapResultOrder1
                                                                            ?.orderId,
                                                                        orderUserRef:
                                                                            currentUserReference,
                                                                        orderAmount: FFAppState()
                                                                            .userflow
                                                                            .paymentProcessingTime
                                                                            .paymentPlanItem
                                                                            .totalPrice,
                                                                        orderCartItem:
                                                                            updateOrderCartItemStruct(
                                                                          FFAppState()
                                                                              .userflow
                                                                              .paymentProcessingTime
                                                                              .paymentPlanItem,
                                                                          clearUnsetFields:
                                                                              false,
                                                                          create:
                                                                              true,
                                                                        ),
                                                                        orderUserMainInfo:
                                                                            updateOrderUserMainInfoStruct(
                                                                          OrderUserMainInfoStruct(
                                                                            userEmail:
                                                                                currentUserEmail,
                                                                            userId:
                                                                                currentUserUid,
                                                                            userName:
                                                                                currentUserDisplayName,
                                                                            userPhone:
                                                                                currentPhoneNumber,
                                                                            userRole:
                                                                                valueOrDefault(currentUserDocument?.userRole, ''),
                                                                          ),
                                                                          clearUnsetFields:
                                                                              false,
                                                                          create:
                                                                              true,
                                                                        ),
                                                                        updatedAt:
                                                                            getCurrentTimestamp,
                                                                        orderType:
                                                                            'private',
                                                                      ));
                                                                      _model.orderUpaymentNew = OrderRecord.getDocumentFromData(
                                                                          createOrderRecordData(
                                                                            orderStatus:
                                                                                'Initialization',
                                                                            createdAt:
                                                                                getCurrentTimestamp,
                                                                            orderID:
                                                                                _model.idMapResultOrder1?.orderId,
                                                                            orderUserRef:
                                                                                currentUserReference,
                                                                            orderAmount:
                                                                                FFAppState().userflow.paymentProcessingTime.paymentPlanItem.totalPrice,
                                                                            orderCartItem:
                                                                                updateOrderCartItemStruct(
                                                                              FFAppState().userflow.paymentProcessingTime.paymentPlanItem,
                                                                              clearUnsetFields: false,
                                                                              create: true,
                                                                            ),
                                                                            orderUserMainInfo:
                                                                                updateOrderUserMainInfoStruct(
                                                                              OrderUserMainInfoStruct(
                                                                                userEmail: currentUserEmail,
                                                                                userId: currentUserUid,
                                                                                userName: currentUserDisplayName,
                                                                                userPhone: currentPhoneNumber,
                                                                                userRole: valueOrDefault(currentUserDocument?.userRole, ''),
                                                                              ),
                                                                              clearUnsetFields: false,
                                                                              create: true,
                                                                            ),
                                                                            updatedAt:
                                                                                getCurrentTimestamp,
                                                                            orderType:
                                                                                'private',
                                                                          ),
                                                                          orderRecordReference2);
                                                                      _shouldSetState =
                                                                          true;

                                                                      await _model
                                                                          .idMapResultOrder1!
                                                                          .reference
                                                                          .update({
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'order_id':
                                                                                FieldValue.increment(1),
                                                                          },
                                                                        ),
                                                                      });
                                                                      unawaited(
                                                                        () async {
                                                                          Navigator.pop(
                                                                              context);
                                                                        }(),
                                                                      );

                                                                      context.goNamed(
                                                                          PaymentWidget
                                                                              .routeName);
                                                                    } else {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return WebViewAware(
                                                                            child:
                                                                                AlertDialog(
                                                                              content: Text(FFLocalizations.of(context).getVariableText(
                                                                                enText: 'Upayment server is busy. Please try again.',
                                                                                arText: 'خادم Upayment مشغول. يُرجى المحاولة مرة أخرى.',
                                                                              )),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: Text(FFLocalizations.of(context).getVariableText(
                                                                                    enText: 'Ok',
                                                                                    arText: 'تمام',
                                                                                  )),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    }
                                                                  } else {
                                                                    if (_model
                                                                            .forPaymentResult1
                                                                            ?.settingsPaymentInfo
                                                                            ?.where((e) =>
                                                                                e.isPrimaryStatus ==
                                                                                true)
                                                                            .toList()
                                                                            ?.firstOrNull
                                                                            ?.paymentName ==
                                                                        'tap') {
                                                                      _model.tapPaymentResult1 = await TapGroup
                                                                          .chargeAPICall
                                                                          .call(
                                                                        amount: FFAppState()
                                                                            .userflow
                                                                            .paymentProcessingTime
                                                                            .paymentPlanItem
                                                                            .totalPrice,
                                                                        productList: FFAppState()
                                                                            .userflow
                                                                            .paymentProcessingTime
                                                                            .paymentPlanItem
                                                                            .planInfo
                                                                            .name,
                                                                        clientname:
                                                                            currentUserDisplayName,
                                                                        orderID: _model
                                                                            .idMapResultOrder1
                                                                            ?.orderId
                                                                            ?.toString(),
                                                                        clientemail:
                                                                            currentUserEmail,
                                                                        clientphone:
                                                                            valueOrDefault<String>(
                                                                          currentPhoneNumber,
                                                                          '+9659876543',
                                                                        ),
                                                                        merchantid: _model
                                                                            .forPaymentResult1
                                                                            ?.settingsPaymentInfo
                                                                            ?.where((e) =>
                                                                                e.isPrimaryStatus ==
                                                                                true)
                                                                            .toList()
                                                                            ?.firstOrNull
                                                                            ?.merchentId,
                                                                        secreatKey: _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.isProductionStatus ==
                                                                                true
                                                                            ? _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.productionSecretKey
                                                                            : _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.testSecretKey,
                                                                        postURL:
                                                                            'https://hook.us1.make.com/p7og7qm3g9v7amn2rdx6odh24brwvypj?project=feshah&&paymenttype=tap',
                                                                        redirectURL:
                                                                            'https://appfeshah.flutterflow.app/verify?orderid=${_model.idMapResultOrder1?.orderId?.toString()}',
                                                                        url: isWeb
                                                                            ? 'https://proxy.vizsoft.in/https://api.tap.company/'
                                                                            : 'https://api.tap.company/',
                                                                      );

                                                                      _shouldSetState =
                                                                          true;
                                                                      if ((_model
                                                                              .tapPaymentResult1
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        FFAppState()
                                                                            .updateUserflowStruct(
                                                                          (e) => e
                                                                            ..updatePaymentProcessingTime(
                                                                              (e) => e
                                                                                ..presentUserRef = currentUserReference
                                                                                ..paymentPlanItem = FFAppState().userflow.paymentProcessingTime.paymentPlanItem
                                                                                ..orderId = _model.idMapResultOrder1?.orderId
                                                                                ..paymentProcessesStatus = 'initialize'
                                                                                ..paymentBaseUrl = isWeb ? 'https://proxy.vizsoft.in/https://api.tap.company/' : 'https://api.tap.company/'
                                                                                ..mainPaymentUrl = TapGroup.chargeAPICall
                                                                                    .chargeUrl(
                                                                                      (_model.tapPaymentResult1?.jsonBody ?? ''),
                                                                                    )
                                                                                    .toString()
                                                                                ..paymentUrl = TapGroup.chargeAPICall
                                                                                    .chargeUrl(
                                                                                      (_model.tapPaymentResult1?.jsonBody ?? ''),
                                                                                    )
                                                                                    .toString()
                                                                                ..paymentType = _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.paymentName
                                                                                ..secretKey = _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.isProductionStatus == true ? _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.productionSecretKey : _model.forPaymentResult1?.settingsPaymentInfo?.where((e) => e.isPrimaryStatus == true).toList()?.firstOrNull?.testSecretKey
                                                                                ..paymentId = TapGroup.chargeAPICall
                                                                                    .chargeId(
                                                                                      (_model.tapPaymentResult1?.jsonBody ?? ''),
                                                                                    )
                                                                                    .toString(),
                                                                            ),
                                                                        );

                                                                        var orderRecordReference3 = OrderRecord
                                                                            .collection
                                                                            .doc();
                                                                        await orderRecordReference3
                                                                            .set(createOrderRecordData(
                                                                          orderStatus:
                                                                              'Initialization',
                                                                          createdAt:
                                                                              getCurrentTimestamp,
                                                                          orderID: _model
                                                                              .idMapResultOrder1
                                                                              ?.orderId,
                                                                          orderUserRef:
                                                                              currentUserReference,
                                                                          orderAmount: FFAppState()
                                                                              .userflow
                                                                              .paymentProcessingTime
                                                                              .paymentPlanItem
                                                                              .totalPrice,
                                                                          orderCartItem:
                                                                              updateOrderCartItemStruct(
                                                                            FFAppState().userflow.paymentProcessingTime.paymentPlanItem,
                                                                            clearUnsetFields:
                                                                                false,
                                                                            create:
                                                                                true,
                                                                          ),
                                                                          orderUserMainInfo:
                                                                              updateOrderUserMainInfoStruct(
                                                                            OrderUserMainInfoStruct(
                                                                              userEmail: currentUserEmail,
                                                                              userId: currentUserUid,
                                                                              userName: currentUserDisplayName,
                                                                              userPhone: currentPhoneNumber,
                                                                              userRole: valueOrDefault(currentUserDocument?.userRole, ''),
                                                                            ),
                                                                            clearUnsetFields:
                                                                                false,
                                                                            create:
                                                                                true,
                                                                          ),
                                                                          updatedAt:
                                                                              getCurrentTimestamp,
                                                                          orderType:
                                                                              'private',
                                                                        ));
                                                                        _model.orderTappaymentNew = OrderRecord.getDocumentFromData(
                                                                            createOrderRecordData(
                                                                              orderStatus: 'Initialization',
                                                                              createdAt: getCurrentTimestamp,
                                                                              orderID: _model.idMapResultOrder1?.orderId,
                                                                              orderUserRef: currentUserReference,
                                                                              orderAmount: FFAppState().userflow.paymentProcessingTime.paymentPlanItem.totalPrice,
                                                                              orderCartItem: updateOrderCartItemStruct(
                                                                                FFAppState().userflow.paymentProcessingTime.paymentPlanItem,
                                                                                clearUnsetFields: false,
                                                                                create: true,
                                                                              ),
                                                                              orderUserMainInfo: updateOrderUserMainInfoStruct(
                                                                                OrderUserMainInfoStruct(
                                                                                  userEmail: currentUserEmail,
                                                                                  userId: currentUserUid,
                                                                                  userName: currentUserDisplayName,
                                                                                  userPhone: currentPhoneNumber,
                                                                                  userRole: valueOrDefault(currentUserDocument?.userRole, ''),
                                                                                ),
                                                                                clearUnsetFields: false,
                                                                                create: true,
                                                                              ),
                                                                              updatedAt: getCurrentTimestamp,
                                                                              orderType: 'private',
                                                                            ),
                                                                            orderRecordReference3);
                                                                        _shouldSetState =
                                                                            true;

                                                                        await _model
                                                                            .idMapResultOrder1!
                                                                            .reference
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'order_id': FieldValue.increment(1),
                                                                            },
                                                                          ),
                                                                        });
                                                                        unawaited(
                                                                          () async {
                                                                            Navigator.pop(context);
                                                                          }(),
                                                                        );

                                                                        context.goNamed(
                                                                            PaymentWidget.routeName);
                                                                      } else {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'TAP payment server is busy. Please try again.',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                          ),
                                                                        );
                                                                        if (_shouldSetState)
                                                                          safeSetState(
                                                                              () {});
                                                                        return;
                                                                      }
                                                                    } else {
                                                                      if (_model
                                                                              .forPaymentResult1
                                                                              ?.settingsPaymentInfo
                                                                              ?.where((e) => e.isPrimaryStatus == true)
                                                                              .toList()
                                                                              ?.firstOrNull
                                                                              ?.paymentName ==
                                                                          'myfatoorah') {
                                                                        _model.myfathooraPayment =
                                                                            'show';
                                                                        safeSetState(
                                                                            () {});
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              } else {
                                                                await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (dialogContext) {
                                                                    return Dialog(
                                                                      elevation:
                                                                          0,
                                                                      insetPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0)
                                                                          .resolve(
                                                                              Directionality.of(context)),
                                                                      child:
                                                                          WebViewAware(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              500.0,
                                                                          child:
                                                                              AlertInformationWidget(
                                                                            title:
                                                                                FFLocalizations.of(context).getText(
                                                                              'jk915l9c' /* There are no payment methods d... */,
                                                                            ),
                                                                          ),
                                                                        ),
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
                                                                          'Please select coin plan.',
                                                                      arText:
                                                                          'الرجاء تحديد خطة العملة.',
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
                                                                              'تمام',
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

                                                          if (_shouldSetState)
                                                            safeSetState(() {});
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'rn7zw8vv' /* Direct pay */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 500.0,
                                                          height: 50.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconAlignment:
                                                              IconAlignment
                                                                  .start,
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Gentona Medium',
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
                                                                  ),
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
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () {
                                                          print(
                                                              'Splitpay pressed ...');
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          '52mvtgq1' /* Split pay */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 500.0,
                                                          height: 50.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
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
                                                              .secondary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Gentona Medium',
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
                                                                  ),
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
                                                                      12.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  if ((valueOrDefault(
                                              currentUserDocument?.walletPoint,
                                              0) >=
                                          10) &&
                                      (widget!.orderFor == 'room'))
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
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
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
                                                                '8s4zkbk2' /* Your Wallet Balance */,
                                                              ),
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
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Coin-min.png',
                                                                    width: 22.0,
                                                                    height:
                                                                        22.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    '${valueOrDefault(currentUserDocument?.walletPoint, 0).toString()}${FFLocalizations.of(context).getVariableText(
                                                                      enText:
                                                                          ' Coins',
                                                                      arText:
                                                                          ' عملات معدنية',
                                                                    )}',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.almarai(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 8.0)),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 8.0)),
                                                        ),
                                                      ),
                                                      if (_model
                                                              .authWalletTextFiledStatus ==
                                                          false)
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            if (valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.walletPoint,
                                                                    0) >=
                                                                10) {
                                                              _model.authWalletTextFiledStatus =
                                                                  true;
                                                              safeSetState(
                                                                  () {});
                                                            }
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            '8wyk7kv0' /* Transfer To Room Wallet */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            height: 34.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
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
                                                                .secondary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
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
                                                                          .primaryBackground,
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
                                                  ),
                                                  if (_model
                                                          .authWalletTextFiledStatus ==
                                                      true)
                                                    TextFormField(
                                                      controller: _model
                                                          .authWalletTextController,
                                                      focusNode: _model
                                                          .authWalletFocusNode,
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
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintText:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'k5fg5ww7' /* Enter value */,
                                                        ),
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .almarai(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
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
                                                      maxLength: 8,
                                                      maxLengthEnforcement:
                                                          MaxLengthEnforcement
                                                              .enforced,
                                                      buildCounter: (context,
                                                              {required currentLength,
                                                              required isFocused,
                                                              maxLength}) =>
                                                          null,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: _model
                                                          .authWalletTextControllerValidator
                                                          .asValidator(context),
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(
                                                                RegExp('[0-9]'))
                                                      ],
                                                    ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ),
                                          if (_model
                                                  .authWalletTextFiledStatus ==
                                              true)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 16.0, 0.0, 16.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  4.0,
                                                                  0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          if ((valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.walletPoint,
                                                                      0) >=
                                                                  10) &&
                                                              (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.walletPoint,
                                                                      0) >=
                                                                  (int.parse(_model
                                                                      .authWalletTextController
                                                                      .text))) &&
                                                              ((int.parse(_model
                                                                      .authWalletTextController
                                                                      .text)) >
                                                                  0)) {
                                                            _model
                                                                .wallet = valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.walletPoint,
                                                                    0) -
                                                                int.parse(_model
                                                                    .authWalletTextController
                                                                    .text);
                                                            _model
                                                                .spent = valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.walletSpent,
                                                                    0) +
                                                                int.parse(_model
                                                                    .authWalletTextController
                                                                    .text);

                                                            await currentUserReference!
                                                                .update(
                                                                    createUsersRecordData(
                                                              walletPoint:
                                                                  _model.wallet,
                                                              walletSpent:
                                                                  _model.spent,
                                                            ));

                                                            await widget!
                                                                .room!.reference
                                                                .update(
                                                                    createRoomRecordData(
                                                              roomWalletTotalPoint: widget!
                                                                      .room!
                                                                      .roomWalletTotalPoint +
                                                                  int.parse(_model
                                                                      .authWalletTextController
                                                                      .text),
                                                              roomAppLaunchTime:
                                                                  false,
                                                            ));
                                                            unawaited(
                                                              () async {
                                                                Navigator.pop(
                                                                    context);
                                                              }(),
                                                            );
                                                          }
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'g446ciav' /* Transfer */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 500.0,
                                                          height: 50.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconAlignment:
                                                              IconAlignment
                                                                  .start,
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Gentona Medium',
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
                                                                  ),
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (_model.myfathooraPayment == 'show')
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      color: Color(0x3B1D2429),
                      offset: Offset(
                        0.0,
                        -3.0,
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, -1.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'iyno7awt' /* How do you pay */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderRadius: 100.0,
                              buttonSize: 36.0,
                              fillColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              icon: Icon(
                                Icons.close,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 20.0,
                              ),
                              onPressed: () async {
                                unawaited(
                                  () async {
                                    Navigator.pop(context);
                                  }(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 16.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.myfathooraID = 1;
                            _model.myfathooraMethod = 'KNET';
                            safeSetState(() {});
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration: BoxDecoration(
                              color: _model.myfathooraMethod == 'KNET'
                                  ? FlutterFlowTheme.of(context).primary
                                  : Color(0x9567B5B0),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).tertiary,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'bm3lc40g' /* Pay with K-Net */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.almarai(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: _model.myfathooraMethod ==
                                                    'KNET'
                                                ? FlutterFlowTheme.of(context)
                                                    .info
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: Image.asset(
                                      'assets/images/Group_(6).png',
                                      width: 50.0,
                                      height: 30.0,
                                      fit: BoxFit.contain,
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(width: 8.0))
                                    .addToStart(SizedBox(width: 8.0))
                                    .addToEnd(SizedBox(width: 8.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 16.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.myfathooraID = 2;
                            _model.myfathooraMethod = 'VISA/MASTER';
                            safeSetState(() {});
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration: BoxDecoration(
                              color: _model.myfathooraMethod == 'VISA/MASTER'
                                  ? FlutterFlowTheme.of(context).primary
                                  : Color(0x9567B5B0),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'h28qy0m4' /* Pay with Card */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.almarai(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: _model.myfathooraMethod ==
                                                    'VISA/MASTER'
                                                ? FlutterFlowTheme.of(context)
                                                    .info
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: Image.asset(
                                      'assets/images/Frame_2085662491.png',
                                      width: 80.0,
                                      height: 30.0,
                                      fit: BoxFit.contain,
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(width: 8.0))
                                    .addToStart(SizedBox(width: 8.0))
                                    .addToEnd(SizedBox(width: 8.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 16.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.myfathooraID = 3;
                              _model.myfathooraMethod = 'Google Pay';
                              safeSetState(() {});
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: _model.myfathooraMethod == 'Google Pay'
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0x9567B5B0),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '71prieuz' /* Pay with G-Pay */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.almarai(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: _model.myfathooraMethod ==
                                                      'Google Pay'
                                                  ? FlutterFlowTheme.of(context)
                                                      .info
                                                  : FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: Image.asset(
                                        'assets/images/Google_Pay_Logo_1.png',
                                        width: 50.0,
                                        height: 30.0,
                                        fit: BoxFit.contain,
                                        alignment: Alignment(0.0, 0.0),
                                      ),
                                    ),
                                  ]
                                      .divide(SizedBox(width: 8.0))
                                      .addToStart(SizedBox(width: 8.0))
                                      .addToEnd(SizedBox(width: 8.0)),
                                ),
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 16.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.myfathooraID = 4;
                              _model.myfathooraMethod = 'Apple Pay';
                              safeSetState(() {});
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: _model.myfathooraMethod == 'Apple Pay'
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0x9567B5B0),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '1mzzwdv3' /* Pay with Apple Pay */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.almarai(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: _model.myfathooraMethod ==
                                                      'Apple Pay'
                                                  ? FlutterFlowTheme.of(context)
                                                      .info
                                                  : FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: Image.asset(
                                        'assets/images/Apple_Pay_logo.png',
                                        width: 50.0,
                                        height: 30.0,
                                        fit: BoxFit.contain,
                                        alignment: Alignment(0.0, 0.0),
                                      ),
                                    ),
                                  ]
                                      .divide(SizedBox(width: 8.0))
                                      .addToStart(SizedBox(width: 8.0))
                                      .addToEnd(SizedBox(width: 8.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 16.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var _shouldSetState = false;
                            _model.myfatoorahPaymentResult1 =
                                await MyfatoorahGroup.executeCall.call(
                              token: _model.forPaymentResult1
                                          ?.settingsPaymentInfo
                                          ?.where(
                                              (e) => e.isPrimaryStatus == true)
                                          .toList()
                                          ?.firstOrNull
                                          ?.isProductionStatus ==
                                      true
                                  ? _model
                                      .forPaymentResult1?.settingsPaymentInfo
                                      ?.where((e) => e.isPrimaryStatus == true)
                                      .toList()
                                      ?.firstOrNull
                                      ?.productionSecretKey
                                  : _model
                                      .forPaymentResult1?.settingsPaymentInfo
                                      ?.where((e) => e.isPrimaryStatus == true)
                                      .toList()
                                      ?.firstOrNull
                                      ?.testSecretKey,
                              customerName: currentUserDisplayName,
                              customerDailCode: '965',
                              customerPhone: valueOrDefault<String>(
                                currentPhoneNumber,
                                '9659876543',
                              ),
                              customerEmail: currentUserEmail,
                              programPrice: FFAppState()
                                  .userflow
                                  .paymentProcessingTime
                                  .paymentPlanItem
                                  .totalPrice,
                              orderId:
                                  _model.idMapResultOrder1?.orderId?.toString(),
                              cartInfo: FFAppState()
                                  .userflow
                                  .paymentProcessingTime
                                  .paymentPlanItem
                                  .planInfo
                                  .name,
                              url: _model.forPaymentResult1?.settingsPaymentInfo
                                          ?.where(
                                              (e) => e.isPrimaryStatus == true)
                                          .toList()
                                          ?.firstOrNull
                                          ?.isProductionStatus ==
                                      true
                                  ? 'api'
                                  : 'apitest',
                              paymentMethodID: _model.myfathooraID?.toString(),
                              returnURL:
                                  'https://appfeshah.flutterflow.app/verify',
                              webhookUrl: _model.forPaymentResult1
                                          ?.settingsPaymentInfo
                                          ?.where(
                                              (e) => e.isPrimaryStatus == true)
                                          .toList()
                                          ?.firstOrNull
                                          ?.isProductionStatus ==
                                      true
                                  ? 'https://hook.us1.make.com/p7og7qm3g9v7amn2rdx6odh24brwvypj?project=feshah&&paymenttype=myfatoorah&&paytype=live'
                                  : 'https://hook.us1.make.com/p7og7qm3g9v7amn2rdx6odh24brwvypj?project=feshah&&paymenttype=myfatoorah&&paytype=test',
                            );

                            _shouldSetState = true;
                            if ((_model.myfatoorahPaymentResult1?.succeeded ??
                                true)) {
                              FFAppState().updateUserflowStruct(
                                (e) => e
                                  ..updatePaymentProcessingTime(
                                    (e) => e
                                      ..presentUserRef = currentUserReference
                                      ..paymentPlanItem = FFAppState()
                                          .userflow
                                          .paymentProcessingTime
                                          .paymentPlanItem
                                      ..orderId =
                                          _model.idMapResultOrder1?.orderId
                                      ..paymentProcessesStatus = 'initialize'
                                      ..paymentBaseUrl = _model
                                                  .forPaymentResult1
                                                  ?.settingsPaymentInfo
                                                  ?.where((e) =>
                                                      e.isPrimaryStatus == true)
                                                  .toList()
                                                  ?.firstOrNull
                                                  ?.isProductionStatus ==
                                              true
                                          ? 'api'
                                          : 'apitest'
                                      ..mainPaymentUrl = MyfatoorahGroup
                                          .executeCall
                                          .paymentURL(
                                        (_model.myfatoorahPaymentResult1
                                                ?.jsonBody ??
                                            ''),
                                      )
                                      ..paymentUrl = MyfatoorahGroup.executeCall
                                          .paymentURL(
                                        (_model.myfatoorahPaymentResult1
                                                ?.jsonBody ??
                                            ''),
                                      )
                                      ..paymentType = _model.forPaymentResult1
                                          ?.settingsPaymentInfo
                                          ?.where(
                                              (e) => e.isPrimaryStatus == true)
                                          .toList()
                                          ?.firstOrNull
                                          ?.paymentName
                                      ..secretKey = _model.forPaymentResult1
                                                  ?.settingsPaymentInfo
                                                  ?.where((e) =>
                                                      e.isPrimaryStatus == true)
                                                  .toList()
                                                  ?.firstOrNull
                                                  ?.isProductionStatus ==
                                              true
                                          ? _model.forPaymentResult1
                                              ?.settingsPaymentInfo
                                              ?.where((e) =>
                                                  e.isPrimaryStatus == true)
                                              .toList()
                                              ?.firstOrNull
                                              ?.productionSecretKey
                                          : _model.forPaymentResult1
                                              ?.settingsPaymentInfo
                                              ?.where((e) =>
                                                  e.isPrimaryStatus == true)
                                              .toList()
                                              ?.firstOrNull
                                              ?.testSecretKey
                                      ..paymentId = MyfatoorahGroup.executeCall
                                          .invoiceID(
                                            (_model.myfatoorahPaymentResult1
                                                    ?.jsonBody ??
                                                ''),
                                          )
                                          ?.toString(),
                                  ),
                              );

                              var orderRecordReference =
                                  OrderRecord.collection.doc();
                              await orderRecordReference
                                  .set(createOrderRecordData(
                                orderStatus: 'Initialization',
                                createdAt: getCurrentTimestamp,
                                orderID: _model.idMapResultOrder1?.orderId,
                                orderUserRef: currentUserReference,
                                orderAmount: FFAppState()
                                    .userflow
                                    .paymentProcessingTime
                                    .paymentPlanItem
                                    .totalPrice,
                                orderCartItem: updateOrderCartItemStruct(
                                  FFAppState()
                                      .userflow
                                      .paymentProcessingTime
                                      .paymentPlanItem,
                                  clearUnsetFields: false,
                                  create: true,
                                ),
                                orderUserMainInfo:
                                    updateOrderUserMainInfoStruct(
                                  OrderUserMainInfoStruct(
                                    userEmail: currentUserEmail,
                                    userId: currentUserUid,
                                    userName: currentUserDisplayName,
                                    userPhone: currentPhoneNumber,
                                    userRole: valueOrDefault(
                                        currentUserDocument?.userRole, ''),
                                  ),
                                  clearUnsetFields: false,
                                  create: true,
                                ),
                                updatedAt: getCurrentTimestamp,
                                orderType: 'private',
                              ));
                              _model.orderMyfatoorahpaymentNew =
                                  OrderRecord.getDocumentFromData(
                                      createOrderRecordData(
                                        orderStatus: 'Initialization',
                                        createdAt: getCurrentTimestamp,
                                        orderID:
                                            _model.idMapResultOrder1?.orderId,
                                        orderUserRef: currentUserReference,
                                        orderAmount: FFAppState()
                                            .userflow
                                            .paymentProcessingTime
                                            .paymentPlanItem
                                            .totalPrice,
                                        orderCartItem:
                                            updateOrderCartItemStruct(
                                          FFAppState()
                                              .userflow
                                              .paymentProcessingTime
                                              .paymentPlanItem,
                                          clearUnsetFields: false,
                                          create: true,
                                        ),
                                        orderUserMainInfo:
                                            updateOrderUserMainInfoStruct(
                                          OrderUserMainInfoStruct(
                                            userEmail: currentUserEmail,
                                            userId: currentUserUid,
                                            userName: currentUserDisplayName,
                                            userPhone: currentPhoneNumber,
                                            userRole: valueOrDefault(
                                                currentUserDocument?.userRole,
                                                ''),
                                          ),
                                          clearUnsetFields: false,
                                          create: true,
                                        ),
                                        updatedAt: getCurrentTimestamp,
                                        orderType: 'private',
                                      ),
                                      orderRecordReference);
                              _shouldSetState = true;

                              await _model.idMapResultOrder1!.reference.update({
                                ...mapToFirestore(
                                  {
                                    'order_id': FieldValue.increment(1),
                                  },
                                ),
                              });
                              unawaited(
                                () async {
                                  Navigator.pop(context);
                                }(),
                              );

                              context.goNamed(PaymentWidget.routeName);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'MyFatoorah payment server is busy. Please try again.',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }

                            if (_shouldSetState) safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'u6yi98qd' /* Proceed to Pay */,
                          ),
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 48.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).tertiary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.almarai(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).info,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ]
                        .addToStart(SizedBox(height: 16.0))
                        .addToEnd(SizedBox(height: 16.0)),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
