// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TopicListStruct extends FFFirebaseStruct {
  TopicListStruct({
    DateTime? createdAt,
    DateTime? updatedAt,
    int? topicID,
    String? topicStatus,
    MainInfoStruct? topicInfo,
    List<GroupListStruct>? groupList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _updatedAt = updatedAt,
        _topicID = topicID,
        _topicStatus = topicStatus,
        _topicInfo = topicInfo,
        _groupList = groupList,
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

  // "topic_ID" field.
  int? _topicID;
  int get topicID => _topicID ?? 0;
  set topicID(int? val) => _topicID = val;

  void incrementTopicID(int amount) => topicID = topicID + amount;

  bool hasTopicID() => _topicID != null;

  // "topic_status" field.
  String? _topicStatus;
  String get topicStatus => _topicStatus ?? '';
  set topicStatus(String? val) => _topicStatus = val;

  bool hasTopicStatus() => _topicStatus != null;

  // "topic_info" field.
  MainInfoStruct? _topicInfo;
  MainInfoStruct get topicInfo => _topicInfo ?? MainInfoStruct();
  set topicInfo(MainInfoStruct? val) => _topicInfo = val;

  void updateTopicInfo(Function(MainInfoStruct) updateFn) {
    updateFn(_topicInfo ??= MainInfoStruct());
  }

  bool hasTopicInfo() => _topicInfo != null;

  // "group_list" field.
  List<GroupListStruct>? _groupList;
  List<GroupListStruct> get groupList => _groupList ?? const [];
  set groupList(List<GroupListStruct>? val) => _groupList = val;

  void updateGroupList(Function(List<GroupListStruct>) updateFn) {
    updateFn(_groupList ??= []);
  }

  bool hasGroupList() => _groupList != null;

  static TopicListStruct fromMap(Map<String, dynamic> data) => TopicListStruct(
        createdAt: data['created_at'] as DateTime?,
        updatedAt: data['updated_at'] as DateTime?,
        topicID: castToType<int>(data['topic_ID']),
        topicStatus: data['topic_status'] as String?,
        topicInfo: data['topic_info'] is MainInfoStruct
            ? data['topic_info']
            : MainInfoStruct.maybeFromMap(data['topic_info']),
        groupList: getStructList(
          data['group_list'],
          GroupListStruct.fromMap,
        ),
      );

  static TopicListStruct? maybeFromMap(dynamic data) => data is Map
      ? TopicListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'topic_ID': _topicID,
        'topic_status': _topicStatus,
        'topic_info': _topicInfo?.toMap(),
        'group_list': _groupList?.map((e) => e.toMap()).toList(),
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
        'topic_ID': serializeParam(
          _topicID,
          ParamType.int,
        ),
        'topic_status': serializeParam(
          _topicStatus,
          ParamType.String,
        ),
        'topic_info': serializeParam(
          _topicInfo,
          ParamType.DataStruct,
        ),
        'group_list': serializeParam(
          _groupList,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static TopicListStruct fromSerializableMap(Map<String, dynamic> data) =>
      TopicListStruct(
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
        topicID: deserializeParam(
          data['topic_ID'],
          ParamType.int,
          false,
        ),
        topicStatus: deserializeParam(
          data['topic_status'],
          ParamType.String,
          false,
        ),
        topicInfo: deserializeStructParam(
          data['topic_info'],
          ParamType.DataStruct,
          false,
          structBuilder: MainInfoStruct.fromSerializableMap,
        ),
        groupList: deserializeStructParam<GroupListStruct>(
          data['group_list'],
          ParamType.DataStruct,
          true,
          structBuilder: GroupListStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'TopicListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TopicListStruct &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        topicID == other.topicID &&
        topicStatus == other.topicStatus &&
        topicInfo == other.topicInfo &&
        listEquality.equals(groupList, other.groupList);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([createdAt, updatedAt, topicID, topicStatus, topicInfo, groupList]);
}

TopicListStruct createTopicListStruct({
  DateTime? createdAt,
  DateTime? updatedAt,
  int? topicID,
  String? topicStatus,
  MainInfoStruct? topicInfo,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TopicListStruct(
      createdAt: createdAt,
      updatedAt: updatedAt,
      topicID: topicID,
      topicStatus: topicStatus,
      topicInfo: topicInfo ?? (clearUnsetFields ? MainInfoStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TopicListStruct? updateTopicListStruct(
  TopicListStruct? topicList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    topicList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTopicListStructData(
  Map<String, dynamic> firestoreData,
  TopicListStruct? topicList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (topicList == null) {
    return;
  }
  if (topicList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && topicList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final topicListData = getTopicListFirestoreData(topicList, forFieldValue);
  final nestedData = topicListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = topicList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTopicListFirestoreData(
  TopicListStruct? topicList, [
  bool forFieldValue = false,
]) {
  if (topicList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(topicList.toMap());

  // Handle nested data for "topic_info" field.
  addMainInfoStructData(
    firestoreData,
    topicList.hasTopicInfo() ? topicList.topicInfo : null,
    'topic_info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(topicList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTopicListListFirestoreData(
  List<TopicListStruct>? topicLists,
) =>
    topicLists?.map((e) => getTopicListFirestoreData(e, true)).toList() ?? [];
