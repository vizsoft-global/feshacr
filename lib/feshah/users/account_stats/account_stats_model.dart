import '/auth/firebase_auth/auth_util.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'account_stats_widget.dart' show AccountStatsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccountStatsModel extends FlutterFlowModel<AccountStatsWidget> {
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
