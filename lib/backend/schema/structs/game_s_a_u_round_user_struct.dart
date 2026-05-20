// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameSAURoundUserStruct extends FFFirebaseStruct {
  GameSAURoundUserStruct({
    int? roundUserId,
    DocumentReference? roundUserRef,
    int? roundPoints,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _roundUserId = roundUserId,
        _roundUserRef = roundUserRef,
        _roundPoints = roundPoints,
        super(firestoreUtilData);

  // "round_user_id" field.
  int? _roundUserId;
  int get roundUserId => _roundUserId ?? 0;
  set roundUserId(int? val) => _roundUserId = val;

  void incrementRoundUserId(int amount) => roundUserId = roundUserId + amount;

  bool hasRoundUserId() => _roundUserId != null;

  // "round_user_ref" field.
  DocumentReference? _roundUserRef;
  DocumentReference? get roundUserRef => _roundUserRef;
  set roundUserRef(DocumentReference? val) => _roundUserRef = val;

  bool hasRoundUserRef() => _roundUserRef != null;

  // "round_points" field.
  int? _roundPoints;
  int get roundPoints => _roundPoints ?? 0;
  set roundPoints(int? val) => _roundPoints = val;

  void incrementRoundPoints(int amount) => roundPoints = roundPoints + amount;

  bool hasRoundPoints() => _roundPoints != null;

  static GameSAURoundUserStruct fromMap(Map<String, dynamic> data) =>
      GameSAURoundUserStruct(
        roundUserId: castToType<int>(data['round_user_id']),
        roundUserRef: data['round_user_ref'] as DocumentReference?,
        roundPoints: castToType<int>(data['round_points']),
      );

  static GameSAURoundUserStruct? maybeFromMap(dynamic data) => data is Map
      ? GameSAURoundUserStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'round_user_id': _roundUserId,
        'round_user_ref': _roundUserRef,
        'round_points': _roundPoints,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'round_user_id': serializeParam(
          _roundUserId,
          ParamType.int,
        ),
        'round_user_ref': serializeParam(
          _roundUserRef,
          ParamType.DocumentReference,
        ),
        'round_points': serializeParam(
          _roundPoints,
          ParamType.int,
        ),
      }.withoutNulls;

  static GameSAURoundUserStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      GameSAURoundUserStruct(
        roundUserId: deserializeParam(
          data['round_user_id'],
          ParamType.int,
          false,
        ),
        roundUserRef: deserializeParam(
          data['round_user_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        roundPoints: deserializeParam(
          data['round_points'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'GameSAURoundUserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GameSAURoundUserStruct &&
        roundUserId == other.roundUserId &&
        roundUserRef == other.roundUserRef &&
        roundPoints == other.roundPoints;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([roundUserId, roundUserRef, roundPoints]);
}

GameSAURoundUserStruct createGameSAURoundUserStruct({
  int? roundUserId,
  DocumentReference? roundUserRef,
  int? roundPoints,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GameSAURoundUserStruct(
      roundUserId: roundUserId,
      roundUserRef: roundUserRef,
      roundPoints: roundPoints,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GameSAURoundUserStruct? updateGameSAURoundUserStruct(
  GameSAURoundUserStruct? gameSAURoundUser, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    gameSAURoundUser
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGameSAURoundUserStructData(
  Map<String, dynamic> firestoreData,
  GameSAURoundUserStruct? gameSAURoundUser,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (gameSAURoundUser == null) {
    return;
  }
  if (gameSAURoundUser.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && gameSAURoundUser.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final gameSAURoundUserData =
      getGameSAURoundUserFirestoreData(gameSAURoundUser, forFieldValue);
  final nestedData =
      gameSAURoundUserData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = gameSAURoundUser.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGameSAURoundUserFirestoreData(
  GameSAURoundUserStruct? gameSAURoundUser, [
  bool forFieldValue = false,
]) {
  if (gameSAURoundUser == null) {
    return {};
  }
  final firestoreData = mapToFirestore(gameSAURoundUser.toMap());

  // Add any Firestore field values
  mapToFirestore(gameSAURoundUser.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGameSAURoundUserListFirestoreData(
  List<GameSAURoundUserStruct>? gameSAURoundUsers,
) =>
    gameSAURoundUsers
        ?.map((e) => getGameSAURoundUserFirestoreData(e, true))
        .toList() ??
    [];
