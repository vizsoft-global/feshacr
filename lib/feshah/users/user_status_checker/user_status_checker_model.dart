import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah/update_notifier/app_update_checker/app_update_checker_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'user_status_checker_widget.dart' show UserStatusCheckerWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserStatusCheckerModel extends FlutterFlowModel<UserStatusCheckerWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in user_status_checker widget.
  SettingsRecord? forInappResult1;
  // Model for App_Update_Checker component.
  late AppUpdateCheckerModel appUpdateCheckerModel;

  @override
  void initState(BuildContext context) {
    appUpdateCheckerModel = createModel(context, () => AppUpdateCheckerModel());
  }

  @override
  void dispose() {
    appUpdateCheckerModel.dispose();
  }
}
