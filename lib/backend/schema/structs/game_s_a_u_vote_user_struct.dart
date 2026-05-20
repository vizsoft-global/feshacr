// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameSAUVoteUserStruct extends FFFirebaseStruct {
  GameSAUVoteUserStruct({
    DateTime? voteCreatedAt,
    DateTime? voteUpdatedAt,
    String? voteStatus,
    int? voteId,
    String? toUserUid,
    DocumentReference? toUserRef,
    String? fromUserUid,
    DocumentReference? fromUserRef,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _voteCreatedAt = voteCreatedAt,
        _voteUpdatedAt = voteUpdatedAt,
        _voteStatus = voteStatus,
        _voteId = voteId,
        _toUserUid = toUserUid,
        _toUserRef = toUserRef,
        _fromUserUid = fromUserUid,
        _fromUserRef = fromUserRef,
        super(firestoreUtilData);

  // "vote_created_at" field.
  DateTime? _voteCreatedAt;
  DateTime? get voteCreatedAt => _voteCreatedAt;
  set voteCreatedAt(DateTime? val) => _voteCreatedAt = val;

  bool hasVoteCreatedAt() => _voteCreatedAt != null;

  // "vote_updated_at" field.
  DateTime? _voteUpdatedAt;
  DateTime? get voteUpdatedAt => _voteUpdatedAt;
  set voteUpdatedAt(DateTime? val) => _voteUpdatedAt = val;

  bool hasVoteUpdatedAt() => _voteUpdatedAt != null;

  // "vote_status" field.
  String? _voteStatus;
  String get voteStatus => _voteStatus ?? '';
  set voteStatus(String? val) => _voteStatus = val;

  bool hasVoteStatus() => _voteStatus != null;

  // "vote_id" field.
  int? _voteId;
  int get voteId => _voteId ?? 0;
  set voteId(int? val) => _voteId = val;

  void incrementVoteId(int amount) => voteId = voteId + amount;

  bool hasVoteId() => _voteId != null;

  // "to_user_uid" field.
  String? _toUserUid;
  String get toUserUid => _toUserUid ?? '';
  set toUserUid(String? val) => _toUserUid = val;

  bool hasToUserUid() => _toUserUid != null;

  // "to_user_ref" field.
  DocumentReference? _toUserRef;
  DocumentReference? get toUserRef => _toUserRef;
  set toUserRef(DocumentReference? val) => _toUserRef = val;

  bool hasToUserRef() => _toUserRef != null;

  // "from_user_uid" field.
  String? _fromUserUid;
  String get fromUserUid => _fromUserUid ?? '';
  set fromUserUid(String? val) => _fromUserUid = val;

  bool hasFromUserUid() => _fromUserUid != null;

  // "from_user_ref" field.
  DocumentReference? _fromUserRef;
  DocumentReference? get fromUserRef => _fromUserRef;
  set fromUserRef(DocumentReference? val) => _fromUserRef = val;

  bool hasFromUserRef() => _fromUserRef != null;

  static GameSAUVoteUserStruct fromMap(Map<String, dynamic> data) =>
      GameSAUVoteUserStruct(
        voteCreatedAt: data['vote_created_at'] as DateTime?,
        voteUpdatedAt: data['vote_updated_at'] as DateTime?,
        voteStatus: data['vote_status'] as String?,
        voteId: castToType<int>(data['vote_id']),
        toUserUid: data['to_user_uid'] as String?,
        toUserRef: data['to_user_ref'] as DocumentReference?,
        fromUserUid: data['from_user_uid'] as String?,
        fromUserRef: data['from_user_ref'] as DocumentReference?,
      );

  static GameSAUVoteUserStruct? maybeFromMap(dynamic data) => data is Map
      ? GameSAUVoteUserStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'vote_created_at': _voteCreatedAt,
        'vote_updated_at': _voteUpdatedAt,
        'vote_status': _voteStatus,
        'vote_id': _voteId,
        'to_user_uid': _toUserUid,
        'to_user_ref': _toUserRef,
        'from_user_uid': _fromUserUid,
        'from_user_ref': _fromUserRef,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'vote_created_at': serializeParam(
          _voteCreatedAt,
          ParamType.DateTime,
        ),
        'vote_updated_at': serializeParam(
          _voteUpdatedAt,
          ParamType.DateTime,
        ),
        'vote_status': serializeParam(
          _voteStatus,
          ParamType.String,
        ),
        'vote_id': serializeParam(
          _voteId,
          ParamType.int,
        ),
        'to_user_uid': serializeParam(
          _toUserUid,
          ParamType.String,
        ),
        'to_user_ref': serializeParam(
          _toUserRef,
          ParamType.DocumentReference,
        ),
        'from_user_uid': serializeParam(
          _fromUserUid,
          ParamType.String,
        ),
        'from_user_ref': serializeParam(
          _fromUserRef,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static GameSAUVoteUserStruct fromSerializableMap(Map<String, dynamic> data) =>
      GameSAUVoteUserStruct(
        voteCreatedAt: deserializeParam(
          data['vote_created_at'],
          ParamType.DateTime,
          false,
        ),
        voteUpdatedAt: deserializeParam(
          data['vote_updated_at'],
          ParamType.DateTime,
          false,
        ),
        voteStatus: deserializeParam(
          data['vote_status'],
          ParamType.String,
          false,
        ),
        voteId: deserializeParam(
          data['vote_id'],
          ParamType.int,
          false,
        ),
        toUserUid: deserializeParam(
          data['to_user_uid'],
          ParamType.String,
          false,
        ),
        toUserRef: deserializeParam(
          data['to_user_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        fromUserUid: deserializeParam(
          data['from_user_uid'],
          ParamType.String,
          false,
        ),
        fromUserRef: deserializeParam(
          data['from_user_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
      );

  @override
  String toString() => 'GameSAUVoteUserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GameSAUVoteUserStruct &&
        voteCreatedAt == other.voteCreatedAt &&
        voteUpdatedAt == other.voteUpdatedAt &&
        voteStatus == other.voteStatus &&
        voteId == other.voteId &&
        toUserUid == other.toUserUid &&
        toUserRef == other.toUserRef &&
        fromUserUid == other.fromUserUid &&
        fromUserRef == other.fromUserRef;
  }

  @override
  int get hashCode => const ListEquality().hash([
        voteCreatedAt,
        voteUpdatedAt,
        voteStatus,
        voteId,
        toUserUid,
        toUserRef,
        fromUserUid,
        fromUserRef
      ]);
}

GameSAUVoteUserStruct createGameSAUVoteUserStruct({
  DateTime? voteCreatedAt,
  DateTime? voteUpdatedAt,
  String? voteStatus,
  int? voteId,
  String? toUserUid,
  DocumentReference? toUserRef,
  String? fromUserUid,
  DocumentReference? fromUserRef,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GameSAUVoteUserStruct(
      voteCreatedAt: voteCreatedAt,
      voteUpdatedAt: voteUpdatedAt,
      voteStatus: voteStatus,
      voteId: voteId,
      toUserUid: toUserUid,
      toUserRef: toUserRef,
      fromUserUid: fromUserUid,
      fromUserRef: fromUserRef,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GameSAUVoteUserStruct? updateGameSAUVoteUserStruct(
  GameSAUVoteUserStruct? gameSAUVoteUser, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    gameSAUVoteUser
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGameSAUVoteUserStructData(
  Map<String, dynamic> firestoreData,
  GameSAUVoteUserStruct? gameSAUVoteUser,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (gameSAUVoteUser == null) {
    return;
  }
  if (gameSAUVoteUser.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && gameSAUVoteUser.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final gameSAUVoteUserData =
      getGameSAUVoteUserFirestoreData(gameSAUVoteUser, forFieldValue);
  final nestedData =
      gameSAUVoteUserData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = gameSAUVoteUser.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGameSAUVoteUserFirestoreData(
  GameSAUVoteUserStruct? gameSAUVoteUser, [
  bool forFieldValue = false,
]) {
  if (gameSAUVoteUser == null) {
    return {};
  }
  final firestoreData = mapToFirestore(gameSAUVoteUser.toMap());

  // Add any Firestore field values
  mapToFirestore(gameSAUVoteUser.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGameSAUVoteUserListFirestoreData(
  List<GameSAUVoteUserStruct>? gameSAUVoteUsers,
) =>
    gameSAUVoteUsers
        ?.map((e) => getGameSAUVoteUserFirestoreData(e, true))
        .toList() ??
    [];
