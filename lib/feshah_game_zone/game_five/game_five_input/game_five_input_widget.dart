import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_five_input_model.dart';
export 'game_five_input_model.dart';

class GameFiveInputWidget extends StatefulWidget {
  const GameFiveInputWidget({
    super.key,
    required this.room,
    required this.selectedGameIndex,
  });

  final RoomRecord? room;
  final int? selectedGameIndex;

  @override
  State<GameFiveInputWidget> createState() => _GameFiveInputWidgetState();
}

class _GameFiveInputWidgetState extends State<GameFiveInputWidget> {
  late GameFiveInputModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFiveInputModel());

    _model.playerNameTextController ??= TextEditingController();
    _model.playerNameFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _model.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional(1.0, -1.0),
                  children: [
                    TextFormField(
                      controller: _model.playerNameTextController,
                      focusNode: _model.playerNameFocusNode,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.almarai(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                        hintText: FFLocalizations.of(context).getText(
                          'h10mwjku' /* Player name here... */,
                        ),
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              font: GoogleFonts.almarai(
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 100.0, 0.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      maxLength: 30,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              maxLength}) =>
                          null,
                      validator: _model.playerNameTextControllerValidator
                          .asValidator(context),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          _model.selectedGameList = widget!
                              .room!.selectedGameList
                              .toList()
                              .cast<SelectedGameListStruct>();
                          _model.userCount = (widget!.room?.selectedGameList
                                  ?.elementAtOrNull(widget!.selectedGameIndex!))
                              ?.selectedGameUserList
                              ?.length;
                          _model.userList = widget!.room!.selectedGameList
                              .elementAtOrNull(widget!.selectedGameIndex!)!
                              .selectedGameUserList
                              .toList()
                              .cast<RoomUserListStruct>();
                          _model.countGame =
                              widget!.room?.selectedGameList?.length;
                          _model.userFoundStatus = 'notFound';
                          if (_model.userCount! < 10) {
                            while (_model.userCount! > 0) {
                              if ((_model.selectedGameList
                                          .elementAtOrNull(
                                              widget!.selectedGameIndex!)
                                          ?.selectedGameUserList
                                          ?.elementAtOrNull(
                                              (_model.userCount!) - 1))
                                      ?.roomUserInfo
                                      ?.userName ==
                                  _model.playerNameTextController.text) {
                                _model.userFoundStatus = 'found';
                                break;
                              }
                              _model.userCount = (_model.userCount!) - 1;
                            }
                            if (_model.userFoundStatus == 'found') {
                              unawaited(
                                () async {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          content:
                                              Text('Already added in game.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }(),
                              );
                            } else {
                              _model.addToUserList(RoomUserListStruct(
                                roomUserOnlineStatus: 'active',
                                roomUserStatus: 'active',
                                roomUserUpdatedTime: getCurrentTimestamp,
                                roomUserJoinTime: getCurrentTimestamp,
                                roomUserInfo: OrderUserMainInfoStruct(
                                  userName:
                                      _model.playerNameTextController.text,
                                  userEmail: currentUserEmail,
                                  userId: valueOrDefault(
                                          currentUserDocument?.userId, 0)
                                      .toString(),
                                  userPhone: currentPhoneNumber,
                                  userRole: valueOrDefault(
                                      currentUserDocument?.userRole, ''),
                                ),
                                roomUserId:
                                    random_data.randomInteger(10000, 99999),
                                roomUserPoints: 0,
                                roomUserNotificationSendStatus: 'send',
                                roomUserRef: currentUserReference,
                              ));
                              _model.updateSelectedGameListAtIndex(
                                widget!.selectedGameIndex!,
                                (e) => e
                                  ..selectedGameUserList =
                                      _model.userList.toList(),
                              );

                              await widget!.room!.reference.update({
                                ...mapToFirestore(
                                  {
                                    'selected_game_list':
                                        getSelectedGameListListFirestoreData(
                                      _model.selectedGameList,
                                    ),
                                  },
                                ),
                              });
                            }

                            safeSetState(() {
                              _model.playerNameTextController?.clear();
                            });
                          } else {
                            unawaited(
                              () async {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        content: Text('User limit reached.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }(),
                            );
                            return;
                          }
                        },
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '2lxyseiz' /* Add */,
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
                                color: FlutterFlowTheme.of(context).tertiary,
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
                    ),
                  ],
                ),
              ),
            ].divide(SizedBox(width: 8.0)),
          ),
        ),
      ),
    );
  }
}
