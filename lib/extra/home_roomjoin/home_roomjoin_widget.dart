import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home_roomjoin_model.dart';
export 'home_roomjoin_model.dart';

class HomeRoomjoinWidget extends StatefulWidget {
  const HomeRoomjoinWidget({super.key});

  @override
  State<HomeRoomjoinWidget> createState() => _HomeRoomjoinWidgetState();
}

class _HomeRoomjoinWidgetState extends State<HomeRoomjoinWidget> {
  late HomeRoomjoinModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeRoomjoinModel());

    _model.pinCodeFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Form(
        key: _model.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      '04hkkxmf' /* Join Room */,
                    ),
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.almarai(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 24.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'r7kgx365' /* You can join your leader room ... */,
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.almarai(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                child: PinCodeTextField(
                  autoDisposeControllers: false,
                  appContext: context,
                  length: 6,
                  textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.almarai(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  enableActiveFill: false,
                  autoFocus: false,
                  focusNode: _model.pinCodeFocusNode,
                  enablePinAutofill: false,
                  errorTextSpace: 16.0,
                  showCursor: true,
                  cursorColor: FlutterFlowTheme.of(context).primary,
                  obscureText: false,
                  hintCharacter: '●',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  pinTheme: PinTheme(
                    fieldHeight: 50.0,
                    fieldWidth: 50.0,
                    borderWidth: 1.0,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    shape: PinCodeFieldShape.box,
                    activeColor: FlutterFlowTheme.of(context).primaryText,
                    inactiveColor: FlutterFlowTheme.of(context).alternate,
                    selectedColor: FlutterFlowTheme.of(context).primary,
                  ),
                  controller: _model.pinCodeController,
                  onChanged: (_) {},
                  autovalidateMode: AutovalidateMode.disabled,
                  validator:
                      _model.pinCodeControllerValidator.asValidator(context),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    var _shouldSetState = false;
                    if (_model.formKey.currentState == null ||
                        !_model.formKey.currentState!.validate()) {
                      return;
                    }
                    if (_model.pinCodeController!.text == '') {
                      if (_shouldSetState) safeSetState(() {});
                      return;
                    }
                    _model.roomResult1 = await queryRoomRecordOnce(
                      queryBuilder: (roomRecord) => roomRecord
                          .where(
                            'room_status',
                            isEqualTo: 'active',
                          )
                          .where(
                            'room_code',
                            isEqualTo:
                                int.tryParse(_model.pinCodeController!.text),
                          ),
                      singleRecord: true,
                    ).then((s) => s.firstOrNull);
                    _shouldSetState = true;
                    if ((_model.roomResult1 != null) == true) {
                      await _model.roomResult1!.reference.update({
                        ...mapToFirestore(
                          {
                            'room_user_list': FieldValue.arrayUnion([
                              getRoomUserListFirestoreData(
                                updateRoomUserListStruct(
                                  RoomUserListStruct(
                                    roomUserJoinTime: getCurrentTimestamp,
                                    roomUserId: valueOrDefault(
                                        currentUserDocument?.userId, 0),
                                    roomUserRef: currentUserReference,
                                    roomUserStatus: 'request',
                                  ),
                                  clearUnsetFields: false,
                                ),
                                true,
                              )
                            ]),
                          },
                        ),
                      });
                      _model.newRoomResult1 = await RoomRecord.getDocumentOnce(
                          _model.roomResult1!.reference);
                      _shouldSetState = true;
                      FFAppState().updateUserflowStruct(
                        (e) => e
                          ..roomInfo = RoomInfoStruct(
                            roomStatus: 'initial',
                            roomId: _model.roomResult1?.roomID,
                            roomMemberLimit:
                                _model.roomResult1?.roomMemberLimit,
                            roomCreatedByUserId:
                                _model.roomResult1?.roomCurrentUserId,
                            roomUserList: _model.newRoomResult1?.roomUserList
                                ?.map((e) => e.roomUserId)
                                .toList(),
                            roomRef: _model.roomResult1?.reference,
                          ),
                      );

                      await currentUserReference!
                          .update(createUsersRecordData());
                    } else {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return WebViewAware(
                            child: AlertDialog(
                              content: Text(
                                  FFLocalizations.of(context).getVariableText(
                                enText: 'Room-id doesn\'t match.',
                                arText: 'معرف الغرفة غير متطابق.',
                              )),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: Text(FFLocalizations.of(context)
                                      .getVariableText(
                                    enText: 'Ok',
                                    arText: 'تمام',
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

                    Navigator.pop(context);
                    unawaited(
                      () async {
                        context.goNamed(
                          RoomCreateS2Widget.routeName,
                          queryParameters: {
                            'room': serializeParam(
                              _model.roomResult1?.reference,
                              ParamType.DocumentReference,
                            ),
                          }.withoutNulls,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      }(),
                    );
                    if (_shouldSetState) safeSetState(() {});
                  },
                  text: FFLocalizations.of(context).getText(
                    'fjw6ffr5' /* Join Now */,
                  ),
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 55.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primaryText,
                    textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Gentona Medium',
                          color: Color(0xFF3D62CF),
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
