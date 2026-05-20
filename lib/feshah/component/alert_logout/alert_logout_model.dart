import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'alert_logout_widget.dart' show AlertLogoutWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AlertLogoutModel extends FlutterFlowModel<AlertLogoutWidget> {
  ///  Local state fields for this component.

  int? countGame;

  List<SelectedGameListStruct> selectedGameList = [];
  void addToSelectedGameList(SelectedGameListStruct item) =>
      selectedGameList.add(item);
  void removeFromSelectedGameList(SelectedGameListStruct item) =>
      selectedGameList.remove(item);
  void removeAtIndexFromSelectedGameList(int index) =>
      selectedGameList.removeAt(index);
  void insertAtIndexInSelectedGameList(
          int index, SelectedGameListStruct item) =>
      selectedGameList.insert(index, item);
  void updateSelectedGameListAtIndex(
          int index, Function(SelectedGameListStruct) updateFn) =>
      selectedGameList[index] = updateFn(selectedGameList[index]);

  int? countUser;

  List<RoomUserListStruct> selectedUserList = [];
  void addToSelectedUserList(RoomUserListStruct item) =>
      selectedUserList.add(item);
  void removeFromSelectedUserList(RoomUserListStruct item) =>
      selectedUserList.remove(item);
  void removeAtIndexFromSelectedUserList(int index) =>
      selectedUserList.removeAt(index);
  void insertAtIndexInSelectedUserList(int index, RoomUserListStruct item) =>
      selectedUserList.insert(index, item);
  void updateSelectedUserListAtIndex(
          int index, Function(RoomUserListStruct) updateFn) =>
      selectedUserList[index] = updateFn(selectedUserList[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
