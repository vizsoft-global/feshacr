// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrderCartItemStruct extends FFFirebaseStruct {
  OrderCartItemStruct({
    String? type,
    String? planFor,
    DocumentReference? roomRef,
    int? planPoint,
    DocumentReference? planRef,
    int? planId,
    MainInfoStruct? planInfo,
    int? quantity,
    double? planPrice,
    double? totalPrice,
    bool? couponStatus,
    CouponCartInfoStruct? couponInfo,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _type = type,
        _planFor = planFor,
        _roomRef = roomRef,
        _planPoint = planPoint,
        _planRef = planRef,
        _planId = planId,
        _planInfo = planInfo,
        _quantity = quantity,
        _planPrice = planPrice,
        _totalPrice = totalPrice,
        _couponStatus = couponStatus,
        _couponInfo = couponInfo,
        super(firestoreUtilData);

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "plan_for" field.
  String? _planFor;
  String get planFor => _planFor ?? '';
  set planFor(String? val) => _planFor = val;

  bool hasPlanFor() => _planFor != null;

  // "room_ref" field.
  DocumentReference? _roomRef;
  DocumentReference? get roomRef => _roomRef;
  set roomRef(DocumentReference? val) => _roomRef = val;

  bool hasRoomRef() => _roomRef != null;

  // "plan_point" field.
  int? _planPoint;
  int get planPoint => _planPoint ?? 0;
  set planPoint(int? val) => _planPoint = val;

  void incrementPlanPoint(int amount) => planPoint = planPoint + amount;

  bool hasPlanPoint() => _planPoint != null;

  // "plan_ref" field.
  DocumentReference? _planRef;
  DocumentReference? get planRef => _planRef;
  set planRef(DocumentReference? val) => _planRef = val;

  bool hasPlanRef() => _planRef != null;

  // "plan_id" field.
  int? _planId;
  int get planId => _planId ?? 0;
  set planId(int? val) => _planId = val;

  void incrementPlanId(int amount) => planId = planId + amount;

  bool hasPlanId() => _planId != null;

  // "plan_info" field.
  MainInfoStruct? _planInfo;
  MainInfoStruct get planInfo => _planInfo ?? MainInfoStruct();
  set planInfo(MainInfoStruct? val) => _planInfo = val;

  void updatePlanInfo(Function(MainInfoStruct) updateFn) {
    updateFn(_planInfo ??= MainInfoStruct());
  }

  bool hasPlanInfo() => _planInfo != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "plan_price" field.
  double? _planPrice;
  double get planPrice => _planPrice ?? 0.0;
  set planPrice(double? val) => _planPrice = val;

  void incrementPlanPrice(double amount) => planPrice = planPrice + amount;

  bool hasPlanPrice() => _planPrice != null;

  // "total_price" field.
  double? _totalPrice;
  double get totalPrice => _totalPrice ?? 0.0;
  set totalPrice(double? val) => _totalPrice = val;

  void incrementTotalPrice(double amount) => totalPrice = totalPrice + amount;

  bool hasTotalPrice() => _totalPrice != null;

  // "coupon_status" field.
  bool? _couponStatus;
  bool get couponStatus => _couponStatus ?? false;
  set couponStatus(bool? val) => _couponStatus = val;

  bool hasCouponStatus() => _couponStatus != null;

  // "coupon_info" field.
  CouponCartInfoStruct? _couponInfo;
  CouponCartInfoStruct get couponInfo => _couponInfo ?? CouponCartInfoStruct();
  set couponInfo(CouponCartInfoStruct? val) => _couponInfo = val;

  void updateCouponInfo(Function(CouponCartInfoStruct) updateFn) {
    updateFn(_couponInfo ??= CouponCartInfoStruct());
  }

  bool hasCouponInfo() => _couponInfo != null;

  static OrderCartItemStruct fromMap(Map<String, dynamic> data) =>
      OrderCartItemStruct(
        type: data['type'] as String?,
        planFor: data['plan_for'] as String?,
        roomRef: data['room_ref'] as DocumentReference?,
        planPoint: castToType<int>(data['plan_point']),
        planRef: data['plan_ref'] as DocumentReference?,
        planId: castToType<int>(data['plan_id']),
        planInfo: data['plan_info'] is MainInfoStruct
            ? data['plan_info']
            : MainInfoStruct.maybeFromMap(data['plan_info']),
        quantity: castToType<int>(data['quantity']),
        planPrice: castToType<double>(data['plan_price']),
        totalPrice: castToType<double>(data['total_price']),
        couponStatus: data['coupon_status'] as bool?,
        couponInfo: data['coupon_info'] is CouponCartInfoStruct
            ? data['coupon_info']
            : CouponCartInfoStruct.maybeFromMap(data['coupon_info']),
      );

  static OrderCartItemStruct? maybeFromMap(dynamic data) => data is Map
      ? OrderCartItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
        'plan_for': _planFor,
        'room_ref': _roomRef,
        'plan_point': _planPoint,
        'plan_ref': _planRef,
        'plan_id': _planId,
        'plan_info': _planInfo?.toMap(),
        'quantity': _quantity,
        'plan_price': _planPrice,
        'total_price': _totalPrice,
        'coupon_status': _couponStatus,
        'coupon_info': _couponInfo?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'plan_for': serializeParam(
          _planFor,
          ParamType.String,
        ),
        'room_ref': serializeParam(
          _roomRef,
          ParamType.DocumentReference,
        ),
        'plan_point': serializeParam(
          _planPoint,
          ParamType.int,
        ),
        'plan_ref': serializeParam(
          _planRef,
          ParamType.DocumentReference,
        ),
        'plan_id': serializeParam(
          _planId,
          ParamType.int,
        ),
        'plan_info': serializeParam(
          _planInfo,
          ParamType.DataStruct,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'plan_price': serializeParam(
          _planPrice,
          ParamType.double,
        ),
        'total_price': serializeParam(
          _totalPrice,
          ParamType.double,
        ),
        'coupon_status': serializeParam(
          _couponStatus,
          ParamType.bool,
        ),
        'coupon_info': serializeParam(
          _couponInfo,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static OrderCartItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      OrderCartItemStruct(
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        planFor: deserializeParam(
          data['plan_for'],
          ParamType.String,
          false,
        ),
        roomRef: deserializeParam(
          data['room_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['room'],
        ),
        planPoint: deserializeParam(
          data['plan_point'],
          ParamType.int,
          false,
        ),
        planRef: deserializeParam(
          data['plan_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['point'],
        ),
        planId: deserializeParam(
          data['plan_id'],
          ParamType.int,
          false,
        ),
        planInfo: deserializeStructParam(
          data['plan_info'],
          ParamType.DataStruct,
          false,
          structBuilder: MainInfoStruct.fromSerializableMap,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        planPrice: deserializeParam(
          data['plan_price'],
          ParamType.double,
          false,
        ),
        totalPrice: deserializeParam(
          data['total_price'],
          ParamType.double,
          false,
        ),
        couponStatus: deserializeParam(
          data['coupon_status'],
          ParamType.bool,
          false,
        ),
        couponInfo: deserializeStructParam(
          data['coupon_info'],
          ParamType.DataStruct,
          false,
          structBuilder: CouponCartInfoStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'OrderCartItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OrderCartItemStruct &&
        type == other.type &&
        planFor == other.planFor &&
        roomRef == other.roomRef &&
        planPoint == other.planPoint &&
        planRef == other.planRef &&
        planId == other.planId &&
        planInfo == other.planInfo &&
        quantity == other.quantity &&
        planPrice == other.planPrice &&
        totalPrice == other.totalPrice &&
        couponStatus == other.couponStatus &&
        couponInfo == other.couponInfo;
  }

  @override
  int get hashCode => const ListEquality().hash([
        type,
        planFor,
        roomRef,
        planPoint,
        planRef,
        planId,
        planInfo,
        quantity,
        planPrice,
        totalPrice,
        couponStatus,
        couponInfo
      ]);
}

OrderCartItemStruct createOrderCartItemStruct({
  String? type,
  String? planFor,
  DocumentReference? roomRef,
  int? planPoint,
  DocumentReference? planRef,
  int? planId,
  MainInfoStruct? planInfo,
  int? quantity,
  double? planPrice,
  double? totalPrice,
  bool? couponStatus,
  CouponCartInfoStruct? couponInfo,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OrderCartItemStruct(
      type: type,
      planFor: planFor,
      roomRef: roomRef,
      planPoint: planPoint,
      planRef: planRef,
      planId: planId,
      planInfo: planInfo ?? (clearUnsetFields ? MainInfoStruct() : null),
      quantity: quantity,
      planPrice: planPrice,
      totalPrice: totalPrice,
      couponStatus: couponStatus,
      couponInfo:
          couponInfo ?? (clearUnsetFields ? CouponCartInfoStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OrderCartItemStruct? updateOrderCartItemStruct(
  OrderCartItemStruct? orderCartItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    orderCartItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOrderCartItemStructData(
  Map<String, dynamic> firestoreData,
  OrderCartItemStruct? orderCartItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (orderCartItem == null) {
    return;
  }
  if (orderCartItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && orderCartItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final orderCartItemData =
      getOrderCartItemFirestoreData(orderCartItem, forFieldValue);
  final nestedData =
      orderCartItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = orderCartItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOrderCartItemFirestoreData(
  OrderCartItemStruct? orderCartItem, [
  bool forFieldValue = false,
]) {
  if (orderCartItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(orderCartItem.toMap());

  // Handle nested data for "plan_info" field.
  addMainInfoStructData(
    firestoreData,
    orderCartItem.hasPlanInfo() ? orderCartItem.planInfo : null,
    'plan_info',
    forFieldValue,
  );

  // Handle nested data for "coupon_info" field.
  addCouponCartInfoStructData(
    firestoreData,
    orderCartItem.hasCouponInfo() ? orderCartItem.couponInfo : null,
    'coupon_info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(orderCartItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOrderCartItemListFirestoreData(
  List<OrderCartItemStruct>? orderCartItems,
) =>
    orderCartItems
        ?.map((e) => getOrderCartItemFirestoreData(e, true))
        .toList() ??
    [];
