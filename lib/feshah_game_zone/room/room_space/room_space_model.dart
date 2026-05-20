import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/app_bar_room/app_bar_room_widget.dart';
import '/feshah/component/empty_widget_game/empty_widget_game_widget.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah/payment/point_list_private_wallet/point_list_private_wallet_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/game_grid/game_grid_widget.dart';
import '/feshah_game_zone/game_one/game_one_user/game_one_user_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'room_space_widget.dart' show RoomSpaceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class RoomSpaceModel extends FlutterFlowModel<RoomSpaceWidget> {
  ///  Local state fields for this page.

  int? count;

  List<int> userIDList = [];
  void addToUserIDList(int item) => userIDList.add(item);
  void removeFromUserIDList(int item) => userIDList.remove(item);
  void removeAtIndexFromUserIDList(int index) => userIDList.removeAt(index);
  void insertAtIndexInUserIDList(int index, int item) =>
      userIDList.insert(index, item);
  void updateUserIDListAtIndex(int index, Function(int) updateFn) =>
      userIDList[index] = updateFn(userIDList[index]);

  int? refresh;

  bool walletClick = false;

  ///  State fields for stateful widgets in this page.

  // Model for AppBar-Room component.
  late AppBarRoomModel appBarRoomModel;
  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<PointRecord>? pointResultRoom;

  @override
  void initState(BuildContext context) {
    appBarRoomModel = createModel(context, () => AppBarRoomModel());
    userStatusCheckerModel =
        createModel(context, () => UserStatusCheckerModel());
  }

  @override
  void dispose() {
    appBarRoomModel.dispose();
    userStatusCheckerModel.dispose();
  }
}
