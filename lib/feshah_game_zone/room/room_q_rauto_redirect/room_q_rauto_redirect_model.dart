import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'room_q_rauto_redirect_widget.dart' show RoomQRautoRedirectWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class RoomQRautoRedirectModel
    extends FlutterFlowModel<RoomQRautoRedirectWidget> {
  ///  Local state fields for this component.

  List<SelectedGameListStruct> gameList = [];
  void addToGameList(SelectedGameListStruct item) => gameList.add(item);
  void removeFromGameList(SelectedGameListStruct item) => gameList.remove(item);
  void removeAtIndexFromGameList(int index) => gameList.removeAt(index);
  void insertAtIndexInGameList(int index, SelectedGameListStruct item) =>
      gameList.insert(index, item);
  void updateGameListAtIndex(
          int index, Function(SelectedGameListStruct) updateFn) =>
      gameList[index] = updateFn(gameList[index]);

  int? countGame;

  List<RoomUserListStruct> userList = [];
  void addToUserList(RoomUserListStruct item) => userList.add(item);
  void removeFromUserList(RoomUserListStruct item) => userList.remove(item);
  void removeAtIndexFromUserList(int index) => userList.removeAt(index);
  void insertAtIndexInUserList(int index, RoomUserListStruct item) =>
      userList.insert(index, item);
  void updateUserListAtIndex(
          int index, Function(RoomUserListStruct) updateFn) =>
      userList[index] = updateFn(userList[index]);

  List<RoomUserListStruct> gmaeUserList = [];
  void addToGmaeUserList(RoomUserListStruct item) => gmaeUserList.add(item);
  void removeFromGmaeUserList(RoomUserListStruct item) =>
      gmaeUserList.remove(item);
  void removeAtIndexFromGmaeUserList(int index) => gmaeUserList.removeAt(index);
  void insertAtIndexInGmaeUserList(int index, RoomUserListStruct item) =>
      gmaeUserList.insert(index, item);
  void updateGmaeUserListAtIndex(
          int index, Function(RoomUserListStruct) updateFn) =>
      gmaeUserList[index] = updateFn(gmaeUserList[index]);

  List<String> qrValue = [];
  void addToQrValue(String item) => qrValue.add(item);
  void removeFromQrValue(String item) => qrValue.remove(item);
  void removeAtIndexFromQrValue(int index) => qrValue.removeAt(index);
  void insertAtIndexInQrValue(int index, String item) =>
      qrValue.insert(index, item);
  void updateQrValueAtIndex(int index, Function(String) updateFn) =>
      qrValue[index] = updateFn(qrValue[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Room_QRautoRedirect widget.
  RoomRecord? qrScannerResultMob;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
