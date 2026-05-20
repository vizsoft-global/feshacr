import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/index.dart';
import 'game_exit_widget.dart' show GameExitWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GameExitModel extends FlutterFlowModel<GameExitWidget> {
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

  int? roundCount;

  List<GameSAUStruct> roundList = [];
  void addToRoundList(GameSAUStruct item) => roundList.add(item);
  void removeFromRoundList(GameSAUStruct item) => roundList.remove(item);
  void removeAtIndexFromRoundList(int index) => roundList.removeAt(index);
  void insertAtIndexInRoundList(int index, GameSAUStruct item) =>
      roundList.insert(index, item);
  void updateRoundListAtIndex(int index, Function(GameSAUStruct) updateFn) =>
      roundList[index] = updateFn(roundList[index]);

  List<GameSAURoundUserStruct> roundUserList = [];
  void addToRoundUserList(GameSAURoundUserStruct item) =>
      roundUserList.add(item);
  void removeFromRoundUserList(GameSAURoundUserStruct item) =>
      roundUserList.remove(item);
  void removeAtIndexFromRoundUserList(int index) =>
      roundUserList.removeAt(index);
  void insertAtIndexInRoundUserList(int index, GameSAURoundUserStruct item) =>
      roundUserList.insert(index, item);
  void updateRoundUserListAtIndex(
          int index, Function(GameSAURoundUserStruct) updateFn) =>
      roundUserList[index] = updateFn(roundUserList[index]);

  List<GameSAURoundUserStruct> finalResultUserList = [];
  void addToFinalResultUserList(GameSAURoundUserStruct item) =>
      finalResultUserList.add(item);
  void removeFromFinalResultUserList(GameSAURoundUserStruct item) =>
      finalResultUserList.remove(item);
  void removeAtIndexFromFinalResultUserList(int index) =>
      finalResultUserList.removeAt(index);
  void insertAtIndexInFinalResultUserList(
          int index, GameSAURoundUserStruct item) =>
      finalResultUserList.insert(index, item);
  void updateFinalResultUserListAtIndex(
          int index, Function(GameSAURoundUserStruct) updateFn) =>
      finalResultUserList[index] = updateFn(finalResultUserList[index]);

  int? points;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  RoomRecord? roomResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  IDmapRecord? idmapResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<GameHistoryRecord>? gameHistoryResult45;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<GameHistoryRecord>? gameHistoryResult2;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<GameHistoryRecord>? gameHistoryResult3;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<GameHistoryRecord>? gameHistoryResult4;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<GameHistoryRecord>? gameHistoryResult1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
