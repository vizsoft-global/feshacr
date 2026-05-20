import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah/update_notifier/app_updater_popup_android/app_updater_popup_android_widget.dart';
import '/feshah/update_notifier/app_updater_popup_i_o_s/app_updater_popup_i_o_s_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'app_update_checker_widget.dart' show AppUpdateCheckerWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class AppUpdateCheckerModel extends FlutterFlowModel<AppUpdateCheckerWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in App_Update_Checker widget.
  SettingsRecord? appVersionResultAndroid;
  // Stores action output result for [Firestore Query - Query a collection] action in App_Update_Checker widget.
  SettingsRecord? appVersionResultIOS;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
