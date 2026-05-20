import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:styled_divider/styled_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_roomlist_model.dart';
export 'home_roomlist_model.dart';

class HomeRoomlistWidget extends StatefulWidget {
  const HomeRoomlistWidget({
    super.key,
    required this.room,
  });

  final RoomRecord? room;

  @override
  State<HomeRoomlistWidget> createState() => _HomeRoomlistWidgetState();
}

class _HomeRoomlistWidgetState extends State<HomeRoomlistWidget> {
  late HomeRoomlistModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeRoomlistModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        if (widget!.room?.roomCreatedUserRef == currentUserReference) {
          await widget!.room!.reference.update(createRoomRecordData(
            roomStatus: 'active',
            roomUpdatedAt: getCurrentTimestamp,
            roomPresentStatus: 'space',
          ));

          context.pushNamed(
            RoomSpaceWidget.routeName,
            queryParameters: {
              'room': serializeParam(
                widget!.room?.reference,
                ParamType.DocumentReference,
              ),
            }.withoutNulls,
          );

          _model.authRoomResult = await queryRoomRecordOnce(
            queryBuilder: (roomRecord) => roomRecord
                .where(
                  'room_created_userRef',
                  isEqualTo: currentUserReference,
                )
                .where(
                  'room_status',
                  isEqualTo: 'active',
                ),
          );
          _model.count = _model.authRoomResult?.length;
          if (_model.count! > 0) {
            while (_model.count! > 0) {
              await _model.authRoomResult!
                  .elementAtOrNull((_model.count!) - 1)!
                  .reference
                  .update(createRoomRecordData(
                    roomPresentStatus: 'deactive',
                    roomUpdatedAt: getCurrentTimestamp,
                  ));
              _model.count = (_model.count!) - 1;
            }
          }
        } else {
          context.pushNamed(
            RoomSpaceWidget.routeName,
            queryParameters: {
              'room': serializeParam(
                widget!.room?.reference,
                ParamType.DocumentReference,
              ),
            }.withoutNulls,
          );
        }

        safeSetState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primaryText,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/yhgsr_.png',
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget!.room!.roomMainInfo.name,
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.almarai(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                    Text(
                      '${valueOrDefault<String>(
                        widget!.room?.roomUserList
                            ?.where((e) => e.roomUserStatus == 'active')
                            .toList()
                            ?.length
                            ?.toString(),
                        ' 0',
                      )}   ${FFLocalizations.of(context).getVariableText(
                        enText: ' Players inside',
                        arText: 'اللاعبين في الداخل',
                      )}',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.almarai(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
                tabletLandscape: false,
                desktop: false,
              ))
                SizedBox(
                  height: 32.0,
                  child: StyledVerticalDivider(
                    width: 4.0,
                    thickness: 1.0,
                    color: Color(0xFF676767),
                    lineStyle: DividerLineStyle.dashed,
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
                tabletLandscape: false,
                desktop: false,
              ))
                FFButtonWidget(
                  onPressed: () {
                    print('Room pressed ...');
                  },
                  text: FFLocalizations.of(context).getText(
                    '2ysvxkxx' /* View */,
                  ),
                  options: FFButtonOptions(
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.almarai(
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                icon: Icon(
                  Icons.more_vert,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  if (widget!.room?.roomCreatedUserRef ==
                      currentUserReference) {
                    await widget!.room!.reference.update(createRoomRecordData(
                      roomStatus: 'active',
                      roomUpdatedAt: getCurrentTimestamp,
                    ));

                    context.pushNamed(
                      RoomCreateS2Widget.routeName,
                      queryParameters: {
                        'room': serializeParam(
                          widget!.room?.reference,
                          ParamType.DocumentReference,
                        ),
                      }.withoutNulls,
                    );
                  } else {
                    context.pushNamed(
                      RoomSpaceWidget.routeName,
                      queryParameters: {
                        'room': serializeParam(
                          widget!.room?.reference,
                          ParamType.DocumentReference,
                        ),
                      }.withoutNulls,
                    );
                  }
                },
              ),
            ].divide(SizedBox(width: 8.0)),
          ),
        ),
      ),
    );
  }
}
