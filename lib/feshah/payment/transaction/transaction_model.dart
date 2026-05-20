import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/app_bar_default/app_bar_default_widget.dart';
import '/feshah/component/empty_widget_transaction/empty_widget_transaction_widget.dart';
import '/feshah/payment/point_list_private_wallet/point_list_private_wallet_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'transaction_widget.dart' show TransactionWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class TransactionModel extends FlutterFlowModel<TransactionWidget> {
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
  // Stores action output result for [Firestore Query - Query a collection] action in Rechargenow widget.
  List<PointRecord>? pointResultAuth;
  // Model for AppBar-Default component.
  late AppBarDefaultModel appBarDefaultModel;

  @override
  void initState(BuildContext context) {
    userStatusCheckerModel =
        createModel(context, () => UserStatusCheckerModel());
    appBarDefaultModel = createModel(context, () => AppBarDefaultModel());
  }

  @override
  void dispose() {
    userStatusCheckerModel.dispose();
    appBarDefaultModel.dispose();
  }
}
