import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'social_widget.dart' show SocialWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SocialModel extends FlutterFlowModel<SocialWidget> {
  ///  Local state fields for this component.

  String googleStatus = 'hide';

  String appleStatus = 'hide';

  int? randomINT;

  int? refresh = 1;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in SignIN widget.
  SettingsRecord? settingsAppLunchTimeGresult;
  // Stores action output result for [Firestore Query - Query a collection] action in SignIN widget.
  int? userResult1;
  // Stores action output result for [Firestore Query - Query a collection] action in SignIN widget.
  SettingsRecord? forInappGoogle;
  // Stores action output result for [Firestore Query - Query a collection] action in Apple widget.
  SettingsRecord? settingsAppLunchTimeAresult;
  // Stores action output result for [Firestore Query - Query a collection] action in Apple widget.
  int? userResult2;
  // Stores action output result for [Firestore Query - Query a collection] action in Apple widget.
  SettingsRecord? forInappApple;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
