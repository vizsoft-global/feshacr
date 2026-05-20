import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payment_checker_model.dart';
export 'payment_checker_model.dart';

class PaymentCheckerWidget extends StatefulWidget {
  const PaymentCheckerWidget({super.key});

  @override
  State<PaymentCheckerWidget> createState() => _PaymentCheckerWidgetState();
}

class _PaymentCheckerWidgetState extends State<PaymentCheckerWidget> {
  late PaymentCheckerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentCheckerModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.instantTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 10000),
        callback: (timer) async {
          if (FFAppState()
                  .userflow
                  .paymentProcessingTime
                  .paymentProcessesStatus ==
              'initialize') {
            _model.paymentResponseResult = await queryPaymentResponseRecordOnce(
              queryBuilder: (paymentResponseRecord) =>
                  paymentResponseRecord.where(
                'order_id',
                isEqualTo: FFAppState()
                    .userflow
                    .paymentProcessingTime
                    .orderId
                    .toString(),
              ),
              singleRecord: true,
            ).then((s) => s.firstOrNull);
            if ((_model.paymentResponseResult != null) == true) {
              _model.presentOrderResult = await queryOrderRecordOnce(
                queryBuilder: (orderRecord) => orderRecord.where(
                  'order_ID',
                  isEqualTo:
                      FFAppState().userflow.paymentProcessingTime.orderId,
                ),
                singleRecord: true,
              ).then((s) => s.firstOrNull);
              if ((_model.paymentResponseResult?.status == 'CAPTURED') ||
                  (_model.paymentResponseResult?.status == 'Succss') ||
                  (_model.paymentResponseResult?.status == 'Paid') ||
                  (_model.paymentResponseResult?.status == 'SUCCESS')) {
                if (FFAppState().userflow.paymentProcessingTime.paymentType ==
                    'upayment') {
                  _model.upaymentApiResult =
                      await UpaymentGroup.statusCall.call(
                    trackId: _model.paymentResponseResult?.trackId,
                    url: FFAppState()
                        .userflow
                        .paymentProcessingTime
                        .paymentBaseUrl,
                    aPIkey:
                        FFAppState().userflow.paymentProcessingTime.secretKey,
                  );

                  if (!(_model.upaymentApiResult?.succeeded ?? true)) {
                    _model.instantTimer?.cancel();

                    await _model.presentOrderResult!.reference
                        .update(createOrderRecordData(
                      orderPaymentInfo: updateOrderPaymentInfoStruct(
                        OrderPaymentInfoStruct(
                          orderPaymentId:
                              _model.paymentResponseResult?.paymentId,
                          orderPaymentMethod:
                              _model.paymentResponseResult?.paymentType,
                          orderPaymentType:
                              _model.paymentResponseResult?.paymentType,
                        ),
                        clearUnsetFields: false,
                      ),
                      orderStatus: _model.paymentResponseResult?.status,
                      updatedAt: getCurrentTimestamp,
                    ));
                    FFAppState().updateUserflowStruct(
                      (e) => e
                        ..updatePaymentProcessingTime(
                          (e) => e..paymentProcessesStatus = 'DONE',
                        ),
                    );

                    context.goNamed(FailedWidget.routeName);

                    return;
                  }
                } else {
                  if (FFAppState().userflow.paymentProcessingTime.paymentType ==
                      'tap') {
                    _model.tappaymentApiResult =
                        await TapGroup.statusAPICall.call(
                      chargeid:
                          FFAppState().userflow.paymentProcessingTime.paymentId,
                      secreatKey:
                          FFAppState().userflow.paymentProcessingTime.secretKey,
                      url: FFAppState()
                          .userflow
                          .paymentProcessingTime
                          .paymentBaseUrl,
                    );

                    if (!(_model.tappaymentApiResult?.succeeded ?? true)) {
                      _model.instantTimer?.cancel();

                      await _model.presentOrderResult!.reference
                          .update(createOrderRecordData(
                        orderPaymentInfo: updateOrderPaymentInfoStruct(
                          OrderPaymentInfoStruct(
                            orderPaymentId:
                                _model.paymentResponseResult?.paymentId,
                            orderPaymentMethod:
                                _model.paymentResponseResult?.paymentType,
                            orderPaymentType:
                                _model.paymentResponseResult?.paymentType,
                          ),
                          clearUnsetFields: false,
                        ),
                        orderStatus: _model.paymentResponseResult?.status,
                        updatedAt: getCurrentTimestamp,
                      ));
                      FFAppState().updateUserflowStruct(
                        (e) => e
                          ..updatePaymentProcessingTime(
                            (e) => e..paymentProcessesStatus = 'DONE',
                          ),
                      );

                      context.goNamed(FailedWidget.routeName);

                      return;
                    }
                  } else {
                    _model.myfatoorahpaymentApiResult =
                        await MyfatoorahGroup.invoiceStatusCall.call(
                      invoiceId:
                          FFAppState().userflow.paymentProcessingTime.paymentId,
                      token:
                          FFAppState().userflow.paymentProcessingTime.secretKey,
                      url: FFAppState()
                          .userflow
                          .paymentProcessingTime
                          .paymentBaseUrl,
                    );

                    if (!(_model.myfatoorahpaymentApiResult?.succeeded ??
                        true)) {
                      _model.instantTimer?.cancel();

                      await _model.presentOrderResult!.reference
                          .update(createOrderRecordData(
                        orderPaymentInfo: updateOrderPaymentInfoStruct(
                          OrderPaymentInfoStruct(
                            orderPaymentId:
                                _model.paymentResponseResult?.paymentId,
                            orderPaymentMethod:
                                _model.paymentResponseResult?.paymentType,
                            orderPaymentType:
                                _model.paymentResponseResult?.paymentType,
                          ),
                          clearUnsetFields: false,
                        ),
                        orderStatus: _model.paymentResponseResult?.status,
                        updatedAt: getCurrentTimestamp,
                      ));
                      FFAppState().updateUserflowStruct(
                        (e) => e
                          ..updatePaymentProcessingTime(
                            (e) => e..paymentProcessesStatus = 'DONE',
                          ),
                      );

                      context.goNamed(FailedWidget.routeName);

                      return;
                    }
                  }
                }

                _model.instantTimer?.cancel();

                await _model.presentOrderResult!.reference
                    .update(createOrderRecordData(
                  orderStatus: _model.paymentResponseResult?.status,
                  updatedAt: getCurrentTimestamp,
                  orderPaymentInfo: updateOrderPaymentInfoStruct(
                    OrderPaymentInfoStruct(
                      orderPaymentId: _model.paymentResponseResult?.paymentId,
                      orderPaymentMethod:
                          _model.paymentResponseResult?.paymentType,
                      orderPaymentType:
                          _model.paymentResponseResult?.paymentType,
                    ),
                    clearUnsetFields: false,
                  ),
                ));
                if (_model.presentOrderResult?.orderCartItem?.planFor ==
                    'auth') {
                  _model.wallet =
                      _model.presentOrderResult!.orderCartItem.planPoint +
                          valueOrDefault(currentUserDocument?.walletPoint, 0);
                } else {
                  _model.presentRoomResult = await RoomRecord.getDocumentOnce(
                      _model.presentOrderResult!.orderCartItem.roomRef!);
                  _model.wallet =
                      _model.presentOrderResult!.orderCartItem.planPoint +
                          _model.presentRoomResult!.roomWalletTotalPoint;
                }

                _model.idmapWalletCredit = await queryIDmapRecordOnce(
                  queryBuilder: (iDmapRecord) => iDmapRecord.where(
                    'type',
                    isEqualTo: 'Main',
                  ),
                  singleRecord: true,
                ).then((s) => s.firstOrNull);

                await WalletSpentRecord.collection
                    .doc()
                    .set(createWalletSpentRecordData(
                      createdAt: getCurrentTimestamp,
                      updatedAt: getCurrentTimestamp,
                      walletSpentID: _model.idmapWalletCredit?.walletSpentId,
                      walletSpentStatus: 'Credit',
                      walletSpentPoint:
                          _model.presentOrderResult?.orderCartItem?.planPoint,
                      walletSpentUserRef: currentUserReference,
                      walletSpentPrevPoint:
                          valueOrDefault(currentUserDocument?.walletPoint, 0),
                      walletSpentPresentPoint: _model
                              .presentOrderResult!.orderCartItem.planPoint +
                          valueOrDefault(currentUserDocument?.walletPoint, 0),
                    ));
                if (_model.presentOrderResult?.orderCartItem?.planFor ==
                    'auth') {
                  await _model.presentOrderResult!.orderUserRef!
                      .update(createUsersRecordData(
                    walletPoint: _model.wallet,
                    appLaunchTimeUser: false,
                  ));
                } else {
                  await _model.presentOrderResult!.orderCartItem.roomRef!
                      .update(createRoomRecordData(
                    roomWalletTotalPoint: _model.wallet,
                    roomAppLaunchTime: false,
                  ));
                }

                if (_model.presentOrderResult?.orderCartItem?.couponStatus ==
                    true) {
                  await _model
                      .presentOrderResult!.orderCartItem.couponInfo.couponRef!
                      .update({
                    ...mapToFirestore(
                      {
                        'coupon_member_limit': FieldValue.increment(-(1)),
                      },
                    ),
                  });
                }

                await _model.idmapWalletCredit!.reference.update({
                  ...mapToFirestore(
                    {
                      'wallet_spent_id': FieldValue.increment(1),
                    },
                  ),
                });

                context.goNamed(SuccessWidget.routeName);

                return;
              } else {
                _model.instantTimer?.cancel();

                await _model.presentOrderResult!.reference
                    .update(createOrderRecordData(
                  orderPaymentInfo: updateOrderPaymentInfoStruct(
                    OrderPaymentInfoStruct(
                      orderPaymentId: _model.paymentResponseResult?.paymentId,
                      orderPaymentMethod:
                          _model.paymentResponseResult?.paymentType,
                      orderPaymentType:
                          _model.paymentResponseResult?.paymentType,
                    ),
                    clearUnsetFields: false,
                  ),
                  orderStatus: _model.paymentResponseResult?.status,
                  updatedAt: getCurrentTimestamp,
                ));
                FFAppState().updateUserflowStruct(
                  (e) => e
                    ..updatePaymentProcessingTime(
                      (e) => e..paymentProcessesStatus = 'DONE',
                    ),
                );

                context.goNamed(FailedWidget.routeName);

                return;
              }
            } else {
              await Future.delayed(
                Duration(
                  milliseconds: 5000,
                ),
              );
            }

            _model.refresh = (_model.refresh!) + 1;
            safeSetState(() {});
          } else {
            _model.instantTimer?.cancel();
            return;
          }
        },
        startImmediately: true,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container();
  }
}
