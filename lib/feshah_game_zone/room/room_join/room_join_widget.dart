import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/notification/notfy_room_request_joinroom/notfy_room_request_joinroom_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/room/room_q_rscanner/room_q_rscanner_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'room_join_model.dart';
export 'room_join_model.dart';

class RoomJoinWidget extends StatefulWidget {
  const RoomJoinWidget({super.key});

  static String routeName = 'RoomJoin';
  static String routePath = '/join_room';

  @override
  State<RoomJoinWidget> createState() => _RoomJoinWidgetState();
}

class _RoomJoinWidgetState extends State<RoomJoinWidget> {
  late RoomJoinModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RoomJoinModel());

    _model.pinCodeFocusNode ??= FocusNode();

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
          backgroundColor: FlutterFlowTheme.of(context).secondary,
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
              context.pushNamed(HomeWidget.routeName);
            },
          ),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  FFLocalizations.of(context).getText(
                    'frcaca5h' /* Join Room */,
                  ),
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.almarai(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
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
                Builder(
                  builder: (context) => FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 40.0,
                    fillColor: FlutterFlowTheme.of(context).secondary,
                    icon: Icon(
                      Icons.qr_code_scanner_rounded,
                      color: FlutterFlowTheme.of(context).info,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      FFAppState().deleteQRvalue();
                      FFAppState().QRvalue = 'null';

                      await showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return Dialog(
                            elevation: 0,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            alignment: AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: WebViewAware(
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(dialogContext).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Container(
                                  width: 500.0,
                                  child: RoomQRscannerWidget(),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ].divide(SizedBox(width: 8.0)),
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
            Padding(
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _model.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
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
                          padding: EdgeInsets.all(16.0),
                          child: Wrap(
                            spacing: 0.0,
                            runSpacing: 0.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'v7552l9h' /* Enter Room ID */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: GoogleFonts.almarai(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                        ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 4.0, 0.0, 16.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '4dpsqyha' /* You can join your leader space... */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        font: GoogleFonts.almarai(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                              ),
                              PinCodeTextField(
                                autoDisposeControllers: false,
                                appContext: context,
                                length: 6,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                enableActiveFill: false,
                                autoFocus: true,
                                focusNode: _model.pinCodeFocusNode,
                                enablePinAutofill: false,
                                errorTextSpace: 24.0,
                                showCursor: false,
                                cursorColor:
                                    FlutterFlowTheme.of(context).secondary,
                                obscureText: false,
                                hintCharacter: '-',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                pinTheme: PinTheme(
                                  fieldHeight: 40.0,
                                  fieldWidth: 40.0,
                                  borderWidth: 0.0,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                  shape: PinCodeFieldShape.box,
                                  activeColor:
                                      FlutterFlowTheme.of(context).secondary,
                                  inactiveColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  selectedColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                                controller: _model.pinCodeController,
                                onChanged: (_) {},
                                autovalidateMode: AutovalidateMode.disabled,
                                validator: _model.pinCodeControllerValidator
                                    .asValidator(context),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    var _shouldSetState = false;
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      return;
                                    }
                                    if (_model.pinCodeController!.text == '') {
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }
                                    _model.roomResult1 =
                                        await queryRoomRecordOnce(
                                      queryBuilder: (roomRecord) => roomRecord
                                          .where(
                                            'room_status',
                                            isEqualTo: 'active',
                                          )
                                          .where(
                                            'room_code',
                                            isEqualTo: int.tryParse(
                                                _model.pinCodeController!.text),
                                          ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    _shouldSetState = true;
                                    if ((_model.roomResult1 != null) == true) {
                                      if (_model.roomResult1!.roomMemberLimit >
                                          _model.roomResult1!.roomUserList
                                              .where((e) =>
                                                  e.roomUserStatus == 'active')
                                              .toList()
                                              .length) {
                                        if (_model.roomResult1?.roomUserList
                                                ?.where((e) =>
                                                    e.roomUserRef ==
                                                    currentUserReference)
                                                .toList()
                                                ?.length ==
                                            0) {
                                          _model.idmapNotificationResult1 =
                                              await queryIDmapRecordOnce(
                                            queryBuilder: (iDmapRecord) =>
                                                iDmapRecord.where(
                                              'type',
                                              isEqualTo: 'Main',
                                            ),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);
                                          _shouldSetState = true;

                                          var notificationRecordReference =
                                              NotificationRecord.collection
                                                  .doc();
                                          await notificationRecordReference
                                              .set(createNotificationRecordData(
                                            createdAt: getCurrentTimestamp,
                                            updatedAt: getCurrentTimestamp,
                                            notificationID: _model
                                                .idmapNotificationResult1
                                                ?.notificationId,
                                            notificationStatus: 'send',
                                            toUserRef: currentUserReference,
                                            fromUserRef: currentUserReference,
                                            roomInfo: updateRoomInfoStruct(
                                              RoomInfoStruct(
                                                roomRef: _model
                                                    .roomResult1?.reference,
                                                roomId:
                                                    _model.roomResult1?.roomID,
                                                roomCreatedByUserId: _model
                                                    .roomResult1
                                                    ?.roomCurrentUserId,
                                                roomCreatedByUserRef: _model
                                                    .roomResult1
                                                    ?.roomCreatedUserRef,
                                                roomInfo: _model
                                                    .roomResult1?.roomMainInfo,
                                                roomInviteTime:
                                                    getCurrentTimestamp,
                                                inviteStatus: 'pending',
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                            notificationType: 'room_request',
                                            notificationFrom: 'room_code',
                                          ));
                                          _model.notificationResult =
                                              NotificationRecord.getDocumentFromData(
                                                  createNotificationRecordData(
                                                    createdAt:
                                                        getCurrentTimestamp,
                                                    updatedAt:
                                                        getCurrentTimestamp,
                                                    notificationID: _model
                                                        .idmapNotificationResult1
                                                        ?.notificationId,
                                                    notificationStatus: 'send',
                                                    toUserRef:
                                                        currentUserReference,
                                                    fromUserRef:
                                                        currentUserReference,
                                                    roomInfo:
                                                        updateRoomInfoStruct(
                                                      RoomInfoStruct(
                                                        roomRef: _model
                                                            .roomResult1
                                                            ?.reference,
                                                        roomId: _model
                                                            .roomResult1
                                                            ?.roomID,
                                                        roomCreatedByUserId: _model
                                                            .roomResult1
                                                            ?.roomCurrentUserId,
                                                        roomCreatedByUserRef: _model
                                                            .roomResult1
                                                            ?.roomCreatedUserRef,
                                                        roomInfo: _model
                                                            .roomResult1
                                                            ?.roomMainInfo,
                                                        roomInviteTime:
                                                            getCurrentTimestamp,
                                                        inviteStatus: 'pending',
                                                      ),
                                                      clearUnsetFields: false,
                                                      create: true,
                                                    ),
                                                    notificationType:
                                                        'room_request',
                                                    notificationFrom:
                                                        'room_code',
                                                  ),
                                                  notificationRecordReference);
                                          _shouldSetState = true;

                                          await _model.roomResult1!.reference
                                              .update({
                                            ...createRoomRecordData(
                                              roomUpdatedAt:
                                                  getCurrentTimestamp,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'room_user_list':
                                                    FieldValue.arrayUnion([
                                                  getRoomUserListFirestoreData(
                                                    updateRoomUserListStruct(
                                                      RoomUserListStruct(
                                                        roomUserJoinTime:
                                                            getCurrentTimestamp,
                                                        roomUserId: valueOrDefault(
                                                            currentUserDocument
                                                                ?.userId,
                                                            0),
                                                        roomUserRef:
                                                            currentUserReference,
                                                        roomUserStatus:
                                                            'request',
                                                        roomUserOnlineStatus:
                                                            'active',
                                                        roomUserUpdatedTime:
                                                            getCurrentTimestamp,
                                                        roomUserNotificationRef:
                                                            _model
                                                                .notificationResult
                                                                ?.reference,
                                                      ),
                                                      clearUnsetFields: false,
                                                    ),
                                                    true,
                                                  )
                                                ]),
                                              },
                                            ),
                                          });

                                          await _model.idmapNotificationResult1!
                                              .reference
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'notification_id':
                                                    FieldValue.increment(1),
                                              },
                                            ),
                                          });
                                        } else {
                                          if (_model.roomResult1!.roomUserList
                                                  .where((e) =>
                                                      (e.roomUserRef ==
                                                          currentUserReference) &&
                                                      (e.roomUserStatus ==
                                                          'invite'))
                                                  .toList()
                                                  .length >
                                              0) {
                                            context.pushNamed(
                                                NotificationWidget.routeName);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                    enText:
                                                        'You are already joined the room',
                                                    arText:
                                                        'لقد انضممت بالفعل إلى الغرفة',
                                                  ),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          }
                                        }

                                        safeSetState(() {
                                          _model.pinCodeController?.clear();
                                        });
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
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text(
                                                        FFLocalizations.of(
                                                                context)
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
                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      }
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
                                                    'Room-id doesn\'t match.',
                                                arText:
                                                    'معرف الغرفة لا يتطابق.',
                                              )),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text(
                                                      FFLocalizations.of(
                                                              context)
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
                                    'm4fr3viz' /* Join Room */,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Gentona Medium',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                            .where(
                              'notification_type',
                              isEqualTo: 'room_request',
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
                        List<NotificationRecord>
                            listViewNotificationRecordList = snapshot.data!;

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewNotificationRecordList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 8.0),
                          itemBuilder: (context, listViewIndex) {
                            final listViewNotificationRecord =
                                listViewNotificationRecordList[listViewIndex];
                            return NotfyRoomRequestJoinroomWidget(
                              key: Key(
                                  'Keyn27_${listViewIndex}_of_${listViewNotificationRecordList.length}'),
                              notification: listViewNotificationRecord,
                            );
                          },
                        );
                      },
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
