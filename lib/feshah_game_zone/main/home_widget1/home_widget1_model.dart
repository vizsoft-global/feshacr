import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'home_widget1_widget.dart' show HomeWidget1Widget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeWidget1Model extends FlutterFlowModel<HomeWidget1Widget> {
  ///  Local state fields for this component.

  int? count = 1;

  int? randomNum;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<RoomRecord>? authRoomResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
