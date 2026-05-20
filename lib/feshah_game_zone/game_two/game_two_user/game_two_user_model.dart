import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import 'game_two_user_widget.dart' show GameTwoUserWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GameTwoUserModel extends FlutterFlowModel<GameTwoUserWidget> {
  ///  Local state fields for this component.

  String addStatus = 'pending';

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

  List<GameSAUStruct> gameSAU = [];
  void addToGameSAU(GameSAUStruct item) => gameSAU.add(item);
  void removeFromGameSAU(GameSAUStruct item) => gameSAU.remove(item);
  void removeAtIndexFromGameSAU(int index) => gameSAU.removeAt(index);
  void insertAtIndexInGameSAU(int index, GameSAUStruct item) =>
      gameSAU.insert(index, item);
  void updateGameSAUAtIndex(int index, Function(GameSAUStruct) updateFn) =>
      gameSAU[index] = updateFn(gameSAU[index]);

  int? indexSAU;

  int? voteCount;

  List<GameSAUVoteUserStruct> voteList = [];
  void addToVoteList(GameSAUVoteUserStruct item) => voteList.add(item);
  void removeFromVoteList(GameSAUVoteUserStruct item) => voteList.remove(item);
  void removeAtIndexFromVoteList(int index) => voteList.removeAt(index);
  void insertAtIndexInVoteList(int index, GameSAUVoteUserStruct item) =>
      voteList.insert(index, item);
  void updateVoteListAtIndex(
          int index, Function(GameSAUVoteUserStruct) updateFn) =>
      voteList[index] = updateFn(voteList[index]);

  int? userCount;

  List<RoomUserListStruct> userList = [];
  void addToUserList(RoomUserListStruct item) => userList.add(item);
  void removeFromUserList(RoomUserListStruct item) => userList.remove(item);
  void removeAtIndexFromUserList(int index) => userList.removeAt(index);
  void insertAtIndexInUserList(int index, RoomUserListStruct item) =>
      userList.insert(index, item);
  void updateUserListAtIndex(
          int index, Function(RoomUserListStruct) updateFn) =>
      userList[index] = updateFn(userList[index]);

  int? countGame;

  String? userFoundStatus;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Vote_ON widget.
  IDmapRecord? idmapResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Remove widget.
  NotificationRecord? notificationResultRemove;
  // Stores action output result for [Firestore Query - Query a collection] action in Add widget.
  int? notificationResultNew;
  // Stores action output result for [Firestore Query - Query a collection] action in Add widget.
  GameRecord? gameResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Add widget.
  IDmapRecord? idmapNotificationResult2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
