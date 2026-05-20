import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah_game_zone/main/q_r_question/q_r_question_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'home_q_r_widget.dart' show HomeQRWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class HomeQRModel extends FlutterFlowModel<HomeQRWidget> {
  ///  Local state fields for this component.

  int? refresh = 1;

  List<String> qrValue = [];
  void addToQrValue(String item) => qrValue.add(item);
  void removeFromQrValue(String item) => qrValue.remove(item);
  void removeAtIndexFromQrValue(int index) => qrValue.removeAt(index);
  void insertAtIndexInQrValue(int index, String item) =>
      qrValue.insert(index, item);
  void updateQrValueAtIndex(int index, Function(String) updateFn) =>
      qrValue[index] = updateFn(qrValue[index]);

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

  List<RoomUserListStruct> roomUserList = [];
  void addToRoomUserList(RoomUserListStruct item) => roomUserList.add(item);
  void removeFromRoomUserList(RoomUserListStruct item) =>
      roomUserList.remove(item);
  void removeAtIndexFromRoomUserList(int index) => roomUserList.removeAt(index);
  void insertAtIndexInRoomUserList(int index, RoomUserListStruct item) =>
      roomUserList.insert(index, item);
  void updateRoomUserListAtIndex(
          int index, Function(RoomUserListStruct) updateFn) =>
      roomUserList[index] = updateFn(roomUserList[index]);

  List<RoomUserListStruct> gameUserList = [];
  void addToGameUserList(RoomUserListStruct item) => gameUserList.add(item);
  void removeFromGameUserList(RoomUserListStruct item) =>
      gameUserList.remove(item);
  void removeAtIndexFromGameUserList(int index) => gameUserList.removeAt(index);
  void insertAtIndexInGameUserList(int index, RoomUserListStruct item) =>
      gameUserList.insert(index, item);
  void updateGameUserListAtIndex(
          int index, Function(RoomUserListStruct) updateFn) =>
      gameUserList[index] = updateFn(gameUserList[index]);

  int? roomID;

  int? selectGameID;

  ///  State fields for stateful widgets in this component.

  var scanResult = '';
  // Stores action output result for [Firestore Query - Query a collection] action in Image widget.
  RoomRecord? qrScannerResultMob;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
