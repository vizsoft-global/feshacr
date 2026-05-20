import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'game_five_input_widget.dart' show GameFiveInputWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GameFiveInputModel extends FlutterFlowModel<GameFiveInputWidget> {
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

  final formKey = GlobalKey<FormState>();
  // State field(s) for PlayerName widget.
  FocusNode? playerNameFocusNode;
  TextEditingController? playerNameTextController;
  String? Function(BuildContext, String?)? playerNameTextControllerValidator;
  String? _playerNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '0hi2l1y0' /* Player name is required */,
      );
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    playerNameTextControllerValidator = _playerNameTextControllerValidator;
  }

  @override
  void dispose() {
    playerNameFocusNode?.dispose();
    playerNameTextController?.dispose();
  }
}
