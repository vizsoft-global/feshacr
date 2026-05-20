import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/alert_information/alert_information_widget.dart';
import '/feshah/payment/coupon/coupon_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import '/index.dart';
import 'point_list_private_wallet_widget.dart'
    show PointListPrivateWalletWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PointListPrivateWalletModel
    extends FlutterFlowModel<PointListPrivateWalletWidget> {
  ///  Local state fields for this component.

  String payButtonStatus = 'continue';

  String myfathooraPayment = 'hide';

  int? myfathooraID = 1;

  String? myfathooraMethod = 'KNET';

  int? wallet;

  bool authWalletTextFiledStatus = false;

  int? spent;

  ///  State fields for stateful widgets in this component.

  // Model for coupon component.
  late CouponModel couponModel;
  // Stores action output result for [Firestore Query - Query a collection] action in Directpay widget.
  SettingsRecord? forPaymentResult1;
  // Stores action output result for [Firestore Query - Query a collection] action in Directpay widget.
  IDmapRecord? idMapResultOrder1;
  // Stores action output result for [RevenueCat - Purchase] action in Directpay widget.
  bool? didPurchased;
  // Stores action output result for [Backend Call - Create Document] action in Directpay widget.
  OrderRecord? orderIosNew;
  // Stores action output result for [Backend Call - Read Document] action in Directpay widget.
  RoomRecord? presentRoomResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Directpay widget.
  IDmapRecord? idmapWalletCredit;
  // Stores action output result for [Backend Call - API (Charge)] action in Directpay widget.
  ApiCallResponse? paymentUpaymentResult1;
  // Stores action output result for [Backend Call - Create Document] action in Directpay widget.
  OrderRecord? orderUpaymentNew;
  // Stores action output result for [Backend Call - API (ChargeAPI)] action in Directpay widget.
  ApiCallResponse? tapPaymentResult1;
  // Stores action output result for [Backend Call - Create Document] action in Directpay widget.
  OrderRecord? orderTappaymentNew;
  // State field(s) for authWallet widget.
  FocusNode? authWalletFocusNode;
  TextEditingController? authWalletTextController;
  String? Function(BuildContext, String?)? authWalletTextControllerValidator;
  // Stores action output result for [Backend Call - API (Execute)] action in save widget.
  ApiCallResponse? myfatoorahPaymentResult1;
  // Stores action output result for [Backend Call - Create Document] action in save widget.
  OrderRecord? orderMyfatoorahpaymentNew;

  @override
  void initState(BuildContext context) {
    couponModel = createModel(context, () => CouponModel());
  }

  @override
  void dispose() {
    couponModel.dispose();
    authWalletFocusNode?.dispose();
    authWalletTextController?.dispose();
  }
}
