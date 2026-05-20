import '/feshah/onboard/social/social_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'signin_phone_widget.dart' show SigninPhoneWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SigninPhoneModel extends FlutterFlowModel<SigninPhoneWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for Social component.
  late SocialModel socialModel;
  // State field(s) for mobilenumber widget.
  FocusNode? mobilenumberFocusNode;
  TextEditingController? mobilenumberTextController;
  String? Function(BuildContext, String?)? mobilenumberTextControllerValidator;
  String? _mobilenumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'fux81q23' /* Field is required */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'yah8pf7w' /* Check your email! */,
      );
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    socialModel = createModel(context, () => SocialModel());
    mobilenumberTextControllerValidator = _mobilenumberTextControllerValidator;
  }

  @override
  void dispose() {
    socialModel.dispose();
    mobilenumberFocusNode?.dispose();
    mobilenumberTextController?.dispose();
  }
}
