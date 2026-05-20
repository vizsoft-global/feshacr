// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameTieQuestionBreakStruct extends FFFirebaseStruct {
  GameTieQuestionBreakStruct({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    int? roundID,
    int? teamID,
    SelectedQuestionListStruct? selectedQuestionList,
    int? tieQuestionID,
    int? tieQuestionPoint,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _updatedAt = updatedAt,
        _status = status,
        _roundID = roundID,
        _teamID = teamID,
        _selectedQuestionList = selectedQuestionList,
        _tieQuestionID = tieQuestionID,
        _tieQuestionPoint = tieQuestionPoint,
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

  // "round_ID" field.
  int? _roundID;
  int get roundID => _roundID ?? 0;
  set roundID(int? val) => _roundID = val;

  void incrementRoundID(int amount) => roundID = roundID + amount;

  bool hasRoundID() => _roundID != null;

  // "team_ID" field.
  int? _teamID;
  int get teamID => _teamID ?? 0;
  set teamID(int? val) => _teamID = val;

  void incrementTeamID(int amount) => teamID = teamID + amount;

  bool hasTeamID() => _teamID != null;

  // "selectedQuestionList" field.
  SelectedQuestionListStruct? _selectedQuestionList;
  SelectedQuestionListStruct get selectedQuestionList =>
      _selectedQuestionList ?? SelectedQuestionListStruct();
  set selectedQuestionList(SelectedQuestionListStruct? val) =>
      _selectedQuestionList = val;

  void updateSelectedQuestionList(
      Function(SelectedQuestionListStruct) updateFn) {
    updateFn(_selectedQuestionList ??= SelectedQuestionListStruct());
  }

  bool hasSelectedQuestionList() => _selectedQuestionList != null;

  // "tie_question_ID" field.
  int? _tieQuestionID;
  int get tieQuestionID => _tieQuestionID ?? 0;
  set tieQuestionID(int? val) => _tieQuestionID = val;

  void incrementTieQuestionID(int amount) =>
      tieQuestionID = tieQuestionID + amount;

  bool hasTieQuestionID() => _tieQuestionID != null;

  // "tie_question_point" field.
  int? _tieQuestionPoint;
  int get tieQuestionPoint => _tieQuestionPoint ?? 0;
  set tieQuestionPoint(int? val) => _tieQuestionPoint = val;

  void incrementTieQuestionPoint(int amount) =>
      tieQuestionPoint = tieQuestionPoint + amount;

  bool hasTieQuestionPoint() => _tieQuestionPoint != null;

  static GameTieQuestionBreakStruct fromMap(Map<String, dynamic> data) =>
      GameTieQuestionBreakStruct(
        createdAt: data['created_at'] as DateTime?,
        updatedAt: data['updated_at'] as DateTime?,
        status: data['status'] as String?,
        roundID: castToType<int>(data['round_ID']),
        teamID: castToType<int>(data['team_ID']),
        selectedQuestionList:
            data['selectedQuestionList'] is SelectedQuestionListStruct
                ? data['selectedQuestionList']
                : SelectedQuestionListStruct.maybeFromMap(
                    data['selectedQuestionList']),
        tieQuestionID: castToType<int>(data['tie_question_ID']),
        tieQuestionPoint: castToType<int>(data['tie_question_point']),
      );

  static GameTieQuestionBreakStruct? maybeFromMap(dynamic data) => data is Map
      ? GameTieQuestionBreakStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'status': _status,
        'round_ID': _roundID,
        'team_ID': _teamID,
        'selectedQuestionList': _selectedQuestionList?.toMap(),
        'tie_question_ID': _tieQuestionID,
        'tie_question_point': _tieQuestionPoint,
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
        'round_ID': serializeParam(
          _roundID,
          ParamType.int,
        ),
        'team_ID': serializeParam(
          _teamID,
          ParamType.int,
        ),
        'selectedQuestionList': serializeParam(
          _selectedQuestionList,
          ParamType.DataStruct,
        ),
        'tie_question_ID': serializeParam(
          _tieQuestionID,
          ParamType.int,
        ),
        'tie_question_point': serializeParam(
          _tieQuestionPoint,
          ParamType.int,
        ),
      }.withoutNulls;

  static GameTieQuestionBreakStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      GameTieQuestionBreakStruct(
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
        roundID: deserializeParam(
          data['round_ID'],
          ParamType.int,
          false,
        ),
        teamID: deserializeParam(
          data['team_ID'],
          ParamType.int,
          false,
        ),
        selectedQuestionList: deserializeStructParam(
          data['selectedQuestionList'],
          ParamType.DataStruct,
          false,
          structBuilder: SelectedQuestionListStruct.fromSerializableMap,
        ),
        tieQuestionID: deserializeParam(
          data['tie_question_ID'],
          ParamType.int,
          false,
        ),
        tieQuestionPoint: deserializeParam(
          data['tie_question_point'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'GameTieQuestionBreakStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GameTieQuestionBreakStruct &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        status == other.status &&
        roundID == other.roundID &&
        teamID == other.teamID &&
        selectedQuestionList == other.selectedQuestionList &&
        tieQuestionID == other.tieQuestionID &&
        tieQuestionPoint == other.tieQuestionPoint;
  }

  @override
  int get hashCode => const ListEquality().hash([
        createdAt,
        updatedAt,
        status,
        roundID,
        teamID,
        selectedQuestionList,
        tieQuestionID,
        tieQuestionPoint
      ]);
}

GameTieQuestionBreakStruct createGameTieQuestionBreakStruct({
  DateTime? createdAt,
  DateTime? updatedAt,
  String? status,
  int? roundID,
  int? teamID,
  SelectedQuestionListStruct? selectedQuestionList,
  int? tieQuestionID,
  int? tieQuestionPoint,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GameTieQuestionBreakStruct(
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      roundID: roundID,
      teamID: teamID,
      selectedQuestionList: selectedQuestionList ??
          (clearUnsetFields ? SelectedQuestionListStruct() : null),
      tieQuestionID: tieQuestionID,
      tieQuestionPoint: tieQuestionPoint,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GameTieQuestionBreakStruct? updateGameTieQuestionBreakStruct(
  GameTieQuestionBreakStruct? gameTieQuestionBreak, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    gameTieQuestionBreak
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGameTieQuestionBreakStructData(
  Map<String, dynamic> firestoreData,
  GameTieQuestionBreakStruct? gameTieQuestionBreak,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (gameTieQuestionBreak == null) {
    return;
  }
  if (gameTieQuestionBreak.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && gameTieQuestionBreak.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final gameTieQuestionBreakData =
      getGameTieQuestionBreakFirestoreData(gameTieQuestionBreak, forFieldValue);
  final nestedData =
      gameTieQuestionBreakData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      gameTieQuestionBreak.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGameTieQuestionBreakFirestoreData(
  GameTieQuestionBreakStruct? gameTieQuestionBreak, [
  bool forFieldValue = false,
]) {
  if (gameTieQuestionBreak == null) {
    return {};
  }
  final firestoreData = mapToFirestore(gameTieQuestionBreak.toMap());

  // Handle nested data for "selectedQuestionList" field.
  addSelectedQuestionListStructData(
    firestoreData,
    gameTieQuestionBreak.hasSelectedQuestionList()
        ? gameTieQuestionBreak.selectedQuestionList
        : null,
    'selectedQuestionList',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(gameTieQuestionBreak.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGameTieQuestionBreakListFirestoreData(
  List<GameTieQuestionBreakStruct>? gameTieQuestionBreaks,
) =>
    gameTieQuestionBreaks
        ?.map((e) => getGameTieQuestionBreakFirestoreData(e, true))
        .toList() ??
    [];
