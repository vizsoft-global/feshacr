import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'user_new_widget_widget.dart' show UserNewWidgetWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class UserNewWidgetModel extends FlutterFlowModel<UserNewWidgetWidget> {
  ///  Local state fields for this component.

  String addStatus = 'pending';

  List<RoomUserListStruct> userList = [];
  void addToUserList(RoomUserListStruct item) => userList.add(item);
  void removeFromUserList(RoomUserListStruct item) => userList.remove(item);
  void removeAtIndexFromUserList(int index) => userList.removeAt(index);
  void insertAtIndexInUserList(int index, RoomUserListStruct item) =>
      userList.insert(index, item);
  void updateUserListAtIndex(
          int index, Function(RoomUserListStruct) updateFn) =>
      userList[index] = updateFn(userList[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Add widget.
  IDmapRecord? idmapNotificationResult1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
