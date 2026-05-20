import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/coming_soon/coming_soon_widget.dart';
import '/feshah/payment/point_list_private_wallet/point_list_private_wallet_widget.dart';
import '/feshah_game_zone/game/game_hint_video/game_hint_video_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/index.dart';
import 'game_grid_widget.dart' show GameGridWidget;
import 'package:styled_divider/styled_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GameGridModel extends FlutterFlowModel<GameGridWidget> {
  ///  Local state fields for this component.

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

  List<RoomUserListStruct> roomUserList = [];
  void addToRoomUserList(RoomUserListStruct item) => roomUserList.add(item);
  void removeFromRoomUserList(RoomUserListStruct item) =>
      roomUserList.remove(item);
  void removeAtIndexFromRoomUserList(int index) => roomUserList.removeAt(index);
  void insertAtIndexInRoomUserList(int index, RoomUserListStruct item) =>
      roomUserList.insert(index, item);
  void updateRoomUserListAtIndex(
          int index, Function(RoomUserListStruct) updateFn) =>
      roomUserList[index] = updateFn(roomUserList[index]);

  bool gridClickStatus = false;

  int? roomUsersCount;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  RoomRecord? roomSoloResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  IDmapRecord? idmapRoomResult;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  RoomRecord? newRoomResult;
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  RoomRecord? roomResultGameCount;
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  RoomRecord? roomResult1;
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  UsersRecord? roomAdminResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<PointRecord>? pointResultAuth;
  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  RoomRecord? gameRoomResult1;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  IDmapRecord? idmapGameResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  NotificationRecord? notificationResultNew;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  UsersRecord? roomUserInfo;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  NotificationRecord? notificationResultNewGame5;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
