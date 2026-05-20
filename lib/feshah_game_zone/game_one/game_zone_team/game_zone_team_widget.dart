import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_zone_team_model.dart';
export 'game_zone_team_model.dart';

class GameZoneTeamWidget extends StatefulWidget {
  const GameZoneTeamWidget({
    super.key,
    this.room,
    this.index,
    this.selectedIndex,
  });

  final RoomRecord? room;
  final int? index;
  final int? selectedIndex;

  @override
  State<GameZoneTeamWidget> createState() => _GameZoneTeamWidgetState();
}

class _GameZoneTeamWidgetState extends State<GameZoneTeamWidget> {
  late GameZoneTeamModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameZoneTeamModel());

    _model.mainListTeamNameTextController ??= TextEditingController();
    _model.mainListTeamNameFocusNode ??= FocusNode();

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
      child: Stack(
        alignment: AlignmentDirectional(0.0, -1.0),
        children: [
          TextFormField(
            controller: _model.mainListTeamNameTextController,
            focusNode: _model.mainListTeamNameFocusNode,
            autofocus: false,
            obscureText: false,
            decoration: InputDecoration(
              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                    font: GoogleFonts.almarai(
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  ),
              hintText: '${FFLocalizations.of(context).getVariableText(
                enText: 'Enter team',
                arText: 'أدخل اسم الفريق',
              )}${() {
                if (widget!.index! >= 2) {
                  return FFLocalizations.of(context).getVariableText(
                    enText: 'C',
                    arText: 'ج',
                  );
                } else if (widget!.index == 1) {
                  return FFLocalizations.of(context).getVariableText(
                    enText: 'B',
                    arText: 'ب',
                  );
                } else {
                  return FFLocalizations.of(context).getVariableText(
                    enText: 'A',
                    arText: 'أ',
                  );
                }
              }()}${FFLocalizations.of(context).getVariableText(
                enText: ' Name...',
                arText: '',
              )}',
              hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.almarai(
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
              fillColor: FlutterFlowTheme.of(context).primaryBackground,
              contentPadding:
                  EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 100.0, 0.0),
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
            maxLength: 30,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                null,
            validator: _model.mainListTeamNameTextControllerValidator
                .asValidator(context),
          ),
          Align(
            alignment: AlignmentDirectional(1.0, -1.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 8.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  var _shouldSetState = false;
                  if (_model.formKey.currentState == null ||
                      !_model.formKey.currentState!.validate()) {
                    return;
                  }
                  if (widget!.room!.selectedGameList
                          .elementAtOrNull(widget!.selectedIndex!)!
                          .teamInfo
                          .length <
                      3) {
                    _model.countTeam = (widget!.room?.selectedGameList
                            ?.elementAtOrNull(widget!.selectedIndex!))
                        ?.teamInfo
                        ?.length;
                    _model.selectedTeamList = widget!.room!.selectedGameList
                        .elementAtOrNull(widget!.selectedIndex!)!
                        .teamInfo
                        .toList()
                        .cast<TeamInfoStruct>();
                    _model.selectedGameList = widget!.room!.selectedGameList
                        .toList()
                        .cast<SelectedGameListStruct>();
                    if (_model.countTeam! > 0) {
                      while (_model.countTeam! > 0) {
                        if (_model.selectedTeamList
                                .elementAtOrNull((_model.countTeam!) - 1)
                                ?.teamInfo
                                ?.name ==
                            _model.mainListTeamNameTextController.text) {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return WebViewAware(
                                child: AlertDialog(
                                  content: Text(FFLocalizations.of(context)
                                      .getVariableText(
                                    enText: 'Team names must be different.',
                                    arText: 'لقد تم تشكيل الفريق بالفعل.',
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
                        _model.countTeam = (_model.countTeam!) - 1;
                      }
                    }
                    _model.idmapTeamResult = await queryIDmapRecordOnce(
                      queryBuilder: (iDmapRecord) => iDmapRecord.where(
                        'type',
                        isEqualTo: 'Main',
                      ),
                      singleRecord: true,
                    ).then((s) => s.firstOrNull);
                    _shouldSetState = true;
                    _model.updateSelectedGameListAtIndex(
                      widget!.selectedIndex!,
                      (e) => e
                        ..updateTeamInfo(
                          (e) => e.add(TeamInfoStruct(
                            createdAt: getCurrentTimestamp,
                            updatedAt: getCurrentTimestamp,
                            teamStatus: 'active',
                            teamID: _model.idmapTeamResult?.teamId,
                            teamInfo: MainInfoStruct(
                              name: _model.mainListTeamNameTextController.text,
                            ),
                            totalResult: 0,
                          )),
                        ),
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

                    await _model.idmapTeamResult!.reference.update({
                      ...mapToFirestore(
                        {
                          'team_id': FieldValue.increment(1),
                        },
                      ),
                    });
                    safeSetState(() {
                      _model.mainListTeamNameTextController?.clear();
                    });
                    FFAppState()
                        .removeAtIndexFromTeamInputFields(widget!.index!);
                    FFAppState().update(() {});
                  }
                  if (_shouldSetState) safeSetState(() {});
                },
                child: Text(
                  FFLocalizations.of(context).getText(
                    'dlsdmnjf' /* Save */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.almarai(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).tertiary,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
