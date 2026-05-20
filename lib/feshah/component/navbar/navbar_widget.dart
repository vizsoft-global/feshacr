import '/auth/base_auth_user_provider.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'navbar_model.dart';
export 'navbar_model.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({
    super.key,
    this.hometext,
    this.homebg,
    this.profiletext,
    this.profilebg,
    required this.navigation,
  });

  final Color? hometext;
  final Color? homebg;
  final Color? profiletext;
  final Color? profilebg;
  final String? navigation;

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  late NavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        List<SettingsRecord> containerSettingsRecordList = snapshot.data!;
        final containerSettingsRecord = containerSettingsRecordList.isNotEmpty
            ? containerSettingsRecordList.first
            : null;

        return Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: 80.0,
          decoration: BoxDecoration(),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6.0,
                          color: Color(0x19EC4D41),
                          offset: Offset(
                            0.0,
                            -6.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.only(),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.goNamed(
                          HomeWidget.routeName,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget!.navigation == 'home'
                              ? Color(0xFFFBECEC)
                              : FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(100.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    FFIcons.khome2,
                                    color: widget!.navigation == 'home'
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    size: 22.0,
                                  ),
                                  if (functions.isLandscape(
                                          MediaQuery.sizeOf(context).width,
                                          MediaQuery.sizeOf(context).height) ??
                                      true)
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'ibn23fig' /* Home */,
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
                                            color: widget!.navigation == 'home'
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText,
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
                                ].divide(SizedBox(width: 4.0)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (loggedIn) {
                          context.goNamed(MyFeshahWidget.routeName);
                        } else {
                          context.goNamed(LoginWidget.routeName);
                        }
                      },
                      child: Container(
                        width: 62.0,
                        height: 62.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              valueOrDefault<String>(
                                containerSettingsRecord
                                    ?.settingsAppVersionInfo?.appMenuBarImage,
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/xzu49wvshv2h/Feshah-Logo.jpg',
                              ),
                            ).image,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 16.0,
                              color: Color(0x3E000000),
                              offset: Offset(
                                0.0,
                                1.0,
                              ),
                            )
                          ],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (loggedIn) {
                          context.goNamed(
                            ProfileWidget.routeName,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                              ),
                            },
                          );
                        } else {
                          context.goNamed(LoginWidget.routeName);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget!.navigation == 'profile'
                              ? Color(0xFFFBECEC)
                              : FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(100.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    FFIcons.kfi43,
                                    color: widget!.navigation == 'profile'
                                        ? FlutterFlowTheme.of(context)
                                            .primaryText
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    size: 20.0,
                                  ),
                                  if (functions.isLandscape(
                                          MediaQuery.sizeOf(context).width,
                                          MediaQuery.sizeOf(context).height) ??
                                      true)
                                    Text(
                                      loggedIn
                                          ? FFLocalizations.of(context)
                                              .getVariableText(
                                              enText: 'Profile',
                                              arText: 'حساب تعريفي',
                                            )
                                          : FFLocalizations.of(context)
                                              .getVariableText(
                                              enText: 'Login',
                                              arText: 'تسجيل الدخول',
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
                                            color: widget!.navigation ==
                                                    'profile'
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText,
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
                                ].divide(SizedBox(width: 4.0)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 8.0)).around(SizedBox(width: 8.0)),
              ),
            ],
          ),
        );
      },
    );
  }
}
