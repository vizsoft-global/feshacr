import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'payment_checker_widget.dart' show PaymentCheckerWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentCheckerModel extends FlutterFlowModel<PaymentCheckerWidget> {
  ///  Local state fields for this component.

  int? refresh;

  int? wallet = 0;

  ///  State fields for stateful widgets in this component.

  InstantTimer? instantTimer;
  // Stores action output result for [Firestore Query - Query a collection] action in Payment_Checker widget.
  PaymentResponseRecord? paymentResponseResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Payment_Checker widget.
  OrderRecord? presentOrderResult;
  // Stores action output result for [Backend Call - API (Status)] action in Payment_Checker widget.
  ApiCallResponse? upaymentApiResult;
  // Stores action output result for [Backend Call - API (StatusAPI)] action in Payment_Checker widget.
  ApiCallResponse? tappaymentApiResult;
  // Stores action output result for [Backend Call - API (Invoice Status)] action in Payment_Checker widget.
  ApiCallResponse? myfatoorahpaymentApiResult;
  // Stores action output result for [Backend Call - Read Document] action in Payment_Checker widget.
  RoomRecord? presentRoomResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Payment_Checker widget.
  IDmapRecord? idmapWalletCredit;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
  }
}
