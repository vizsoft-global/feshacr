import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'game_one_user_widget.dart' show GameOneUserWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GameOneUserModel extends FlutterFlowModel<GameOneUserWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
