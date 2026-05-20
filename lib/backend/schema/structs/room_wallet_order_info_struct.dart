// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomWalletOrderInfoStruct extends FFFirebaseStruct {
  RoomWalletOrderInfoStruct({
    DocumentReference? orderRef,
    int? orderID,
    String? orderStatus,
    String? orderType,
    double? orderAmount,
    DocumentReference? orderUserRef,
    OrderCartItemStruct? orderCartItem,
    int? roomPreviousPoint,
    int? roomAddedPoint,
    int? roomTotalPoint,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _orderRef = orderRef,
        _orderID = orderID,
        _orderStatus = orderStatus,
        _orderType = orderType,
        _orderAmount = orderAmount,
        _orderUserRef = orderUserRef,
        _orderCartItem = orderCartItem,
        _roomPreviousPoint = roomPreviousPoint,
        _roomAddedPoint = roomAddedPoint,
        _roomTotalPoint = roomTotalPoint,
        super(firestoreUtilData);

  // "order_ref" field.
  DocumentReference? _orderRef;
  DocumentReference? get orderRef => _orderRef;
  set orderRef(DocumentReference? val) => _orderRef = val;

  bool hasOrderRef() => _orderRef != null;

  // "order_ID" field.
  int? _orderID;
  int get orderID => _orderID ?? 0;
  set orderID(int? val) => _orderID = val;

  void incrementOrderID(int amount) => orderID = orderID + amount;

  bool hasOrderID() => _orderID != null;

  // "order_status" field.
  String? _orderStatus;
  String get orderStatus => _orderStatus ?? '';
  set orderStatus(String? val) => _orderStatus = val;

  bool hasOrderStatus() => _orderStatus != null;

  // "order_type" field.
  String? _orderType;
  String get orderType => _orderType ?? '';
  set orderType(String? val) => _orderType = val;

  bool hasOrderType() => _orderType != null;

  // "order_amount" field.
  double? _orderAmount;
  double get orderAmount => _orderAmount ?? 0.0;
  set orderAmount(double? val) => _orderAmount = val;

  void incrementOrderAmount(double amount) =>
      orderAmount = orderAmount + amount;

  bool hasOrderAmount() => _orderAmount != null;

  // "order_userRef" field.
  DocumentReference? _orderUserRef;
  DocumentReference? get orderUserRef => _orderUserRef;
  set orderUserRef(DocumentReference? val) => _orderUserRef = val;

  bool hasOrderUserRef() => _orderUserRef != null;

  // "order_cart_item" field.
  OrderCartItemStruct? _orderCartItem;
  OrderCartItemStruct get orderCartItem =>
      _orderCartItem ?? OrderCartItemStruct();
  set orderCartItem(OrderCartItemStruct? val) => _orderCartItem = val;

  void updateOrderCartItem(Function(OrderCartItemStruct) updateFn) {
    updateFn(_orderCartItem ??= OrderCartItemStruct());
  }

  bool hasOrderCartItem() => _orderCartItem != null;

  // "room_previous_point" field.
  int? _roomPreviousPoint;
  int get roomPreviousPoint => _roomPreviousPoint ?? 0;
  set roomPreviousPoint(int? val) => _roomPreviousPoint = val;

  void incrementRoomPreviousPoint(int amount) =>
      roomPreviousPoint = roomPreviousPoint + amount;

  bool hasRoomPreviousPoint() => _roomPreviousPoint != null;

  // "room_added_point" field.
  int? _roomAddedPoint;
  int get roomAddedPoint => _roomAddedPoint ?? 0;
  set roomAddedPoint(int? val) => _roomAddedPoint = val;

  void incrementRoomAddedPoint(int amount) =>
      roomAddedPoint = roomAddedPoint + amount;

  bool hasRoomAddedPoint() => _roomAddedPoint != null;

  // "room_total_point" field.
  int? _roomTotalPoint;
  int get roomTotalPoint => _roomTotalPoint ?? 0;
  set roomTotalPoint(int? val) => _roomTotalPoint = val;

  void incrementRoomTotalPoint(int amount) =>
      roomTotalPoint = roomTotalPoint + amount;

  bool hasRoomTotalPoint() => _roomTotalPoint != null;

  static RoomWalletOrderInfoStruct fromMap(Map<String, dynamic> data) =>
      RoomWalletOrderInfoStruct(
        orderRef: data['order_ref'] as DocumentReference?,
        orderID: castToType<int>(data['order_ID']),
        orderStatus: data['order_status'] as String?,
        orderType: data['order_type'] as String?,
        orderAmount: castToType<double>(data['order_amount']),
        orderUserRef: data['order_userRef'] as DocumentReference?,
        orderCartItem: data['order_cart_item'] is OrderCartItemStruct
            ? data['order_cart_item']
            : OrderCartItemStruct.maybeFromMap(data['order_cart_item']),
        roomPreviousPoint: castToType<int>(data['room_previous_point']),
        roomAddedPoint: castToType<int>(data['room_added_point']),
        roomTotalPoint: castToType<int>(data['room_total_point']),
      );

  static RoomWalletOrderInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? RoomWalletOrderInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'order_ref': _orderRef,
        'order_ID': _orderID,
        'order_status': _orderStatus,
        'order_type': _orderType,
        'order_amount': _orderAmount,
        'order_userRef': _orderUserRef,
        'order_cart_item': _orderCartItem?.toMap(),
        'room_previous_point': _roomPreviousPoint,
        'room_added_point': _roomAddedPoint,
        'room_total_point': _roomTotalPoint,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'order_ref': serializeParam(
          _orderRef,
          ParamType.DocumentReference,
        ),
        'order_ID': serializeParam(
          _orderID,
          ParamType.int,
        ),
        'order_status': serializeParam(
          _orderStatus,
          ParamType.String,
        ),
        'order_type': serializeParam(
          _orderType,
          ParamType.String,
        ),
        'order_amount': serializeParam(
          _orderAmount,
          ParamType.double,
        ),
        'order_userRef': serializeParam(
          _orderUserRef,
          ParamType.DocumentReference,
        ),
        'order_cart_item': serializeParam(
          _orderCartItem,
          ParamType.DataStruct,
        ),
        'room_previous_point': serializeParam(
          _roomPreviousPoint,
          ParamType.int,
        ),
        'room_added_point': serializeParam(
          _roomAddedPoint,
          ParamType.int,
        ),
        'room_total_point': serializeParam(
          _roomTotalPoint,
          ParamType.int,
        ),
      }.withoutNulls;

  static RoomWalletOrderInfoStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RoomWalletOrderInfoStruct(
        orderRef: deserializeParam(
          data['order_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['order'],
        ),
        orderID: deserializeParam(
          data['order_ID'],
          ParamType.int,
          false,
        ),
        orderStatus: deserializeParam(
          data['order_status'],
          ParamType.String,
          false,
        ),
        orderType: deserializeParam(
          data['order_type'],
          ParamType.String,
          false,
        ),
        orderAmount: deserializeParam(
          data['order_amount'],
          ParamType.double,
          false,
        ),
        orderUserRef: deserializeParam(
          data['order_userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        orderCartItem: deserializeStructParam(
          data['order_cart_item'],
          ParamType.DataStruct,
          false,
          structBuilder: OrderCartItemStruct.fromSerializableMap,
        ),
        roomPreviousPoint: deserializeParam(
          data['room_previous_point'],
          ParamType.int,
          false,
        ),
        roomAddedPoint: deserializeParam(
          data['room_added_point'],
          ParamType.int,
          false,
        ),
        roomTotalPoint: deserializeParam(
          data['room_total_point'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'RoomWalletOrderInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RoomWalletOrderInfoStruct &&
        orderRef == other.orderRef &&
        orderID == other.orderID &&
        orderStatus == other.orderStatus &&
        orderType == other.orderType &&
        orderAmount == other.orderAmount &&
        orderUserRef == other.orderUserRef &&
        orderCartItem == other.orderCartItem &&
        roomPreviousPoint == other.roomPreviousPoint &&
        roomAddedPoint == other.roomAddedPoint &&
        roomTotalPoint == other.roomTotalPoint;
  }

  @override
  int get hashCode => const ListEquality().hash([
        orderRef,
        orderID,
        orderStatus,
        orderType,
        orderAmount,
        orderUserRef,
        orderCartItem,
        roomPreviousPoint,
        roomAddedPoint,
        roomTotalPoint
      ]);
}

RoomWalletOrderInfoStruct createRoomWalletOrderInfoStruct({
  DocumentReference? orderRef,
  int? orderID,
  String? orderStatus,
  String? orderType,
  double? orderAmount,
  DocumentReference? orderUserRef,
  OrderCartItemStruct? orderCartItem,
  int? roomPreviousPoint,
  int? roomAddedPoint,
  int? roomTotalPoint,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RoomWalletOrderInfoStruct(
      orderRef: orderRef,
      orderID: orderID,
      orderStatus: orderStatus,
      orderType: orderType,
      orderAmount: orderAmount,
      orderUserRef: orderUserRef,
      orderCartItem:
          orderCartItem ?? (clearUnsetFields ? OrderCartItemStruct() : null),
      roomPreviousPoint: roomPreviousPoint,
      roomAddedPoint: roomAddedPoint,
      roomTotalPoint: roomTotalPoint,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RoomWalletOrderInfoStruct? updateRoomWalletOrderInfoStruct(
  RoomWalletOrderInfoStruct? roomWalletOrderInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    roomWalletOrderInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRoomWalletOrderInfoStructData(
  Map<String, dynamic> firestoreData,
  RoomWalletOrderInfoStruct? roomWalletOrderInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (roomWalletOrderInfo == null) {
    return;
  }
  if (roomWalletOrderInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && roomWalletOrderInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final roomWalletOrderInfoData =
      getRoomWalletOrderInfoFirestoreData(roomWalletOrderInfo, forFieldValue);
  final nestedData =
      roomWalletOrderInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      roomWalletOrderInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRoomWalletOrderInfoFirestoreData(
  RoomWalletOrderInfoStruct? roomWalletOrderInfo, [
  bool forFieldValue = false,
]) {
  if (roomWalletOrderInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(roomWalletOrderInfo.toMap());

  // Handle nested data for "order_cart_item" field.
  addOrderCartItemStructData(
    firestoreData,
    roomWalletOrderInfo.hasOrderCartItem()
        ? roomWalletOrderInfo.orderCartItem
        : null,
    'order_cart_item',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(roomWalletOrderInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRoomWalletOrderInfoListFirestoreData(
  List<RoomWalletOrderInfoStruct>? roomWalletOrderInfos,
) =>
    roomWalletOrderInfos
        ?.map((e) => getRoomWalletOrderInfoFirestoreData(e, true))
        .toList() ??
    [];
