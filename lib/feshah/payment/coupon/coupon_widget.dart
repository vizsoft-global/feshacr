import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'coupon_model.dart';
export 'coupon_model.dart';

class CouponWidget extends StatefulWidget {
  const CouponWidget({super.key});

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  late CouponModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CouponModel());

    _model.couponCodeTextController ??= TextEditingController();
    _model.couponCodeFocusNode ??= FocusNode();

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

    return Align(
      alignment: AlignmentDirectional(1.0, -1.0),
      child: Stack(
        alignment: AlignmentDirectional(1.0, -1.0),
        children: [
          Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Visibility(
              visible: FFAppState()
                      .userflow
                      .paymentProcessingTime
                      .paymentPlanItem
                      .couponStatus ==
                  false,
              child: Stack(
                alignment: AlignmentDirectional(0.0, -1.0),
                children: [
                  TextFormField(
                    controller: _model.couponCodeTextController,
                    focusNode: _model.couponCodeFocusNode,
                    autofocus: false,
                    textInputAction: TextInputAction.go,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.almarai(
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                      hintText: FFLocalizations.of(context).getText(
                        'zhf020mg' /* Enter discount code... */,
                      ),
                      hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.almarai(
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.almarai(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    maxLength: 8,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    buildCounter: (context,
                            {required currentLength,
                            required isFocused,
                            maxLength}) =>
                        null,
                    keyboardType: TextInputType.emailAddress,
                    validator: _model.couponCodeTextControllerValidator
                        .asValidator(context),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.0, -1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 12.0, 0.0),
                      child: FlutterFlowIconButton(
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 36.0,
                        fillColor: FlutterFlowTheme.of(context).tertiary,
                        icon: Icon(
                          Icons.navigate_next_rounded,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 21.0,
                        ),
                        onPressed: () async {
                          var _shouldSetState = false;
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          _model.couponResult1 = await queryCouponRecordOnce(
                            queryBuilder: (couponRecord) => couponRecord
                                .where(
                                  'coupon_value',
                                  isEqualTo:
                                      _model.couponCodeTextController.text,
                                )
                                .where(
                                  'coupon_status',
                                  isEqualTo: 'active',
                                ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          _shouldSetState = true;
                          if (_model.couponCodeTextController.text == '') {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    content: Text(FFLocalizations.of(context)
                                        .getVariableText(
                                      enText: 'Please enter a coupon code.',
                                      arText: 'الرجاء إدخال رمز القسيمة.',
                                    )),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text(FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'OK',
                                          arText: 'نعم',
                                        )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else if ((_model.couponResult1 != null) == false) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    content: Text(FFLocalizations.of(context)
                                        .getVariableText(
                                      enText: 'Invalid Coupon',
                                      arText: 'قسيمة غير صالحة',
                                    )),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text(FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'OK',
                                          arText: 'نعم',
                                        )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            safeSetState(() {
                              _model.couponCodeTextController?.clear();
                            });
                            if (_shouldSetState) safeSetState(() {});
                            return;
                          } else if (_model.couponResult1!.couponStartDate! >
                              getCurrentTimestamp) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    content: Text(FFLocalizations.of(context)
                                        .getVariableText(
                                      enText: 'Coupon is not yet active',
                                      arText: 'القسيمة ليست نشطة بعد',
                                    )),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text(FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'OK',
                                          arText: 'نعم',
                                        )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            safeSetState(() {
                              _model.couponCodeTextController?.clear();
                            });
                            if (_shouldSetState) safeSetState(() {});
                            return;
                          } else if (_model.couponResult1!.couponEndDate! <
                              getCurrentTimestamp) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    content: Text(FFLocalizations.of(context)
                                        .getVariableText(
                                      enText: 'Coupon is Expired',
                                      arText: 'انتهت صلاحية القسيمة',
                                    )),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text(FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'OK',
                                          arText: 'نعم',
                                        )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            safeSetState(() {
                              _model.couponCodeTextController?.clear();
                            });
                            if (_shouldSetState) safeSetState(() {});
                            return;
                          } else if (_model.couponResult1?.couponUsedUserList
                                  ?.contains(currentUserUid) ==
                              true) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    content: Text(FFLocalizations.of(context)
                                        .getVariableText(
                                      enText: 'Coupon already been used.',
                                      arText: 'تم استخدام القسيمة بالفعل.',
                                    )),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text(FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'OK',
                                          arText: 'تمام',
                                        )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            safeSetState(() {
                              _model.couponCodeTextController?.clear();
                            });
                            if (_shouldSetState) safeSetState(() {});
                            return;
                          } else if (_model.couponResult1!.couponMemberLimit <=
                              0) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    content: Text(FFLocalizations.of(context)
                                        .getVariableText(
                                      enText: 'Coupon usage limit is exceeded.',
                                      arText: 'تم تجاوز حد استخدام القسيمة.',
                                    )),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text(FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'OK',
                                          arText: 'تمام',
                                        )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            safeSetState(() {
                              _model.couponCodeTextController?.clear();
                            });
                            if (_shouldSetState) safeSetState(() {});
                            return;
                          } else if (_model.couponResult1?.couponDiscountType ==
                              'Amount') {
                            if (FFAppState()
                                    .userflow
                                    .paymentProcessingTime
                                    .paymentPlanItem
                                    .totalPrice >=
                                _model.couponResult1!.couponMinimumAmount) {
                              if (FFAppState()
                                      .userflow
                                      .paymentProcessingTime
                                      .paymentPlanItem
                                      .totalPrice <=
                                  _model.couponResult1!.couponMaximumAmount) {
                                _model.couponPrice = _model
                                    .couponResult1?.couponDiscountAmountValue;
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        content: Text(
                                            '${FFLocalizations.of(context).getVariableText(
                                          enText:
                                              'The maximum order price is  ',
                                          arText: 'الحد الأقصى لسعر الطلب هو',
                                        )}${_model.couponResult1?.couponMaximumAmount?.toString()}${FFLocalizations.of(context).getVariableText(
                                          enText:
                                              ' KD to apply the coupon code.',
                                          arText:
                                              'دينار كويتي لتطبيق رمز القسيمة.',
                                        )}'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              enText: 'OK',
                                              arText: 'تمام',
                                            )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                safeSetState(() {
                                  _model.couponCodeTextController?.clear();
                                });
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      content: Text(
                                          '${FFLocalizations.of(context).getVariableText(
                                        enText: 'The minimum order price is ',
                                        arText: 'الحد الأدنى لسعر الطلب هو',
                                      )}${_model.couponResult1?.couponMinimumAmount?.toString()}${FFLocalizations.of(context).getVariableText(
                                        enText: ' KD to apply the coupon code.',
                                        arText:
                                            'دينار كويتي لتطبيق رمز القسيمة.',
                                      )}'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                            enText: 'OK',
                                            arText: 'تمام',
                                          )),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              safeSetState(() {
                                _model.couponCodeTextController?.clear();
                              });
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                          } else if (_model.couponResult1?.couponDiscountType ==
                              'Discount') {
                            _model.couponPrice = _model
                                        .couponResult1!.couponMaximumDiscount <
                                    (FFAppState()
                                            .userflow
                                            .paymentProcessingTime
                                            .paymentPlanItem
                                            .totalPrice *
                                        (_model.couponResult1!
                                                .couponDiscountAmountValue /
                                            100))
                                ? _model.couponResult1?.couponMaximumDiscount
                                : (FFAppState()
                                        .userflow
                                        .paymentProcessingTime
                                        .paymentPlanItem
                                        .totalPrice *
                                    (_model.couponResult1!
                                            .couponDiscountAmountValue /
                                        100));
                          }

                          if (_model.couponResult1?.couponUserType != 'fixed') {
                            if (_model.couponResult1?.couponUserList
                                    ?.contains(currentUserUid) !=
                                false) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      content: Text(FFLocalizations.of(context)
                                          .getVariableText(
                                        enText: 'Invalid Coupon for User.',
                                        arText: 'قسيمة غير صالحة',
                                      )),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                            enText: 'OK',
                                            arText: 'نعم',
                                          )),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              safeSetState(() {
                                _model.couponCodeTextController?.clear();
                              });
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                          }
                          FFAppState().updateUserflowStruct(
                            (e) => e
                              ..updatePaymentProcessingTime(
                                (e) => e
                                  ..updatePaymentPlanItem(
                                    (e) => e
                                      ..couponStatus = true
                                      ..couponInfo = CouponCartInfoStruct(
                                        couponRef:
                                            _model.couponResult1?.reference,
                                        couponId:
                                            _model.couponResult1?.couponId,
                                        couponValue:
                                            _model.couponResult1?.couponValue,
                                        couponDiscountedPrice: _model
                                            .couponResult1
                                            ?.couponDiscountAmountValue,
                                        couponDiscountType: _model
                                            .couponResult1?.couponDiscountType,
                                        couponUserInfo: currentUserUid,
                                        couponDiscountAmountValue: _model
                                            .couponResult1
                                            ?.couponDiscountAmountValue,
                                        couponMaximumDiscount: _model
                                            .couponResult1
                                            ?.couponMaximumDiscount,
                                        couponMaximumAmount: _model
                                            .couponResult1?.couponMinimumAmount,
                                        couponMinimumAmount: _model
                                            .couponResult1?.couponMinimumAmount,
                                      )
                                      ..totalPrice = FFAppState()
                                              .userflow
                                              .paymentProcessingTime
                                              .paymentPlanItem
                                              .totalPrice -
                                          (_model.couponPrice!),
                                  ),
                              ),
                          );
                          FFAppState().refresh = FFAppState().refresh + 1;
                          FFAppState().update(() {});
                          if (_shouldSetState) safeSetState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (FFAppState()
                  .userflow
                  .paymentProcessingTime
                  .paymentPlanItem
                  .couponStatus ==
              true)
            Align(
              alignment: AlignmentDirectional(1.0, -1.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.discount_outlined,
                      color: FlutterFlowTheme.of(context).success,
                      size: 24.0,
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Text(
                          '${FFLocalizations.of(context).getVariableText(
                            enText: 'Code \"',
                            arText: 'رمز القسيمة \"',
                          )}${FFAppState().userflow.paymentProcessingTime.paymentPlanItem.couponInfo.couponValue}${FFLocalizations.of(context).getVariableText(
                            enText: '\" applied - New total : ',
                            arText: '\"تم تطبيقه - المجموع الجديد:',
                          )}${FFAppState().userflow.paymentProcessingTime.paymentPlanItem.totalPrice.toString()} KD',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).success,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        var confirmDialogResponse = await showDialog<bool>(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    title: Text(FFLocalizations.of(context)
                                        .getVariableText(
                                      enText: 'Remove from Cart',
                                      arText: 'إزالة من العربة',
                                    )),
                                    content: Text(
                                        '${FFLocalizations.of(context).getVariableText(
                                      enText:
                                          'Do you want to remove this coupon?',
                                      arText: 'هل تريد إزالة هذه القسيمة؟',
                                    )}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text(FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'No',
                                          arText: 'لا',
                                        )),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text(FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'Yes!',
                                          arText: 'نعم!',
                                        )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ) ??
                            false;
                        if (confirmDialogResponse) {
                          FFAppState().updateUserflowStruct(
                            (e) => e
                              ..updatePaymentProcessingTime(
                                (e) => e
                                  ..updatePaymentPlanItem(
                                    (e) => e
                                      ..couponStatus = null
                                      ..couponInfo = null
                                      ..totalPrice = FFAppState()
                                          .userflow
                                          .paymentProcessingTime
                                          .paymentPlanItem
                                          .planPrice,
                                  ),
                              ),
                          );
                          safeSetState(() {
                            _model.couponCodeTextController?.clear();
                          });
                          FFAppState().refresh = FFAppState().refresh + 1;
                          safeSetState(() {});
                        }
                      },
                      child: Icon(
                        Icons.remove_circle,
                        color: FlutterFlowTheme.of(context).error,
                        size: 24.0,
                      ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
