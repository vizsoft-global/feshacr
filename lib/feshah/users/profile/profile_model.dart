import '/auth/firebase_auth/auth_util.dart';
import '/feshah/users/address_popup/address_popup_widget.dart';
import '/feshah/users/popup/country_popup/country_popup_widget.dart';
import '/feshah/users/popup/language_popup/language_popup_widget.dart';
import '/feshah/users/popup/notification_popup/notification_popup_widget.dart';
import '/feshah/users/popup/sound_popup/sound_popup_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;

  @override
  void initState(BuildContext context) {
    userStatusCheckerModel =
        createModel(context, () => UserStatusCheckerModel());
  }

  @override
  void dispose() {
    userStatusCheckerModel.dispose();
  }
}
