import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'coupon_widget.dart' show CouponWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CouponModel extends FlutterFlowModel<CouponWidget> {
  ///  Local state fields for this component.

  double? couponPrice;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for coupon_code widget.
  FocusNode? couponCodeFocusNode;
  TextEditingController? couponCodeTextController;
  String? Function(BuildContext, String?)? couponCodeTextControllerValidator;
  String? _couponCodeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '8ikaqakj' /* *code is required */,
      );
    }

    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  CouponRecord? couponResult1;

  @override
  void initState(BuildContext context) {
    couponCodeTextControllerValidator = _couponCodeTextControllerValidator;
  }

  @override
  void dispose() {
    couponCodeFocusNode?.dispose();
    couponCodeTextController?.dispose();
  }
}
