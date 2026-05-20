import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah_game_zone/main/home_roomlist/home_roomlist_widget.dart';
import '/feshah_game_zone/main/home_widget1/home_widget1_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'home_widget2_widget.dart' show HomeWidget2Widget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeWidget2Model extends FlutterFlowModel<HomeWidget2Widget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Model for CreateaRoom.
  late HomeWidget1Model createaRoomModel;
  // Model for JoinaRoom.
  late HomeWidget1Model joinaRoomModel;

  @override
  void initState(BuildContext context) {
    createaRoomModel = createModel(context, () => HomeWidget1Model());
    joinaRoomModel = createModel(context, () => HomeWidget1Model());
  }

  @override
  void dispose() {
    createaRoomModel.dispose();
    joinaRoomModel.dispose();
  }
}
