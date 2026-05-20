// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuestionInfoStruct extends FFFirebaseStruct {
  QuestionInfoStruct({
    int? timeForResultInMin,
    String? questionType,
    MainInfoStruct? questionInfo,
    String? question,
    String? answer,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _timeForResultInMin = timeForResultInMin,
        _questionType = questionType,
        _questionInfo = questionInfo,
        _question = question,
        _answer = answer,
        super(firestoreUtilData);

  // "time_for_result_in_min" field.
  int? _timeForResultInMin;
  int get timeForResultInMin => _timeForResultInMin ?? 0;
  set timeForResultInMin(int? val) => _timeForResultInMin = val;

  void incrementTimeForResultInMin(int amount) =>
      timeForResultInMin = timeForResultInMin + amount;

  bool hasTimeForResultInMin() => _timeForResultInMin != null;

  // "question_type" field.
  String? _questionType;
  String get questionType => _questionType ?? '';
  set questionType(String? val) => _questionType = val;

  bool hasQuestionType() => _questionType != null;

  // "question_info" field.
  MainInfoStruct? _questionInfo;
  MainInfoStruct get questionInfo => _questionInfo ?? MainInfoStruct();
  set questionInfo(MainInfoStruct? val) => _questionInfo = val;

  void updateQuestionInfo(Function(MainInfoStruct) updateFn) {
    updateFn(_questionInfo ??= MainInfoStruct());
  }

  bool hasQuestionInfo() => _questionInfo != null;

  // "question" field.
  String? _question;
  String get question => _question ?? '';
  set question(String? val) => _question = val;

  bool hasQuestion() => _question != null;

  // "answer" field.
  String? _answer;
  String get answer => _answer ?? '';
  set answer(String? val) => _answer = val;

  bool hasAnswer() => _answer != null;

  static QuestionInfoStruct fromMap(Map<String, dynamic> data) =>
      QuestionInfoStruct(
        timeForResultInMin: castToType<int>(data['time_for_result_in_min']),
        questionType: data['question_type'] as String?,
        questionInfo: data['question_info'] is MainInfoStruct
            ? data['question_info']
            : MainInfoStruct.maybeFromMap(data['question_info']),
        question: data['question'] as String?,
        answer: data['answer'] as String?,
      );

  static QuestionInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? QuestionInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'time_for_result_in_min': _timeForResultInMin,
        'question_type': _questionType,
        'question_info': _questionInfo?.toMap(),
        'question': _question,
        'answer': _answer,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'time_for_result_in_min': serializeParam(
          _timeForResultInMin,
          ParamType.int,
        ),
        'question_type': serializeParam(
          _questionType,
          ParamType.String,
        ),
        'question_info': serializeParam(
          _questionInfo,
          ParamType.DataStruct,
        ),
        'question': serializeParam(
          _question,
          ParamType.String,
        ),
        'answer': serializeParam(
          _answer,
          ParamType.String,
        ),
      }.withoutNulls;

  static QuestionInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      QuestionInfoStruct(
        timeForResultInMin: deserializeParam(
          data['time_for_result_in_min'],
          ParamType.int,
          false,
        ),
        questionType: deserializeParam(
          data['question_type'],
          ParamType.String,
          false,
        ),
        questionInfo: deserializeStructParam(
          data['question_info'],
          ParamType.DataStruct,
          false,
          structBuilder: MainInfoStruct.fromSerializableMap,
        ),
        question: deserializeParam(
          data['question'],
          ParamType.String,
          false,
        ),
        answer: deserializeParam(
          data['answer'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'QuestionInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is QuestionInfoStruct &&
        timeForResultInMin == other.timeForResultInMin &&
        questionType == other.questionType &&
        questionInfo == other.questionInfo &&
        question == other.question &&
        answer == other.answer;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([timeForResultInMin, questionType, questionInfo, question, answer]);
}

QuestionInfoStruct createQuestionInfoStruct({
  int? timeForResultInMin,
  String? questionType,
  MainInfoStruct? questionInfo,
  String? question,
  String? answer,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    QuestionInfoStruct(
      timeForResultInMin: timeForResultInMin,
      questionType: questionType,
      questionInfo:
          questionInfo ?? (clearUnsetFields ? MainInfoStruct() : null),
      question: question,
      answer: answer,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

QuestionInfoStruct? updateQuestionInfoStruct(
  QuestionInfoStruct? questionInfoStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    questionInfoStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addQuestionInfoStructData(
  Map<String, dynamic> firestoreData,
  QuestionInfoStruct? questionInfoStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (questionInfoStruct == null) {
    return;
  }
  if (questionInfoStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && questionInfoStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final questionInfoStructData =
      getQuestionInfoFirestoreData(questionInfoStruct, forFieldValue);
  final nestedData =
      questionInfoStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      questionInfoStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getQuestionInfoFirestoreData(
  QuestionInfoStruct? questionInfoStruct, [
  bool forFieldValue = false,
]) {
  if (questionInfoStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(questionInfoStruct.toMap());

  // Handle nested data for "question_info" field.
  addMainInfoStructData(
    firestoreData,
    questionInfoStruct.hasQuestionInfo()
        ? questionInfoStruct.questionInfo
        : null,
    'question_info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(questionInfoStruct.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getQuestionInfoListFirestoreData(
  List<QuestionInfoStruct>? questionInfoStructs,
) =>
    questionInfoStructs
        ?.map((e) => getQuestionInfoFirestoreData(e, true))
        .toList() ??
    [];
