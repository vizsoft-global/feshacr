import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'app_bar_room_widget.dart' show AppBarRoomWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppBarRoomModel extends FlutterFlowModel<AppBarRoomWidget> {
  ///  Local state fields for this component.

  int? count;

  List<RoomUserListStruct> userIDList = [];
  void addToUserIDList(RoomUserListStruct item) => userIDList.add(item);
  void removeFromUserIDList(RoomUserListStruct item) => userIDList.remove(item);
  void removeAtIndexFromUserIDList(int index) => userIDList.removeAt(index);
  void insertAtIndexInUserIDList(int index, RoomUserListStruct item) =>
      userIDList.insert(index, item);
  void updateUserIDListAtIndex(
          int index, Function(RoomUserListStruct) updateFn) =>
      userIDList[index] = updateFn(userIDList[index]);

  int? refresh;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  RoomRecord? roomResult1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
