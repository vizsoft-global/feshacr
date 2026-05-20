// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameInfoStruct extends FFFirebaseStruct {
  GameInfoStruct({
    int? roomId,
    MainInfoStruct? roomInfo,
    int? gameID,
    MainInfoStruct? gameInfo,
    DateTime? gameInviteTime,
    String? fromUserName,
    int? fromUserId,
    DocumentReference? fromUserRef,
    String? gameInviteStatus,
    int? roomUserSelectedGameId,
    int? teamID,
    TeamInfoStruct? teamInfo,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _roomId = roomId,
        _roomInfo = roomInfo,
        _gameID = gameID,
        _gameInfo = gameInfo,
        _gameInviteTime = gameInviteTime,
        _fromUserName = fromUserName,
        _fromUserId = fromUserId,
        _fromUserRef = fromUserRef,
        _gameInviteStatus = gameInviteStatus,
        _roomUserSelectedGameId = roomUserSelectedGameId,
        _teamID = teamID,
        _teamInfo = teamInfo,
        super(firestoreUtilData);

  // "room_id" field.
  int? _roomId;
  int get roomId => _roomId ?? 0;
  set roomId(int? val) => _roomId = val;

  void incrementRoomId(int amount) => roomId = roomId + amount;

  bool hasRoomId() => _roomId != null;

  // "room_info" field.
  MainInfoStruct? _roomInfo;
  MainInfoStruct get roomInfo => _roomInfo ?? MainInfoStruct();
  set roomInfo(MainInfoStruct? val) => _roomInfo = val;

  void updateRoomInfo(Function(MainInfoStruct) updateFn) {
    updateFn(_roomInfo ??= MainInfoStruct());
  }

  bool hasRoomInfo() => _roomInfo != null;

  // "game_ID" field.
  int? _gameID;
  int get gameID => _gameID ?? 0;
  set gameID(int? val) => _gameID = val;

  void incrementGameID(int amount) => gameID = gameID + amount;

  bool hasGameID() => _gameID != null;

  // "game_info" field.
  MainInfoStruct? _gameInfo;
  MainInfoStruct get gameInfo => _gameInfo ?? MainInfoStruct();
  set gameInfo(MainInfoStruct? val) => _gameInfo = val;

  void updateGameInfo(Function(MainInfoStruct) updateFn) {
    updateFn(_gameInfo ??= MainInfoStruct());
  }

  bool hasGameInfo() => _gameInfo != null;

  // "game_invite_time" field.
  DateTime? _gameInviteTime;
  DateTime? get gameInviteTime => _gameInviteTime;
  set gameInviteTime(DateTime? val) => _gameInviteTime = val;

  bool hasGameInviteTime() => _gameInviteTime != null;

  // "from_user_name" field.
  String? _fromUserName;
  String get fromUserName => _fromUserName ?? '';
  set fromUserName(String? val) => _fromUserName = val;

  bool hasFromUserName() => _fromUserName != null;

  // "from_user_id" field.
  int? _fromUserId;
  int get fromUserId => _fromUserId ?? 0;
  set fromUserId(int? val) => _fromUserId = val;

  void incrementFromUserId(int amount) => fromUserId = fromUserId + amount;

  bool hasFromUserId() => _fromUserId != null;

  // "from_user_ref" field.
  DocumentReference? _fromUserRef;
  DocumentReference? get fromUserRef => _fromUserRef;
  set fromUserRef(DocumentReference? val) => _fromUserRef = val;

  bool hasFromUserRef() => _fromUserRef != null;

  // "game_invite_status" field.
  String? _gameInviteStatus;
  String get gameInviteStatus => _gameInviteStatus ?? '';
  set gameInviteStatus(String? val) => _gameInviteStatus = val;

  bool hasGameInviteStatus() => _gameInviteStatus != null;

  // "room_user_selected_game_id" field.
  int? _roomUserSelectedGameId;
  int get roomUserSelectedGameId => _roomUserSelectedGameId ?? 0;
  set roomUserSelectedGameId(int? val) => _roomUserSelectedGameId = val;

  void incrementRoomUserSelectedGameId(int amount) =>
      roomUserSelectedGameId = roomUserSelectedGameId + amount;

  bool hasRoomUserSelectedGameId() => _roomUserSelectedGameId != null;

  // "team_ID" field.
  int? _teamID;
  int get teamID => _teamID ?? 0;
  set teamID(int? val) => _teamID = val;

  void incrementTeamID(int amount) => teamID = teamID + amount;

  bool hasTeamID() => _teamID != null;

  // "team_info" field.
  TeamInfoStruct? _teamInfo;
  TeamInfoStruct get teamInfo => _teamInfo ?? TeamInfoStruct();
  set teamInfo(TeamInfoStruct? val) => _teamInfo = val;

  void updateTeamInfo(Function(TeamInfoStruct) updateFn) {
    updateFn(_teamInfo ??= TeamInfoStruct());
  }

  bool hasTeamInfo() => _teamInfo != null;

  static GameInfoStruct fromMap(Map<String, dynamic> data) => GameInfoStruct(
        roomId: castToType<int>(data['room_id']),
        roomInfo: data['room_info'] is MainInfoStruct
            ? data['room_info']
            : MainInfoStruct.maybeFromMap(data['room_info']),
        gameID: castToType<int>(data['game_ID']),
        gameInfo: data['game_info'] is MainInfoStruct
            ? data['game_info']
            : MainInfoStruct.maybeFromMap(data['game_info']),
        gameInviteTime: data['game_invite_time'] as DateTime?,
        fromUserName: data['from_user_name'] as String?,
        fromUserId: castToType<int>(data['from_user_id']),
        fromUserRef: data['from_user_ref'] as DocumentReference?,
        gameInviteStatus: data['game_invite_status'] as String?,
        roomUserSelectedGameId:
            castToType<int>(data['room_user_selected_game_id']),
        teamID: castToType<int>(data['team_ID']),
        teamInfo: data['team_info'] is TeamInfoStruct
            ? data['team_info']
            : TeamInfoStruct.maybeFromMap(data['team_info']),
      );

  static GameInfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? GameInfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'room_id': _roomId,
        'room_info': _roomInfo?.toMap(),
        'game_ID': _gameID,
        'game_info': _gameInfo?.toMap(),
        'game_invite_time': _gameInviteTime,
        'from_user_name': _fromUserName,
        'from_user_id': _fromUserId,
        'from_user_ref': _fromUserRef,
        'game_invite_status': _gameInviteStatus,
        'room_user_selected_game_id': _roomUserSelectedGameId,
        'team_ID': _teamID,
        'team_info': _teamInfo?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'room_id': serializeParam(
          _roomId,
          ParamType.int,
        ),
        'room_info': serializeParam(
          _roomInfo,
          ParamType.DataStruct,
        ),
        'game_ID': serializeParam(
          _gameID,
          ParamType.int,
        ),
        'game_info': serializeParam(
          _gameInfo,
          ParamType.DataStruct,
        ),
        'game_invite_time': serializeParam(
          _gameInviteTime,
          ParamType.DateTime,
        ),
        'from_user_name': serializeParam(
          _fromUserName,
          ParamType.String,
        ),
        'from_user_id': serializeParam(
          _fromUserId,
          ParamType.int,
        ),
        'from_user_ref': serializeParam(
          _fromUserRef,
          ParamType.DocumentReference,
        ),
        'game_invite_status': serializeParam(
          _gameInviteStatus,
          ParamType.String,
        ),
        'room_user_selected_game_id': serializeParam(
          _roomUserSelectedGameId,
          ParamType.int,
        ),
        'team_ID': serializeParam(
          _teamID,
          ParamType.int,
        ),
        'team_info': serializeParam(
          _teamInfo,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static GameInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      GameInfoStruct(
        roomId: deserializeParam(
          data['room_id'],
          ParamType.int,
          false,
        ),
        roomInfo: deserializeStructParam(
          data['room_info'],
          ParamType.DataStruct,
          false,
          structBuilder: MainInfoStruct.fromSerializableMap,
        ),
        gameID: deserializeParam(
          data['game_ID'],
          ParamType.int,
          false,
        ),
        gameInfo: deserializeStructParam(
          data['game_info'],
          ParamType.DataStruct,
          false,
          structBuilder: MainInfoStruct.fromSerializableMap,
        ),
        gameInviteTime: deserializeParam(
          data['game_invite_time'],
          ParamType.DateTime,
          false,
        ),
        fromUserName: deserializeParam(
          data['from_user_name'],
          ParamType.String,
          false,
        ),
        fromUserId: deserializeParam(
          data['from_user_id'],
          ParamType.int,
          false,
        ),
        fromUserRef: deserializeParam(
          data['from_user_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        gameInviteStatus: deserializeParam(
          data['game_invite_status'],
          ParamType.String,
          false,
        ),
        roomUserSelectedGameId: deserializeParam(
          data['room_user_selected_game_id'],
          ParamType.int,
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
          structBuilder: TeamInfoStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'GameInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GameInfoStruct &&
        roomId == other.roomId &&
        roomInfo == other.roomInfo &&
        gameID == other.gameID &&
        gameInfo == other.gameInfo &&
        gameInviteTime == other.gameInviteTime &&
        fromUserName == other.fromUserName &&
        fromUserId == other.fromUserId &&
        fromUserRef == other.fromUserRef &&
        gameInviteStatus == other.gameInviteStatus &&
        roomUserSelectedGameId == other.roomUserSelectedGameId &&
        teamID == other.teamID &&
        teamInfo == other.teamInfo;
  }

  @override
  int get hashCode => const ListEquality().hash([
        roomId,
        roomInfo,
        gameID,
        gameInfo,
        gameInviteTime,
        fromUserName,
        fromUserId,
        fromUserRef,
        gameInviteStatus,
        roomUserSelectedGameId,
        teamID,
        teamInfo
      ]);
}

GameInfoStruct createGameInfoStruct({
  int? roomId,
  MainInfoStruct? roomInfo,
  int? gameID,
  MainInfoStruct? gameInfo,
  DateTime? gameInviteTime,
  String? fromUserName,
  int? fromUserId,
  DocumentReference? fromUserRef,
  String? gameInviteStatus,
  int? roomUserSelectedGameId,
  int? teamID,
  TeamInfoStruct? teamInfo,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GameInfoStruct(
      roomId: roomId,
      roomInfo: roomInfo ?? (clearUnsetFields ? MainInfoStruct() : null),
      gameID: gameID,
      gameInfo: gameInfo ?? (clearUnsetFields ? MainInfoStruct() : null),
      gameInviteTime: gameInviteTime,
      fromUserName: fromUserName,
      fromUserId: fromUserId,
      fromUserRef: fromUserRef,
      gameInviteStatus: gameInviteStatus,
      roomUserSelectedGameId: roomUserSelectedGameId,
      teamID: teamID,
      teamInfo: teamInfo ?? (clearUnsetFields ? TeamInfoStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GameInfoStruct? updateGameInfoStruct(
  GameInfoStruct? gameInfoStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    gameInfoStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGameInfoStructData(
  Map<String, dynamic> firestoreData,
  GameInfoStruct? gameInfoStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (gameInfoStruct == null) {
    return;
  }
  if (gameInfoStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && gameInfoStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final gameInfoStructData =
      getGameInfoFirestoreData(gameInfoStruct, forFieldValue);
  final nestedData =
      gameInfoStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = gameInfoStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGameInfoFirestoreData(
  GameInfoStruct? gameInfoStruct, [
  bool forFieldValue = false,
]) {
  if (gameInfoStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(gameInfoStruct.toMap());

  // Handle nested data for "room_info" field.
  addMainInfoStructData(
    firestoreData,
    gameInfoStruct.hasRoomInfo() ? gameInfoStruct.roomInfo : null,
    'room_info',
    forFieldValue,
  );

  // Handle nested data for "game_info" field.
  addMainInfoStructData(
    firestoreData,
    gameInfoStruct.hasGameInfo() ? gameInfoStruct.gameInfo : null,
    'game_info',
    forFieldValue,
  );

  // Handle nested data for "team_info" field.
  addTeamInfoStructData(
    firestoreData,
    gameInfoStruct.hasTeamInfo() ? gameInfoStruct.teamInfo : null,
    'team_info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(gameInfoStruct.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGameInfoListFirestoreData(
  List<GameInfoStruct>? gameInfoStructs,
) =>
    gameInfoStructs?.map((e) => getGameInfoFirestoreData(e, true)).toList() ??
    [];
