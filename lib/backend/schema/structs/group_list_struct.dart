// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GroupListStruct extends FFFirebaseStruct {
  GroupListStruct({
    DateTime? createdAt,
    DateTime? updatedAt,
    int? groupID,
    String? groupStatus,
    MainInfoStruct? groupInfo,
    int? groupPoint,
    List<QuestionListStruct>? questionList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _updatedAt = updatedAt,
        _groupID = groupID,
        _groupStatus = groupStatus,
        _groupInfo = groupInfo,
        _groupPoint = groupPoint,
        _questionList = questionList,
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

  // "group_ID" field.
  int? _groupID;
  int get groupID => _groupID ?? 0;
  set groupID(int? val) => _groupID = val;

  void incrementGroupID(int amount) => groupID = groupID + amount;

  bool hasGroupID() => _groupID != null;

  // "group_status" field.
  String? _groupStatus;
  String get groupStatus => _groupStatus ?? '';
  set groupStatus(String? val) => _groupStatus = val;

  bool hasGroupStatus() => _groupStatus != null;

  // "group_Info" field.
  MainInfoStruct? _groupInfo;
  MainInfoStruct get groupInfo => _groupInfo ?? MainInfoStruct();
  set groupInfo(MainInfoStruct? val) => _groupInfo = val;

  void updateGroupInfo(Function(MainInfoStruct) updateFn) {
    updateFn(_groupInfo ??= MainInfoStruct());
  }

  bool hasGroupInfo() => _groupInfo != null;

  // "group_point" field.
  int? _groupPoint;
  int get groupPoint => _groupPoint ?? 0;
  set groupPoint(int? val) => _groupPoint = val;

  void incrementGroupPoint(int amount) => groupPoint = groupPoint + amount;

  bool hasGroupPoint() => _groupPoint != null;

  // "question_list" field.
  List<QuestionListStruct>? _questionList;
  List<QuestionListStruct> get questionList => _questionList ?? const [];
  set questionList(List<QuestionListStruct>? val) => _questionList = val;

  void updateQuestionList(Function(List<QuestionListStruct>) updateFn) {
    updateFn(_questionList ??= []);
  }

  bool hasQuestionList() => _questionList != null;

  static GroupListStruct fromMap(Map<String, dynamic> data) => GroupListStruct(
        createdAt: data['created_at'] as DateTime?,
        updatedAt: data['updated_at'] as DateTime?,
        groupID: castToType<int>(data['group_ID']),
        groupStatus: data['group_status'] as String?,
        groupInfo: data['group_Info'] is MainInfoStruct
            ? data['group_Info']
            : MainInfoStruct.maybeFromMap(data['group_Info']),
        groupPoint: castToType<int>(data['group_point']),
        questionList: getStructList(
          data['question_list'],
          QuestionListStruct.fromMap,
        ),
      );

  static GroupListStruct? maybeFromMap(dynamic data) => data is Map
      ? GroupListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'group_ID': _groupID,
        'group_status': _groupStatus,
        'group_Info': _groupInfo?.toMap(),
        'group_point': _groupPoint,
        'question_list': _questionList?.map((e) => e.toMap()).toList(),
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
        'group_ID': serializeParam(
          _groupID,
          ParamType.int,
        ),
        'group_status': serializeParam(
          _groupStatus,
          ParamType.String,
        ),
        'group_Info': serializeParam(
          _groupInfo,
          ParamType.DataStruct,
        ),
        'group_point': serializeParam(
          _groupPoint,
          ParamType.int,
        ),
        'question_list': serializeParam(
          _questionList,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static GroupListStruct fromSerializableMap(Map<String, dynamic> data) =>
      GroupListStruct(
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
        groupID: deserializeParam(
          data['group_ID'],
          ParamType.int,
          false,
        ),
        groupStatus: deserializeParam(
          data['group_status'],
          ParamType.String,
          false,
        ),
        groupInfo: deserializeStructParam(
          data['group_Info'],
          ParamType.DataStruct,
          false,
          structBuilder: MainInfoStruct.fromSerializableMap,
        ),
        groupPoint: deserializeParam(
          data['group_point'],
          ParamType.int,
          false,
        ),
        questionList: deserializeStructParam<QuestionListStruct>(
          data['question_list'],
          ParamType.DataStruct,
          true,
          structBuilder: QuestionListStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'GroupListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is GroupListStruct &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        groupID == other.groupID &&
        groupStatus == other.groupStatus &&
        groupInfo == other.groupInfo &&
        groupPoint == other.groupPoint &&
        listEquality.equals(questionList, other.questionList);
  }

  @override
  int get hashCode => const ListEquality().hash([
        createdAt,
        updatedAt,
        groupID,
        groupStatus,
        groupInfo,
        groupPoint,
        questionList
      ]);
}

GroupListStruct createGroupListStruct({
  DateTime? createdAt,
  DateTime? updatedAt,
  int? groupID,
  String? groupStatus,
  MainInfoStruct? groupInfo,
  int? groupPoint,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GroupListStruct(
      createdAt: createdAt,
      updatedAt: updatedAt,
      groupID: groupID,
      groupStatus: groupStatus,
      groupInfo: groupInfo ?? (clearUnsetFields ? MainInfoStruct() : null),
      groupPoint: groupPoint,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GroupListStruct? updateGroupListStruct(
  GroupListStruct? groupList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    groupList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGroupListStructData(
  Map<String, dynamic> firestoreData,
  GroupListStruct? groupList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (groupList == null) {
    return;
  }
  if (groupList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && groupList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final groupListData = getGroupListFirestoreData(groupList, forFieldValue);
  final nestedData = groupListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = groupList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGroupListFirestoreData(
  GroupListStruct? groupList, [
  bool forFieldValue = false,
]) {
  if (groupList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(groupList.toMap());

  // Handle nested data for "group_Info" field.
  addMainInfoStructData(
    firestoreData,
    groupList.hasGroupInfo() ? groupList.groupInfo : null,
    'group_Info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(groupList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGroupListListFirestoreData(
  List<GroupListStruct>? groupLists,
) =>
    groupLists?.map((e) => getGroupListFirestoreData(e, true)).toList() ?? [];
