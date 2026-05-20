import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/feshah_game_zone/game_one/game_one_user/game_one_user_widget.dart';
import '/feshah_game_zone/game_one/game_zone_team/game_zone_team_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'game_one_copy_widget.dart' show GameOneCopyWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GameOneCopyModel extends FlutterFlowModel<GameOneCopyWidget> {
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

  int? topicLimit = 3;

  int? randomIndex = 1;

  ///  State fields for stateful widgets in this page.

  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<TopicRecord>? topicResult;
  // State field(s) for TopicsChips widget.
  FormFieldController<List<String>>? topicsChipsValueController;
  String? get topicsChipsValue =>
      topicsChipsValueController?.value?.firstOrNull;
  set topicsChipsValue(String? val) =>
      topicsChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Firestore Query - Query a collection] action in GameOne_User widget.
  IDmapRecord? idmapNotificationResult2;
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
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    tabBarController?.dispose();
    appBarGameModel.dispose();
  }
}
