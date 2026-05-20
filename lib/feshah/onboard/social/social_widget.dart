import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'social_model.dart';
export 'social_model.dart';

class SocialWidget extends StatefulWidget {
  const SocialWidget({super.key});

  @override
  State<SocialWidget> createState() => _SocialWidgetState();
}

class _SocialWidgetState extends State<SocialWidget> {
  late SocialModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SocialModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  _model.googleStatus = 'show';
                  GoRouter.of(context).prepareAuthEvent();
                  final user = await authManager.signInWithGoogle(context);
                  if (user == null) {
                    return;
                  }
                  await actions.registerFcmTokenIfMissing();
                  _model.settingsAppLunchTimeGresult =
                      await querySettingsRecordOnce(
                    queryBuilder: (settingsRecord) => settingsRecord.where(
                      'type',
                      isEqualTo: 'Company',
                    ),
                    singleRecord: true,
                  ).then((s) => s.firstOrNull);
                  FFAppState().currentUserRef = currentUserReference;
                  if (valueOrDefault<bool>(
                          currentUserDocument?.isWalkthroughStatus, false) ==
                      false) {
                    FFAppState().walkStatus = false;
                  }
                  if (valueOrDefault(currentUserDocument?.status, '') == '') {
                    while (_model.refresh != 0) {
                      _model.randomINT =
                          random_data.randomInteger(10000000, 99999999);
                      _model.userResult1 = await queryUsersRecordCount(
                        queryBuilder: (usersRecord) => usersRecord.where(
                          'user_id',
                          isEqualTo: _model.randomINT,
                        ),
                      );
                      if (_model.userResult1! > 0) {
                        _model.randomINT =
                            random_data.randomInteger(10000000, 99999999);
                      } else {
                        await currentUserReference!
                            .update(createUsersRecordData(
                          status: 'Publish',
                          userRole: 'users',
                          userId: _model.randomINT,
                          isWalkthroughStatus: false,
                          appLaunchTimeUser: _model.settingsAppLunchTimeGresult
                              ?.settingsCompanyInfo?.companyAppLaunchTimeStatus,
                        ));
                        break;
                      }
                    }
                    _model.forInappGoogle = await querySettingsRecordOnce(
                      queryBuilder: (settingsRecord) => settingsRecord.where(
                        'type',
                        isEqualTo: 'Company',
                      ),
                      singleRecord: true,
                    ).then((s) => s.firstOrNull);
                    if (_model.forInappGoogle?.settingsInappPurchaseStatus ==
                        true) {
                      context.goNamedAuth(
                        HomeWidget.routeName,
                        context.mounted,
                        extra: <String, dynamic>{
                          '__transition_info__': TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    } else {
                      context.goNamedAuth(
                        CompleteProfileWidget.routeName,
                        context.mounted,
                        extra: <String, dynamic>{
                          '__transition_info__': TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    }
                  } else {
                    if (valueOrDefault(currentUserDocument?.status, '') ==
                        'Publish') {
                      context.goNamedAuth(
                        HomeWidget.routeName,
                        context.mounted,
                        extra: <String, dynamic>{
                          '__transition_info__': TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    } else {
                      FFAppState().deleteCurrentUserRef();
                      FFAppState().currentUserRef = null;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            FFLocalizations.of(context).getVariableText(
                              enText: 'Please contact the admin.',
                              arText: 'يرجى الاتصال بالمسؤول.',
                            ),
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                      GoRouter.of(context).prepareAuthEvent();
                      await authManager.signOut();
                      GoRouter.of(context).clearRedirectLocation();

                      context.goNamedAuth(
                        LoginWidget.routeName,
                        context.mounted,
                        extra: <String, dynamic>{
                          '__transition_info__': TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    }
                  }

                  safeSetState(() {});
                },
                child: Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.0,
                    ),
                  ),
                  child: Stack(
                    children: [
                      if (_model.googleStatus == 'show')
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Lottie.asset(
                            'assets/jsons/google-login.json',
                            width: 450.0,
                            height: 40.0,
                            fit: BoxFit.contain,
                            animate: true,
                          ),
                        ),
                      if (_model.googleStatus == 'hide')
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/google-logo.png',
                                    width: 24.0,
                                    height: 24.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'e7rike0j' /* Google */,
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
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(SizedBox(width: 12.0)),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isiOS)
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.appleStatus = 'show';
                    GoRouter.of(context).prepareAuthEvent();
                    final user = await authManager.signInWithApple(context);
                    if (user == null) {
                      return;
                    }
                    await actions.registerFcmTokenIfMissing();
                    _model.settingsAppLunchTimeAresult =
                        await querySettingsRecordOnce(
                      queryBuilder: (settingsRecord) => settingsRecord.where(
                        'type',
                        isEqualTo: 'Company',
                      ),
                      singleRecord: true,
                    ).then((s) => s.firstOrNull);
                    FFAppState().currentUserRef = currentUserReference;
                    if (valueOrDefault<bool>(
                            currentUserDocument?.isWalkthroughStatus, false) ==
                        false) {
                      FFAppState().walkStatus = false;
                    }
                    if (valueOrDefault(currentUserDocument?.status, '') == '') {
                      while (_model.refresh != 0) {
                        _model.randomINT =
                            random_data.randomInteger(10000000, 99999999);
                        _model.userResult2 = await queryUsersRecordCount(
                          queryBuilder: (usersRecord) => usersRecord.where(
                            'user_id',
                            isEqualTo: _model.randomINT,
                          ),
                        );
                        if (_model.userResult2! > 0) {
                          _model.randomINT =
                              random_data.randomInteger(10000000, 99999999);
                        } else {
                          await currentUserReference!
                              .update(createUsersRecordData(
                            status: 'Publish',
                            userRole: 'users',
                            userId: _model.randomINT,
                            isWalkthroughStatus: false,
                            appLaunchTimeUser: _model
                                .settingsAppLunchTimeAresult
                                ?.settingsCompanyInfo
                                ?.companyAppLaunchTimeStatus,
                          ));
                          break;
                        }
                      }
                      _model.forInappApple = await querySettingsRecordOnce(
                        queryBuilder: (settingsRecord) => settingsRecord.where(
                          'type',
                          isEqualTo: 'Company',
                        ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      if (_model.forInappApple?.settingsInappPurchaseStatus ==
                          true) {
                        context.goNamedAuth(
                          HomeWidget.routeName,
                          context.mounted,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      } else {
                        context.goNamedAuth(
                          CompleteProfileWidget.routeName,
                          context.mounted,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      }
                    } else {
                      if (valueOrDefault(currentUserDocument?.status, '') ==
                          'Publish') {
                        context.goNamedAuth(
                          HomeWidget.routeName,
                          context.mounted,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      } else {
                        FFAppState().deleteCurrentUserRef();
                        FFAppState().currentUserRef = null;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              FFLocalizations.of(context).getVariableText(
                                enText: 'Please contact the admin.',
                                arText: 'يرجى الاتصال بالمسؤول.',
                              ),
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();

                        context.goNamedAuth(
                          LoginWidget.routeName,
                          context.mounted,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      }
                    }

                    safeSetState(() {});
                  },
                  child: Container(
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                    ),
                    child: Stack(
                      children: [
                        if (_model.appleStatus == 'show')
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Lottie.asset(
                              'assets/jsons/apple_login.json',
                              width: 40.0,
                              height: 40.0,
                              fit: BoxFit.contain,
                              animate: true,
                            ),
                          ),
                        if (_model.appleStatus == 'hide')
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/apple-logo_(1).png',
                                      width: 24.0,
                                      height: 24.0,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'u5bi46yl' /* Apple */,
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
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 12.0)),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
