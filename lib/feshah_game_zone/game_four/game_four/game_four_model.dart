import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_one/game_zone_team/game_zone_team_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'game_four_widget.dart' show GameFourWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GameFourModel extends FlutterFlowModel<GameFourWidget> {
  ///  Local state fields for this page.

  int? count;

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

  String widgetStatus = 'default';

  List<int> selectedTopicList = [];
  void addToSelectedTopicList(int item) => selectedTopicList.add(item);
  void removeFromSelectedTopicList(int item) => selectedTopicList.remove(item);
  void removeAtIndexFromSelectedTopicList(int index) =>
      selectedTopicList.removeAt(index);
  void insertAtIndexInSelectedTopicList(int index, int item) =>
      selectedTopicList.insert(index, item);
  void updateSelectedTopicListAtIndex(int index, Function(int) updateFn) =>
      selectedTopicList[index] = updateFn(selectedTopicList[index]);

  String? selectedTopicStatus;

  List<RoomUserListStruct> selectedGameUserList = [];
  void addToSelectedGameUserList(RoomUserListStruct item) =>
      selectedGameUserList.add(item);
  void removeFromSelectedGameUserList(RoomUserListStruct item) =>
      selectedGameUserList.remove(item);
  void removeAtIndexFromSelectedGameUserList(int index) =>
      selectedGameUserList.removeAt(index);
  void insertAtIndexInSelectedGameUserList(
          int index, RoomUserListStruct item) =>
      selectedGameUserList.insert(index, item);
  void updateSelectedGameUserListAtIndex(
          int index, Function(RoomUserListStruct) updateFn) =>
      selectedGameUserList[index] = updateFn(selectedGameUserList[index]);

  String? selectedUserStatus;

  int? teamLimit = 2;

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

  int? topicLimit = 2;

  int? randomIndex = 1;

  int? topicID;

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

  int? questionCount;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;
  // State field(s) for TeamA widget.
  FocusNode? teamAFocusNode;
  TextEditingController? teamATextController;
  String? Function(BuildContext, String?)? teamATextControllerValidator;
  String? _teamATextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'b0jvmm3u' /* Team A Name is required. */,
      );
    }

    if (val.length < 2) {
      return FFLocalizations.of(context).getText(
        'in83gz0y' /* Requires atleast 2 characters */,
      );
    }
    if (val.length > 20) {
      return FFLocalizations.of(context).getText(
        'mpdjibce' /* Maximum 20 characters are allo... */,
      );
    }

    return null;
  }

  // State field(s) for TeamB widget.
  FocusNode? teamBFocusNode;
  TextEditingController? teamBTextController;
  String? Function(BuildContext, String?)? teamBTextControllerValidator;
  String? _teamBTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'k6h53mep' /* Team B Name is required. */,
      );
    }

    if (val.length < 2) {
      return FFLocalizations.of(context).getText(
        'b7c4za5q' /* Requires atleast 2 characters */,
      );
    }
    if (val.length > 20) {
      return FFLocalizations.of(context).getText(
        'u4lrmn54' /* Maximum 20 characters are allo... */,
      );
    }

    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in Button1 widget.
  IDmapRecord? idmapTeamResult1;
  // Stores action output result for [Firestore Query - Query a collection] action in Button1 widget.
  List<TopicQuestionRecord>? topicQuestionResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Button1 widget.
  List<TopicQuestionRecord>? selectedTopicQuestionList;
  AudioPlayer? soundPlayer;
  // Stores action output result for [Firestore Query - Query a collection] action in Button1 widget.
  IDmapRecord? idmapGameoneResult;
  // Model for AppBar-Game component.
  late AppBarGameModel appBarGameModel;

  @override
  void initState(BuildContext context) {
    userStatusCheckerModel =
        createModel(context, () => UserStatusCheckerModel());
    teamATextControllerValidator = _teamATextControllerValidator;
    teamBTextControllerValidator = _teamBTextControllerValidator;
    appBarGameModel = createModel(context, () => AppBarGameModel());
  }

  @override
  void dispose() {
    userStatusCheckerModel.dispose();
    teamAFocusNode?.dispose();
    teamATextController?.dispose();

    teamBFocusNode?.dispose();
    teamBTextController?.dispose();

    appBarGameModel.dispose();
  }
}
