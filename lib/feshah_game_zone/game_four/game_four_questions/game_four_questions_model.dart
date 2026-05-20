import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'game_four_questions_widget.dart' show GameFourQuestionsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GameFourQuestionsModel extends FlutterFlowModel<GameFourQuestionsWidget> {
  ///  Local state fields for this component.

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

  int? countTopicList;

  List<int> selectedTopicList = [];
  void addToSelectedTopicList(int item) => selectedTopicList.add(item);
  void removeFromSelectedTopicList(int item) => selectedTopicList.remove(item);
  void removeAtIndexFromSelectedTopicList(int index) =>
      selectedTopicList.removeAt(index);
  void insertAtIndexInSelectedTopicList(int index, int item) =>
      selectedTopicList.insert(index, item);
  void updateSelectedTopicListAtIndex(int index, Function(int) updateFn) =>
      selectedTopicList[index] = updateFn(selectedTopicList[index]);

  int? countQuestionList;

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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
