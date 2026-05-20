import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/index.dart';
import 'notfy_room_request_notification_widget.dart'
    show NotfyRoomRequestNotificationWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotfyRoomRequestNotificationModel
    extends FlutterFlowModel<NotfyRoomRequestNotificationWidget> {
  ///  Local state fields for this component.

  int? count;

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

  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  RoomRecord? roomResult1;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  RoomRecord? roomResultDecline;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
