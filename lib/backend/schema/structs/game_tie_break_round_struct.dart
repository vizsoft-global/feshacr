// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameTieBreakRoundStruct extends FFFirebaseStruct {
  GameTieBreakRoundStruct({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    List<int>? teamId,
    int? roundResultID,
    List<GameTieQuestionListStruct>? gameTieQuestionList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _updatedAt = updatedAt,
        _status = status,
        _teamId = teamId,
        _roundResultID = roundResultID,
        _gameTieQuestionList = gameTieQuestionList,
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

  // "team_id" field.
  List<int>? _teamId;
  List<int> get teamId => _teamId ?? const [];
  set teamId(List<int>? val) => _teamId = val;

  void updateTeamId(Function(List<int>) updateFn) {
    updateFn(_teamId ??= []);
  }

  bool hasTeamId() => _teamId != null;

  // "round_result_ID" field.
  int? _roundResultID;
  int get roundResultID => _roundResultID ?? 0;
  set roundResultID(int? val) => _roundResultID = val;

  void incrementRoundResultID(int amount) =>
      roundResultID = roundResultID + amount;

  bool hasRoundResultID() => _roundResultID != null;

  // "gameTieQuestionList" field.
  List<GameTieQuestionListStruct>? _gameTieQuestionList;
  List<GameTieQuestionListStruct> get gameTieQuestionList =>
      _gameTieQuestionList ?? const [];
  set gameTieQuestionList(List<GameTieQuestionListStruct>? val) =>
      _gameTieQuestionList = val;

  void updateGameTieQuestionList(
      Function(List<GameTieQuestionListStruct>) updateFn) {
    updateFn(_gameTieQuestionList ??= []);
  }

  bool hasGameTieQuestionList() => _gameTieQuestionList != null;

  static GameTieBreakRoundStruct fromMap(Map<String, dynamic> data) =>
      GameTieBreakRoundStruct(
        createdAt: data['created_at'] as DateTime?,
        updatedAt: data['updated_at'] as DateTime?,
        status: data['status'] as String?,
        teamId: getDataList(data['team_id']),
        roundResultID: castToType<int>(data['round_result_ID']),
        gameTieQuestionList: getStructList(
          data['gameTieQuestionList'],
          GameTieQuestionListStruct.fromMap,
        ),
      );

  static GameTieBreakRoundStruct? maybeFromMap(dynamic data) => data is Map
      ? GameTieBreakRoundStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'status': _status,
        'team_id': _teamId,
        'round_result_ID': _roundResultID,
        'gameTieQuestionList':
            _gameTieQuestionList?.map((e) => e.toMap()).toList(),
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
        'team_id': serializeParam(
          _teamId,
          ParamType.int,
          isList: true,
        ),
        'round_result_ID': serializeParam(
          _roundResultID,
          ParamType.int,
        ),
        'gameTieQuestionList': serializeParam(
          _gameTieQuestionList,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static GameTieBreakRoundStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      GameTieBreakRoundStruct(
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
        teamId: deserializeParam<int>(
          data['team_id'],
          ParamType.int,
          true,
        ),
        roundResultID: deserializeParam(
          data['round_result_ID'],
          ParamType.int,
          false,
        ),
        gameTieQuestionList: deserializeStructParam<GameTieQuestionListStruct>(
          data['gameTieQuestionList'],
          ParamType.DataStruct,
          true,
          structBuilder: GameTieQuestionListStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'GameTieBreakRoundStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is GameTieBreakRoundStruct &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        status == other.status &&
        listEquality.equals(teamId, other.teamId) &&
        roundResultID == other.roundResultID &&
        listEquality.equals(gameTieQuestionList, other.gameTieQuestionList);
  }

  @override
  int get hashCode => const ListEquality().hash([
        createdAt,
        updatedAt,
        status,
        teamId,
        roundResultID,
        gameTieQuestionList
      ]);
}

GameTieBreakRoundStruct createGameTieBreakRoundStruct({
  DateTime? createdAt,
  DateTime? updatedAt,
  String? status,
  int? roundResultID,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GameTieBreakRoundStruct(
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      roundResultID: roundResultID,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GameTieBreakRoundStruct? updateGameTieBreakRoundStruct(
  GameTieBreakRoundStruct? gameTieBreakRound, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    gameTieBreakRound
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGameTieBreakRoundStructData(
  Map<String, dynamic> firestoreData,
  GameTieBreakRoundStruct? gameTieBreakRound,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (gameTieBreakRound == null) {
    return;
  }
  if (gameTieBreakRound.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && gameTieBreakRound.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final gameTieBreakRoundData =
      getGameTieBreakRoundFirestoreData(gameTieBreakRound, forFieldValue);
  final nestedData =
      gameTieBreakRoundData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = gameTieBreakRound.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGameTieBreakRoundFirestoreData(
  GameTieBreakRoundStruct? gameTieBreakRound, [
  bool forFieldValue = false,
]) {
  if (gameTieBreakRound == null) {
    return {};
  }
  final firestoreData = mapToFirestore(gameTieBreakRound.toMap());

  // Add any Firestore field values
  mapToFirestore(gameTieBreakRound.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGameTieBreakRoundListFirestoreData(
  List<GameTieBreakRoundStruct>? gameTieBreakRounds,
) =>
    gameTieBreakRounds
        ?.map((e) => getGameTieBreakRoundFirestoreData(e, true))
        .toList() ??
    [];
