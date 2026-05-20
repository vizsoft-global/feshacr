import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'game_four_s3_widget.dart' show GameFourS3Widget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class GameFourS3Model extends FlutterFlowModel<GameFourS3Widget> {
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

  int? countTopic;

  List<int> selectedTopicIDlist = [];
  void addToSelectedTopicIDlist(int item) => selectedTopicIDlist.add(item);
  void removeFromSelectedTopicIDlist(int item) =>
      selectedTopicIDlist.remove(item);
  void removeAtIndexFromSelectedTopicIDlist(int index) =>
      selectedTopicIDlist.removeAt(index);
  void insertAtIndexInSelectedTopicIDlist(int index, int item) =>
      selectedTopicIDlist.insert(index, item);
  void updateSelectedTopicIDlistAtIndex(int index, Function(int) updateFn) =>
      selectedTopicIDlist[index] = updateFn(selectedTopicIDlist[index]);

  List<GameTieQuestionListStruct> roundList = [];
  void addToRoundList(GameTieQuestionListStruct item) => roundList.add(item);
  void removeFromRoundList(GameTieQuestionListStruct item) =>
      roundList.remove(item);
  void removeAtIndexFromRoundList(int index) => roundList.removeAt(index);
  void insertAtIndexInRoundList(int index, GameTieQuestionListStruct item) =>
      roundList.insert(index, item);
  void updateRoundListAtIndex(
          int index, Function(GameTieQuestionListStruct) updateFn) =>
      roundList[index] = updateFn(roundList[index]);

  int? roundQuestionCount;

  int? refresh = 1;

  int? tieTotalQuestionCount;

  ///  State fields for stateful widgets in this page.

  AudioPlayer? soundPlayer1;
  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;
  AudioPlayer? soundPlayer2;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  IDmapRecord? idmapResult1;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  IDmapRecord? idmapResultexit;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  IDmapRecord? idmapNewRound;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<TopicQuestionRecord>? tieQuestionResult100;
  AudioPlayer? soundPlayer3;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  IDmapRecord? idmapResult;

  @override
  void initState(BuildContext context) {
    userStatusCheckerModel =
        createModel(context, () => UserStatusCheckerModel());
  }

  @override
  void dispose() {
    userStatusCheckerModel.dispose();
  }
}
