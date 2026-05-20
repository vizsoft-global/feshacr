// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameTieBreakRoundResultDetailsStruct extends FFFirebaseStruct {
  GameTieBreakRoundResultDetailsStruct({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    int? roundResultID,
    int? winTeamId,
    List<GameTieQuestionListStruct>? gameTieBreakRound,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _updatedAt = updatedAt,
        _status = status,
        _roundResultID = roundResultID,
        _winTeamId = winTeamId,
        _gameTieBreakRound = gameTieBreakRound,
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

  // "round_result_ID" field.
  int? _roundResultID;
  int get roundResultID => _roundResultID ?? 0;
  set roundResultID(int? val) => _roundResultID = val;

  void incrementRoundResultID(int amount) =>
      roundResultID = roundResultID + amount;

  bool hasRoundResultID() => _roundResultID != null;

  // "win_team_id" field.
  int? _winTeamId;
  int get winTeamId => _winTeamId ?? 0;
  set winTeamId(int? val) => _winTeamId = val;

  void incrementWinTeamId(int amount) => winTeamId = winTeamId + amount;

  bool hasWinTeamId() => _winTeamId != null;

  // "gameTieBreakRound" field.
  List<GameTieQuestionListStruct>? _gameTieBreakRound;
  List<GameTieQuestionListStruct> get gameTieBreakRound =>
      _gameTieBreakRound ?? const [];
  set gameTieBreakRound(List<GameTieQuestionListStruct>? val) =>
      _gameTieBreakRound = val;

  void updateGameTieBreakRound(
      Function(List<GameTieQuestionListStruct>) updateFn) {
    updateFn(_gameTieBreakRound ??= []);
  }

  bool hasGameTieBreakRound() => _gameTieBreakRound != null;

  static GameTieBreakRoundResultDetailsStruct fromMap(
          Map<String, dynamic> data) =>
      GameTieBreakRoundResultDetailsStruct(
        createdAt: data['created_at'] as DateTime?,
        updatedAt: data['updated_at'] as DateTime?,
        status: data['status'] as String?,
        roundResultID: castToType<int>(data['round_result_ID']),
        winTeamId: castToType<int>(data['win_team_id']),
        gameTieBreakRound: getStructList(
          data['gameTieBreakRound'],
          GameTieQuestionListStruct.fromMap,
        ),
      );

  static GameTieBreakRoundResultDetailsStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? GameTieBreakRoundResultDetailsStruct.fromMap(
              data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'status': _status,
        'round_result_ID': _roundResultID,
        'win_team_id': _winTeamId,
        'gameTieBreakRound': _gameTieBreakRound?.map((e) => e.toMap()).toList(),
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
        'round_result_ID': serializeParam(
          _roundResultID,
          ParamType.int,
        ),
        'win_team_id': serializeParam(
          _winTeamId,
          ParamType.int,
        ),
        'gameTieBreakRound': serializeParam(
          _gameTieBreakRound,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static GameTieBreakRoundResultDetailsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      GameTieBreakRoundResultDetailsStruct(
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
        roundResultID: deserializeParam(
          data['round_result_ID'],
          ParamType.int,
          false,
        ),
        winTeamId: deserializeParam(
          data['win_team_id'],
          ParamType.int,
          false,
        ),
        gameTieBreakRound: deserializeStructParam<GameTieQuestionListStruct>(
          data['gameTieBreakRound'],
          ParamType.DataStruct,
          true,
          structBuilder: GameTieQuestionListStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'GameTieBreakRoundResultDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is GameTieBreakRoundResultDetailsStruct &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        status == other.status &&
        roundResultID == other.roundResultID &&
        winTeamId == other.winTeamId &&
        listEquality.equals(gameTieBreakRound, other.gameTieBreakRound);
  }

  @override
  int get hashCode => const ListEquality().hash([
        createdAt,
        updatedAt,
        status,
        roundResultID,
        winTeamId,
        gameTieBreakRound
      ]);
}

GameTieBreakRoundResultDetailsStruct
    createGameTieBreakRoundResultDetailsStruct({
  DateTime? createdAt,
  DateTime? updatedAt,
  String? status,
  int? roundResultID,
  int? winTeamId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
        GameTieBreakRoundResultDetailsStruct(
          createdAt: createdAt,
          updatedAt: updatedAt,
          status: status,
          roundResultID: roundResultID,
          winTeamId: winTeamId,
          firestoreUtilData: FirestoreUtilData(
            clearUnsetFields: clearUnsetFields,
            create: create,
            delete: delete,
            fieldValues: fieldValues,
          ),
        );

GameTieBreakRoundResultDetailsStruct?
    updateGameTieBreakRoundResultDetailsStruct(
  GameTieBreakRoundResultDetailsStruct? gameTieBreakRoundResultDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
        gameTieBreakRoundResultDetails
          ?..firestoreUtilData = FirestoreUtilData(
            clearUnsetFields: clearUnsetFields,
            create: create,
          );

void addGameTieBreakRoundResultDetailsStructData(
  Map<String, dynamic> firestoreData,
  GameTieBreakRoundResultDetailsStruct? gameTieBreakRoundResultDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (gameTieBreakRoundResultDetails == null) {
    return;
  }
  if (gameTieBreakRoundResultDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      gameTieBreakRoundResultDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final gameTieBreakRoundResultDetailsData =
      getGameTieBreakRoundResultDetailsFirestoreData(
          gameTieBreakRoundResultDetails, forFieldValue);
  final nestedData = gameTieBreakRoundResultDetailsData
      .map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      gameTieBreakRoundResultDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGameTieBreakRoundResultDetailsFirestoreData(
  GameTieBreakRoundResultDetailsStruct? gameTieBreakRoundResultDetails, [
  bool forFieldValue = false,
]) {
  if (gameTieBreakRoundResultDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(gameTieBreakRoundResultDetails.toMap());

  // Add any Firestore field values
  mapToFirestore(gameTieBreakRoundResultDetails.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGameTieBreakRoundResultDetailsListFirestoreData(
  List<GameTieBreakRoundResultDetailsStruct>? gameTieBreakRoundResultDetailss,
) =>
    gameTieBreakRoundResultDetailss
        ?.map((e) => getGameTieBreakRoundResultDetailsFirestoreData(e, true))
        .toList() ??
    [];
