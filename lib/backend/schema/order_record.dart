import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrderRecord extends FirestoreRecord {
  OrderRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "order_ID" field.
  int? _orderID;
  int get orderID => _orderID ?? 0;
  bool hasOrderID() => _orderID != null;

  // "order_status" field.
  String? _orderStatus;
  String get orderStatus => _orderStatus ?? '';
  bool hasOrderStatus() => _orderStatus != null;

  // "order_amount" field.
  double? _orderAmount;
  double get orderAmount => _orderAmount ?? 0.0;
  bool hasOrderAmount() => _orderAmount != null;

  // "order_user_main_info" field.
  OrderUserMainInfoStruct? _orderUserMainInfo;
  OrderUserMainInfoStruct get orderUserMainInfo =>
      _orderUserMainInfo ?? OrderUserMainInfoStruct();
  bool hasOrderUserMainInfo() => _orderUserMainInfo != null;

  // "order_payment_info" field.
  OrderPaymentInfoStruct? _orderPaymentInfo;
  OrderPaymentInfoStruct get orderPaymentInfo =>
      _orderPaymentInfo ?? OrderPaymentInfoStruct();
  bool hasOrderPaymentInfo() => _orderPaymentInfo != null;

  // "order_cart_item" field.
  OrderCartItemStruct? _orderCartItem;
  OrderCartItemStruct get orderCartItem =>
      _orderCartItem ?? OrderCartItemStruct();
  bool hasOrderCartItem() => _orderCartItem != null;

  // "order_userRef" field.
  DocumentReference? _orderUserRef;
  DocumentReference? get orderUserRef => _orderUserRef;
  bool hasOrderUserRef() => _orderUserRef != null;

  // "order_type" field.
  String? _orderType;
  String get orderType => _orderType ?? '';
  bool hasOrderType() => _orderType != null;

  // "order_coupon_info" field.
  CouponCartInfoStruct? _orderCouponInfo;
  CouponCartInfoStruct get orderCouponInfo =>
      _orderCouponInfo ?? CouponCartInfoStruct();
  bool hasOrderCouponInfo() => _orderCouponInfo != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _orderID = castToType<int>(snapshotData['order_ID']);
    _orderStatus = snapshotData['order_status'] as String?;
    _orderAmount = castToType<double>(snapshotData['order_amount']);
    _orderUserMainInfo =
        snapshotData['order_user_main_info'] is OrderUserMainInfoStruct
            ? snapshotData['order_user_main_info']
            : OrderUserMainInfoStruct.maybeFromMap(
                snapshotData['order_user_main_info']);
    _orderPaymentInfo =
        snapshotData['order_payment_info'] is OrderPaymentInfoStruct
            ? snapshotData['order_payment_info']
            : OrderPaymentInfoStruct.maybeFromMap(
                snapshotData['order_payment_info']);
    _orderCartItem = snapshotData['order_cart_item'] is OrderCartItemStruct
        ? snapshotData['order_cart_item']
        : OrderCartItemStruct.maybeFromMap(snapshotData['order_cart_item']);
    _orderUserRef = snapshotData['order_userRef'] as DocumentReference?;
    _orderType = snapshotData['order_type'] as String?;
    _orderCouponInfo = snapshotData['order_coupon_info'] is CouponCartInfoStruct
        ? snapshotData['order_coupon_info']
        : CouponCartInfoStruct.maybeFromMap(snapshotData['order_coupon_info']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('order');

  static Stream<OrderRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OrderRecord.fromSnapshot(s));

  static Future<OrderRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OrderRecord.fromSnapshot(s));

  static OrderRecord fromSnapshot(DocumentSnapshot snapshot) => OrderRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OrderRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OrderRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OrderRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OrderRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOrderRecordData({
  DateTime? createdAt,
  DateTime? updatedAt,
  int? orderID,
  String? orderStatus,
  double? orderAmount,
  OrderUserMainInfoStruct? orderUserMainInfo,
  OrderPaymentInfoStruct? orderPaymentInfo,
  OrderCartItemStruct? orderCartItem,
  DocumentReference? orderUserRef,
  String? orderType,
  CouponCartInfoStruct? orderCouponInfo,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'updated_at': updatedAt,
      'order_ID': orderID,
      'order_status': orderStatus,
      'order_amount': orderAmount,
      'order_user_main_info': OrderUserMainInfoStruct().toMap(),
      'order_payment_info': OrderPaymentInfoStruct().toMap(),
      'order_cart_item': OrderCartItemStruct().toMap(),
      'order_userRef': orderUserRef,
      'order_type': orderType,
      'order_coupon_info': CouponCartInfoStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "order_user_main_info" field.
  addOrderUserMainInfoStructData(
      firestoreData, orderUserMainInfo, 'order_user_main_info');

  // Handle nested data for "order_payment_info" field.
  addOrderPaymentInfoStructData(
      firestoreData, orderPaymentInfo, 'order_payment_info');

  // Handle nested data for "order_cart_item" field.
  addOrderCartItemStructData(firestoreData, orderCartItem, 'order_cart_item');

  // Handle nested data for "order_coupon_info" field.
  addCouponCartInfoStructData(
      firestoreData, orderCouponInfo, 'order_coupon_info');

  return firestoreData;
}

class OrderRecordDocumentEquality implements Equality<OrderRecord> {
  const OrderRecordDocumentEquality();

  @override
  bool equals(OrderRecord? e1, OrderRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.orderID == e2?.orderID &&
        e1?.orderStatus == e2?.orderStatus &&
        e1?.orderAmount == e2?.orderAmount &&
        e1?.orderUserMainInfo == e2?.orderUserMainInfo &&
        e1?.orderPaymentInfo == e2?.orderPaymentInfo &&
        e1?.orderCartItem == e2?.orderCartItem &&
        e1?.orderUserRef == e2?.orderUserRef &&
        e1?.orderType == e2?.orderType &&
        e1?.orderCouponInfo == e2?.orderCouponInfo;
  }

  @override
  int hash(OrderRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.updatedAt,
        e?.orderID,
        e?.orderStatus,
        e?.orderAmount,
        e?.orderUserMainInfo,
        e?.orderPaymentInfo,
        e?.orderCartItem,
        e?.orderUserRef,
        e?.orderType,
        e?.orderCouponInfo
      ]);

  @override
  bool isValidKey(Object? o) => o is OrderRecord;
}
