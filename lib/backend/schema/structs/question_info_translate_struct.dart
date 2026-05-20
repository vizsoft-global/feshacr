// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuestionInfoTranslateStruct extends FFFirebaseStruct {
  QuestionInfoTranslateStruct({
    TranslateLangStruct? question,
    TranslateLangStruct? answer,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _question = question,
        _answer = answer,
        super(firestoreUtilData);

  // "question" field.
  TranslateLangStruct? _question;
  TranslateLangStruct get question => _question ?? TranslateLangStruct();
  set question(TranslateLangStruct? val) => _question = val;

  void updateQuestion(Function(TranslateLangStruct) updateFn) {
    updateFn(_question ??= TranslateLangStruct());
  }

  bool hasQuestion() => _question != null;

  // "answer" field.
  TranslateLangStruct? _answer;
  TranslateLangStruct get answer => _answer ?? TranslateLangStruct();
  set answer(TranslateLangStruct? val) => _answer = val;

  void updateAnswer(Function(TranslateLangStruct) updateFn) {
    updateFn(_answer ??= TranslateLangStruct());
  }

  bool hasAnswer() => _answer != null;

  static QuestionInfoTranslateStruct fromMap(Map<String, dynamic> data) =>
      QuestionInfoTranslateStruct(
        question: data['question'] is TranslateLangStruct
            ? data['question']
            : TranslateLangStruct.maybeFromMap(data['question']),
        answer: data['answer'] is TranslateLangStruct
            ? data['answer']
            : TranslateLangStruct.maybeFromMap(data['answer']),
      );

  static QuestionInfoTranslateStruct? maybeFromMap(dynamic data) => data is Map
      ? QuestionInfoTranslateStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'question': _question?.toMap(),
        'answer': _answer?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'question': serializeParam(
          _question,
          ParamType.DataStruct,
        ),
        'answer': serializeParam(
          _answer,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static QuestionInfoTranslateStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      QuestionInfoTranslateStruct(
        question: deserializeStructParam(
          data['question'],
          ParamType.DataStruct,
          false,
          structBuilder: TranslateLangStruct.fromSerializableMap,
        ),
        answer: deserializeStructParam(
          data['answer'],
          ParamType.DataStruct,
          false,
          structBuilder: TranslateLangStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'QuestionInfoTranslateStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is QuestionInfoTranslateStruct &&
        question == other.question &&
        answer == other.answer;
  }

  @override
  int get hashCode => const ListEquality().hash([question, answer]);
}

QuestionInfoTranslateStruct createQuestionInfoTranslateStruct({
  TranslateLangStruct? question,
  TranslateLangStruct? answer,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    QuestionInfoTranslateStruct(
      question: question ?? (clearUnsetFields ? TranslateLangStruct() : null),
      answer: answer ?? (clearUnsetFields ? TranslateLangStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

QuestionInfoTranslateStruct? updateQuestionInfoTranslateStruct(
  QuestionInfoTranslateStruct? questionInfoTranslate, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    questionInfoTranslate
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addQuestionInfoTranslateStructData(
  Map<String, dynamic> firestoreData,
  QuestionInfoTranslateStruct? questionInfoTranslate,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (questionInfoTranslate == null) {
    return;
  }
  if (questionInfoTranslate.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      questionInfoTranslate.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final questionInfoTranslateData = getQuestionInfoTranslateFirestoreData(
      questionInfoTranslate, forFieldValue);
  final nestedData =
      questionInfoTranslateData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      questionInfoTranslate.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getQuestionInfoTranslateFirestoreData(
  QuestionInfoTranslateStruct? questionInfoTranslate, [
  bool forFieldValue = false,
]) {
  if (questionInfoTranslate == null) {
    return {};
  }
  final firestoreData = mapToFirestore(questionInfoTranslate.toMap());

  // Handle nested data for "question" field.
  addTranslateLangStructData(
    firestoreData,
    questionInfoTranslate.hasQuestion() ? questionInfoTranslate.question : null,
    'question',
    forFieldValue,
  );

  // Handle nested data for "answer" field.
  addTranslateLangStructData(
    firestoreData,
    questionInfoTranslate.hasAnswer() ? questionInfoTranslate.answer : null,
    'answer',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(questionInfoTranslate.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getQuestionInfoTranslateListFirestoreData(
  List<QuestionInfoTranslateStruct>? questionInfoTranslates,
) =>
    questionInfoTranslates
        ?.map((e) => getQuestionInfoTranslateFirestoreData(e, true))
        .toList() ??
    [];
