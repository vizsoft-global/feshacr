// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameTieInfoStruct extends FFFirebaseStruct {
  GameTieInfoStruct({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    ResultInfoStruct? tieResult,
    int? tieQuestionId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _updatedAt = updatedAt,
        _status = status,
        _tieResult = tieResult,
        _tieQuestionId = tieQuestionId,
        super(firestoreUtilData);

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  set updatedAt(DateTime? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "tie_result" field.
  ResultInfoStruct? _tieResult;
  ResultInfoStruct get tieResult => _tieResult ?? ResultInfoStruct();
  set tieResult(ResultInfoStruct? val) => _tieResult = val;

  void updateTieResult(Function(ResultInfoStruct) updateFn) {
    updateFn(_tieResult ??= ResultInfoStruct());
  }

  bool hasTieResult() => _tieResult != null;

  // "tie_question_id" field.
  int? _tieQuestionId;
  int get tieQuestionId => _tieQuestionId ?? 0;
  set tieQuestionId(int? val) => _tieQuestionId = val;

  void incrementTieQuestionId(int amount) =>
      tieQuestionId = tieQuestionId + amount;

  bool hasTieQuestionId() => _tieQuestionId != null;

  static GameTieInfoStruct fromMap(Map<String, dynamic> data) =>
      GameTieInfoStruct(
        createdAt: data['created_at'] as DateTime?,
        updatedAt: data['updated_at'] as DateTime?,
        status: data['status'] as String?,
        tieResult: data['tie_result'] is ResultInfoStruct
            ? data['tie_result']
            : ResultInfoStruct.maybeFromMap(data['tie_result']),
        tieQuestionId: castToType<int>(data['tie_question_id']),
      );

  static GameTieInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? GameTieInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'status': _status,
        'tie_result': _tieResult?.toMap(),
        'tie_question_id': _tieQuestionId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'created_at': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.DateTime,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'tie_result': serializeParam(
          _tieResult,
          ParamType.DataStruct,
        ),
        'tie_question_id': serializeParam(
          _tieQuestionId,
          ParamType.int,
        ),
      }.withoutNulls;

  static GameTieInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      GameTieInfoStruct(
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.DateTime,
          false,
        ),
        updatedAt: deserializeParam(
          data['updated_at'],
          ParamType.DateTime,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        tieResult: deserializeStructParam(
          data['tie_result'],
          ParamType.DataStruct,
          false,
          structBuilder: ResultInfoStruct.fromSerializableMap,
        ),
        tieQuestionId: deserializeParam(
          data['tie_question_id'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'GameTieInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GameTieInfoStruct &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        status == other.status &&
        tieResult == other.tieResult &&
        tieQuestionId == other.tieQuestionId;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([createdAt, updatedAt, status, tieResult, tieQuestionId]);
}

GameTieInfoStruct createGameTieInfoStruct({
  DateTime? createdAt,
  DateTime? updatedAt,
  String? status,
  ResultInfoStruct? tieResult,
  int? tieQuestionId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GameTieInfoStruct(
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      tieResult: tieResult ?? (clearUnsetFields ? ResultInfoStruct() : null),
      tieQuestionId: tieQuestionId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GameTieInfoStruct? updateGameTieInfoStruct(
  GameTieInfoStruct? gameTieInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    gameTieInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGameTieInfoStructData(
  Map<String, dynamic> firestoreData,
  GameTieInfoStruct? gameTieInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (gameTieInfo == null) {
    return;
  }
  if (gameTieInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && gameTieInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final gameTieInfoData =
      getGameTieInfoFirestoreData(gameTieInfo, forFieldValue);
  final nestedData =
      gameTieInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = gameTieInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGameTieInfoFirestoreData(
  GameTieInfoStruct? gameTieInfo, [
  bool forFieldValue = false,
]) {
  if (gameTieInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(gameTieInfo.toMap());

  // Handle nested data for "tie_result" field.
  addResultInfoStructData(
    firestoreData,
    gameTieInfo.hasTieResult() ? gameTieInfo.tieResult : null,
    'tie_result',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(gameTieInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGameTieInfoListFirestoreData(
  List<GameTieInfoStruct>? gameTieInfos,
) =>
    gameTieInfos?.map((e) => getGameTieInfoFirestoreData(e, true)).toList() ??
    [];
