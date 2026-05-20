import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'game_zone_team_widget.dart' show GameZoneTeamWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GameZoneTeamModel extends FlutterFlowModel<GameZoneTeamWidget> {
  ///  Local state fields for this component.

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

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for MainListTeamName widget.
  FocusNode? mainListTeamNameFocusNode;
  TextEditingController? mainListTeamNameTextController;
  String? Function(BuildContext, String?)?
      mainListTeamNameTextControllerValidator;
  String? _mainListTeamNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'v11tc98z' /* Team Name is required. */,
      );
    }

    if (val.length < 2) {
      return FFLocalizations.of(context).getText(
        'hz3wwul7' /* Requires atleast 2 characters */,
      );
    }
    if (val.length > 20) {
      return FFLocalizations.of(context).getText(
        'rp4p6uf0' /* Maximum 20 characters are allo... */,
      );
    }

    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  IDmapRecord? idmapTeamResult;

  @override
  void initState(BuildContext context) {
    mainListTeamNameTextControllerValidator =
        _mainListTeamNameTextControllerValidator;
  }

  @override
  void dispose() {
    mainListTeamNameFocusNode?.dispose();
    mainListTeamNameTextController?.dispose();
  }
}
