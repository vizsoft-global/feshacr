import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'game_four_user2_widget.dart' show GameFourUser2Widget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GameFourUser2Model extends FlutterFlowModel<GameFourUser2Widget> {
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

  int? point;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
