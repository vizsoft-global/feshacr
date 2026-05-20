import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'country_popup_model.dart';
export 'country_popup_model.dart';

class CountryPopupWidget extends StatefulWidget {
  const CountryPopupWidget({super.key});

  @override
  State<CountryPopupWidget> createState() => _CountryPopupWidgetState();
}

class _CountryPopupWidgetState extends State<CountryPopupWidget> {
  late CountryPopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CountryPopupModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (_model.setStatus == false) {
        if (valueOrDefault(currentUserDocument?.country, '') != '') {
          safeSetState(() {
            _model.countryValueController?.value =
                valueOrDefault(currentUserDocument?.country, '');
            _model.countryValue =
                valueOrDefault(currentUserDocument?.country, '');
          });
          _model.countryName = valueOrDefault(currentUserDocument?.country, '');
          _model.setStatus = true;
          safeSetState(() {});
        } else {
          _model.countryName = 'Kuwait';
          _model.setStatus = true;
          safeSetState(() {});
          safeSetState(() {
            _model.countryValueController?.value = 'Kuwait';
            _model.countryValue = 'Kuwait';
          });
        }
      }
    });

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
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          safeSetState(() {
            _model.countryValueController?.value =
                valueOrDefault(currentUserDocument?.country, '');
            _model.countryValue =
                valueOrDefault(currentUserDocument?.country, '');
          });
        },
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
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 120.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'efc75ntc' /* Country */,
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
                            Expanded(
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: FlutterFlowDropDown<String>(
                                          controller:
                                              _model.countryValueController ??=
                                                  FormFieldController<String>(
                                            _model.countryValue ??=
                                                _model.countryName,
                                          ),
                                          options: functions.getCountrList(),
                                          onChanged: (val) async {
                                            safeSetState(() =>
                                                _model.countryValue = val);
                                            Navigator.pop(context);
                                          },
                                          width: double.infinity,
                                          height: 45.0,
                                          maxHeight: 100.0,
                                          searchHintTextStyle:
                                              GoogleFonts.almarai(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                          searchTextStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.almarai(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
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
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.almarai(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
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
                                          hintText: FFLocalizations.of(context)
                                              .getText(
                                            'yxo53hu2' /* Please select... */,
                                          ),
                                          searchHintText:
                                              FFLocalizations.of(context)
                                                  .getText(
                                            'e7zryddu' /* Search... */,
                                          ),
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          elevation: 0.0,
                                          borderColor: Colors.transparent,
                                          borderWidth: 0.0,
                                          borderRadius: 0.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  65.0, 4.0, 12.0, 4.0),
                                          hidesUnderline: true,
                                          isOverButton: false,
                                          isSearchable: true,
                                          isMultiSelect: false,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, -1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 12.0, 8.0, 8.0),
                                        child: Image.network(
                                          functions.getCountryFlag(
                                              _model.countryValue)!,
                                          width: 35.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ),
                    ].divide(SizedBox(width: 24.0)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
