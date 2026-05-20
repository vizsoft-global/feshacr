// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomUserListStruct extends FFFirebaseStruct {
  RoomUserListStruct({
    String? roomUserOnlineStatus,
    String? roomUserStatus,
    DateTime? roomUserUpdatedTime,
    DateTime? roomUserJoinTime,
    OrderUserMainInfoStruct? roomUserInfo,
    int? roomUserId,
    DocumentReference? roomUserRef,
    int? roomUserPoints,
    String? roomUserReason,
    DocumentReference? roomUserNotificationRef,
    String? roomUserNotificationSendStatus,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _roomUserOnlineStatus = roomUserOnlineStatus,
        _roomUserStatus = roomUserStatus,
        _roomUserUpdatedTime = roomUserUpdatedTime,
        _roomUserJoinTime = roomUserJoinTime,
        _roomUserInfo = roomUserInfo,
        _roomUserId = roomUserId,
        _roomUserRef = roomUserRef,
        _roomUserPoints = roomUserPoints,
        _roomUserReason = roomUserReason,
        _roomUserNotificationRef = roomUserNotificationRef,
        _roomUserNotificationSendStatus = roomUserNotificationSendStatus,
        super(firestoreUtilData);

  // "room_user_online_status" field.
  String? _roomUserOnlineStatus;
  String get roomUserOnlineStatus => _roomUserOnlineStatus ?? '';
  set roomUserOnlineStatus(String? val) => _roomUserOnlineStatus = val;

  bool hasRoomUserOnlineStatus() => _roomUserOnlineStatus != null;

  // "room_user_status" field.
  String? _roomUserStatus;
  String get roomUserStatus => _roomUserStatus ?? '';
  set roomUserStatus(String? val) => _roomUserStatus = val;

  bool hasRoomUserStatus() => _roomUserStatus != null;

  // "room_user_updated_time" field.
  DateTime? _roomUserUpdatedTime;
  DateTime? get roomUserUpdatedTime => _roomUserUpdatedTime;
  set roomUserUpdatedTime(DateTime? val) => _roomUserUpdatedTime = val;

  bool hasRoomUserUpdatedTime() => _roomUserUpdatedTime != null;

  // "room_user_join_time" field.
  DateTime? _roomUserJoinTime;
  DateTime? get roomUserJoinTime => _roomUserJoinTime;
  set roomUserJoinTime(DateTime? val) => _roomUserJoinTime = val;

  bool hasRoomUserJoinTime() => _roomUserJoinTime != null;

  // "room_user_info" field.
  OrderUserMainInfoStruct? _roomUserInfo;
  OrderUserMainInfoStruct get roomUserInfo =>
      _roomUserInfo ?? OrderUserMainInfoStruct();
  set roomUserInfo(OrderUserMainInfoStruct? val) => _roomUserInfo = val;

  void updateRoomUserInfo(Function(OrderUserMainInfoStruct) updateFn) {
    updateFn(_roomUserInfo ??= OrderUserMainInfoStruct());
  }

  bool hasRoomUserInfo() => _roomUserInfo != null;

  // "room_user_id" field.
  int? _roomUserId;
  int get roomUserId => _roomUserId ?? 0;
  set roomUserId(int? val) => _roomUserId = val;

  void incrementRoomUserId(int amount) => roomUserId = roomUserId + amount;

  bool hasRoomUserId() => _roomUserId != null;

  // "room_user_ref" field.
  DocumentReference? _roomUserRef;
  DocumentReference? get roomUserRef => _roomUserRef;
  set roomUserRef(DocumentReference? val) => _roomUserRef = val;

  bool hasRoomUserRef() => _roomUserRef != null;

  // "room_user_points" field.
  int? _roomUserPoints;
  int get roomUserPoints => _roomUserPoints ?? 0;
  set roomUserPoints(int? val) => _roomUserPoints = val;

  void incrementRoomUserPoints(int amount) =>
      roomUserPoints = roomUserPoints + amount;

  bool hasRoomUserPoints() => _roomUserPoints != null;

  // "room_user_reason" field.
  String? _roomUserReason;
  String get roomUserReason => _roomUserReason ?? '';
  set roomUserReason(String? val) => _roomUserReason = val;

  bool hasRoomUserReason() => _roomUserReason != null;

  // "room_user_notification_ref" field.
  DocumentReference? _roomUserNotificationRef;
  DocumentReference? get roomUserNotificationRef => _roomUserNotificationRef;
  set roomUserNotificationRef(DocumentReference? val) =>
      _roomUserNotificationRef = val;

  bool hasRoomUserNotificationRef() => _roomUserNotificationRef != null;

  // "room_user_notification_send_status" field.
  String? _roomUserNotificationSendStatus;
  String get roomUserNotificationSendStatus =>
      _roomUserNotificationSendStatus ?? '';
  set roomUserNotificationSendStatus(String? val) =>
      _roomUserNotificationSendStatus = val;

  bool hasRoomUserNotificationSendStatus() =>
      _roomUserNotificationSendStatus != null;

  static RoomUserListStruct fromMap(Map<String, dynamic> data) =>
      RoomUserListStruct(
        roomUserOnlineStatus: data['room_user_online_status'] as String?,
        roomUserStatus: data['room_user_status'] as String?,
        roomUserUpdatedTime: data['room_user_updated_time'] as DateTime?,
        roomUserJoinTime: data['room_user_join_time'] as DateTime?,
        roomUserInfo: data['room_user_info'] is OrderUserMainInfoStruct
            ? data['room_user_info']
            : OrderUserMainInfoStruct.maybeFromMap(data['room_user_info']),
        roomUserId: castToType<int>(data['room_user_id']),
        roomUserRef: data['room_user_ref'] as DocumentReference?,
        roomUserPoints: castToType<int>(data['room_user_points']),
        roomUserReason: data['room_user_reason'] as String?,
        roomUserNotificationRef:
            data['room_user_notification_ref'] as DocumentReference?,
        roomUserNotificationSendStatus:
            data['room_user_notification_send_status'] as String?,
      );

  static RoomUserListStruct? maybeFromMap(dynamic data) => data is Map
      ? RoomUserListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'room_user_online_status': _roomUserOnlineStatus,
        'room_user_status': _roomUserStatus,
        'room_user_updated_time': _roomUserUpdatedTime,
        'room_user_join_time': _roomUserJoinTime,
        'room_user_info': _roomUserInfo?.toMap(),
        'room_user_id': _roomUserId,
        'room_user_ref': _roomUserRef,
        'room_user_points': _roomUserPoints,
        'room_user_reason': _roomUserReason,
        'room_user_notification_ref': _roomUserNotificationRef,
        'room_user_notification_send_status': _roomUserNotificationSendStatus,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'room_user_online_status': serializeParam(
          _roomUserOnlineStatus,
          ParamType.String,
        ),
        'room_user_status': serializeParam(
          _roomUserStatus,
          ParamType.String,
        ),
        'room_user_updated_time': serializeParam(
          _roomUserUpdatedTime,
          ParamType.DateTime,
        ),
        'room_user_join_time': serializeParam(
          _roomUserJoinTime,
          ParamType.DateTime,
        ),
        'room_user_info': serializeParam(
          _roomUserInfo,
          ParamType.DataStruct,
        ),
        'room_user_id': serializeParam(
          _roomUserId,
          ParamType.int,
        ),
        'room_user_ref': serializeParam(
          _roomUserRef,
          ParamType.DocumentReference,
        ),
        'room_user_points': serializeParam(
          _roomUserPoints,
          ParamType.int,
        ),
        'room_user_reason': serializeParam(
          _roomUserReason,
          ParamType.String,
        ),
        'room_user_notification_ref': serializeParam(
          _roomUserNotificationRef,
          ParamType.DocumentReference,
        ),
        'room_user_notification_send_status': serializeParam(
          _roomUserNotificationSendStatus,
          ParamType.String,
        ),
      }.withoutNulls;

  static RoomUserListStruct fromSerializableMap(Map<String, dynamic> data) =>
      RoomUserListStruct(
        roomUserOnlineStatus: deserializeParam(
          data['room_user_online_status'],
          ParamType.String,
          false,
        ),
        roomUserStatus: deserializeParam(
          data['room_user_status'],
          ParamType.String,
          false,
        ),
        roomUserUpdatedTime: deserializeParam(
          data['room_user_updated_time'],
          ParamType.DateTime,
          false,
        ),
        roomUserJoinTime: deserializeParam(
          data['room_user_join_time'],
          ParamType.DateTime,
          false,
        ),
        roomUserInfo: deserializeStructParam(
          data['room_user_info'],
          ParamType.DataStruct,
          false,
          structBuilder: OrderUserMainInfoStruct.fromSerializableMap,
        ),
        roomUserId: deserializeParam(
          data['room_user_id'],
          ParamType.int,
          false,
        ),
        roomUserRef: deserializeParam(
          data['room_user_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        roomUserPoints: deserializeParam(
          data['room_user_points'],
          ParamType.int,
          false,
        ),
        roomUserReason: deserializeParam(
          data['room_user_reason'],
          ParamType.String,
          false,
        ),
        roomUserNotificationRef: deserializeParam(
          data['room_user_notification_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['notification'],
        ),
        roomUserNotificationSendStatus: deserializeParam(
          data['room_user_notification_send_status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RoomUserListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RoomUserListStruct &&
        roomUserOnlineStatus == other.roomUserOnlineStatus &&
        roomUserStatus == other.roomUserStatus &&
        roomUserUpdatedTime == other.roomUserUpdatedTime &&
        roomUserJoinTime == other.roomUserJoinTime &&
        roomUserInfo == other.roomUserInfo &&
        roomUserId == other.roomUserId &&
        roomUserRef == other.roomUserRef &&
        roomUserPoints == other.roomUserPoints &&
        roomUserReason == other.roomUserReason &&
        roomUserNotificationRef == other.roomUserNotificationRef &&
        roomUserNotificationSendStatus == other.roomUserNotificationSendStatus;
  }

  @override
  int get hashCode => const ListEquality().hash([
        roomUserOnlineStatus,
        roomUserStatus,
        roomUserUpdatedTime,
        roomUserJoinTime,
        roomUserInfo,
        roomUserId,
        roomUserRef,
        roomUserPoints,
        roomUserReason,
        roomUserNotificationRef,
        roomUserNotificationSendStatus
      ]);
}

RoomUserListStruct createRoomUserListStruct({
  String? roomUserOnlineStatus,
  String? roomUserStatus,
  DateTime? roomUserUpdatedTime,
  DateTime? roomUserJoinTime,
  OrderUserMainInfoStruct? roomUserInfo,
  int? roomUserId,
  DocumentReference? roomUserRef,
  int? roomUserPoints,
  String? roomUserReason,
  DocumentReference? roomUserNotificationRef,
  String? roomUserNotificationSendStatus,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RoomUserListStruct(
      roomUserOnlineStatus: roomUserOnlineStatus,
      roomUserStatus: roomUserStatus,
      roomUserUpdatedTime: roomUserUpdatedTime,
      roomUserJoinTime: roomUserJoinTime,
      roomUserInfo:
          roomUserInfo ?? (clearUnsetFields ? OrderUserMainInfoStruct() : null),
      roomUserId: roomUserId,
      roomUserRef: roomUserRef,
      roomUserPoints: roomUserPoints,
      roomUserReason: roomUserReason,
      roomUserNotificationRef: roomUserNotificationRef,
      roomUserNotificationSendStatus: roomUserNotificationSendStatus,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RoomUserListStruct? updateRoomUserListStruct(
  RoomUserListStruct? roomUserList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    roomUserList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRoomUserListStructData(
  Map<String, dynamic> firestoreData,
  RoomUserListStruct? roomUserList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (roomUserList == null) {
    return;
  }
  if (roomUserList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && roomUserList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final roomUserListData =
      getRoomUserListFirestoreData(roomUserList, forFieldValue);
  final nestedData =
      roomUserListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = roomUserList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRoomUserListFirestoreData(
  RoomUserListStruct? roomUserList, [
  bool forFieldValue = false,
]) {
  if (roomUserList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(roomUserList.toMap());

  // Handle nested data for "room_user_info" field.
  addOrderUserMainInfoStructData(
    firestoreData,
    roomUserList.hasRoomUserInfo() ? roomUserList.roomUserInfo : null,
    'room_user_info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(roomUserList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRoomUserListListFirestoreData(
  List<RoomUserListStruct>? roomUserLists,
) =>
    roomUserLists?.map((e) => getRoomUserListFirestoreData(e, true)).toList() ??
    [];
