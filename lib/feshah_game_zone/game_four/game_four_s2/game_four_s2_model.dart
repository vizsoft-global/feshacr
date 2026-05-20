import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_four/game_four_initial/game_four_initial_widget.dart';
import '/feshah_game_zone/game_four/game_four_tie_start/game_four_tie_start_widget.dart';
import '/feshah_game_zone/game_four/game_four_timer/game_four_timer_widget.dart';
import '/feshah_game_zone/game_four/game_four_user2/game_four_user2_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'game_four_s2_widget.dart' show GameFourS2Widget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class GameFourS2Model extends FlutterFlowModel<GameFourS2Widget> {
  ///  Local state fields for this page.

  int? countGameList;

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

  int? countQuestion;

  List<SelectedQuestionListStruct> selectedQuestionList = [];
  void addToSelectedQuestionList(SelectedQuestionListStruct item) =>
      selectedQuestionList.add(item);
  void removeFromSelectedQuestionList(SelectedQuestionListStruct item) =>
      selectedQuestionList.remove(item);
  void removeAtIndexFromSelectedQuestionList(int index) =>
      selectedQuestionList.removeAt(index);
  void insertAtIndexInSelectedQuestionList(
          int index, SelectedQuestionListStruct item) =>
      selectedQuestionList.insert(index, item);
  void updateSelectedQuestionListAtIndex(
          int index, Function(SelectedQuestionListStruct) updateFn) =>
      selectedQuestionList[index] = updateFn(selectedQuestionList[index]);

  String? questionStatus;

  int? countTeam;

  List<TeamInfoStruct> selectedTeamList = [];
  void addToSelectedTeamList(TeamInfoStruct item) => selectedTeamList.add(item);
  void removeFromSelectedTeamList(TeamInfoStruct item) =>
      selectedTeamList.remove(item);
  void removeAtIndexFromSelectedTeamList(int index) =>
      selectedTeamList.removeAt(index);
  void insertAtIndexInSelectedTeamList(int index, TeamInfoStruct item) =>
      selectedTeamList.insert(index, item);
  void updateSelectedTeamListAtIndex(
          int index, Function(TeamInfoStruct) updateFn) =>
      selectedTeamList[index] = updateFn(selectedTeamList[index]);

  String? teamStatus;

  int? pointWin;

  int? poinrLos;

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

  int? countRound;

  List<GameTieBreakRoundStruct> roundList = [];
  void addToRoundList(GameTieBreakRoundStruct item) => roundList.add(item);
  void removeFromRoundList(GameTieBreakRoundStruct item) =>
      roundList.remove(item);
  void removeAtIndexFromRoundList(int index) => roundList.removeAt(index);
  void insertAtIndexInRoundList(int index, GameTieBreakRoundStruct item) =>
      roundList.insert(index, item);
  void updateRoundListAtIndex(
          int index, Function(GameTieBreakRoundStruct) updateFn) =>
      roundList[index] = updateFn(roundList[index]);

  int? countRoundQuestionNew;

  List<GameTieQuestionListStruct> roundQuestionListNEW = [];
  void addToRoundQuestionListNEW(GameTieQuestionListStruct item) =>
      roundQuestionListNEW.add(item);
  void removeFromRoundQuestionListNEW(GameTieQuestionListStruct item) =>
      roundQuestionListNEW.remove(item);
  void removeAtIndexFromRoundQuestionListNEW(int index) =>
      roundQuestionListNEW.removeAt(index);
  void insertAtIndexInRoundQuestionListNEW(
          int index, GameTieQuestionListStruct item) =>
      roundQuestionListNEW.insert(index, item);
  void updateRoundQuestionListNEWAtIndex(
          int index, Function(GameTieQuestionListStruct) updateFn) =>
      roundQuestionListNEW[index] = updateFn(roundQuestionListNEW[index]);

  String indexSetStatus = 'notYet';

  int? tieQuestionCount;

  List<GameTieQuestionBreakStruct> tieQuestionList = [];
  void addToTieQuestionList(GameTieQuestionBreakStruct item) =>
      tieQuestionList.add(item);
  void removeFromTieQuestionList(GameTieQuestionBreakStruct item) =>
      tieQuestionList.remove(item);
  void removeAtIndexFromTieQuestionList(int index) =>
      tieQuestionList.removeAt(index);
  void insertAtIndexInTieQuestionList(
          int index, GameTieQuestionBreakStruct item) =>
      tieQuestionList.insert(index, item);
  void updateTieQuestionListAtIndex(
          int index, Function(GameTieQuestionBreakStruct) updateFn) =>
      tieQuestionList[index] = updateFn(tieQuestionList[index]);

  String? scoreProceedStatus = 'Yes';

  ///  State fields for stateful widgets in this page.

  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;
  // Model for GameFour_Initial component.
  late GameFourInitialModel gameFourInitialModel;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  IDmapRecord? idmapResult;
  AudioPlayer? soundPlayer;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  IDmapRecord? idmapResultNone1;
  // Model for AppBar-Game component.
  late AppBarGameModel appBarGameModel;

  @override
  void initState(BuildContext context) {
    userStatusCheckerModel =
        createModel(context, () => UserStatusCheckerModel());
    gameFourInitialModel = createModel(context, () => GameFourInitialModel());
    appBarGameModel = createModel(context, () => AppBarGameModel());
  }

  @override
  void dispose() {
    userStatusCheckerModel.dispose();
    gameFourInitialModel.dispose();
    appBarGameModel.dispose();
  }
}
