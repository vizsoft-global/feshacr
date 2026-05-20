import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'user_request_widget_model.dart';
export 'user_request_widget_model.dart';

class UserRequestWidgetWidget extends StatefulWidget {
  const UserRequestWidgetWidget({
    super.key,
    required this.room,
    required this.userInfo,
    required this.user,
  });

  final DocumentReference? room;
  final RoomUserListStruct? userInfo;
  final DocumentReference? user;

  @override
  State<UserRequestWidgetWidget> createState() =>
      _UserRequestWidgetWidgetState();
}

class _UserRequestWidgetWidgetState extends State<UserRequestWidgetWidget> {
  late UserRequestWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserRequestWidgetModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget!.user!),
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

        final containerUsersRecord = snapshot.data!;

        return ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 12.0, 0.0),
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.network(
                                  valueOrDefault<String>(
                                    containerUsersRecord.photoUrl,
                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/7fnvxvk9w0jj/Frame_2087324742.png',
                                  ),
                                ).image,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 12.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  containerUsersRecord.displayName,
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
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      valueOrDefault<String>(
                                        '${FFLocalizations.of(context).getVariableText(
                                          enText: 'Player ID: ',
                                          arText: 'معرف اللاعب:',
                                        )}${containerUsersRecord.userId.toString()}',
                                        ' Player ID: 22364598',
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
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 13.0,
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
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ].divide(SizedBox(height: 4.0)),
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
                          Icon(
                            Icons.more_vert,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () async {
                              var _shouldSetState = false;
                              _model.roomResult1 =
                                  await RoomRecord.getDocumentOnce(
                                      widget!.room!);
                              _shouldSetState = true;
                              if (_model.roomResult1!.roomMemberLimit >=
                                  _model.roomResult1!.roomUserList.length) {
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
                                      widget!.userInfo?.roomUserRef) {
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

                                await widget!.room!.update({
                                  ...mapToFirestore(
                                    {
                                      'room_user_list':
                                          getRoomUserListListFirestoreData(
                                        _model.userList,
                                      ),
                                    },
                                  ),
                                });

                                await _model.userList
                                    .elementAtOrNull((_model.count!) - 1)!
                                    .roomUserNotificationRef!
                                    .update(createNotificationRecordData(
                                      updatedAt: getCurrentTimestamp,
                                      notificationType: 'room_active',
                                    ));
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        content: Text(
                                            FFLocalizations.of(context)
                                                .getVariableText(
                                          enText:
                                              'The maximum number of room members has been exceeded.',
                                          arText:
                                              'لقد تم تجاوز الحد الأقصى لعدد أعضاء الغرفة.',
                                        )),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              enText: 'Ok',
                                              arText: 'نعم',
                                            )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }

                              if (_shouldSetState) safeSetState(() {});
                            },
                            text: FFLocalizations.of(context).getText(
                              'b0qk5rpl' /* Accept */,
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
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () async {
                              _model.roomResult2 =
                                  await RoomRecord.getDocumentOnce(
                                      widget!.room!);
                              _model.count =
                                  _model.roomResult2?.roomUserList?.length;
                              _model.userList = _model.roomResult2!.roomUserList
                                  .toList()
                                  .cast<RoomUserListStruct>();
                              while (_model.count! > 0) {
                                if (_model.userList
                                        .elementAtOrNull((_model.count!) - 1)
                                        ?.roomUserRef ==
                                    widget!.userInfo?.roomUserRef) {
                                  _model.roomUserNotificationResult =
                                      await NotificationRecord.getDocumentOnce(
                                          _model.userList
                                              .elementAtOrNull(
                                                  (_model.count!) - 1)!
                                              .roomUserNotificationRef!);
                                  _model.updateUserListAtIndex(
                                    (_model.count!) - 1,
                                    (e) => e
                                      ..roomUserOnlineStatus = null
                                      ..roomUserStatus = null
                                      ..roomUserUpdatedTime =
                                          getCurrentTimestamp
                                      ..roomUserNotificationRef = null
                                      ..roomUserNotificationSendStatus = null,
                                  );
                                  unawaited(
                                    () async {
                                      await _model.userList
                                          .elementAtOrNull((_model.count!) - 1)!
                                          .roomUserNotificationRef!
                                          .delete();
                                    }(),
                                  );
                                  break;
                                }
                                _model.count = (_model.count!) - 1;
                              }

                              await widget!.room!.update({
                                ...mapToFirestore(
                                  {
                                    'room_user_list':
                                        getRoomUserListListFirestoreData(
                                      _model.userList,
                                    ),
                                  },
                                ),
                              });

                              await _model.userList
                                  .elementAtOrNull((_model.count!) - 1)!
                                  .roomUserNotificationRef!
                                  .update(createNotificationRecordData(
                                    updatedAt: getCurrentTimestamp,
                                    notificationType: 'room_decline',
                                    notificationStatus: 'decline',
                                  ));

                              safeSetState(() {});
                            },
                            text: FFLocalizations.of(context).getText(
                              '2m69jflt' /* Decline */,
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
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                  ),
                ].divide(SizedBox(height: 8.0)).addToEnd(SizedBox(height: 8.0)),
              ),
            ),
          ),
        );
      },
    );
  }
}
