// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameTieQuestionListStruct extends FFFirebaseStruct {
  GameTieQuestionListStruct({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    int? roundID,
    int? teamID,
    int? questionID,
    SelectedQuestionListStruct? selectedQuestionList,
    int? teamPoint,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _updatedAt = updatedAt,
        _status = status,
        _roundID = roundID,
        _teamID = teamID,
        _questionID = questionID,
        _selectedQuestionList = selectedQuestionList,
        _teamPoint = teamPoint,
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

  // "question_ID" field.
  int? _questionID;
  int get questionID => _questionID ?? 0;
  set questionID(int? val) => _questionID = val;

  void incrementQuestionID(int amount) => questionID = questionID + amount;

  bool hasQuestionID() => _questionID != null;

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

  // "team_point" field.
  int? _teamPoint;
  int get teamPoint => _teamPoint ?? 0;
  set teamPoint(int? val) => _teamPoint = val;

  void incrementTeamPoint(int amount) => teamPoint = teamPoint + amount;

  bool hasTeamPoint() => _teamPoint != null;

  static GameTieQuestionListStruct fromMap(Map<String, dynamic> data) =>
      GameTieQuestionListStruct(
        createdAt: data['created_at'] as DateTime?,
        updatedAt: data['updated_at'] as DateTime?,
        status: data['status'] as String?,
        roundID: castToType<int>(data['round_ID']),
        teamID: castToType<int>(data['team_ID']),
        questionID: castToType<int>(data['question_ID']),
        selectedQuestionList:
            data['selectedQuestionList'] is SelectedQuestionListStruct
                ? data['selectedQuestionList']
                : SelectedQuestionListStruct.maybeFromMap(
                    data['selectedQuestionList']),
        teamPoint: castToType<int>(data['team_point']),
      );

  static GameTieQuestionListStruct? maybeFromMap(dynamic data) => data is Map
      ? GameTieQuestionListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'status': _status,
        'round_ID': _roundID,
        'team_ID': _teamID,
        'question_ID': _questionID,
        'selectedQuestionList': _selectedQuestionList?.toMap(),
        'team_point': _teamPoint,
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
        'question_ID': serializeParam(
          _questionID,
          ParamType.int,
        ),
        'selectedQuestionList': serializeParam(
          _selectedQuestionList,
          ParamType.DataStruct,
        ),
        'team_point': serializeParam(
          _teamPoint,
          ParamType.int,
        ),
      }.withoutNulls;

  static GameTieQuestionListStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      GameTieQuestionListStruct(
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
        questionID: deserializeParam(
          data['question_ID'],
          ParamType.int,
          false,
        ),
        selectedQuestionList: deserializeStructParam(
          data['selectedQuestionList'],
          ParamType.DataStruct,
          false,
          structBuilder: SelectedQuestionListStruct.fromSerializableMap,
        ),
        teamPoint: deserializeParam(
          data['team_point'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'GameTieQuestionListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GameTieQuestionListStruct &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        status == other.status &&
        roundID == other.roundID &&
        teamID == other.teamID &&
        questionID == other.questionID &&
        selectedQuestionList == other.selectedQuestionList &&
        teamPoint == other.teamPoint;
  }

  @override
  int get hashCode => const ListEquality().hash([
        createdAt,
        updatedAt,
        status,
        roundID,
        teamID,
        questionID,
        selectedQuestionList,
        teamPoint
      ]);
}

GameTieQuestionListStruct createGameTieQuestionListStruct({
  DateTime? createdAt,
  DateTime? updatedAt,
  String? status,
  int? roundID,
  int? teamID,
  int? questionID,
  SelectedQuestionListStruct? selectedQuestionList,
  int? teamPoint,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GameTieQuestionListStruct(
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      roundID: roundID,
      teamID: teamID,
      questionID: questionID,
      selectedQuestionList: selectedQuestionList ??
          (clearUnsetFields ? SelectedQuestionListStruct() : null),
      teamPoint: teamPoint,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GameTieQuestionListStruct? updateGameTieQuestionListStruct(
  GameTieQuestionListStruct? gameTieQuestionList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    gameTieQuestionList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGameTieQuestionListStructData(
  Map<String, dynamic> firestoreData,
  GameTieQuestionListStruct? gameTieQuestionList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (gameTieQuestionList == null) {
    return;
  }
  if (gameTieQuestionList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && gameTieQuestionList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final gameTieQuestionListData =
      getGameTieQuestionListFirestoreData(gameTieQuestionList, forFieldValue);
  final nestedData =
      gameTieQuestionListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      gameTieQuestionList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGameTieQuestionListFirestoreData(
  GameTieQuestionListStruct? gameTieQuestionList, [
  bool forFieldValue = false,
]) {
  if (gameTieQuestionList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(gameTieQuestionList.toMap());

  // Handle nested data for "selectedQuestionList" field.
  addSelectedQuestionListStructData(
    firestoreData,
    gameTieQuestionList.hasSelectedQuestionList()
        ? gameTieQuestionList.selectedQuestionList
        : null,
    'selectedQuestionList',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(gameTieQuestionList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGameTieQuestionListListFirestoreData(
  List<GameTieQuestionListStruct>? gameTieQuestionLists,
) =>
    gameTieQuestionLists
        ?.map((e) => getGameTieQuestionListFirestoreData(e, true))
        .toList() ??
    [];
