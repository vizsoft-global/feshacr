import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah/component/app_language/app_language_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'edit_profile_widget.dart' show EditProfileWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class EditProfileModel extends FlutterFlowModel<EditProfileWidget> {
  ///  Local state fields for this page.

  String countyName = 'Kuwait';

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for app_language component.
  late AppLanguageModel appLanguageModel;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '1gveeodr' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'h29533gv' /* Name is required and cannot be... */,
      );
    }

    if (val.length > 25) {
      return FFLocalizations.of(context).getText(
        'x19t20mm' /* Maximum characters exceded */,
      );
    }

    return null;
  }

  DateTime? datePicked;
  // State field(s) for countryMain widget.
  String? countryMainValue;
  FormFieldController<String>? countryMainValueController;
  // State field(s) for phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  String? _phoneTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'jp6xvuoj' /* Mobile number is required */,
      );
    }

    return null;
  }

  // State field(s) for GenderStatus widget.
  FormFieldController<String>? genderStatusValueController;
  // State field(s) for offersStatus widget.
  bool? offersStatusValue;
  // State field(s) for newsletterStatus widget.
  bool? newsletterStatusValue;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? userPhoneExistsingResult;

  @override
  void initState(BuildContext context) {
    appLanguageModel = createModel(context, () => AppLanguageModel());
    emailTextControllerValidator = _emailTextControllerValidator;
    nameTextControllerValidator = _nameTextControllerValidator;
    phoneTextControllerValidator = _phoneTextControllerValidator;
  }

  @override
  void dispose() {
    appLanguageModel.dispose();
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    nameFocusNode?.dispose();
    nameTextController?.dispose();

    phoneFocusNode?.dispose();
    phoneTextController?.dispose();
  }

  /// Additional helper methods.
  String? get genderStatusValue => genderStatusValueController?.value;
}
