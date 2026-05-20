import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_widget1_model.dart';
export 'home_widget1_model.dart';

class HomeWidget1Widget extends StatefulWidget {
  const HomeWidget1Widget({
    super.key,
    required this.buttonbackgroundcolor,
    required this.buttonicon,
    required this.buttontext,
    required this.type,
  });

  final Color? buttonbackgroundcolor;
  final Widget? buttonicon;
  final String? buttontext;
  final String? type;

  @override
  State<HomeWidget1Widget> createState() => _HomeWidget1WidgetState();
}

class _HomeWidget1WidgetState extends State<HomeWidget1Widget> {
  late HomeWidget1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeWidget1Model());

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
        FFAppState().deleteUserflow();
        FFAppState().userflow = UserflowStruct();

        if (widget!.type == 'create') {
          context.pushNamed(RoomCreateS1Widget.routeName);
        } else {
          if (widget!.type == 'join') {
            _model.authRoomResult = await queryRoomRecordOnce(
              queryBuilder: (roomRecord) => roomRecord.where(
                'room_created_userRef',
                isEqualTo: currentUserReference,
              ),
            );
            _model.count = _model.authRoomResult?.length;
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

            context.pushNamed(RoomJoinWidget.routeName);
          }
        }

        safeSetState(() {});
      },
      child: Container(
        width: 500.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: widget!.buttonbackgroundcolor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primaryText,
            width: 0.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget!.buttonicon!,
            Text(
              valueOrDefault<String>(
                widget!.buttontext,
                'buttontext',
              ),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.almarai(
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ].divide(SizedBox(height: 8.0)),
        ),
      ),
    );
  }
}
