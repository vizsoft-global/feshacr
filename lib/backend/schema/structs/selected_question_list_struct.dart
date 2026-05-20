// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SelectedQuestionListStruct extends FFFirebaseStruct {
  SelectedQuestionListStruct({
    int? questionID,
    String? questionAnswerStatus,
    ResultInfoStruct? resultInfo,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _questionID = questionID,
        _questionAnswerStatus = questionAnswerStatus,
        _resultInfo = resultInfo,
        super(firestoreUtilData);

  // "question_ID" field.
  int? _questionID;
  int get questionID => _questionID ?? 0;
  set questionID(int? val) => _questionID = val;

  void incrementQuestionID(int amount) => questionID = questionID + amount;

  bool hasQuestionID() => _questionID != null;

  // "question_answer_status" field.
  String? _questionAnswerStatus;
  String get questionAnswerStatus => _questionAnswerStatus ?? '';
  set questionAnswerStatus(String? val) => _questionAnswerStatus = val;

  bool hasQuestionAnswerStatus() => _questionAnswerStatus != null;

  // "result_info" field.
  ResultInfoStruct? _resultInfo;
  ResultInfoStruct get resultInfo => _resultInfo ?? ResultInfoStruct();
  set resultInfo(ResultInfoStruct? val) => _resultInfo = val;

  void updateResultInfo(Function(ResultInfoStruct) updateFn) {
    updateFn(_resultInfo ??= ResultInfoStruct());
  }

  bool hasResultInfo() => _resultInfo != null;

  static SelectedQuestionListStruct fromMap(Map<String, dynamic> data) =>
      SelectedQuestionListStruct(
        questionID: castToType<int>(data['question_ID']),
        questionAnswerStatus: data['question_answer_status'] as String?,
        resultInfo: data['result_info'] is ResultInfoStruct
            ? data['result_info']
            : ResultInfoStruct.maybeFromMap(data['result_info']),
      );

  static SelectedQuestionListStruct? maybeFromMap(dynamic data) => data is Map
      ? SelectedQuestionListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'question_ID': _questionID,
        'question_answer_status': _questionAnswerStatus,
        'result_info': _resultInfo?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'question_ID': serializeParam(
          _questionID,
          ParamType.int,
        ),
        'question_answer_status': serializeParam(
          _questionAnswerStatus,
          ParamType.String,
        ),
        'result_info': serializeParam(
          _resultInfo,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static SelectedQuestionListStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SelectedQuestionListStruct(
        questionID: deserializeParam(
          data['question_ID'],
          ParamType.int,
          false,
        ),
        questionAnswerStatus: deserializeParam(
          data['question_answer_status'],
          ParamType.String,
          false,
        ),
        resultInfo: deserializeStructParam(
          data['result_info'],
          ParamType.DataStruct,
          false,
          structBuilder: ResultInfoStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SelectedQuestionListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SelectedQuestionListStruct &&
        questionID == other.questionID &&
        questionAnswerStatus == other.questionAnswerStatus &&
        resultInfo == other.resultInfo;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([questionID, questionAnswerStatus, resultInfo]);
}

SelectedQuestionListStruct createSelectedQuestionListStruct({
  int? questionID,
  String? questionAnswerStatus,
  ResultInfoStruct? resultInfo,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SelectedQuestionListStruct(
      questionID: questionID,
      questionAnswerStatus: questionAnswerStatus,
      resultInfo: resultInfo ?? (clearUnsetFields ? ResultInfoStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SelectedQuestionListStruct? updateSelectedQuestionListStruct(
  SelectedQuestionListStruct? selectedQuestionList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    selectedQuestionList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSelectedQuestionListStructData(
  Map<String, dynamic> firestoreData,
  SelectedQuestionListStruct? selectedQuestionList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (selectedQuestionList == null) {
    return;
  }
  if (selectedQuestionList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && selectedQuestionList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final selectedQuestionListData =
      getSelectedQuestionListFirestoreData(selectedQuestionList, forFieldValue);
  final nestedData =
      selectedQuestionListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      selectedQuestionList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSelectedQuestionListFirestoreData(
  SelectedQuestionListStruct? selectedQuestionList, [
  bool forFieldValue = false,
]) {
  if (selectedQuestionList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(selectedQuestionList.toMap());

  // Handle nested data for "result_info" field.
  addResultInfoStructData(
    firestoreData,
    selectedQuestionList.hasResultInfo()
        ? selectedQuestionList.resultInfo
        : null,
    'result_info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(selectedQuestionList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSelectedQuestionListListFirestoreData(
  List<SelectedQuestionListStruct>? selectedQuestionLists,
) =>
    selectedQuestionLists
        ?.map((e) => getSelectedQuestionListFirestoreData(e, true))
        .toList() ??
    [];
