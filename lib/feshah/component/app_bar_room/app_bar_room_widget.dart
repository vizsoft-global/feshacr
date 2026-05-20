import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'app_bar_room_model.dart';
export 'app_bar_room_model.dart';

class AppBarRoomWidget extends StatefulWidget {
  const AppBarRoomWidget({
    super.key,
    required this.room,
    bool? roomNormalNav,
    bool? roomAdminNav,
    String? backStatus,
  })  : this.roomNormalNav = roomNormalNav ?? false,
        this.roomAdminNav = roomAdminNav ?? false,
        this.backStatus = backStatus ?? 'black';

  final DocumentReference? room;
  final bool roomNormalNav;
  final bool roomAdminNav;
  final String backStatus;

  @override
  State<AppBarRoomWidget> createState() => _AppBarRoomWidgetState();
}

class _AppBarRoomWidgetState extends State<AppBarRoomWidget> {
  late AppBarRoomModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppBarRoomModel());

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
            if (widget!.backStatus == 'white')
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.white,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
            if (widget!.backStatus == 'black')
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                icon: Icon(
                  Icons.chevron_left_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
            if (widget!.roomAdminNav == true)
              FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                icon: Icon(
                  Icons.keyboard_control,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.goNamed(
                    RoomCreateS2Widget.routeName,
                    queryParameters: {
                      'room': serializeParam(
                        widget!.room,
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
                  );
                },
              ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthUserStreamWidget(
                    builder: (context) => Text(
                      valueOrDefault<String>(
                        currentUserDisplayName,
                        '-',
                      ),
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.almarai(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  AuthUserStreamWidget(
                    builder: (context) => Text(
                      '${FFLocalizations.of(context).getVariableText(
                        enText: 'Player ID: ',
                        arText: 'معرف اللاعب:',
                      )}${valueOrDefault(currentUserDocument?.userId, 0).toString()}',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.almarai(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
            ),
            if (widget!.roomNormalNav == true)
              FFButtonWidget(
                onPressed: () async {
                  _model.roomResult1 =
                      await RoomRecord.getDocumentOnce(widget!.room!);
                  if (_model.roomResult1?.roomCreatedUserRef ==
                      currentUserReference) {
                    await widget!.room!.update(createRoomRecordData(
                      roomPresentStatus: 'exit',
                    ));

                    context.goNamed(HomeWidget.routeName);
                  } else {
                    _model.count = _model.roomResult1?.roomUserList?.length;
                    _model.userIDList = _model.roomResult1!.roomUserList
                        .toList()
                        .cast<RoomUserListStruct>();
                    while (_model.count! > 0) {
                      if (_model.userIDList
                              .elementAtOrNull((_model.count!) - 1)
                              ?.roomUserRef ==
                          currentUserReference) {
                        _model.updateUserIDListAtIndex(
                          (_model.count!) - 1,
                          (e) => e..roomUserOnlineStatus = 'deactive',
                        );
                      }
                      _model.count = (_model.count!) - 1;
                    }

                    await widget!.room!.update({
                      ...mapToFirestore(
                        {
                          'room_user_list': getRoomUserListListFirestoreData(
                            _model.userIDList,
                          ),
                        },
                      ),
                    });

                    context.goNamed(HomeWidget.routeName);
                  }

                  safeSetState(() {});
                },
                text: FFLocalizations.of(context).getText(
                  '7y52pz6m' /* Exit Room */,
                ),
                icon: Icon(
                  FFIcons.kfi8,
                  size: 15.0,
                ),
                options: FFButtonOptions(
                  height: 30.0,
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                  iconAlignment: IconAlignment.end,
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Gentona Medium',
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
          ].divide(SizedBox(width: 12.0)),
        ),
      ],
    );
  }
}
