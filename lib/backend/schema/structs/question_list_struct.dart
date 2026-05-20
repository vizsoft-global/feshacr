// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuestionListStruct extends FFFirebaseStruct {
  QuestionListStruct({
    DateTime? createdAt,
    DateTime? updatedAt,
    int? questionID,
    String? questionStatus,
    QuestionInfoStruct? questionInfo,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _updatedAt = updatedAt,
        _questionID = questionID,
        _questionStatus = questionStatus,
        _questionInfo = questionInfo,
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

  // "question_ID" field.
  int? _questionID;
  int get questionID => _questionID ?? 0;
  set questionID(int? val) => _questionID = val;

  void incrementQuestionID(int amount) => questionID = questionID + amount;

  bool hasQuestionID() => _questionID != null;

  // "question_status" field.
  String? _questionStatus;
  String get questionStatus => _questionStatus ?? '';
  set questionStatus(String? val) => _questionStatus = val;

  bool hasQuestionStatus() => _questionStatus != null;

  // "question_Info" field.
  QuestionInfoStruct? _questionInfo;
  QuestionInfoStruct get questionInfo => _questionInfo ?? QuestionInfoStruct();
  set questionInfo(QuestionInfoStruct? val) => _questionInfo = val;

  void updateQuestionInfo(Function(QuestionInfoStruct) updateFn) {
    updateFn(_questionInfo ??= QuestionInfoStruct());
  }

  bool hasQuestionInfo() => _questionInfo != null;

  static QuestionListStruct fromMap(Map<String, dynamic> data) =>
      QuestionListStruct(
        createdAt: data['created_at'] as DateTime?,
        updatedAt: data['updated_at'] as DateTime?,
        questionID: castToType<int>(data['question_ID']),
        questionStatus: data['question_status'] as String?,
        questionInfo: data['question_Info'] is QuestionInfoStruct
            ? data['question_Info']
            : QuestionInfoStruct.maybeFromMap(data['question_Info']),
      );

  static QuestionListStruct? maybeFromMap(dynamic data) => data is Map
      ? QuestionListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'question_ID': _questionID,
        'question_status': _questionStatus,
        'question_Info': _questionInfo?.toMap(),
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
        'question_ID': serializeParam(
          _questionID,
          ParamType.int,
        ),
        'question_status': serializeParam(
          _questionStatus,
          ParamType.String,
        ),
        'question_Info': serializeParam(
          _questionInfo,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static QuestionListStruct fromSerializableMap(Map<String, dynamic> data) =>
      QuestionListStruct(
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
        questionID: deserializeParam(
          data['question_ID'],
          ParamType.int,
          false,
        ),
        questionStatus: deserializeParam(
          data['question_status'],
          ParamType.String,
          false,
        ),
        questionInfo: deserializeStructParam(
          data['question_Info'],
          ParamType.DataStruct,
          false,
          structBuilder: QuestionInfoStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'QuestionListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is QuestionListStruct &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        questionID == other.questionID &&
        questionStatus == other.questionStatus &&
        questionInfo == other.questionInfo;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([createdAt, updatedAt, questionID, questionStatus, questionInfo]);
}

QuestionListStruct createQuestionListStruct({
  DateTime? createdAt,
  DateTime? updatedAt,
  int? questionID,
  String? questionStatus,
  QuestionInfoStruct? questionInfo,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    QuestionListStruct(
      createdAt: createdAt,
      updatedAt: updatedAt,
      questionID: questionID,
      questionStatus: questionStatus,
      questionInfo:
          questionInfo ?? (clearUnsetFields ? QuestionInfoStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

QuestionListStruct? updateQuestionListStruct(
  QuestionListStruct? questionList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    questionList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addQuestionListStructData(
  Map<String, dynamic> firestoreData,
  QuestionListStruct? questionList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (questionList == null) {
    return;
  }
  if (questionList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && questionList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final questionListData =
      getQuestionListFirestoreData(questionList, forFieldValue);
  final nestedData =
      questionListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = questionList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getQuestionListFirestoreData(
  QuestionListStruct? questionList, [
  bool forFieldValue = false,
]) {
  if (questionList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(questionList.toMap());

  // Handle nested data for "question_Info" field.
  addQuestionInfoStructData(
    firestoreData,
    questionList.hasQuestionInfo() ? questionList.questionInfo : null,
    'question_Info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(questionList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getQuestionListListFirestoreData(
  List<QuestionListStruct>? questionLists,
) =>
    questionLists?.map((e) => getQuestionListFirestoreData(e, true)).toList() ??
    [];
