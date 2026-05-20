// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrderPaymentInfoStruct extends FFFirebaseStruct {
  OrderPaymentInfoStruct({
    String? orderPaymentId,
    String? orderPaymentMethod,
    String? orderPaymentType,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _orderPaymentId = orderPaymentId,
        _orderPaymentMethod = orderPaymentMethod,
        _orderPaymentType = orderPaymentType,
        super(firestoreUtilData);

  // "order_paymentId" field.
  String? _orderPaymentId;
  String get orderPaymentId => _orderPaymentId ?? '';
  set orderPaymentId(String? val) => _orderPaymentId = val;

  bool hasOrderPaymentId() => _orderPaymentId != null;

  // "order_paymentMethod" field.
  String? _orderPaymentMethod;
  String get orderPaymentMethod => _orderPaymentMethod ?? '';
  set orderPaymentMethod(String? val) => _orderPaymentMethod = val;

  bool hasOrderPaymentMethod() => _orderPaymentMethod != null;

  // "order_paymentType" field.
  String? _orderPaymentType;
  String get orderPaymentType => _orderPaymentType ?? '';
  set orderPaymentType(String? val) => _orderPaymentType = val;

  bool hasOrderPaymentType() => _orderPaymentType != null;

  static OrderPaymentInfoStruct fromMap(Map<String, dynamic> data) =>
      OrderPaymentInfoStruct(
        orderPaymentId: data['order_paymentId'] as String?,
        orderPaymentMethod: data['order_paymentMethod'] as String?,
        orderPaymentType: data['order_paymentType'] as String?,
      );

  static OrderPaymentInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? OrderPaymentInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'order_paymentId': _orderPaymentId,
        'order_paymentMethod': _orderPaymentMethod,
        'order_paymentType': _orderPaymentType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'order_paymentId': serializeParam(
          _orderPaymentId,
          ParamType.String,
        ),
        'order_paymentMethod': serializeParam(
          _orderPaymentMethod,
          ParamType.String,
        ),
        'order_paymentType': serializeParam(
          _orderPaymentType,
          ParamType.String,
        ),
      }.withoutNulls;

  static OrderPaymentInfoStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      OrderPaymentInfoStruct(
        orderPaymentId: deserializeParam(
          data['order_paymentId'],
          ParamType.String,
          false,
        ),
        orderPaymentMethod: deserializeParam(
          data['order_paymentMethod'],
          ParamType.String,
          false,
        ),
        orderPaymentType: deserializeParam(
          data['order_paymentType'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OrderPaymentInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OrderPaymentInfoStruct &&
        orderPaymentId == other.orderPaymentId &&
        orderPaymentMethod == other.orderPaymentMethod &&
        orderPaymentType == other.orderPaymentType;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([orderPaymentId, orderPaymentMethod, orderPaymentType]);
}

OrderPaymentInfoStruct createOrderPaymentInfoStruct({
  String? orderPaymentId,
  String? orderPaymentMethod,
  String? orderPaymentType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OrderPaymentInfoStruct(
      orderPaymentId: orderPaymentId,
      orderPaymentMethod: orderPaymentMethod,
      orderPaymentType: orderPaymentType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OrderPaymentInfoStruct? updateOrderPaymentInfoStruct(
  OrderPaymentInfoStruct? orderPaymentInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    orderPaymentInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOrderPaymentInfoStructData(
  Map<String, dynamic> firestoreData,
  OrderPaymentInfoStruct? orderPaymentInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (orderPaymentInfo == null) {
    return;
  }
  if (orderPaymentInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && orderPaymentInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final orderPaymentInfoData =
      getOrderPaymentInfoFirestoreData(orderPaymentInfo, forFieldValue);
  final nestedData =
      orderPaymentInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = orderPaymentInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOrderPaymentInfoFirestoreData(
  OrderPaymentInfoStruct? orderPaymentInfo, [
  bool forFieldValue = false,
]) {
  if (orderPaymentInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(orderPaymentInfo.toMap());

  // Add any Firestore field values
  mapToFirestore(orderPaymentInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOrderPaymentInfoListFirestoreData(
  List<OrderPaymentInfoStruct>? orderPaymentInfos,
) =>
    orderPaymentInfos
        ?.map((e) => getOrderPaymentInfoFirestoreData(e, true))
        .toList() ??
    [];
