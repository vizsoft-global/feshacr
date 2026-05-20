// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PresentRoomGameInfoStruct extends FFFirebaseStruct {
  PresentRoomGameInfoStruct({
    DocumentReference? roomRef,
    DocumentReference? roomAdminRef,
    DocumentReference? roomAdminSelectedGameRef,
    String? roomGameAdminStatus,
    int? roomSelectedGameID,
    int? roomGameId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _roomRef = roomRef,
        _roomAdminRef = roomAdminRef,
        _roomAdminSelectedGameRef = roomAdminSelectedGameRef,
        _roomGameAdminStatus = roomGameAdminStatus,
        _roomSelectedGameID = roomSelectedGameID,
        _roomGameId = roomGameId,
        super(firestoreUtilData);

  // "room_ref" field.
  DocumentReference? _roomRef;
  DocumentReference? get roomRef => _roomRef;
  set roomRef(DocumentReference? val) => _roomRef = val;

  bool hasRoomRef() => _roomRef != null;

  // "room_admin_ref" field.
  DocumentReference? _roomAdminRef;
  DocumentReference? get roomAdminRef => _roomAdminRef;
  set roomAdminRef(DocumentReference? val) => _roomAdminRef = val;

  bool hasRoomAdminRef() => _roomAdminRef != null;

  // "room_admin_selected_game_ref" field.
  DocumentReference? _roomAdminSelectedGameRef;
  DocumentReference? get roomAdminSelectedGameRef => _roomAdminSelectedGameRef;
  set roomAdminSelectedGameRef(DocumentReference? val) =>
      _roomAdminSelectedGameRef = val;

  bool hasRoomAdminSelectedGameRef() => _roomAdminSelectedGameRef != null;

  // "room_game_admin_status" field.
  String? _roomGameAdminStatus;
  String get roomGameAdminStatus => _roomGameAdminStatus ?? '';
  set roomGameAdminStatus(String? val) => _roomGameAdminStatus = val;

  bool hasRoomGameAdminStatus() => _roomGameAdminStatus != null;

  // "room_selected_game_ID" field.
  int? _roomSelectedGameID;
  int get roomSelectedGameID => _roomSelectedGameID ?? 0;
  set roomSelectedGameID(int? val) => _roomSelectedGameID = val;

  void incrementRoomSelectedGameID(int amount) =>
      roomSelectedGameID = roomSelectedGameID + amount;

  bool hasRoomSelectedGameID() => _roomSelectedGameID != null;

  // "room_game_id" field.
  int? _roomGameId;
  int get roomGameId => _roomGameId ?? 0;
  set roomGameId(int? val) => _roomGameId = val;

  void incrementRoomGameId(int amount) => roomGameId = roomGameId + amount;

  bool hasRoomGameId() => _roomGameId != null;

  static PresentRoomGameInfoStruct fromMap(Map<String, dynamic> data) =>
      PresentRoomGameInfoStruct(
        roomRef: data['room_ref'] as DocumentReference?,
        roomAdminRef: data['room_admin_ref'] as DocumentReference?,
        roomAdminSelectedGameRef:
            data['room_admin_selected_game_ref'] as DocumentReference?,
        roomGameAdminStatus: data['room_game_admin_status'] as String?,
        roomSelectedGameID: castToType<int>(data['room_selected_game_ID']),
        roomGameId: castToType<int>(data['room_game_id']),
      );

  static PresentRoomGameInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? PresentRoomGameInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'room_ref': _roomRef,
        'room_admin_ref': _roomAdminRef,
        'room_admin_selected_game_ref': _roomAdminSelectedGameRef,
        'room_game_admin_status': _roomGameAdminStatus,
        'room_selected_game_ID': _roomSelectedGameID,
        'room_game_id': _roomGameId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'room_ref': serializeParam(
          _roomRef,
          ParamType.DocumentReference,
        ),
        'room_admin_ref': serializeParam(
          _roomAdminRef,
          ParamType.DocumentReference,
        ),
        'room_admin_selected_game_ref': serializeParam(
          _roomAdminSelectedGameRef,
          ParamType.DocumentReference,
        ),
        'room_game_admin_status': serializeParam(
          _roomGameAdminStatus,
          ParamType.String,
        ),
        'room_selected_game_ID': serializeParam(
          _roomSelectedGameID,
          ParamType.int,
        ),
        'room_game_id': serializeParam(
          _roomGameId,
          ParamType.int,
        ),
      }.withoutNulls;

  static PresentRoomGameInfoStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PresentRoomGameInfoStruct(
        roomRef: deserializeParam(
          data['room_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['room'],
        ),
        roomAdminRef: deserializeParam(
          data['room_admin_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        roomAdminSelectedGameRef: deserializeParam(
          data['room_admin_selected_game_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['game'],
        ),
        roomGameAdminStatus: deserializeParam(
          data['room_game_admin_status'],
          ParamType.String,
          false,
        ),
        roomSelectedGameID: deserializeParam(
          data['room_selected_game_ID'],
          ParamType.int,
          false,
        ),
        roomGameId: deserializeParam(
          data['room_game_id'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'PresentRoomGameInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PresentRoomGameInfoStruct &&
        roomRef == other.roomRef &&
        roomAdminRef == other.roomAdminRef &&
        roomAdminSelectedGameRef == other.roomAdminSelectedGameRef &&
        roomGameAdminStatus == other.roomGameAdminStatus &&
        roomSelectedGameID == other.roomSelectedGameID &&
        roomGameId == other.roomGameId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        roomRef,
        roomAdminRef,
        roomAdminSelectedGameRef,
        roomGameAdminStatus,
        roomSelectedGameID,
        roomGameId
      ]);
}

PresentRoomGameInfoStruct createPresentRoomGameInfoStruct({
  DocumentReference? roomRef,
  DocumentReference? roomAdminRef,
  DocumentReference? roomAdminSelectedGameRef,
  String? roomGameAdminStatus,
  int? roomSelectedGameID,
  int? roomGameId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PresentRoomGameInfoStruct(
      roomRef: roomRef,
      roomAdminRef: roomAdminRef,
      roomAdminSelectedGameRef: roomAdminSelectedGameRef,
      roomGameAdminStatus: roomGameAdminStatus,
      roomSelectedGameID: roomSelectedGameID,
      roomGameId: roomGameId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PresentRoomGameInfoStruct? updatePresentRoomGameInfoStruct(
  PresentRoomGameInfoStruct? presentRoomGameInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    presentRoomGameInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPresentRoomGameInfoStructData(
  Map<String, dynamic> firestoreData,
  PresentRoomGameInfoStruct? presentRoomGameInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (presentRoomGameInfo == null) {
    return;
  }
  if (presentRoomGameInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && presentRoomGameInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final presentRoomGameInfoData =
      getPresentRoomGameInfoFirestoreData(presentRoomGameInfo, forFieldValue);
  final nestedData =
      presentRoomGameInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      presentRoomGameInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPresentRoomGameInfoFirestoreData(
  PresentRoomGameInfoStruct? presentRoomGameInfo, [
  bool forFieldValue = false,
]) {
  if (presentRoomGameInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(presentRoomGameInfo.toMap());

  // Add any Firestore field values
  mapToFirestore(presentRoomGameInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPresentRoomGameInfoListFirestoreData(
  List<PresentRoomGameInfoStruct>? presentRoomGameInfos,
) =>
    presentRoomGameInfos
        ?.map((e) => getPresentRoomGameInfoFirestoreData(e, true))
        .toList() ??
    [];
