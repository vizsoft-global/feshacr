// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResultInfoStruct extends FFFirebaseStruct {
  ResultInfoStruct({
    DateTime? createdAt,
    String? status,
    int? teamID,
    MainInfoStruct? teamInfo,
    int? userID,
    DocumentReference? userRef,
    int? point,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _status = status,
        _teamID = teamID,
        _teamInfo = teamInfo,
        _userID = userID,
        _userRef = userRef,
        _point = point,
        super(firestoreUtilData);

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "team_ID" field.
  int? _teamID;
  int get teamID => _teamID ?? 0;
  set teamID(int? val) => _teamID = val;

  void incrementTeamID(int amount) => teamID = teamID + amount;

  bool hasTeamID() => _teamID != null;

  // "team_info" field.
  MainInfoStruct? _teamInfo;
  MainInfoStruct get teamInfo => _teamInfo ?? MainInfoStruct();
  set teamInfo(MainInfoStruct? val) => _teamInfo = val;

  void updateTeamInfo(Function(MainInfoStruct) updateFn) {
    updateFn(_teamInfo ??= MainInfoStruct());
  }

  bool hasTeamInfo() => _teamInfo != null;

  // "user_ID" field.
  int? _userID;
  int get userID => _userID ?? 0;
  set userID(int? val) => _userID = val;

  void incrementUserID(int amount) => userID = userID + amount;

  bool hasUserID() => _userID != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;

  bool hasUserRef() => _userRef != null;

  // "point" field.
  int? _point;
  int get point => _point ?? 0;
  set point(int? val) => _point = val;

  void incrementPoint(int amount) => point = point + amount;

  bool hasPoint() => _point != null;

  static ResultInfoStruct fromMap(Map<String, dynamic> data) =>
      ResultInfoStruct(
        createdAt: data['created_at'] as DateTime?,
        status: data['status'] as String?,
        teamID: castToType<int>(data['team_ID']),
        teamInfo: data['team_info'] is MainInfoStruct
            ? data['team_info']
            : MainInfoStruct.maybeFromMap(data['team_info']),
        userID: castToType<int>(data['user_ID']),
        userRef: data['user_ref'] as DocumentReference?,
        point: castToType<int>(data['point']),
      );

  static ResultInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? ResultInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'status': _status,
        'team_ID': _teamID,
        'team_info': _teamInfo?.toMap(),
        'user_ID': _userID,
        'user_ref': _userRef,
        'point': _point,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'created_at': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'team_ID': serializeParam(
          _teamID,
          ParamType.int,
        ),
        'team_info': serializeParam(
          _teamInfo,
          ParamType.DataStruct,
        ),
        'user_ID': serializeParam(
          _userID,
          ParamType.int,
        ),
        'user_ref': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'point': serializeParam(
          _point,
          ParamType.int,
        ),
      }.withoutNulls;

  static ResultInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      ResultInfoStruct(
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.DateTime,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        teamID: deserializeParam(
          data['team_ID'],
          ParamType.int,
          false,
        ),
        teamInfo: deserializeStructParam(
          data['team_info'],
          ParamType.DataStruct,
          false,
          structBuilder: MainInfoStruct.fromSerializableMap,
        ),
        userID: deserializeParam(
          data['user_ID'],
          ParamType.int,
          false,
        ),
        userRef: deserializeParam(
          data['user_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        point: deserializeParam(
          data['point'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ResultInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ResultInfoStruct &&
        createdAt == other.createdAt &&
        status == other.status &&
        teamID == other.teamID &&
        teamInfo == other.teamInfo &&
        userID == other.userID &&
        userRef == other.userRef &&
        point == other.point;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([createdAt, status, teamID, teamInfo, userID, userRef, point]);
}

ResultInfoStruct createResultInfoStruct({
  DateTime? createdAt,
  String? status,
  int? teamID,
  MainInfoStruct? teamInfo,
  int? userID,
  DocumentReference? userRef,
  int? point,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ResultInfoStruct(
      createdAt: createdAt,
      status: status,
      teamID: teamID,
      teamInfo: teamInfo ?? (clearUnsetFields ? MainInfoStruct() : null),
      userID: userID,
      userRef: userRef,
      point: point,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ResultInfoStruct? updateResultInfoStruct(
  ResultInfoStruct? resultInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    resultInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addResultInfoStructData(
  Map<String, dynamic> firestoreData,
  ResultInfoStruct? resultInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (resultInfo == null) {
    return;
  }
  if (resultInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && resultInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final resultInfoData = getResultInfoFirestoreData(resultInfo, forFieldValue);
  final nestedData = resultInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = resultInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getResultInfoFirestoreData(
  ResultInfoStruct? resultInfo, [
  bool forFieldValue = false,
]) {
  if (resultInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(resultInfo.toMap());

  // Handle nested data for "team_info" field.
  addMainInfoStructData(
    firestoreData,
    resultInfo.hasTeamInfo() ? resultInfo.teamInfo : null,
    'team_info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(resultInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getResultInfoListFirestoreData(
  List<ResultInfoStruct>? resultInfos,
) =>
    resultInfos?.map((e) => getResultInfoFirestoreData(e, true)).toList() ?? [];
