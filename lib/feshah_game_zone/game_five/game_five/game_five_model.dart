import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_five/game_five_input/game_five_input_widget.dart';
import '/feshah_game_zone/game_five/game_five_players/game_five_players_widget.dart';
import '/feshah_game_zone/game_five/game_five_timer/game_five_timer_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'game_five_widget.dart' show GameFiveWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GameFiveModel extends FlutterFlowModel<GameFiveWidget> {
  ///  Local state fields for this page.

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

  int? countTopic;

  List<int> selectedTopicList = [];
  void addToSelectedTopicList(int item) => selectedTopicList.add(item);
  void removeFromSelectedTopicList(int item) => selectedTopicList.remove(item);
  void removeAtIndexFromSelectedTopicList(int index) =>
      selectedTopicList.removeAt(index);
  void insertAtIndexInSelectedTopicList(int index, int item) =>
      selectedTopicList.insert(index, item);
  void updateSelectedTopicListAtIndex(int index, Function(int) updateFn) =>
      selectedTopicList[index] = updateFn(selectedTopicList[index]);

  int? topicLimit = 5;

  String? topicFoundStatus;

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

  String? userFoundStatus;

  int? countUser;

  int? userLimit = 2;

  int? randomTopicIndex;

  int? randomQuestionIndex;

  int? randomUserIndex;

  String userNavigation = 'players';

  List<GameSAUStruct> gameSAU = [];
  void addToGameSAU(GameSAUStruct item) => gameSAU.add(item);
  void removeFromGameSAU(GameSAUStruct item) => gameSAU.remove(item);
  void removeAtIndexFromGameSAU(int index) => gameSAU.removeAt(index);
  void insertAtIndexInGameSAU(int index, GameSAUStruct item) =>
      gameSAU.insert(index, item);
  void updateGameSAUAtIndex(int index, Function(GameSAUStruct) updateFn) =>
      gameSAU[index] = updateFn(gameSAU[index]);

  int? roundIndex;

  int? voteCount;

  List<GameSAUVoteUserStruct> voteUser = [];
  void addToVoteUser(GameSAUVoteUserStruct item) => voteUser.add(item);
  void removeFromVoteUser(GameSAUVoteUserStruct item) => voteUser.remove(item);
  void removeAtIndexFromVoteUser(int index) => voteUser.removeAt(index);
  void insertAtIndexInVoteUser(int index, GameSAUVoteUserStruct item) =>
      voteUser.insert(index, item);
  void updateVoteUserAtIndex(
          int index, Function(GameSAUVoteUserStruct) updateFn) =>
      voteUser[index] = updateFn(voteUser[index]);

  int? voteResult;

  List<GameSAURoundUserStruct> roundSAUser = [];
  void addToRoundSAUser(GameSAURoundUserStruct item) => roundSAUser.add(item);
  void removeFromRoundSAUser(GameSAURoundUserStruct item) =>
      roundSAUser.remove(item);
  void removeAtIndexFromRoundSAUser(int index) => roundSAUser.removeAt(index);
  void insertAtIndexInRoundSAUser(int index, GameSAURoundUserStruct item) =>
      roundSAUser.insert(index, item);
  void updateRoundSAUserAtIndex(
          int index, Function(GameSAURoundUserStruct) updateFn) =>
      roundSAUser[index] = updateFn(roundSAUser[index]);

  int? roundCount;

  List<GameSAUStruct> roundList = [];
  void addToRoundList(GameSAUStruct item) => roundList.add(item);
  void removeFromRoundList(GameSAUStruct item) => roundList.remove(item);
  void removeAtIndexFromRoundList(int index) => roundList.removeAt(index);
  void insertAtIndexInRoundList(int index, GameSAUStruct item) =>
      roundList.insert(index, item);
  void updateRoundListAtIndex(int index, Function(GameSAUStruct) updateFn) =>
      roundList[index] = updateFn(roundList[index]);

  int? points;

  List<GameSAURoundUserStruct> finalWinUserList = [];
  void addToFinalWinUserList(GameSAURoundUserStruct item) =>
      finalWinUserList.add(item);
  void removeFromFinalWinUserList(GameSAURoundUserStruct item) =>
      finalWinUserList.remove(item);
  void removeAtIndexFromFinalWinUserList(int index) =>
      finalWinUserList.removeAt(index);
  void insertAtIndexInFinalWinUserList(
          int index, GameSAURoundUserStruct item) =>
      finalWinUserList.insert(index, item);
  void updateFinalWinUserListAtIndex(
          int index, Function(GameSAURoundUserStruct) updateFn) =>
      finalWinUserList[index] = updateFn(finalWinUserList[index]);

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

  String? questionFoundStatus;

  int? questionRandomIndex;

  int? randomIndex;

  bool randomTopicStatus = true;

  int? topicCount;

  int? topicQuestionCount;

  List<int> questionListID = [];
  void addToQuestionListID(int item) => questionListID.add(item);
  void removeFromQuestionListID(int item) => questionListID.remove(item);
  void removeAtIndexFromQuestionListID(int index) =>
      questionListID.removeAt(index);
  void insertAtIndexInQuestionListID(int index, int item) =>
      questionListID.insert(index, item);
  void updateQuestionListIDAtIndex(int index, Function(int) updateFn) =>
      questionListID[index] = updateFn(questionListID[index]);

  int? selectedUserPoint;

  int? selectedUserEarnPoint;

  List<TeamInfoStruct> teamInfo = [];
  void addToTeamInfo(TeamInfoStruct item) => teamInfo.add(item);
  void removeFromTeamInfo(TeamInfoStruct item) => teamInfo.remove(item);
  void removeAtIndexFromTeamInfo(int index) => teamInfo.removeAt(index);
  void insertAtIndexInTeamInfo(int index, TeamInfoStruct item) =>
      teamInfo.insert(index, item);
  void updateTeamInfoAtIndex(int index, Function(TeamInfoStruct) updateFn) =>
      teamInfo[index] = updateFn(teamInfo[index]);

  String? timmerStatus = 'pause';

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;
  // Stores action output result for [Firestore Query - Query a collection] action in Step1-Start widget.
  List<TopicRecord>? topicsResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Step1-Start widget.
  List<TopicQuestionRecord>? topicQuestionResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Step1-Start widget.
  IDmapRecord? idmapResult1;
  AudioPlayer? soundPlayer;
  // Stores action output result for [Firestore Query - Query a collection] action in Step1-Start widget.
  IDmapRecord? idmapGameoneResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  IDmapRecord? idmapRoundRightResult1;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  IDmapRecord? idmapRoundExitResult1;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<GameHistoryRecord>? gameHistoryResult1;
  // Model for AppBar-Game component.
  late AppBarGameModel appBarGameModel;

  @override
  void initState(BuildContext context) {
    userStatusCheckerModel =
        createModel(context, () => UserStatusCheckerModel());
    appBarGameModel = createModel(context, () => AppBarGameModel());
  }

  @override
  void dispose() {
    userStatusCheckerModel.dispose();
    appBarGameModel.dispose();
  }
}
