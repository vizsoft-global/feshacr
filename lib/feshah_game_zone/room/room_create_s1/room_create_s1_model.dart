import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'room_create_s1_widget.dart' show RoomCreateS1Widget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RoomCreateS1Model extends FlutterFlowModel<RoomCreateS1Widget> {
  ///  Local state fields for this page.

  int? refresh = 1;

  int? randomNum;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;
  // State field(s) for roomname widget.
  FocusNode? roomnameFocusNode;
  TextEditingController? roomnameTextController;
  String? Function(BuildContext, String?)? roomnameTextControllerValidator;
  String? _roomnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'revzkbwf' /* What should we call your room? */,
      );
    }

    return null;
  }

  // State field(s) for memberlimitsDD widget.
  String? memberlimitsDDValue;
  FormFieldController<String>? memberlimitsDDValueController;
  // State field(s) for Checkbox-RoomWallet widget.
  bool? checkboxRoomWalletValue;
  // Stores action output result for [Firestore Query - Query a collection] action in createRoom widget.
  int? roomCountResult1;
  // Stores action output result for [Firestore Query - Query a collection] action in createRoom widget.
  IDmapRecord? idmapRoomResult;
  // Stores action output result for [Firestore Query - Query a collection] action in createRoom widget.
  SettingsRecord? settingsAppLunchTimeResult;
  // Stores action output result for [Backend Call - Create Document] action in createRoom widget.
  RoomRecord? newRoomResult;

  @override
  void initState(BuildContext context) {
    userStatusCheckerModel =
        createModel(context, () => UserStatusCheckerModel());
    roomnameTextControllerValidator = _roomnameTextControllerValidator;
  }

  @override
  void dispose() {
    userStatusCheckerModel.dispose();
    roomnameFocusNode?.dispose();
    roomnameTextController?.dispose();
  }
}
