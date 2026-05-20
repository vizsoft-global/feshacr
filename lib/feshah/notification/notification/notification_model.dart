import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah/component/app_bar_default/app_bar_default_widget.dart';
import '/feshah/component/empty_widget_notification/empty_widget_notification_widget.dart';
import '/feshah/notification/notfy_game_request/notfy_game_request_widget.dart';
import '/feshah/notification/notfy_room_request_accept/notfy_room_request_accept_widget.dart';
import '/feshah/notification/notfy_room_request_decline/notfy_room_request_decline_widget.dart';
import '/feshah/notification/notfy_room_request_joinroom/notfy_room_request_joinroom_widget.dart';
import '/feshah/notification/notfy_room_request_notification/notfy_room_request_notification_widget.dart';
import '/feshah/notification/notify_sound/notify_sound_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'notification_widget.dart' show NotificationWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationModel extends FlutterFlowModel<NotificationWidget> {
  ///  Local state fields for this page.

  int? count;

  ///  State fields for stateful widgets in this page.

  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<NotificationRecord>? notificationList;
  // Model for notify_sound component.
  late NotifySoundModel notifySoundModel;
  // Model for AppBar-Default component.
  late AppBarDefaultModel appBarDefaultModel;

  @override
  void initState(BuildContext context) {
    userStatusCheckerModel =
        createModel(context, () => UserStatusCheckerModel());
    notifySoundModel = createModel(context, () => NotifySoundModel());
    appBarDefaultModel = createModel(context, () => AppBarDefaultModel());
  }

  @override
  void dispose() {
    userStatusCheckerModel.dispose();
    notifySoundModel.dispose();
    appBarDefaultModel.dispose();
  }
}
