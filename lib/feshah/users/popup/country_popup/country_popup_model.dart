import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'country_popup_widget.dart' show CountryPopupWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CountryPopupModel extends FlutterFlowModel<CountryPopupWidget> {
  ///  Local state fields for this component.

  String countryName = 'Kuwait';

  bool setStatus = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for country widget.
  String? countryValue;
  FormFieldController<String>? countryValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
