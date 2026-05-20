import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'user_new_widget_model.dart';
export 'user_new_widget_model.dart';

class UserNewWidgetWidget extends StatefulWidget {
  const UserNewWidgetWidget({
    super.key,
    required this.user,
    required this.room,
  });

  final DocumentReference? user;
  final RoomRecord? room;

  @override
  State<UserNewWidgetWidget> createState() => _UserNewWidgetWidgetState();
}

class _UserNewWidgetWidgetState extends State<UserNewWidgetWidget> {
  late UserNewWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserNewWidgetModel());

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

        return Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          containerUsersRecord.displayName,
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
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
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
                          ].divide(SizedBox(width: 8.0)),
                        ),
                      ].divide(SizedBox(height: 4.0)),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      var _shouldSetState = false;
                      if (_model.addStatus == 'pending') {
                        if (widget!.room!.roomMemberLimit >
                            widget!.room!.roomUserList.length) {
                          _model.addStatus = 'done';

                          await widget!.room!.reference.update({
                            ...mapToFirestore(
                              {
                                'room_user_list': FieldValue.arrayUnion([
                                  getRoomUserListFirestoreData(
                                    updateRoomUserListStruct(
                                      RoomUserListStruct(
                                        roomUserOnlineStatus: 'deactive',
                                        roomUserStatus: 'invite',
                                        roomUserUpdatedTime:
                                            getCurrentTimestamp,
                                        roomUserJoinTime: getCurrentTimestamp,
                                        roomUserId: containerUsersRecord.userId,
                                        roomUserRef: widget!.user,
                                      ),
                                      clearUnsetFields: false,
                                    ),
                                    true,
                                  )
                                ]),
                              },
                            ),
                          });
                          _model.idmapNotificationResult1 =
                              await queryIDmapRecordOnce(
                            queryBuilder: (iDmapRecord) => iDmapRecord.where(
                              'type',
                              isEqualTo: 'Main',
                            ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          _shouldSetState = true;

                          await NotificationRecord.collection
                              .doc()
                              .set(createNotificationRecordData(
                                createdAt: getCurrentTimestamp,
                                updatedAt: getCurrentTimestamp,
                                notificationID: _model
                                    .idmapNotificationResult1?.notificationId,
                                notificationStatus: 'send',
                                toUserRef: widget!.user,
                                fromUserRef: currentUserReference,
                                roomInfo: updateRoomInfoStruct(
                                  RoomInfoStruct(
                                    roomRef: widget!.room?.reference,
                                    roomStatus: 'active',
                                    roomId: widget!.room?.roomID,
                                    roomMemberLimit:
                                        widget!.room?.roomMemberLimit,
                                    roomCreatedByUserId:
                                        widget!.room?.roomCurrentUserId,
                                    roomCreatedByUserRef:
                                        widget!.room?.roomCreatedUserRef,
                                    roomInfo: widget!.room?.roomMainInfo,
                                    roomInviteTime: getCurrentTimestamp,
                                    inviteStatus: 'pending',
                                  ),
                                  clearUnsetFields: false,
                                  create: true,
                                ),
                                notificationType: 'room_request',
                                notificationFrom: 'room_admin',
                              ));

                          await _model.idmapNotificationResult1!.reference
                              .update({
                            ...mapToFirestore(
                              {
                                'notification_id': FieldValue.increment(1),
                              },
                            ),
                          });
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return WebViewAware(
                                child: AlertDialog(
                                  content: Text(FFLocalizations.of(context)
                                      .getVariableText(
                                    enText:
                                        'The maximum number of room members has been exceeded.',
                                    arText:
                                        'لقد تم تجاوز الحد الأقصى لعدد أعضاء الغرفة.',
                                  )),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text(FFLocalizations.of(context)
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
                      }
                      if (_shouldSetState) safeSetState(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      'gnztyxnr' /* + Add */,
                    ),
                    options: FFButtonOptions(
                      height: 24.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0x3267B5B0),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.almarai(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
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
        );
      },
    );
  }
}
