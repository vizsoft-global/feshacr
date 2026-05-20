import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'room_create_s1_model.dart';
export 'room_create_s1_model.dart';

class RoomCreateS1Widget extends StatefulWidget {
  const RoomCreateS1Widget({super.key});

  static String routeName = 'RoomCreate-S1';
  static String routePath = '/create_room_s1';

  @override
  State<RoomCreateS1Widget> createState() => _RoomCreateS1WidgetState();
}

class _RoomCreateS1WidgetState extends State<RoomCreateS1Widget> {
  late RoomCreateS1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RoomCreateS1Model());

    _model.roomnameTextController ??= TextEditingController();
    _model.roomnameFocusNode ??= FocusNode();

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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'rhrk21ho' /* Create Room */,
            ),
            style: FlutterFlowTheme.of(context).titleSmall.override(
                  font: GoogleFonts.almarai(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: Stack(
          children: [
            wrapWithModel(
              model: _model.userStatusCheckerModel,
              updateCallback: () => safeSetState(() {}),
              child: UserStatusCheckerWidget(),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Padding(
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
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primaryText,
                      width: 0.5,
                    ),
                  ),
                  child: Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                              tabletLandscape: false,
                            ))
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 75.0,
                                      height: 75.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          child: Image.asset(
                                            'assets/images/yhgsr_.png',
                                            width: 200.0,
                                            height: 200.0,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        context.pushNamed(
                                          EditProfileWidget.routeName,
                                          extra: <String, dynamic>{
                                            '__transition_info__':
                                                TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'itnly8sq' /* Change icon */,
                                      ),
                                      options: FFButtonOptions(
                                        height: 32.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Gentona Medium',
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 0.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 8.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '1ji8v0ux' /* Name  your  Room */,
                                ),
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
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
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.roomnameTextController,
                                  focusNode: _model.roomnameFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      '3n851b1h' /* eg., “Family Space” */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  maxLength: 20,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  validator: _model
                                      .roomnameTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 8.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'ij27lhi3' /* Member Limits */,
                                ),
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
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
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: FlutterFlowDropDown<String>(
                                controller:
                                    _model.memberlimitsDDValueController ??=
                                        FormFieldController<String>(
                                  _model.memberlimitsDDValue ??=
                                      FFLocalizations.of(context).getText(
                                    'wce7l26g' /* 0 to 5 Player */,
                                  ),
                                ),
                                options: [
                                  FFLocalizations.of(context).getText(
                                    '0e3e6sbg' /* 0 to 5 Player */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '5lv7nruo' /* 5 to 25 Player */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'pia1did3' /* more than 25 Player */,
                                  )
                                ],
                                onChanged: (val) => safeSetState(
                                    () => _model.memberlimitsDDValue = val),
                                width: MediaQuery.sizeOf(context).width * 1.0,
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
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                hintText: FFLocalizations.of(context).getText(
                                  'x5bwffts' /* Select... */,
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                elevation: 2.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).primary,
                                borderWidth: 0.0,
                                borderRadius: 8.0,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
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
                                    0.0, 0.0, 0.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        checkboxTheme: CheckboxThemeData(
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        unselectedWidgetColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                      ),
                                      child: Checkbox(
                                        value: _model
                                            .checkboxRoomWalletValue ??= true,
                                        onChanged: (newValue) async {
                                          safeSetState(() =>
                                              _model.checkboxRoomWalletValue =
                                                  newValue!);
                                        },
                                        side: (FlutterFlowTheme.of(context)
                                                    .alternate !=
                                                null)
                                            ? BorderSide(
                                                width: 2,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate!,
                                              )
                                            : null,
                                        activeColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        checkColor:
                                            FlutterFlowTheme.of(context).info,
                                      ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'ytmw1r7x' /* Please confirm if you are usin... */,
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
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 13.0,
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
                              ),
                            FFButtonWidget(
                              onPressed: () async {
                                if (_model.formKey.currentState == null ||
                                    !_model.formKey.currentState!.validate()) {
                                  return;
                                }
                                FFAppState().deleteUserflow();
                                FFAppState().userflow = UserflowStruct();

                                while (_model.refresh! > 0) {
                                  _model.randomNum =
                                      random_data.randomInteger(100000, 999999);
                                  _model.roomCountResult1 =
                                      await queryRoomRecordCount(
                                    queryBuilder: (roomRecord) =>
                                        roomRecord.where(
                                      'room_code',
                                      isEqualTo: _model.randomNum,
                                    ),
                                  );
                                  if (_model.roomCountResult1! > 0) {
                                    _model.randomNum = random_data
                                        .randomInteger(100000, 999999);
                                  } else {
                                    break;
                                  }
                                }
                                _model.idmapRoomResult =
                                    await queryIDmapRecordOnce(
                                  queryBuilder: (iDmapRecord) =>
                                      iDmapRecord.where(
                                    'type',
                                    isEqualTo: 'Main',
                                  ),
                                  singleRecord: true,
                                ).then((s) => s.firstOrNull);
                                _model.settingsAppLunchTimeResult =
                                    await querySettingsRecordOnce(
                                  queryBuilder: (settingsRecord) =>
                                      settingsRecord.where(
                                    'type',
                                    isEqualTo: 'Company',
                                  ),
                                  singleRecord: true,
                                ).then((s) => s.firstOrNull);

                                var roomRecordReference =
                                    RoomRecord.collection.doc();
                                await roomRecordReference.set({
                                  ...createRoomRecordData(
                                    roomStatus: 'active',
                                    roomCreatedAt: getCurrentTimestamp,
                                    roomCreatedBy: valueOrDefault(
                                            currentUserDocument?.userId, 0)
                                        .toString(),
                                    roomMemberLimit: () {
                                      if (_model.memberlimitsDDValue ==
                                          '0 to 5 Player') {
                                        return 5;
                                      } else if (_model.memberlimitsDDValue ==
                                          '5 to 25 Player') {
                                        return 25;
                                      } else {
                                        return 999;
                                      }
                                    }(),
                                    roomMainInfo: updateMainInfoStruct(
                                      MainInfoStruct(
                                        name:
                                            _model.roomnameTextController.text,
                                        mainImage:
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/nx4yo2w3wqhm/%F0%9F%8F%A0.png',
                                      ),
                                      clearUnsetFields: false,
                                      create: true,
                                    ),
                                    roomCurrentUserId: valueOrDefault(
                                        currentUserDocument?.userId, 0),
                                    roomUpdatedAt: getCurrentTimestamp,
                                    roomID: _model.idmapRoomResult?.roomId,
                                    roomCreatedByUid: currentUserUid,
                                    roomCreatedUserRef: currentUserReference,
                                    isRoomWalletStatus: true,
                                    roomWalletTotalPoint: _model
                                        .settingsAppLunchTimeResult
                                        ?.settingsNewRoomCoins,
                                    roomCode: _model.randomNum,
                                    roomPresentStatus: 'create',
                                    roomAppLaunchTime: _model
                                        .settingsAppLunchTimeResult
                                        ?.settingsCompanyInfo
                                        ?.companyAppLaunchTimeStatus,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'room_user_list': [
                                        getRoomUserListFirestoreData(
                                          updateRoomUserListStruct(
                                            RoomUserListStruct(
                                              roomUserJoinTime:
                                                  getCurrentTimestamp,
                                              roomUserId: valueOrDefault(
                                                  currentUserDocument?.userId,
                                                  0),
                                              roomUserRef: currentUserReference,
                                              roomUserStatus: 'active',
                                              roomUserUpdatedTime:
                                                  getCurrentTimestamp,
                                              roomUserOnlineStatus: 'active',
                                            ),
                                            clearUnsetFields: false,
                                            create: true,
                                          ),
                                          true,
                                        )
                                      ],
                                      'room_attended_question_list': [0],
                                    },
                                  ),
                                });
                                _model.newRoomResult =
                                    RoomRecord.getDocumentFromData({
                                  ...createRoomRecordData(
                                    roomStatus: 'active',
                                    roomCreatedAt: getCurrentTimestamp,
                                    roomCreatedBy: valueOrDefault(
                                            currentUserDocument?.userId, 0)
                                        .toString(),
                                    roomMemberLimit: () {
                                      if (_model.memberlimitsDDValue ==
                                          '0 to 5 Player') {
                                        return 5;
                                      } else if (_model.memberlimitsDDValue ==
                                          '5 to 25 Player') {
                                        return 25;
                                      } else {
                                        return 999;
                                      }
                                    }(),
                                    roomMainInfo: updateMainInfoStruct(
                                      MainInfoStruct(
                                        name:
                                            _model.roomnameTextController.text,
                                        mainImage:
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/nx4yo2w3wqhm/%F0%9F%8F%A0.png',
                                      ),
                                      clearUnsetFields: false,
                                      create: true,
                                    ),
                                    roomCurrentUserId: valueOrDefault(
                                        currentUserDocument?.userId, 0),
                                    roomUpdatedAt: getCurrentTimestamp,
                                    roomID: _model.idmapRoomResult?.roomId,
                                    roomCreatedByUid: currentUserUid,
                                    roomCreatedUserRef: currentUserReference,
                                    isRoomWalletStatus: true,
                                    roomWalletTotalPoint: _model
                                        .settingsAppLunchTimeResult
                                        ?.settingsNewRoomCoins,
                                    roomCode: _model.randomNum,
                                    roomPresentStatus: 'create',
                                    roomAppLaunchTime: _model
                                        .settingsAppLunchTimeResult
                                        ?.settingsCompanyInfo
                                        ?.companyAppLaunchTimeStatus,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'room_user_list': [
                                        getRoomUserListFirestoreData(
                                          updateRoomUserListStruct(
                                            RoomUserListStruct(
                                              roomUserJoinTime:
                                                  getCurrentTimestamp,
                                              roomUserId: valueOrDefault(
                                                  currentUserDocument?.userId,
                                                  0),
                                              roomUserRef: currentUserReference,
                                              roomUserStatus: 'active',
                                              roomUserUpdatedTime:
                                                  getCurrentTimestamp,
                                              roomUserOnlineStatus: 'active',
                                            ),
                                            clearUnsetFields: false,
                                            create: true,
                                          ),
                                          true,
                                        )
                                      ],
                                      'room_attended_question_list': [0],
                                    },
                                  ),
                                }, roomRecordReference);

                                await _model.idmapRoomResult!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'room_id': FieldValue.increment(1),
                                    },
                                  ),
                                });
                                unawaited(
                                  () async {
                                    context.goNamed(
                                      RoomCreateS2Widget.routeName,
                                      queryParameters: {
                                        'room': serializeParam(
                                          _model.newRoomResult?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  }(),
                                );

                                safeSetState(() {});
                              },
                              text: FFLocalizations.of(context).getText(
                                'd2s3mx9h' /* Create Room */,
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
