import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/app_bar_game/app_bar_game_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'game3_room_mode_invite_widget.dart' show Game3RoomModeInviteWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Game3RoomModeInviteModel
    extends FlutterFlowModel<Game3RoomModeInviteWidget> {
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

  ///  State fields for stateful widgets in this page.

  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;
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
