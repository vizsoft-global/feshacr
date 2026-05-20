// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeamInfoStruct extends FFFirebaseStruct {
  TeamInfoStruct({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? teamStatus,
    int? teamID,
    MainInfoStruct? teamInfo,
    List<RoomUserListStruct>? roomUserList,
    int? totalResult,
    bool? helpLineCall,
    bool? helpLineSwap,
    bool? helpLineDouble,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _updatedAt = updatedAt,
        _teamStatus = teamStatus,
        _teamID = teamID,
        _teamInfo = teamInfo,
        _roomUserList = roomUserList,
        _totalResult = totalResult,
        _helpLineCall = helpLineCall,
        _helpLineSwap = helpLineSwap,
        _helpLineDouble = helpLineDouble,
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

  // "team_status" field.
  String? _teamStatus;
  String get teamStatus => _teamStatus ?? '';
  set teamStatus(String? val) => _teamStatus = val;

  bool hasTeamStatus() => _teamStatus != null;

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

  // "room_user_list" field.
  List<RoomUserListStruct>? _roomUserList;
  List<RoomUserListStruct> get roomUserList => _roomUserList ?? const [];
  set roomUserList(List<RoomUserListStruct>? val) => _roomUserList = val;

  void updateRoomUserList(Function(List<RoomUserListStruct>) updateFn) {
    updateFn(_roomUserList ??= []);
  }

  bool hasRoomUserList() => _roomUserList != null;

  // "total_result" field.
  int? _totalResult;
  int get totalResult => _totalResult ?? 0;
  set totalResult(int? val) => _totalResult = val;

  void incrementTotalResult(int amount) => totalResult = totalResult + amount;

  bool hasTotalResult() => _totalResult != null;

  // "helpLine_call" field.
  bool? _helpLineCall;
  bool get helpLineCall => _helpLineCall ?? false;
  set helpLineCall(bool? val) => _helpLineCall = val;

  bool hasHelpLineCall() => _helpLineCall != null;

  // "helpLine_swap" field.
  bool? _helpLineSwap;
  bool get helpLineSwap => _helpLineSwap ?? false;
  set helpLineSwap(bool? val) => _helpLineSwap = val;

  bool hasHelpLineSwap() => _helpLineSwap != null;

  // "helpLine_double" field.
  bool? _helpLineDouble;
  bool get helpLineDouble => _helpLineDouble ?? false;
  set helpLineDouble(bool? val) => _helpLineDouble = val;

  bool hasHelpLineDouble() => _helpLineDouble != null;

  static TeamInfoStruct fromMap(Map<String, dynamic> data) => TeamInfoStruct(
        createdAt: data['created_at'] as DateTime?,
        updatedAt: data['updated_at'] as DateTime?,
        teamStatus: data['team_status'] as String?,
        teamID: castToType<int>(data['team_ID']),
        teamInfo: data['team_info'] is MainInfoStruct
            ? data['team_info']
            : MainInfoStruct.maybeFromMap(data['team_info']),
        roomUserList: getStructList(
          data['room_user_list'],
          RoomUserListStruct.fromMap,
        ),
        totalResult: castToType<int>(data['total_result']),
        helpLineCall: data['helpLine_call'] as bool?,
        helpLineSwap: data['helpLine_swap'] as bool?,
        helpLineDouble: data['helpLine_double'] as bool?,
      );

  static TeamInfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? TeamInfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'team_status': _teamStatus,
        'team_ID': _teamID,
        'team_info': _teamInfo?.toMap(),
        'room_user_list': _roomUserList?.map((e) => e.toMap()).toList(),
        'total_result': _totalResult,
        'helpLine_call': _helpLineCall,
        'helpLine_swap': _helpLineSwap,
        'helpLine_double': _helpLineDouble,
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
        'team_status': serializeParam(
          _teamStatus,
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
        'room_user_list': serializeParam(
          _roomUserList,
          ParamType.DataStruct,
          isList: true,
        ),
        'total_result': serializeParam(
          _totalResult,
          ParamType.int,
        ),
        'helpLine_call': serializeParam(
          _helpLineCall,
          ParamType.bool,
        ),
        'helpLine_swap': serializeParam(
          _helpLineSwap,
          ParamType.bool,
        ),
        'helpLine_double': serializeParam(
          _helpLineDouble,
          ParamType.bool,
        ),
      }.withoutNulls;

  static TeamInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      TeamInfoStruct(
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
        teamStatus: deserializeParam(
          data['team_status'],
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
        roomUserList: deserializeStructParam<RoomUserListStruct>(
          data['room_user_list'],
          ParamType.DataStruct,
          true,
          structBuilder: RoomUserListStruct.fromSerializableMap,
        ),
        totalResult: deserializeParam(
          data['total_result'],
          ParamType.int,
          false,
        ),
        helpLineCall: deserializeParam(
          data['helpLine_call'],
          ParamType.bool,
          false,
        ),
        helpLineSwap: deserializeParam(
          data['helpLine_swap'],
          ParamType.bool,
          false,
        ),
        helpLineDouble: deserializeParam(
          data['helpLine_double'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'TeamInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TeamInfoStruct &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        teamStatus == other.teamStatus &&
        teamID == other.teamID &&
        teamInfo == other.teamInfo &&
        listEquality.equals(roomUserList, other.roomUserList) &&
        totalResult == other.totalResult &&
        helpLineCall == other.helpLineCall &&
        helpLineSwap == other.helpLineSwap &&
        helpLineDouble == other.helpLineDouble;
  }

  @override
  int get hashCode => const ListEquality().hash([
        createdAt,
        updatedAt,
        teamStatus,
        teamID,
        teamInfo,
        roomUserList,
        totalResult,
        helpLineCall,
        helpLineSwap,
        helpLineDouble
      ]);
}

TeamInfoStruct createTeamInfoStruct({
  DateTime? createdAt,
  DateTime? updatedAt,
  String? teamStatus,
  int? teamID,
  MainInfoStruct? teamInfo,
  int? totalResult,
  bool? helpLineCall,
  bool? helpLineSwap,
  bool? helpLineDouble,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TeamInfoStruct(
      createdAt: createdAt,
      updatedAt: updatedAt,
      teamStatus: teamStatus,
      teamID: teamID,
      teamInfo: teamInfo ?? (clearUnsetFields ? MainInfoStruct() : null),
      totalResult: totalResult,
      helpLineCall: helpLineCall,
      helpLineSwap: helpLineSwap,
      helpLineDouble: helpLineDouble,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TeamInfoStruct? updateTeamInfoStruct(
  TeamInfoStruct? teamInfoStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    teamInfoStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTeamInfoStructData(
  Map<String, dynamic> firestoreData,
  TeamInfoStruct? teamInfoStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (teamInfoStruct == null) {
    return;
  }
  if (teamInfoStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && teamInfoStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final teamInfoStructData =
      getTeamInfoFirestoreData(teamInfoStruct, forFieldValue);
  final nestedData =
      teamInfoStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = teamInfoStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTeamInfoFirestoreData(
  TeamInfoStruct? teamInfoStruct, [
  bool forFieldValue = false,
]) {
  if (teamInfoStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(teamInfoStruct.toMap());

  // Handle nested data for "team_info" field.
  addMainInfoStructData(
    firestoreData,
    teamInfoStruct.hasTeamInfo() ? teamInfoStruct.teamInfo : null,
    'team_info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(teamInfoStruct.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTeamInfoListFirestoreData(
  List<TeamInfoStruct>? teamInfoStructs,
) =>
    teamInfoStructs?.map((e) => getTeamInfoFirestoreData(e, true)).toList() ??
    [];
