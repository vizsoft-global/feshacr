// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomInviteUserListStruct extends FFFirebaseStruct {
  RoomInviteUserListStruct({
    String? roomUserInviteType,
    DateTime? roomUserInviteTime,
    int? roomUserInviteId,
    DocumentReference? roomUserInviteRef,
    String? roomUserInviteStatus,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _roomUserInviteType = roomUserInviteType,
        _roomUserInviteTime = roomUserInviteTime,
        _roomUserInviteId = roomUserInviteId,
        _roomUserInviteRef = roomUserInviteRef,
        _roomUserInviteStatus = roomUserInviteStatus,
        super(firestoreUtilData);

  // "room_user_invite_type" field.
  String? _roomUserInviteType;
  String get roomUserInviteType => _roomUserInviteType ?? '';
  set roomUserInviteType(String? val) => _roomUserInviteType = val;

  bool hasRoomUserInviteType() => _roomUserInviteType != null;

  // "room_user_invite_time" field.
  DateTime? _roomUserInviteTime;
  DateTime? get roomUserInviteTime => _roomUserInviteTime;
  set roomUserInviteTime(DateTime? val) => _roomUserInviteTime = val;

  bool hasRoomUserInviteTime() => _roomUserInviteTime != null;

  // "room_user_invite_id" field.
  int? _roomUserInviteId;
  int get roomUserInviteId => _roomUserInviteId ?? 0;
  set roomUserInviteId(int? val) => _roomUserInviteId = val;

  void incrementRoomUserInviteId(int amount) =>
      roomUserInviteId = roomUserInviteId + amount;

  bool hasRoomUserInviteId() => _roomUserInviteId != null;

  // "room_user_invite_ref" field.
  DocumentReference? _roomUserInviteRef;
  DocumentReference? get roomUserInviteRef => _roomUserInviteRef;
  set roomUserInviteRef(DocumentReference? val) => _roomUserInviteRef = val;

  bool hasRoomUserInviteRef() => _roomUserInviteRef != null;

  // "room_user_invite_status" field.
  String? _roomUserInviteStatus;
  String get roomUserInviteStatus => _roomUserInviteStatus ?? '';
  set roomUserInviteStatus(String? val) => _roomUserInviteStatus = val;

  bool hasRoomUserInviteStatus() => _roomUserInviteStatus != null;

  static RoomInviteUserListStruct fromMap(Map<String, dynamic> data) =>
      RoomInviteUserListStruct(
        roomUserInviteType: data['room_user_invite_type'] as String?,
        roomUserInviteTime: data['room_user_invite_time'] as DateTime?,
        roomUserInviteId: castToType<int>(data['room_user_invite_id']),
        roomUserInviteRef: data['room_user_invite_ref'] as DocumentReference?,
        roomUserInviteStatus: data['room_user_invite_status'] as String?,
      );

  static RoomInviteUserListStruct? maybeFromMap(dynamic data) => data is Map
      ? RoomInviteUserListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'room_user_invite_type': _roomUserInviteType,
        'room_user_invite_time': _roomUserInviteTime,
        'room_user_invite_id': _roomUserInviteId,
        'room_user_invite_ref': _roomUserInviteRef,
        'room_user_invite_status': _roomUserInviteStatus,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'room_user_invite_type': serializeParam(
          _roomUserInviteType,
          ParamType.String,
        ),
        'room_user_invite_time': serializeParam(
          _roomUserInviteTime,
          ParamType.DateTime,
        ),
        'room_user_invite_id': serializeParam(
          _roomUserInviteId,
          ParamType.int,
        ),
        'room_user_invite_ref': serializeParam(
          _roomUserInviteRef,
          ParamType.DocumentReference,
        ),
        'room_user_invite_status': serializeParam(
          _roomUserInviteStatus,
          ParamType.String,
        ),
      }.withoutNulls;

  static RoomInviteUserListStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RoomInviteUserListStruct(
        roomUserInviteType: deserializeParam(
          data['room_user_invite_type'],
          ParamType.String,
          false,
        ),
        roomUserInviteTime: deserializeParam(
          data['room_user_invite_time'],
          ParamType.DateTime,
          false,
        ),
        roomUserInviteId: deserializeParam(
          data['room_user_invite_id'],
          ParamType.int,
          false,
        ),
        roomUserInviteRef: deserializeParam(
          data['room_user_invite_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        roomUserInviteStatus: deserializeParam(
          data['room_user_invite_status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RoomInviteUserListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RoomInviteUserListStruct &&
        roomUserInviteType == other.roomUserInviteType &&
        roomUserInviteTime == other.roomUserInviteTime &&
        roomUserInviteId == other.roomUserInviteId &&
        roomUserInviteRef == other.roomUserInviteRef &&
        roomUserInviteStatus == other.roomUserInviteStatus;
  }

  @override
  int get hashCode => const ListEquality().hash([
        roomUserInviteType,
        roomUserInviteTime,
        roomUserInviteId,
        roomUserInviteRef,
        roomUserInviteStatus
      ]);
}

RoomInviteUserListStruct createRoomInviteUserListStruct({
  String? roomUserInviteType,
  DateTime? roomUserInviteTime,
  int? roomUserInviteId,
  DocumentReference? roomUserInviteRef,
  String? roomUserInviteStatus,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RoomInviteUserListStruct(
      roomUserInviteType: roomUserInviteType,
      roomUserInviteTime: roomUserInviteTime,
      roomUserInviteId: roomUserInviteId,
      roomUserInviteRef: roomUserInviteRef,
      roomUserInviteStatus: roomUserInviteStatus,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RoomInviteUserListStruct? updateRoomInviteUserListStruct(
  RoomInviteUserListStruct? roomInviteUserList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    roomInviteUserList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRoomInviteUserListStructData(
  Map<String, dynamic> firestoreData,
  RoomInviteUserListStruct? roomInviteUserList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (roomInviteUserList == null) {
    return;
  }
  if (roomInviteUserList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && roomInviteUserList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final roomInviteUserListData =
      getRoomInviteUserListFirestoreData(roomInviteUserList, forFieldValue);
  final nestedData =
      roomInviteUserListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      roomInviteUserList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRoomInviteUserListFirestoreData(
  RoomInviteUserListStruct? roomInviteUserList, [
  bool forFieldValue = false,
]) {
  if (roomInviteUserList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(roomInviteUserList.toMap());

  // Add any Firestore field values
  mapToFirestore(roomInviteUserList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRoomInviteUserListListFirestoreData(
  List<RoomInviteUserListStruct>? roomInviteUserLists,
) =>
    roomInviteUserLists
        ?.map((e) => getRoomInviteUserListFirestoreData(e, true))
        .toList() ??
    [];
