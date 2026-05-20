import '/feshah/component/app_language/app_language_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'welcome_widget.dart' show WelcomeWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WelcomeModel extends FlutterFlowModel<WelcomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for app_language component.
  late AppLanguageModel appLanguageModel;

  @override
  void initState(BuildContext context) {
    appLanguageModel = createModel(context, () => AppLanguageModel());
  }

  @override
  void dispose() {
    appLanguageModel.dispose();
  }
}
