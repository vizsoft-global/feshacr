import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'app_bar_default_model.dart';
export 'app_bar_default_model.dart';

class AppBarDefaultWidget extends StatefulWidget {
  const AppBarDefaultWidget({
    super.key,
    String? exitButtonStatus,
    required this.pageTitle,
    required this.notificationNavStatus,
    required this.backNavStatus,
  }) : this.exitButtonStatus = exitButtonStatus ?? 'show';

  final String exitButtonStatus;
  final String? pageTitle;
  final bool? notificationNavStatus;
  final bool? backNavStatus;

  @override
  State<AppBarDefaultWidget> createState() => _AppBarDefaultWidgetState();
}

class _AppBarDefaultWidgetState extends State<AppBarDefaultWidget> {
  late AppBarDefaultModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppBarDefaultModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (widget!.backNavStatus == true)
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.safePop();
                },
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget!.pageTitle,
                      'pageTitle',
                    ),
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.almarai(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
            ),
            if (widget!.notificationNavStatus == true)
              FutureBuilder<int>(
                future: queryNotificationRecordCount(
                  queryBuilder: (notificationRecord) => notificationRecord
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
                  int containerCount = snapshot.data!;

                  return Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Visibility(
                      visible: (containerCount > 0) &&
                          (loggedIn
                              ? (currentUserDocument
                                      ?.userSetting?.isNotificationstatus ==
                                  true)
                              : true),
                      child: AuthUserStreamWidget(
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (containerCount > 0) {
                                  context.goNamed(NotificationWidget.routeName);
                                }
                              },
                              child: Stack(
                                children: [
                                  if (containerCount > 0)
                                    badges.Badge(
                                      badgeContent: Text(
                                        valueOrDefault<String>(
                                          containerCount.toString(),
                                          '0',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.almarai(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                      ),
                                      showBadge: true,
                                      shape: badges.BadgeShape.circle,
                                      badgeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      elevation: 4.0,
                                      padding: EdgeInsets.all(6.0),
                                      position: badges.BadgePosition.topEnd(),
                                      animationType:
                                          badges.BadgeAnimationType.scale,
                                      toAnimate: true,
                                      child: Icon(
                                        FFIcons.kfi28,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ),
                                  if (containerCount == 0)
                                    Icon(
                                      FFIcons.kfi28,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          ].divide(SizedBox(width: 12.0)),
        ),
      ],
    );
  }
}
