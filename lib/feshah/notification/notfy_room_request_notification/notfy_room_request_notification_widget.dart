import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notfy_room_request_notification_model.dart';
export 'notfy_room_request_notification_model.dart';

class NotfyRoomRequestNotificationWidget extends StatefulWidget {
  const NotfyRoomRequestNotificationWidget({
    super.key,
    required this.notification,
  });

  final NotificationRecord? notification;

  @override
  State<NotfyRoomRequestNotificationWidget> createState() =>
      _NotfyRoomRequestNotificationWidgetState();
}

class _NotfyRoomRequestNotificationWidgetState
    extends State<NotfyRoomRequestNotificationWidget> {
  late NotfyRoomRequestNotificationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotfyRoomRequestNotificationModel());

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

    return Container(
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
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: FFLocalizations.of(context).getText(
                                '62u3o69i' /* You have asked to join */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  widget!.notification!.roomInfo.roomInfo.name,
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            )
                          ],
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                        ),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Text(
                          FFLocalizations.of(context).getText(
                            '4w4ff3wz' /* Your request has been accepted */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                        ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await widget!.notification!.reference
                        .update(createNotificationRecordData(
                      updatedAt: getCurrentTimestamp,
                      notificationType: 'room_clear',
                      notificationStatus: 'clear',
                    ));
                  },
                  child: Icon(
                    Icons.close_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: StreamBuilder<RoomRecord>(
                stream: RoomRecord.getDocument(
                    widget!.notification!.roomInfo.roomRef!),
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

                  final containerRoomRecord = snapshot.data!;

                  return Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Visibility(
                      visible:
                          widget!.notification?.notificationFrom != 'room_code',
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.roomResult1 =
                                    await RoomRecord.getDocumentOnce(widget!
                                        .notification!.roomInfo.roomRef!);
                                _model.count =
                                    _model.roomResult1?.roomUserList?.length;
                                _model.userList = _model
                                    .roomResult1!.roomUserList
                                    .toList()
                                    .cast<RoomUserListStruct>();
                                while (_model.count! > 0) {
                                  if (_model.userList
                                          .elementAtOrNull((_model.count!) - 1)
                                          ?.roomUserRef ==
                                      currentUserReference) {
                                    _model.updateUserListAtIndex(
                                      (_model.count!) - 1,
                                      (e) => e
                                        ..roomUserOnlineStatus = 'active'
                                        ..roomUserStatus = 'active'
                                        ..roomUserUpdatedTime =
                                            getCurrentTimestamp
                                        ..roomUserJoinTime =
                                            getCurrentTimestamp,
                                    );
                                    break;
                                  }
                                  _model.count = (_model.count!) - 1;
                                }

                                await _model.roomResult1!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'room_user_list':
                                          getRoomUserListListFirestoreData(
                                        _model.userList,
                                      ),
                                    },
                                  ),
                                });
                                unawaited(
                                  () async {
                                    await widget!.notification!.reference
                                        .update(createNotificationRecordData(
                                      updatedAt: getCurrentTimestamp,
                                      notificationType: 'room_active',
                                    ));
                                  }(),
                                );

                                context.goNamed(
                                  RoomSpaceWidget.routeName,
                                  queryParameters: {
                                    'room': serializeParam(
                                      containerRoomRecord.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );

                                safeSetState(() {});
                              },
                              text: FFLocalizations.of(context).getText(
                                'kyok0a46' /* Accept */,
                              ),
                              options: FFButtonOptions(
                                width: 500.0,
                                height: 36.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconAlignment: IconAlignment.start,
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).tertiary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Gentona Medium',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
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
                          ),
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.roomResultDecline =
                                    await RoomRecord.getDocumentOnce(widget!
                                        .notification!.roomInfo.roomRef!);
                                _model.count = _model
                                    .roomResultDecline?.roomUserList?.length;
                                _model.userList = _model
                                    .roomResultDecline!.roomUserList
                                    .toList()
                                    .cast<RoomUserListStruct>();
                                while (_model.count! > 0) {
                                  if (_model.userList
                                          .elementAtOrNull((_model.count!) - 1)
                                          ?.roomUserRef ==
                                      FFAppState().currentUserRef) {
                                    _model.removeAtIndexFromUserList(
                                        (_model.count!) - 1);
                                    break;
                                  }
                                  _model.count = (_model.count!) - 1;
                                }

                                await _model.roomResultDecline!.reference
                                    .update({
                                  ...mapToFirestore(
                                    {
                                      'room_user_list':
                                          getRoomUserListListFirestoreData(
                                        _model.userList,
                                      ),
                                    },
                                  ),
                                });

                                await widget!.notification!.reference
                                    .update(createNotificationRecordData(
                                  updatedAt: getCurrentTimestamp,
                                  notificationType: 'room_decline',
                                ));

                                context.goNamed(
                                  RoomSpaceWidget.routeName,
                                  queryParameters: {
                                    'room': serializeParam(
                                      containerRoomRecord.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );

                                safeSetState(() {});
                              },
                              text: FFLocalizations.of(context).getText(
                                'zei7s4ky' /* Decline */,
                              ),
                              options: FFButtonOptions(
                                width: 500.0,
                                height: 36.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Gentona Medium',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
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
                          ),
                        ].divide(SizedBox(width: 8.0)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: AlignmentDirectional(1.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: Text(
                  dateTimeFormat(
                    "d/M h:mm a",
                    widget!.notification!.updatedAt!,
                    locale: FFLocalizations.of(context).languageCode,
                  ),
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.almarai(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                        fontSize: 10.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodySmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodySmall.fontStyle,
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
