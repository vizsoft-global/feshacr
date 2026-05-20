import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sound_popup_model.dart';
export 'sound_popup_model.dart';

class SoundPopupWidget extends StatefulWidget {
  const SoundPopupWidget({super.key});

  @override
  State<SoundPopupWidget> createState() => _SoundPopupWidgetState();
}

class _SoundPopupWidgetState extends State<SoundPopupWidget> {
  late SoundPopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SoundPopupModel());

    _model.switchValue = currentUserDocument!.userSetting.isSoundstatus;
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
            border: Border.all(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'rc0ihdt5' /* Sound */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                        AuthUserStreamWidget(
                          builder: (context) => Switch.adaptive(
                            value: _model.switchValue!,
                            onChanged: (newValue) async {
                              safeSetState(
                                  () => _model.switchValue = newValue!);
                              if (newValue!) {
                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  userSetting: createUserSettingStruct(
                                    isSoundstatus: true,
                                    clearUnsetFields: false,
                                  ),
                                ));
                                Navigator.pop(context);
                              } else {
                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  userSetting: createUserSettingStruct(
                                    isSoundstatus: false,
                                    clearUnsetFields: false,
                                  ),
                                ));
                                Navigator.pop(context);
                              }
                            },
                            activeColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            activeTrackColor:
                                FlutterFlowTheme.of(context).primary,
                            inactiveTrackColor:
                                FlutterFlowTheme.of(context).alternate,
                            inactiveThumbColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
