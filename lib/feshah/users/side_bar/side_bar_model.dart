import '/auth/firebase_auth/auth_util.dart';
import '/feshah/component/alert_logout/alert_logout_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_language_selector.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'side_bar_widget.dart' show SideBarWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class SideBarModel extends FlutterFlowModel<SideBarWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Expandable-en widget.
  late ExpandableController expandableEnExpandableController;

  // State field(s) for Expandable-ar widget.
  late ExpandableController expandableArExpandableController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableEnExpandableController.dispose();
    expandableArExpandableController.dispose();
  }
}
