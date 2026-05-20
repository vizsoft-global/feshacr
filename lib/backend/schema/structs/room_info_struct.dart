// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomInfoStruct extends FFFirebaseStruct {
  RoomInfoStruct({
    DocumentReference? roomRef,
    String? roomStatus,
    int? roomId,
    int? roomMemberLimit,
    int? roomCreatedByUserId,
    DocumentReference? roomCreatedByUserRef,
    List<int>? roomUserList,
    MainInfoStruct? roomInfo,
    DateTime? roomInviteTime,
    int? fromUserId,
    DocumentReference? fromUserRef,
    String? inviteStatus,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _roomRef = roomRef,
        _roomStatus = roomStatus,
        _roomId = roomId,
        _roomMemberLimit = roomMemberLimit,
        _roomCreatedByUserId = roomCreatedByUserId,
        _roomCreatedByUserRef = roomCreatedByUserRef,
        _roomUserList = roomUserList,
        _roomInfo = roomInfo,
        _roomInviteTime = roomInviteTime,
        _fromUserId = fromUserId,
        _fromUserRef = fromUserRef,
        _inviteStatus = inviteStatus,
        super(firestoreUtilData);

  // "room_ref" field.
  DocumentReference? _roomRef;
  DocumentReference? get roomRef => _roomRef;
  set roomRef(DocumentReference? val) => _roomRef = val;

  bool hasRoomRef() => _roomRef != null;

  // "room_status" field.
  String? _roomStatus;
  String get roomStatus => _roomStatus ?? '';
  set roomStatus(String? val) => _roomStatus = val;

  bool hasRoomStatus() => _roomStatus != null;

  // "room_id" field.
  int? _roomId;
  int get roomId => _roomId ?? 0;
  set roomId(int? val) => _roomId = val;

  void incrementRoomId(int amount) => roomId = roomId + amount;

  bool hasRoomId() => _roomId != null;

  // "room_member_limit" field.
  int? _roomMemberLimit;
  int get roomMemberLimit => _roomMemberLimit ?? 0;
  set roomMemberLimit(int? val) => _roomMemberLimit = val;

  void incrementRoomMemberLimit(int amount) =>
      roomMemberLimit = roomMemberLimit + amount;

  bool hasRoomMemberLimit() => _roomMemberLimit != null;

  // "room_created_by_user_id" field.
  int? _roomCreatedByUserId;
  int get roomCreatedByUserId => _roomCreatedByUserId ?? 0;
  set roomCreatedByUserId(int? val) => _roomCreatedByUserId = val;

  void incrementRoomCreatedByUserId(int amount) =>
      roomCreatedByUserId = roomCreatedByUserId + amount;

  bool hasRoomCreatedByUserId() => _roomCreatedByUserId != null;

  // "room_created_by_user_ref" field.
  DocumentReference? _roomCreatedByUserRef;
  DocumentReference? get roomCreatedByUserRef => _roomCreatedByUserRef;
  set roomCreatedByUserRef(DocumentReference? val) =>
      _roomCreatedByUserRef = val;

  bool hasRoomCreatedByUserRef() => _roomCreatedByUserRef != null;

  // "room_user_list" field.
  List<int>? _roomUserList;
  List<int> get roomUserList => _roomUserList ?? const [];
  set roomUserList(List<int>? val) => _roomUserList = val;

  void updateRoomUserList(Function(List<int>) updateFn) {
    updateFn(_roomUserList ??= []);
  }

  bool hasRoomUserList() => _roomUserList != null;

  // "room_info" field.
  MainInfoStruct? _roomInfo;
  MainInfoStruct get roomInfo => _roomInfo ?? MainInfoStruct();
  set roomInfo(MainInfoStruct? val) => _roomInfo = val;

  void updateRoomInfo(Function(MainInfoStruct) updateFn) {
    updateFn(_roomInfo ??= MainInfoStruct());
  }

  bool hasRoomInfo() => _roomInfo != null;

  // "room_invite_time" field.
  DateTime? _roomInviteTime;
  DateTime? get roomInviteTime => _roomInviteTime;
  set roomInviteTime(DateTime? val) => _roomInviteTime = val;

  bool hasRoomInviteTime() => _roomInviteTime != null;

  // "from_user_id" field.
  int? _fromUserId;
  int get fromUserId => _fromUserId ?? 0;
  set fromUserId(int? val) => _fromUserId = val;

  void incrementFromUserId(int amount) => fromUserId = fromUserId + amount;

  bool hasFromUserId() => _fromUserId != null;

  // "from_userRef" field.
  DocumentReference? _fromUserRef;
  DocumentReference? get fromUserRef => _fromUserRef;
  set fromUserRef(DocumentReference? val) => _fromUserRef = val;

  bool hasFromUserRef() => _fromUserRef != null;

  // "invite_status" field.
  String? _inviteStatus;
  String get inviteStatus => _inviteStatus ?? '';
  set inviteStatus(String? val) => _inviteStatus = val;

  bool hasInviteStatus() => _inviteStatus != null;

  static RoomInfoStruct fromMap(Map<String, dynamic> data) => RoomInfoStruct(
        roomRef: data['room_ref'] as DocumentReference?,
        roomStatus: data['room_status'] as String?,
        roomId: castToType<int>(data['room_id']),
        roomMemberLimit: castToType<int>(data['room_member_limit']),
        roomCreatedByUserId: castToType<int>(data['room_created_by_user_id']),
        roomCreatedByUserRef:
            data['room_created_by_user_ref'] as DocumentReference?,
        roomUserList: getDataList(data['room_user_list']),
        roomInfo: data['room_info'] is MainInfoStruct
            ? data['room_info']
            : MainInfoStruct.maybeFromMap(data['room_info']),
        roomInviteTime: data['room_invite_time'] as DateTime?,
        fromUserId: castToType<int>(data['from_user_id']),
        fromUserRef: data['from_userRef'] as DocumentReference?,
        inviteStatus: data['invite_status'] as String?,
      );

  static RoomInfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? RoomInfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'room_ref': _roomRef,
        'room_status': _roomStatus,
        'room_id': _roomId,
        'room_member_limit': _roomMemberLimit,
        'room_created_by_user_id': _roomCreatedByUserId,
        'room_created_by_user_ref': _roomCreatedByUserRef,
        'room_user_list': _roomUserList,
        'room_info': _roomInfo?.toMap(),
        'room_invite_time': _roomInviteTime,
        'from_user_id': _fromUserId,
        'from_userRef': _fromUserRef,
        'invite_status': _inviteStatus,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'room_ref': serializeParam(
          _roomRef,
          ParamType.DocumentReference,
        ),
        'room_status': serializeParam(
          _roomStatus,
          ParamType.String,
        ),
        'room_id': serializeParam(
          _roomId,
          ParamType.int,
        ),
        'room_member_limit': serializeParam(
          _roomMemberLimit,
          ParamType.int,
        ),
        'room_created_by_user_id': serializeParam(
          _roomCreatedByUserId,
          ParamType.int,
        ),
        'room_created_by_user_ref': serializeParam(
          _roomCreatedByUserRef,
          ParamType.DocumentReference,
        ),
        'room_user_list': serializeParam(
          _roomUserList,
          ParamType.int,
          isList: true,
        ),
        'room_info': serializeParam(
          _roomInfo,
          ParamType.DataStruct,
        ),
        'room_invite_time': serializeParam(
          _roomInviteTime,
          ParamType.DateTime,
        ),
        'from_user_id': serializeParam(
          _fromUserId,
          ParamType.int,
        ),
        'from_userRef': serializeParam(
          _fromUserRef,
          ParamType.DocumentReference,
        ),
        'invite_status': serializeParam(
          _inviteStatus,
          ParamType.String,
        ),
      }.withoutNulls;

  static RoomInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      RoomInfoStruct(
        roomRef: deserializeParam(
          data['room_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['room'],
        ),
        roomStatus: deserializeParam(
          data['room_status'],
          ParamType.String,
          false,
        ),
        roomId: deserializeParam(
          data['room_id'],
          ParamType.int,
          false,
        ),
        roomMemberLimit: deserializeParam(
          data['room_member_limit'],
          ParamType.int,
          false,
        ),
        roomCreatedByUserId: deserializeParam(
          data['room_created_by_user_id'],
          ParamType.int,
          false,
        ),
        roomCreatedByUserRef: deserializeParam(
          data['room_created_by_user_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        roomUserList: deserializeParam<int>(
          data['room_user_list'],
          ParamType.int,
          true,
        ),
        roomInfo: deserializeStructParam(
          data['room_info'],
          ParamType.DataStruct,
          false,
          structBuilder: MainInfoStruct.fromSerializableMap,
        ),
        roomInviteTime: deserializeParam(
          data['room_invite_time'],
          ParamType.DateTime,
          false,
        ),
        fromUserId: deserializeParam(
          data['from_user_id'],
          ParamType.int,
          false,
        ),
        fromUserRef: deserializeParam(
          data['from_userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        inviteStatus: deserializeParam(
          data['invite_status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RoomInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is RoomInfoStruct &&
        roomRef == other.roomRef &&
        roomStatus == other.roomStatus &&
        roomId == other.roomId &&
        roomMemberLimit == other.roomMemberLimit &&
        roomCreatedByUserId == other.roomCreatedByUserId &&
        roomCreatedByUserRef == other.roomCreatedByUserRef &&
        listEquality.equals(roomUserList, other.roomUserList) &&
        roomInfo == other.roomInfo &&
        roomInviteTime == other.roomInviteTime &&
        fromUserId == other.fromUserId &&
        fromUserRef == other.fromUserRef &&
        inviteStatus == other.inviteStatus;
  }

  @override
  int get hashCode => const ListEquality().hash([
        roomRef,
        roomStatus,
        roomId,
        roomMemberLimit,
        roomCreatedByUserId,
        roomCreatedByUserRef,
        roomUserList,
        roomInfo,
        roomInviteTime,
        fromUserId,
        fromUserRef,
        inviteStatus
      ]);
}

RoomInfoStruct createRoomInfoStruct({
  DocumentReference? roomRef,
  String? roomStatus,
  int? roomId,
  int? roomMemberLimit,
  int? roomCreatedByUserId,
  DocumentReference? roomCreatedByUserRef,
  MainInfoStruct? roomInfo,
  DateTime? roomInviteTime,
  int? fromUserId,
  DocumentReference? fromUserRef,
  String? inviteStatus,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RoomInfoStruct(
      roomRef: roomRef,
      roomStatus: roomStatus,
      roomId: roomId,
      roomMemberLimit: roomMemberLimit,
      roomCreatedByUserId: roomCreatedByUserId,
      roomCreatedByUserRef: roomCreatedByUserRef,
      roomInfo: roomInfo ?? (clearUnsetFields ? MainInfoStruct() : null),
      roomInviteTime: roomInviteTime,
      fromUserId: fromUserId,
      fromUserRef: fromUserRef,
      inviteStatus: inviteStatus,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RoomInfoStruct? updateRoomInfoStruct(
  RoomInfoStruct? roomInfoStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    roomInfoStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRoomInfoStructData(
  Map<String, dynamic> firestoreData,
  RoomInfoStruct? roomInfoStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (roomInfoStruct == null) {
    return;
  }
  if (roomInfoStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && roomInfoStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final roomInfoStructData =
      getRoomInfoFirestoreData(roomInfoStruct, forFieldValue);
  final nestedData =
      roomInfoStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = roomInfoStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRoomInfoFirestoreData(
  RoomInfoStruct? roomInfoStruct, [
  bool forFieldValue = false,
]) {
  if (roomInfoStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(roomInfoStruct.toMap());

  // Handle nested data for "room_info" field.
  addMainInfoStructData(
    firestoreData,
    roomInfoStruct.hasRoomInfo() ? roomInfoStruct.roomInfo : null,
    'room_info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(roomInfoStruct.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRoomInfoListFirestoreData(
  List<RoomInfoStruct>? roomInfoStructs,
) =>
    roomInfoStructs?.map((e) => getRoomInfoFirestoreData(e, true)).toList() ??
    [];
