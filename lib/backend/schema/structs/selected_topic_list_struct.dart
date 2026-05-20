// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SelectedTopicListStruct extends FFFirebaseStruct {
  SelectedTopicListStruct({
    int? topicID,
    List<SelectedQuestionListStruct>? selectedQuestionList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _topicID = topicID,
        _selectedQuestionList = selectedQuestionList,
        super(firestoreUtilData);

  // "topic_ID" field.
  int? _topicID;
  int get topicID => _topicID ?? 0;
  set topicID(int? val) => _topicID = val;

  void incrementTopicID(int amount) => topicID = topicID + amount;

  bool hasTopicID() => _topicID != null;

  // "selectedQuestionList" field.
  List<SelectedQuestionListStruct>? _selectedQuestionList;
  List<SelectedQuestionListStruct> get selectedQuestionList =>
      _selectedQuestionList ?? const [];
  set selectedQuestionList(List<SelectedQuestionListStruct>? val) =>
      _selectedQuestionList = val;

  void updateSelectedQuestionList(
      Function(List<SelectedQuestionListStruct>) updateFn) {
    updateFn(_selectedQuestionList ??= []);
  }

  bool hasSelectedQuestionList() => _selectedQuestionList != null;

  static SelectedTopicListStruct fromMap(Map<String, dynamic> data) =>
      SelectedTopicListStruct(
        topicID: castToType<int>(data['topic_ID']),
        selectedQuestionList: getStructList(
          data['selectedQuestionList'],
          SelectedQuestionListStruct.fromMap,
        ),
      );

  static SelectedTopicListStruct? maybeFromMap(dynamic data) => data is Map
      ? SelectedTopicListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'topic_ID': _topicID,
        'selectedQuestionList':
            _selectedQuestionList?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'topic_ID': serializeParam(
          _topicID,
          ParamType.int,
        ),
        'selectedQuestionList': serializeParam(
          _selectedQuestionList,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static SelectedTopicListStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SelectedTopicListStruct(
        topicID: deserializeParam(
          data['topic_ID'],
          ParamType.int,
          false,
        ),
        selectedQuestionList:
            deserializeStructParam<SelectedQuestionListStruct>(
          data['selectedQuestionList'],
          ParamType.DataStruct,
          true,
          structBuilder: SelectedQuestionListStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SelectedTopicListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SelectedTopicListStruct &&
        topicID == other.topicID &&
        listEquality.equals(selectedQuestionList, other.selectedQuestionList);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([topicID, selectedQuestionList]);
}

SelectedTopicListStruct createSelectedTopicListStruct({
  int? topicID,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SelectedTopicListStruct(
      topicID: topicID,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SelectedTopicListStruct? updateSelectedTopicListStruct(
  SelectedTopicListStruct? selectedTopicList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    selectedTopicList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSelectedTopicListStructData(
  Map<String, dynamic> firestoreData,
  SelectedTopicListStruct? selectedTopicList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (selectedTopicList == null) {
    return;
  }
  if (selectedTopicList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && selectedTopicList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final selectedTopicListData =
      getSelectedTopicListFirestoreData(selectedTopicList, forFieldValue);
  final nestedData =
      selectedTopicListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = selectedTopicList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSelectedTopicListFirestoreData(
  SelectedTopicListStruct? selectedTopicList, [
  bool forFieldValue = false,
]) {
  if (selectedTopicList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(selectedTopicList.toMap());

  // Add any Firestore field values
  mapToFirestore(selectedTopicList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSelectedTopicListListFirestoreData(
  List<SelectedTopicListStruct>? selectedTopicLists,
) =>
    selectedTopicLists
        ?.map((e) => getSelectedTopicListFirestoreData(e, true))
        .toList() ??
    [];
