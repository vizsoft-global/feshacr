import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah/component/app_bar_default/app_bar_default_widget.dart';
import '/feshah/component/empty_widget_notification/empty_widget_notification_widget.dart';
import '/feshah/notification/notfy_game_request/notfy_game_request_widget.dart';
import '/feshah/notification/notfy_room_request_accept/notfy_room_request_accept_widget.dart';
import '/feshah/notification/notfy_room_request_decline/notfy_room_request_decline_widget.dart';
import '/feshah/notification/notfy_room_request_joinroom/notfy_room_request_joinroom_widget.dart';
import '/feshah/notification/notfy_room_request_notification/notfy_room_request_notification_widget.dart';
import '/feshah/notification/notify_sound/notify_sound_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notification_model.dart';
export 'notification_model.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  static String routeName = 'Notification';
  static String routePath = '/notification';

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late NotificationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationModel());

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
                Expanded(
                  child: wrapWithModel(
                    model: _model.appBarDefaultModel,
                    updateCallback: () => safeSetState(() {}),
                    updateOnChange: true,
                    child: AppBarDefaultWidget(
                      pageTitle: FFLocalizations.of(context).getText(
                        'aztdjrbx' /* Notifications */,
                      ),
                      notificationNavStatus: false,
                      backNavStatus: true,
                    ),
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
            StreamBuilder<List<NotificationRecord>>(
              stream: queryNotificationRecord(
                queryBuilder: (notificationRecord) => notificationRecord
                    .where(
                      'notification_status',
                      isEqualTo: 'send',
                    )
                    .where(
                      'to_userRef',
                      isEqualTo: currentUserReference,
                    )
                    .orderBy('created_at', descending: true),
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
                List<NotificationRecord> containerNotificationRecordList =
                    snapshot.data!;

                return Container(
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
                        16.0,
                        16.0,
                        0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AuthUserStreamWidget(
                            builder: (context) => Builder(
                              builder: (context) {
                                final containerVar =
                                    containerNotificationRecordList
                                        .where((e) => loggedIn
                                            ? ((currentUserDocument?.userSetting
                                                        ?.isNotificationstatus ==
                                                    true) &&
                                                (e.notificationType !=
                                                    'room_request'))
                                            : (e.notificationType !=
                                                'room_request'))
                                        .toList();
                                if (containerVar.isEmpty) {
                                  return Center(
                                    child: Container(
                                      height: 220.0,
                                      child: EmptyWidgetNotificationWidget(),
                                    ),
                                  );
                                }

                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: containerVar.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 16.0),
                                  itemBuilder: (context, containerVarIndex) {
                                    final containerVarItem =
                                        containerVar[containerVarIndex];
                                    return Stack(
                                      children: [
                                        if ((containerVarItem
                                                    .notificationType ==
                                                'room_request') &&
                                            (containerVarItem
                                                    .notificationFrom !=
                                                'room_code'))
                                          NotfyRoomRequestNotificationWidget(
                                            key: Key(
                                                'Keydmw_${containerVarIndex}_of_${containerVar.length}'),
                                            notification: containerVarItem,
                                          ),
                                        if (containerVarItem.notificationType ==
                                            'room_active')
                                          NotfyRoomRequestAcceptWidget(
                                            key: Key(
                                                'Keylvk_${containerVarIndex}_of_${containerVar.length}'),
                                            notification: containerVarItem,
                                          ),
                                        if (containerVarItem.notificationType ==
                                            'game_invite')
                                          NotfyGameRequestWidget(
                                            key: Key(
                                                'Key93e_${containerVarIndex}_of_${containerVar.length}'),
                                            notification: containerVarItem,
                                          ),
                                        if (containerVarItem.notificationType ==
                                            'room_decline')
                                          NotfyRoomRequestDeclineWidget(
                                            key: Key(
                                                'Keyrsi_${containerVarIndex}_of_${containerVar.length}'),
                                            notification: containerVarItem,
                                          ),
                                        if ((containerVarItem
                                                    .notificationType ==
                                                'room_request') &&
                                            (containerVarItem
                                                    .notificationFrom ==
                                                'room_code'))
                                          NotfyRoomRequestJoinroomWidget(
                                            key: Key(
                                                'Keygdl_${containerVarIndex}_of_${containerVar.length}'),
                                            notification: containerVarItem,
                                          ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          if (containerNotificationRecordList.length != 0)
                            FFButtonWidget(
                              onPressed: () async {
                                _model.notificationList =
                                    await queryNotificationRecordOnce(
                                  queryBuilder: (notificationRecord) =>
                                      notificationRecord
                                          .where(
                                            'notification_status',
                                            isEqualTo: 'send',
                                          )
                                          .where(
                                            'to_userRef',
                                            isEqualTo: currentUserReference,
                                          ),
                                );
                                if (_model.notificationList!.length > 0) {
                                  _model.count =
                                      _model.notificationList?.length;
                                  while (_model.count! > 0) {
                                    await _model.notificationList!
                                        .elementAtOrNull((_model.count!) - 1)!
                                        .reference
                                        .update(createNotificationRecordData(
                                          updatedAt: getCurrentTimestamp,
                                          notificationStatus: 'clear',
                                        ));
                                    _model.count = (_model.count!) - 1;
                                  }
                                  _model.count = null;
                                  safeSetState(() {});
                                }

                                safeSetState(() {});
                              },
                              text: FFLocalizations.of(context).getText(
                                '4127qkj6' /* Clear All */,
                              ),
                              options: FFButtonOptions(
                                height: 32.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
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
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          if (containerNotificationRecordList
                                  .where((e) => loggedIn
                                      ? (currentUserDocument?.userSetting
                                              ?.isNotificationstatus ==
                                          true)
                                      : true)
                                  .toList()
                                  .length !=
                              0)
                            AuthUserStreamWidget(
                              builder: (context) => wrapWithModel(
                                model: _model.notifySoundModel,
                                updateCallback: () => safeSetState(() {}),
                                child: NotifySoundWidget(),
                              ),
                            ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 100.0,
                            decoration: BoxDecoration(),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
