// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaymentProcessingTimeStruct extends FFFirebaseStruct {
  PaymentProcessingTimeStruct({
    DocumentReference? presentUserRef,
    int? orderId,
    String? paymentProcessesStatus,
    String? paymentType,
    String? paymentBaseUrl,
    String? mainPaymentUrl,
    String? paymentUrl,
    String? paymentId,
    String? secretKey,
    OrderCartItemStruct? paymentPlanItem,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _presentUserRef = presentUserRef,
        _orderId = orderId,
        _paymentProcessesStatus = paymentProcessesStatus,
        _paymentType = paymentType,
        _paymentBaseUrl = paymentBaseUrl,
        _mainPaymentUrl = mainPaymentUrl,
        _paymentUrl = paymentUrl,
        _paymentId = paymentId,
        _secretKey = secretKey,
        _paymentPlanItem = paymentPlanItem,
        super(firestoreUtilData);

  // "present_user_ref" field.
  DocumentReference? _presentUserRef;
  DocumentReference? get presentUserRef => _presentUserRef;
  set presentUserRef(DocumentReference? val) => _presentUserRef = val;

  bool hasPresentUserRef() => _presentUserRef != null;

  // "order_id" field.
  int? _orderId;
  int get orderId => _orderId ?? 0;
  set orderId(int? val) => _orderId = val;

  void incrementOrderId(int amount) => orderId = orderId + amount;

  bool hasOrderId() => _orderId != null;

  // "payment_processes_status" field.
  String? _paymentProcessesStatus;
  String get paymentProcessesStatus => _paymentProcessesStatus ?? '';
  set paymentProcessesStatus(String? val) => _paymentProcessesStatus = val;

  bool hasPaymentProcessesStatus() => _paymentProcessesStatus != null;

  // "payment_type" field.
  String? _paymentType;
  String get paymentType => _paymentType ?? '';
  set paymentType(String? val) => _paymentType = val;

  bool hasPaymentType() => _paymentType != null;

  // "payment_base_url" field.
  String? _paymentBaseUrl;
  String get paymentBaseUrl => _paymentBaseUrl ?? '';
  set paymentBaseUrl(String? val) => _paymentBaseUrl = val;

  bool hasPaymentBaseUrl() => _paymentBaseUrl != null;

  // "main_payment_url" field.
  String? _mainPaymentUrl;
  String get mainPaymentUrl => _mainPaymentUrl ?? '';
  set mainPaymentUrl(String? val) => _mainPaymentUrl = val;

  bool hasMainPaymentUrl() => _mainPaymentUrl != null;

  // "payment_url" field.
  String? _paymentUrl;
  String get paymentUrl => _paymentUrl ?? '';
  set paymentUrl(String? val) => _paymentUrl = val;

  bool hasPaymentUrl() => _paymentUrl != null;

  // "payment_id" field.
  String? _paymentId;
  String get paymentId => _paymentId ?? '';
  set paymentId(String? val) => _paymentId = val;

  bool hasPaymentId() => _paymentId != null;

  // "secret_key" field.
  String? _secretKey;
  String get secretKey => _secretKey ?? '';
  set secretKey(String? val) => _secretKey = val;

  bool hasSecretKey() => _secretKey != null;

  // "payment_plan_item" field.
  OrderCartItemStruct? _paymentPlanItem;
  OrderCartItemStruct get paymentPlanItem =>
      _paymentPlanItem ?? OrderCartItemStruct();
  set paymentPlanItem(OrderCartItemStruct? val) => _paymentPlanItem = val;

  void updatePaymentPlanItem(Function(OrderCartItemStruct) updateFn) {
    updateFn(_paymentPlanItem ??= OrderCartItemStruct());
  }

  bool hasPaymentPlanItem() => _paymentPlanItem != null;

  static PaymentProcessingTimeStruct fromMap(Map<String, dynamic> data) =>
      PaymentProcessingTimeStruct(
        presentUserRef: data['present_user_ref'] as DocumentReference?,
        orderId: castToType<int>(data['order_id']),
        paymentProcessesStatus: data['payment_processes_status'] as String?,
        paymentType: data['payment_type'] as String?,
        paymentBaseUrl: data['payment_base_url'] as String?,
        mainPaymentUrl: data['main_payment_url'] as String?,
        paymentUrl: data['payment_url'] as String?,
        paymentId: data['payment_id'] as String?,
        secretKey: data['secret_key'] as String?,
        paymentPlanItem: data['payment_plan_item'] is OrderCartItemStruct
            ? data['payment_plan_item']
            : OrderCartItemStruct.maybeFromMap(data['payment_plan_item']),
      );

  static PaymentProcessingTimeStruct? maybeFromMap(dynamic data) => data is Map
      ? PaymentProcessingTimeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'present_user_ref': _presentUserRef,
        'order_id': _orderId,
        'payment_processes_status': _paymentProcessesStatus,
        'payment_type': _paymentType,
        'payment_base_url': _paymentBaseUrl,
        'main_payment_url': _mainPaymentUrl,
        'payment_url': _paymentUrl,
        'payment_id': _paymentId,
        'secret_key': _secretKey,
        'payment_plan_item': _paymentPlanItem?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'present_user_ref': serializeParam(
          _presentUserRef,
          ParamType.DocumentReference,
        ),
        'order_id': serializeParam(
          _orderId,
          ParamType.int,
        ),
        'payment_processes_status': serializeParam(
          _paymentProcessesStatus,
          ParamType.String,
        ),
        'payment_type': serializeParam(
          _paymentType,
          ParamType.String,
        ),
        'payment_base_url': serializeParam(
          _paymentBaseUrl,
          ParamType.String,
        ),
        'main_payment_url': serializeParam(
          _mainPaymentUrl,
          ParamType.String,
        ),
        'payment_url': serializeParam(
          _paymentUrl,
          ParamType.String,
        ),
        'payment_id': serializeParam(
          _paymentId,
          ParamType.String,
        ),
        'secret_key': serializeParam(
          _secretKey,
          ParamType.String,
        ),
        'payment_plan_item': serializeParam(
          _paymentPlanItem,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static PaymentProcessingTimeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PaymentProcessingTimeStruct(
        presentUserRef: deserializeParam(
          data['present_user_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        orderId: deserializeParam(
          data['order_id'],
          ParamType.int,
          false,
        ),
        paymentProcessesStatus: deserializeParam(
          data['payment_processes_status'],
          ParamType.String,
          false,
        ),
        paymentType: deserializeParam(
          data['payment_type'],
          ParamType.String,
          false,
        ),
        paymentBaseUrl: deserializeParam(
          data['payment_base_url'],
          ParamType.String,
          false,
        ),
        mainPaymentUrl: deserializeParam(
          data['main_payment_url'],
          ParamType.String,
          false,
        ),
        paymentUrl: deserializeParam(
          data['payment_url'],
          ParamType.String,
          false,
        ),
        paymentId: deserializeParam(
          data['payment_id'],
          ParamType.String,
          false,
        ),
        secretKey: deserializeParam(
          data['secret_key'],
          ParamType.String,
          false,
        ),
        paymentPlanItem: deserializeStructParam(
          data['payment_plan_item'],
          ParamType.DataStruct,
          false,
          structBuilder: OrderCartItemStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'PaymentProcessingTimeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PaymentProcessingTimeStruct &&
        presentUserRef == other.presentUserRef &&
        orderId == other.orderId &&
        paymentProcessesStatus == other.paymentProcessesStatus &&
        paymentType == other.paymentType &&
        paymentBaseUrl == other.paymentBaseUrl &&
        mainPaymentUrl == other.mainPaymentUrl &&
        paymentUrl == other.paymentUrl &&
        paymentId == other.paymentId &&
        secretKey == other.secretKey &&
        paymentPlanItem == other.paymentPlanItem;
  }

  @override
  int get hashCode => const ListEquality().hash([
        presentUserRef,
        orderId,
        paymentProcessesStatus,
        paymentType,
        paymentBaseUrl,
        mainPaymentUrl,
        paymentUrl,
        paymentId,
        secretKey,
        paymentPlanItem
      ]);
}

PaymentProcessingTimeStruct createPaymentProcessingTimeStruct({
  DocumentReference? presentUserRef,
  int? orderId,
  String? paymentProcessesStatus,
  String? paymentType,
  String? paymentBaseUrl,
  String? mainPaymentUrl,
  String? paymentUrl,
  String? paymentId,
  String? secretKey,
  OrderCartItemStruct? paymentPlanItem,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PaymentProcessingTimeStruct(
      presentUserRef: presentUserRef,
      orderId: orderId,
      paymentProcessesStatus: paymentProcessesStatus,
      paymentType: paymentType,
      paymentBaseUrl: paymentBaseUrl,
      mainPaymentUrl: mainPaymentUrl,
      paymentUrl: paymentUrl,
      paymentId: paymentId,
      secretKey: secretKey,
      paymentPlanItem:
          paymentPlanItem ?? (clearUnsetFields ? OrderCartItemStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PaymentProcessingTimeStruct? updatePaymentProcessingTimeStruct(
  PaymentProcessingTimeStruct? paymentProcessingTime, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    paymentProcessingTime
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPaymentProcessingTimeStructData(
  Map<String, dynamic> firestoreData,
  PaymentProcessingTimeStruct? paymentProcessingTime,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (paymentProcessingTime == null) {
    return;
  }
  if (paymentProcessingTime.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      paymentProcessingTime.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final paymentProcessingTimeData = getPaymentProcessingTimeFirestoreData(
      paymentProcessingTime, forFieldValue);
  final nestedData =
      paymentProcessingTimeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      paymentProcessingTime.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPaymentProcessingTimeFirestoreData(
  PaymentProcessingTimeStruct? paymentProcessingTime, [
  bool forFieldValue = false,
]) {
  if (paymentProcessingTime == null) {
    return {};
  }
  final firestoreData = mapToFirestore(paymentProcessingTime.toMap());

  // Handle nested data for "payment_plan_item" field.
  addOrderCartItemStructData(
    firestoreData,
    paymentProcessingTime.hasPaymentPlanItem()
        ? paymentProcessingTime.paymentPlanItem
        : null,
    'payment_plan_item',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(paymentProcessingTime.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPaymentProcessingTimeListFirestoreData(
  List<PaymentProcessingTimeStruct>? paymentProcessingTimes,
) =>
    paymentProcessingTimes
        ?.map((e) => getPaymentProcessingTimeFirestoreData(e, true))
        .toList() ??
    [];
