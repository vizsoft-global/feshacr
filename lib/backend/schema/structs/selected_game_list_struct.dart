// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SelectedGameListStruct extends FFFirebaseStruct {
  SelectedGameListStruct({
    int? selectedGameID,
    int? selectedGameIndex,
    int? gameId,
    MainInfoStruct? gameInfo,
    DateTime? gameStartTime,
    DateTime? gameEndTime,
    ResultInfoStruct? gameResult,
    String? gameSelectedByUid,
    DocumentReference? gameSelectedByUserRef,
    int? gameSelectedPoint,
    int? teamLimit,
    List<TeamInfoStruct>? teamInfo,
    int? teamCount,
    List<RoomUserListStruct>? selectedGameUserList,
    List<int>? selectedTopicIDList,
    List<int>? selectedQuestionIDList,
    List<SelectedQuestionListStruct>? selectedQuestionList,
    GameTieInfoStruct? gameTieInfo,
    int? gameTossWinTeamId,
    int? gameTosswinTeamIndex,
    int? presentTeamID,
    int? presentTeamIndex,
    String? gameTieBreak,
    List<int>? gameTieTopicIDList,
    List<int>? gameTieQuestionIDList,
    List<GameTieQuestionBreakStruct>? gameTieQuestionBreak,
    String? gameTieBreakStatus,
    DateTime? gameTieBreakStartTime,
    List<int>? gameTieBreakCompletedTeamIDList,
    int? gameSAUStep,
    DocumentReference? gameSAUStarterUserref,
    List<GameSAUStruct>? gameSAU,
    DateTime? gameSAUVoteStartedTime,
    List<GameSAURoundUserStruct>? gameSAUFinalResult,
    List<int>? listedQuestionIDList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _selectedGameID = selectedGameID,
        _selectedGameIndex = selectedGameIndex,
        _gameId = gameId,
        _gameInfo = gameInfo,
        _gameStartTime = gameStartTime,
        _gameEndTime = gameEndTime,
        _gameResult = gameResult,
        _gameSelectedByUid = gameSelectedByUid,
        _gameSelectedByUserRef = gameSelectedByUserRef,
        _gameSelectedPoint = gameSelectedPoint,
        _teamLimit = teamLimit,
        _teamInfo = teamInfo,
        _teamCount = teamCount,
        _selectedGameUserList = selectedGameUserList,
        _selectedTopicIDList = selectedTopicIDList,
        _selectedQuestionIDList = selectedQuestionIDList,
        _selectedQuestionList = selectedQuestionList,
        _gameTieInfo = gameTieInfo,
        _gameTossWinTeamId = gameTossWinTeamId,
        _gameTosswinTeamIndex = gameTosswinTeamIndex,
        _presentTeamID = presentTeamID,
        _presentTeamIndex = presentTeamIndex,
        _gameTieBreak = gameTieBreak,
        _gameTieTopicIDList = gameTieTopicIDList,
        _gameTieQuestionIDList = gameTieQuestionIDList,
        _gameTieQuestionBreak = gameTieQuestionBreak,
        _gameTieBreakStatus = gameTieBreakStatus,
        _gameTieBreakStartTime = gameTieBreakStartTime,
        _gameTieBreakCompletedTeamIDList = gameTieBreakCompletedTeamIDList,
        _gameSAUStep = gameSAUStep,
        _gameSAUStarterUserref = gameSAUStarterUserref,
        _gameSAU = gameSAU,
        _gameSAUVoteStartedTime = gameSAUVoteStartedTime,
        _gameSAUFinalResult = gameSAUFinalResult,
        _listedQuestionIDList = listedQuestionIDList,
        super(firestoreUtilData);

  // "selected_game_ID" field.
  int? _selectedGameID;
  int get selectedGameID => _selectedGameID ?? 0;
  set selectedGameID(int? val) => _selectedGameID = val;

  void incrementSelectedGameID(int amount) =>
      selectedGameID = selectedGameID + amount;

  bool hasSelectedGameID() => _selectedGameID != null;

  // "selected_game_index" field.
  int? _selectedGameIndex;
  int get selectedGameIndex => _selectedGameIndex ?? 0;
  set selectedGameIndex(int? val) => _selectedGameIndex = val;

  void incrementSelectedGameIndex(int amount) =>
      selectedGameIndex = selectedGameIndex + amount;

  bool hasSelectedGameIndex() => _selectedGameIndex != null;

  // "game_id" field.
  int? _gameId;
  int get gameId => _gameId ?? 0;
  set gameId(int? val) => _gameId = val;

  void incrementGameId(int amount) => gameId = gameId + amount;

  bool hasGameId() => _gameId != null;

  // "game_info" field.
  MainInfoStruct? _gameInfo;
  MainInfoStruct get gameInfo => _gameInfo ?? MainInfoStruct();
  set gameInfo(MainInfoStruct? val) => _gameInfo = val;

  void updateGameInfo(Function(MainInfoStruct) updateFn) {
    updateFn(_gameInfo ??= MainInfoStruct());
  }

  bool hasGameInfo() => _gameInfo != null;

  // "game_start_time" field.
  DateTime? _gameStartTime;
  DateTime? get gameStartTime => _gameStartTime;
  set gameStartTime(DateTime? val) => _gameStartTime = val;

  bool hasGameStartTime() => _gameStartTime != null;

  // "game_end_time" field.
  DateTime? _gameEndTime;
  DateTime? get gameEndTime => _gameEndTime;
  set gameEndTime(DateTime? val) => _gameEndTime = val;

  bool hasGameEndTime() => _gameEndTime != null;

  // "game_result" field.
  ResultInfoStruct? _gameResult;
  ResultInfoStruct get gameResult => _gameResult ?? ResultInfoStruct();
  set gameResult(ResultInfoStruct? val) => _gameResult = val;

  void updateGameResult(Function(ResultInfoStruct) updateFn) {
    updateFn(_gameResult ??= ResultInfoStruct());
  }

  bool hasGameResult() => _gameResult != null;

  // "game_selected_by_uid" field.
  String? _gameSelectedByUid;
  String get gameSelectedByUid => _gameSelectedByUid ?? '';
  set gameSelectedByUid(String? val) => _gameSelectedByUid = val;

  bool hasGameSelectedByUid() => _gameSelectedByUid != null;

  // "game_selected_by_userRef" field.
  DocumentReference? _gameSelectedByUserRef;
  DocumentReference? get gameSelectedByUserRef => _gameSelectedByUserRef;
  set gameSelectedByUserRef(DocumentReference? val) =>
      _gameSelectedByUserRef = val;

  bool hasGameSelectedByUserRef() => _gameSelectedByUserRef != null;

  // "game_selected_point" field.
  int? _gameSelectedPoint;
  int get gameSelectedPoint => _gameSelectedPoint ?? 0;
  set gameSelectedPoint(int? val) => _gameSelectedPoint = val;

  void incrementGameSelectedPoint(int amount) =>
      gameSelectedPoint = gameSelectedPoint + amount;

  bool hasGameSelectedPoint() => _gameSelectedPoint != null;

  // "team_limit" field.
  int? _teamLimit;
  int get teamLimit => _teamLimit ?? 0;
  set teamLimit(int? val) => _teamLimit = val;

  void incrementTeamLimit(int amount) => teamLimit = teamLimit + amount;

  bool hasTeamLimit() => _teamLimit != null;

  // "team_info" field.
  List<TeamInfoStruct>? _teamInfo;
  List<TeamInfoStruct> get teamInfo => _teamInfo ?? const [];
  set teamInfo(List<TeamInfoStruct>? val) => _teamInfo = val;

  void updateTeamInfo(Function(List<TeamInfoStruct>) updateFn) {
    updateFn(_teamInfo ??= []);
  }

  bool hasTeamInfo() => _teamInfo != null;

  // "team_count" field.
  int? _teamCount;
  int get teamCount => _teamCount ?? 0;
  set teamCount(int? val) => _teamCount = val;

  void incrementTeamCount(int amount) => teamCount = teamCount + amount;

  bool hasTeamCount() => _teamCount != null;

  // "selected_game_user_list" field.
  List<RoomUserListStruct>? _selectedGameUserList;
  List<RoomUserListStruct> get selectedGameUserList =>
      _selectedGameUserList ?? const [];
  set selectedGameUserList(List<RoomUserListStruct>? val) =>
      _selectedGameUserList = val;

  void updateSelectedGameUserList(Function(List<RoomUserListStruct>) updateFn) {
    updateFn(_selectedGameUserList ??= []);
  }

  bool hasSelectedGameUserList() => _selectedGameUserList != null;

  // "selectedTopicIDList" field.
  List<int>? _selectedTopicIDList;
  List<int> get selectedTopicIDList => _selectedTopicIDList ?? const [];
  set selectedTopicIDList(List<int>? val) => _selectedTopicIDList = val;

  void updateSelectedTopicIDList(Function(List<int>) updateFn) {
    updateFn(_selectedTopicIDList ??= []);
  }

  bool hasSelectedTopicIDList() => _selectedTopicIDList != null;

  // "selectedQuestionIDList" field.
  List<int>? _selectedQuestionIDList;
  List<int> get selectedQuestionIDList => _selectedQuestionIDList ?? const [];
  set selectedQuestionIDList(List<int>? val) => _selectedQuestionIDList = val;

  void updateSelectedQuestionIDList(Function(List<int>) updateFn) {
    updateFn(_selectedQuestionIDList ??= []);
  }

  bool hasSelectedQuestionIDList() => _selectedQuestionIDList != null;

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

  // "gameTieInfo" field.
  GameTieInfoStruct? _gameTieInfo;
  GameTieInfoStruct get gameTieInfo => _gameTieInfo ?? GameTieInfoStruct();
  set gameTieInfo(GameTieInfoStruct? val) => _gameTieInfo = val;

  void updateGameTieInfo(Function(GameTieInfoStruct) updateFn) {
    updateFn(_gameTieInfo ??= GameTieInfoStruct());
  }

  bool hasGameTieInfo() => _gameTieInfo != null;

  // "game_toss_win_team_id" field.
  int? _gameTossWinTeamId;
  int get gameTossWinTeamId => _gameTossWinTeamId ?? 0;
  set gameTossWinTeamId(int? val) => _gameTossWinTeamId = val;

  void incrementGameTossWinTeamId(int amount) =>
      gameTossWinTeamId = gameTossWinTeamId + amount;

  bool hasGameTossWinTeamId() => _gameTossWinTeamId != null;

  // "game_tosswin_team_index" field.
  int? _gameTosswinTeamIndex;
  int get gameTosswinTeamIndex => _gameTosswinTeamIndex ?? 0;
  set gameTosswinTeamIndex(int? val) => _gameTosswinTeamIndex = val;

  void incrementGameTosswinTeamIndex(int amount) =>
      gameTosswinTeamIndex = gameTosswinTeamIndex + amount;

  bool hasGameTosswinTeamIndex() => _gameTosswinTeamIndex != null;

  // "presentTeamID" field.
  int? _presentTeamID;
  int get presentTeamID => _presentTeamID ?? 0;
  set presentTeamID(int? val) => _presentTeamID = val;

  void incrementPresentTeamID(int amount) =>
      presentTeamID = presentTeamID + amount;

  bool hasPresentTeamID() => _presentTeamID != null;

  // "presentTeamIndex" field.
  int? _presentTeamIndex;
  int get presentTeamIndex => _presentTeamIndex ?? 0;
  set presentTeamIndex(int? val) => _presentTeamIndex = val;

  void incrementPresentTeamIndex(int amount) =>
      presentTeamIndex = presentTeamIndex + amount;

  bool hasPresentTeamIndex() => _presentTeamIndex != null;

  // "gameTieBreak" field.
  String? _gameTieBreak;
  String get gameTieBreak => _gameTieBreak ?? '';
  set gameTieBreak(String? val) => _gameTieBreak = val;

  bool hasGameTieBreak() => _gameTieBreak != null;

  // "gameTieTopicIDList" field.
  List<int>? _gameTieTopicIDList;
  List<int> get gameTieTopicIDList => _gameTieTopicIDList ?? const [];
  set gameTieTopicIDList(List<int>? val) => _gameTieTopicIDList = val;

  void updateGameTieTopicIDList(Function(List<int>) updateFn) {
    updateFn(_gameTieTopicIDList ??= []);
  }

  bool hasGameTieTopicIDList() => _gameTieTopicIDList != null;

  // "gameTieQuestionIDList" field.
  List<int>? _gameTieQuestionIDList;
  List<int> get gameTieQuestionIDList => _gameTieQuestionIDList ?? const [];
  set gameTieQuestionIDList(List<int>? val) => _gameTieQuestionIDList = val;

  void updateGameTieQuestionIDList(Function(List<int>) updateFn) {
    updateFn(_gameTieQuestionIDList ??= []);
  }

  bool hasGameTieQuestionIDList() => _gameTieQuestionIDList != null;

  // "gameTieQuestionBreak" field.
  List<GameTieQuestionBreakStruct>? _gameTieQuestionBreak;
  List<GameTieQuestionBreakStruct> get gameTieQuestionBreak =>
      _gameTieQuestionBreak ?? const [];
  set gameTieQuestionBreak(List<GameTieQuestionBreakStruct>? val) =>
      _gameTieQuestionBreak = val;

  void updateGameTieQuestionBreak(
      Function(List<GameTieQuestionBreakStruct>) updateFn) {
    updateFn(_gameTieQuestionBreak ??= []);
  }

  bool hasGameTieQuestionBreak() => _gameTieQuestionBreak != null;

  // "gameTieBreakStatus" field.
  String? _gameTieBreakStatus;
  String get gameTieBreakStatus => _gameTieBreakStatus ?? '';
  set gameTieBreakStatus(String? val) => _gameTieBreakStatus = val;

  bool hasGameTieBreakStatus() => _gameTieBreakStatus != null;

  // "gameTieBreakStartTime" field.
  DateTime? _gameTieBreakStartTime;
  DateTime? get gameTieBreakStartTime => _gameTieBreakStartTime;
  set gameTieBreakStartTime(DateTime? val) => _gameTieBreakStartTime = val;

  bool hasGameTieBreakStartTime() => _gameTieBreakStartTime != null;

  // "gameTieBreakCompletedTeamIDList" field.
  List<int>? _gameTieBreakCompletedTeamIDList;
  List<int> get gameTieBreakCompletedTeamIDList =>
      _gameTieBreakCompletedTeamIDList ?? const [];
  set gameTieBreakCompletedTeamIDList(List<int>? val) =>
      _gameTieBreakCompletedTeamIDList = val;

  void updateGameTieBreakCompletedTeamIDList(Function(List<int>) updateFn) {
    updateFn(_gameTieBreakCompletedTeamIDList ??= []);
  }

  bool hasGameTieBreakCompletedTeamIDList() =>
      _gameTieBreakCompletedTeamIDList != null;

  // "gameSAU_step" field.
  int? _gameSAUStep;
  int get gameSAUStep => _gameSAUStep ?? 0;
  set gameSAUStep(int? val) => _gameSAUStep = val;

  void incrementGameSAUStep(int amount) => gameSAUStep = gameSAUStep + amount;

  bool hasGameSAUStep() => _gameSAUStep != null;

  // "gameSAU_starter_userref" field.
  DocumentReference? _gameSAUStarterUserref;
  DocumentReference? get gameSAUStarterUserref => _gameSAUStarterUserref;
  set gameSAUStarterUserref(DocumentReference? val) =>
      _gameSAUStarterUserref = val;

  bool hasGameSAUStarterUserref() => _gameSAUStarterUserref != null;

  // "gameSAU" field.
  List<GameSAUStruct>? _gameSAU;
  List<GameSAUStruct> get gameSAU => _gameSAU ?? const [];
  set gameSAU(List<GameSAUStruct>? val) => _gameSAU = val;

  void updateGameSAU(Function(List<GameSAUStruct>) updateFn) {
    updateFn(_gameSAU ??= []);
  }

  bool hasGameSAU() => _gameSAU != null;

  // "gameSAU_vote_started_time" field.
  DateTime? _gameSAUVoteStartedTime;
  DateTime? get gameSAUVoteStartedTime => _gameSAUVoteStartedTime;
  set gameSAUVoteStartedTime(DateTime? val) => _gameSAUVoteStartedTime = val;

  bool hasGameSAUVoteStartedTime() => _gameSAUVoteStartedTime != null;

  // "gameSAU_finalResult" field.
  List<GameSAURoundUserStruct>? _gameSAUFinalResult;
  List<GameSAURoundUserStruct> get gameSAUFinalResult =>
      _gameSAUFinalResult ?? const [];
  set gameSAUFinalResult(List<GameSAURoundUserStruct>? val) =>
      _gameSAUFinalResult = val;

  void updateGameSAUFinalResult(
      Function(List<GameSAURoundUserStruct>) updateFn) {
    updateFn(_gameSAUFinalResult ??= []);
  }

  bool hasGameSAUFinalResult() => _gameSAUFinalResult != null;

  // "listedQuestionIDList" field.
  List<int>? _listedQuestionIDList;
  List<int> get listedQuestionIDList => _listedQuestionIDList ?? const [];
  set listedQuestionIDList(List<int>? val) => _listedQuestionIDList = val;

  void updateListedQuestionIDList(Function(List<int>) updateFn) {
    updateFn(_listedQuestionIDList ??= []);
  }

  bool hasListedQuestionIDList() => _listedQuestionIDList != null;

  static SelectedGameListStruct fromMap(Map<String, dynamic> data) =>
      SelectedGameListStruct(
        selectedGameID: castToType<int>(data['selected_game_ID']),
        selectedGameIndex: castToType<int>(data['selected_game_index']),
        gameId: castToType<int>(data['game_id']),
        gameInfo: data['game_info'] is MainInfoStruct
            ? data['game_info']
            : MainInfoStruct.maybeFromMap(data['game_info']),
        gameStartTime: data['game_start_time'] as DateTime?,
        gameEndTime: data['game_end_time'] as DateTime?,
        gameResult: data['game_result'] is ResultInfoStruct
            ? data['game_result']
            : ResultInfoStruct.maybeFromMap(data['game_result']),
        gameSelectedByUid: data['game_selected_by_uid'] as String?,
        gameSelectedByUserRef:
            data['game_selected_by_userRef'] as DocumentReference?,
        gameSelectedPoint: castToType<int>(data['game_selected_point']),
        teamLimit: castToType<int>(data['team_limit']),
        teamInfo: getStructList(
          data['team_info'],
          TeamInfoStruct.fromMap,
        ),
        teamCount: castToType<int>(data['team_count']),
        selectedGameUserList: getStructList(
          data['selected_game_user_list'],
          RoomUserListStruct.fromMap,
        ),
        selectedTopicIDList: getDataList(data['selectedTopicIDList']),
        selectedQuestionIDList: getDataList(data['selectedQuestionIDList']),
        selectedQuestionList: getStructList(
          data['selectedQuestionList'],
          SelectedQuestionListStruct.fromMap,
        ),
        gameTieInfo: data['gameTieInfo'] is GameTieInfoStruct
            ? data['gameTieInfo']
            : GameTieInfoStruct.maybeFromMap(data['gameTieInfo']),
        gameTossWinTeamId: castToType<int>(data['game_toss_win_team_id']),
        gameTosswinTeamIndex: castToType<int>(data['game_tosswin_team_index']),
        presentTeamID: castToType<int>(data['presentTeamID']),
        presentTeamIndex: castToType<int>(data['presentTeamIndex']),
        gameTieBreak: data['gameTieBreak'] as String?,
        gameTieTopicIDList: getDataList(data['gameTieTopicIDList']),
        gameTieQuestionIDList: getDataList(data['gameTieQuestionIDList']),
        gameTieQuestionBreak: getStructList(
          data['gameTieQuestionBreak'],
          GameTieQuestionBreakStruct.fromMap,
        ),
        gameTieBreakStatus: data['gameTieBreakStatus'] as String?,
        gameTieBreakStartTime: data['gameTieBreakStartTime'] as DateTime?,
        gameTieBreakCompletedTeamIDList:
            getDataList(data['gameTieBreakCompletedTeamIDList']),
        gameSAUStep: castToType<int>(data['gameSAU_step']),
        gameSAUStarterUserref:
            data['gameSAU_starter_userref'] as DocumentReference?,
        gameSAU: getStructList(
          data['gameSAU'],
          GameSAUStruct.fromMap,
        ),
        gameSAUVoteStartedTime: data['gameSAU_vote_started_time'] as DateTime?,
        gameSAUFinalResult: getStructList(
          data['gameSAU_finalResult'],
          GameSAURoundUserStruct.fromMap,
        ),
        listedQuestionIDList: getDataList(data['listedQuestionIDList']),
      );

  static SelectedGameListStruct? maybeFromMap(dynamic data) => data is Map
      ? SelectedGameListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'selected_game_ID': _selectedGameID,
        'selected_game_index': _selectedGameIndex,
        'game_id': _gameId,
        'game_info': _gameInfo?.toMap(),
        'game_start_time': _gameStartTime,
        'game_end_time': _gameEndTime,
        'game_result': _gameResult?.toMap(),
        'game_selected_by_uid': _gameSelectedByUid,
        'game_selected_by_userRef': _gameSelectedByUserRef,
        'game_selected_point': _gameSelectedPoint,
        'team_limit': _teamLimit,
        'team_info': _teamInfo?.map((e) => e.toMap()).toList(),
        'team_count': _teamCount,
        'selected_game_user_list':
            _selectedGameUserList?.map((e) => e.toMap()).toList(),
        'selectedTopicIDList': _selectedTopicIDList,
        'selectedQuestionIDList': _selectedQuestionIDList,
        'selectedQuestionList':
            _selectedQuestionList?.map((e) => e.toMap()).toList(),
        'gameTieInfo': _gameTieInfo?.toMap(),
        'game_toss_win_team_id': _gameTossWinTeamId,
        'game_tosswin_team_index': _gameTosswinTeamIndex,
        'presentTeamID': _presentTeamID,
        'presentTeamIndex': _presentTeamIndex,
        'gameTieBreak': _gameTieBreak,
        'gameTieTopicIDList': _gameTieTopicIDList,
        'gameTieQuestionIDList': _gameTieQuestionIDList,
        'gameTieQuestionBreak':
            _gameTieQuestionBreak?.map((e) => e.toMap()).toList(),
        'gameTieBreakStatus': _gameTieBreakStatus,
        'gameTieBreakStartTime': _gameTieBreakStartTime,
        'gameTieBreakCompletedTeamIDList': _gameTieBreakCompletedTeamIDList,
        'gameSAU_step': _gameSAUStep,
        'gameSAU_starter_userref': _gameSAUStarterUserref,
        'gameSAU': _gameSAU?.map((e) => e.toMap()).toList(),
        'gameSAU_vote_started_time': _gameSAUVoteStartedTime,
        'gameSAU_finalResult':
            _gameSAUFinalResult?.map((e) => e.toMap()).toList(),
        'listedQuestionIDList': _listedQuestionIDList,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'selected_game_ID': serializeParam(
          _selectedGameID,
          ParamType.int,
        ),
        'selected_game_index': serializeParam(
          _selectedGameIndex,
          ParamType.int,
        ),
        'game_id': serializeParam(
          _gameId,
          ParamType.int,
        ),
        'game_info': serializeParam(
          _gameInfo,
          ParamType.DataStruct,
        ),
        'game_start_time': serializeParam(
          _gameStartTime,
          ParamType.DateTime,
        ),
        'game_end_time': serializeParam(
          _gameEndTime,
          ParamType.DateTime,
        ),
        'game_result': serializeParam(
          _gameResult,
          ParamType.DataStruct,
        ),
        'game_selected_by_uid': serializeParam(
          _gameSelectedByUid,
          ParamType.String,
        ),
        'game_selected_by_userRef': serializeParam(
          _gameSelectedByUserRef,
          ParamType.DocumentReference,
        ),
        'game_selected_point': serializeParam(
          _gameSelectedPoint,
          ParamType.int,
        ),
        'team_limit': serializeParam(
          _teamLimit,
          ParamType.int,
        ),
        'team_info': serializeParam(
          _teamInfo,
          ParamType.DataStruct,
          isList: true,
        ),
        'team_count': serializeParam(
          _teamCount,
          ParamType.int,
        ),
        'selected_game_user_list': serializeParam(
          _selectedGameUserList,
          ParamType.DataStruct,
          isList: true,
        ),
        'selectedTopicIDList': serializeParam(
          _selectedTopicIDList,
          ParamType.int,
          isList: true,
        ),
        'selectedQuestionIDList': serializeParam(
          _selectedQuestionIDList,
          ParamType.int,
          isList: true,
        ),
        'selectedQuestionList': serializeParam(
          _selectedQuestionList,
          ParamType.DataStruct,
          isList: true,
        ),
        'gameTieInfo': serializeParam(
          _gameTieInfo,
          ParamType.DataStruct,
        ),
        'game_toss_win_team_id': serializeParam(
          _gameTossWinTeamId,
          ParamType.int,
        ),
        'game_tosswin_team_index': serializeParam(
          _gameTosswinTeamIndex,
          ParamType.int,
        ),
        'presentTeamID': serializeParam(
          _presentTeamID,
          ParamType.int,
        ),
        'presentTeamIndex': serializeParam(
          _presentTeamIndex,
          ParamType.int,
        ),
        'gameTieBreak': serializeParam(
          _gameTieBreak,
          ParamType.String,
        ),
        'gameTieTopicIDList': serializeParam(
          _gameTieTopicIDList,
          ParamType.int,
          isList: true,
        ),
        'gameTieQuestionIDList': serializeParam(
          _gameTieQuestionIDList,
          ParamType.int,
          isList: true,
        ),
        'gameTieQuestionBreak': serializeParam(
          _gameTieQuestionBreak,
          ParamType.DataStruct,
          isList: true,
        ),
        'gameTieBreakStatus': serializeParam(
          _gameTieBreakStatus,
          ParamType.String,
        ),
        'gameTieBreakStartTime': serializeParam(
          _gameTieBreakStartTime,
          ParamType.DateTime,
        ),
        'gameTieBreakCompletedTeamIDList': serializeParam(
          _gameTieBreakCompletedTeamIDList,
          ParamType.int,
          isList: true,
        ),
        'gameSAU_step': serializeParam(
          _gameSAUStep,
          ParamType.int,
        ),
        'gameSAU_starter_userref': serializeParam(
          _gameSAUStarterUserref,
          ParamType.DocumentReference,
        ),
        'gameSAU': serializeParam(
          _gameSAU,
          ParamType.DataStruct,
          isList: true,
        ),
        'gameSAU_vote_started_time': serializeParam(
          _gameSAUVoteStartedTime,
          ParamType.DateTime,
        ),
        'gameSAU_finalResult': serializeParam(
          _gameSAUFinalResult,
          ParamType.DataStruct,
          isList: true,
        ),
        'listedQuestionIDList': serializeParam(
          _listedQuestionIDList,
          ParamType.int,
          isList: true,
        ),
      }.withoutNulls;

  static SelectedGameListStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SelectedGameListStruct(
        selectedGameID: deserializeParam(
          data['selected_game_ID'],
          ParamType.int,
          false,
        ),
        selectedGameIndex: deserializeParam(
          data['selected_game_index'],
          ParamType.int,
          false,
        ),
        gameId: deserializeParam(
          data['game_id'],
          ParamType.int,
          false,
        ),
        gameInfo: deserializeStructParam(
          data['game_info'],
          ParamType.DataStruct,
          false,
          structBuilder: MainInfoStruct.fromSerializableMap,
        ),
        gameStartTime: deserializeParam(
          data['game_start_time'],
          ParamType.DateTime,
          false,
        ),
        gameEndTime: deserializeParam(
          data['game_end_time'],
          ParamType.DateTime,
          false,
        ),
        gameResult: deserializeStructParam(
          data['game_result'],
          ParamType.DataStruct,
          false,
          structBuilder: ResultInfoStruct.fromSerializableMap,
        ),
        gameSelectedByUid: deserializeParam(
          data['game_selected_by_uid'],
          ParamType.String,
          false,
        ),
        gameSelectedByUserRef: deserializeParam(
          data['game_selected_by_userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        gameSelectedPoint: deserializeParam(
          data['game_selected_point'],
          ParamType.int,
          false,
        ),
        teamLimit: deserializeParam(
          data['team_limit'],
          ParamType.int,
          false,
        ),
        teamInfo: deserializeStructParam<TeamInfoStruct>(
          data['team_info'],
          ParamType.DataStruct,
          true,
          structBuilder: TeamInfoStruct.fromSerializableMap,
        ),
        teamCount: deserializeParam(
          data['team_count'],
          ParamType.int,
          false,
        ),
        selectedGameUserList: deserializeStructParam<RoomUserListStruct>(
          data['selected_game_user_list'],
          ParamType.DataStruct,
          true,
          structBuilder: RoomUserListStruct.fromSerializableMap,
        ),
        selectedTopicIDList: deserializeParam<int>(
          data['selectedTopicIDList'],
          ParamType.int,
          true,
        ),
        selectedQuestionIDList: deserializeParam<int>(
          data['selectedQuestionIDList'],
          ParamType.int,
          true,
        ),
        selectedQuestionList:
            deserializeStructParam<SelectedQuestionListStruct>(
          data['selectedQuestionList'],
          ParamType.DataStruct,
          true,
          structBuilder: SelectedQuestionListStruct.fromSerializableMap,
        ),
        gameTieInfo: deserializeStructParam(
          data['gameTieInfo'],
          ParamType.DataStruct,
          false,
          structBuilder: GameTieInfoStruct.fromSerializableMap,
        ),
        gameTossWinTeamId: deserializeParam(
          data['game_toss_win_team_id'],
          ParamType.int,
          false,
        ),
        gameTosswinTeamIndex: deserializeParam(
          data['game_tosswin_team_index'],
          ParamType.int,
          false,
        ),
        presentTeamID: deserializeParam(
          data['presentTeamID'],
          ParamType.int,
          false,
        ),
        presentTeamIndex: deserializeParam(
          data['presentTeamIndex'],
          ParamType.int,
          false,
        ),
        gameTieBreak: deserializeParam(
          data['gameTieBreak'],
          ParamType.String,
          false,
        ),
        gameTieTopicIDList: deserializeParam<int>(
          data['gameTieTopicIDList'],
          ParamType.int,
          true,
        ),
        gameTieQuestionIDList: deserializeParam<int>(
          data['gameTieQuestionIDList'],
          ParamType.int,
          true,
        ),
        gameTieQuestionBreak:
            deserializeStructParam<GameTieQuestionBreakStruct>(
          data['gameTieQuestionBreak'],
          ParamType.DataStruct,
          true,
          structBuilder: GameTieQuestionBreakStruct.fromSerializableMap,
        ),
        gameTieBreakStatus: deserializeParam(
          data['gameTieBreakStatus'],
          ParamType.String,
          false,
        ),
        gameTieBreakStartTime: deserializeParam(
          data['gameTieBreakStartTime'],
          ParamType.DateTime,
          false,
        ),
        gameTieBreakCompletedTeamIDList: deserializeParam<int>(
          data['gameTieBreakCompletedTeamIDList'],
          ParamType.int,
          true,
        ),
        gameSAUStep: deserializeParam(
          data['gameSAU_step'],
          ParamType.int,
          false,
        ),
        gameSAUStarterUserref: deserializeParam(
          data['gameSAU_starter_userref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        gameSAU: deserializeStructParam<GameSAUStruct>(
          data['gameSAU'],
          ParamType.DataStruct,
          true,
          structBuilder: GameSAUStruct.fromSerializableMap,
        ),
        gameSAUVoteStartedTime: deserializeParam(
          data['gameSAU_vote_started_time'],
          ParamType.DateTime,
          false,
        ),
        gameSAUFinalResult: deserializeStructParam<GameSAURoundUserStruct>(
          data['gameSAU_finalResult'],
          ParamType.DataStruct,
          true,
          structBuilder: GameSAURoundUserStruct.fromSerializableMap,
        ),
        listedQuestionIDList: deserializeParam<int>(
          data['listedQuestionIDList'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'SelectedGameListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SelectedGameListStruct &&
        selectedGameID == other.selectedGameID &&
        selectedGameIndex == other.selectedGameIndex &&
        gameId == other.gameId &&
        gameInfo == other.gameInfo &&
        gameStartTime == other.gameStartTime &&
        gameEndTime == other.gameEndTime &&
        gameResult == other.gameResult &&
        gameSelectedByUid == other.gameSelectedByUid &&
        gameSelectedByUserRef == other.gameSelectedByUserRef &&
        gameSelectedPoint == other.gameSelectedPoint &&
        teamLimit == other.teamLimit &&
        listEquality.equals(teamInfo, other.teamInfo) &&
        teamCount == other.teamCount &&
        listEquality.equals(selectedGameUserList, other.selectedGameUserList) &&
        listEquality.equals(selectedTopicIDList, other.selectedTopicIDList) &&
        listEquality.equals(
            selectedQuestionIDList, other.selectedQuestionIDList) &&
        listEquality.equals(selectedQuestionList, other.selectedQuestionList) &&
        gameTieInfo == other.gameTieInfo &&
        gameTossWinTeamId == other.gameTossWinTeamId &&
        gameTosswinTeamIndex == other.gameTosswinTeamIndex &&
        presentTeamID == other.presentTeamID &&
        presentTeamIndex == other.presentTeamIndex &&
        gameTieBreak == other.gameTieBreak &&
        listEquality.equals(gameTieTopicIDList, other.gameTieTopicIDList) &&
        listEquality.equals(
            gameTieQuestionIDList, other.gameTieQuestionIDList) &&
        listEquality.equals(gameTieQuestionBreak, other.gameTieQuestionBreak) &&
        gameTieBreakStatus == other.gameTieBreakStatus &&
        gameTieBreakStartTime == other.gameTieBreakStartTime &&
        listEquality.equals(gameTieBreakCompletedTeamIDList,
            other.gameTieBreakCompletedTeamIDList) &&
        gameSAUStep == other.gameSAUStep &&
        gameSAUStarterUserref == other.gameSAUStarterUserref &&
        listEquality.equals(gameSAU, other.gameSAU) &&
        gameSAUVoteStartedTime == other.gameSAUVoteStartedTime &&
        listEquality.equals(gameSAUFinalResult, other.gameSAUFinalResult) &&
        listEquality.equals(listedQuestionIDList, other.listedQuestionIDList);
  }

  @override
  int get hashCode => const ListEquality().hash([
        selectedGameID,
        selectedGameIndex,
        gameId,
        gameInfo,
        gameStartTime,
        gameEndTime,
        gameResult,
        gameSelectedByUid,
        gameSelectedByUserRef,
        gameSelectedPoint,
        teamLimit,
        teamInfo,
        teamCount,
        selectedGameUserList,
        selectedTopicIDList,
        selectedQuestionIDList,
        selectedQuestionList,
        gameTieInfo,
        gameTossWinTeamId,
        gameTosswinTeamIndex,
        presentTeamID,
        presentTeamIndex,
        gameTieBreak,
        gameTieTopicIDList,
        gameTieQuestionIDList,
        gameTieQuestionBreak,
        gameTieBreakStatus,
        gameTieBreakStartTime,
        gameTieBreakCompletedTeamIDList,
        gameSAUStep,
        gameSAUStarterUserref,
        gameSAU,
        gameSAUVoteStartedTime,
        gameSAUFinalResult,
        listedQuestionIDList
      ]);
}

SelectedGameListStruct createSelectedGameListStruct({
  int? selectedGameID,
  int? selectedGameIndex,
  int? gameId,
  MainInfoStruct? gameInfo,
  DateTime? gameStartTime,
  DateTime? gameEndTime,
  ResultInfoStruct? gameResult,
  String? gameSelectedByUid,
  DocumentReference? gameSelectedByUserRef,
  int? gameSelectedPoint,
  int? teamLimit,
  int? teamCount,
  GameTieInfoStruct? gameTieInfo,
  int? gameTossWinTeamId,
  int? gameTosswinTeamIndex,
  int? presentTeamID,
  int? presentTeamIndex,
  String? gameTieBreak,
  String? gameTieBreakStatus,
  DateTime? gameTieBreakStartTime,
  int? gameSAUStep,
  DocumentReference? gameSAUStarterUserref,
  DateTime? gameSAUVoteStartedTime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SelectedGameListStruct(
      selectedGameID: selectedGameID,
      selectedGameIndex: selectedGameIndex,
      gameId: gameId,
      gameInfo: gameInfo ?? (clearUnsetFields ? MainInfoStruct() : null),
      gameStartTime: gameStartTime,
      gameEndTime: gameEndTime,
      gameResult: gameResult ?? (clearUnsetFields ? ResultInfoStruct() : null),
      gameSelectedByUid: gameSelectedByUid,
      gameSelectedByUserRef: gameSelectedByUserRef,
      gameSelectedPoint: gameSelectedPoint,
      teamLimit: teamLimit,
      teamCount: teamCount,
      gameTieInfo:
          gameTieInfo ?? (clearUnsetFields ? GameTieInfoStruct() : null),
      gameTossWinTeamId: gameTossWinTeamId,
      gameTosswinTeamIndex: gameTosswinTeamIndex,
      presentTeamID: presentTeamID,
      presentTeamIndex: presentTeamIndex,
      gameTieBreak: gameTieBreak,
      gameTieBreakStatus: gameTieBreakStatus,
      gameTieBreakStartTime: gameTieBreakStartTime,
      gameSAUStep: gameSAUStep,
      gameSAUStarterUserref: gameSAUStarterUserref,
      gameSAUVoteStartedTime: gameSAUVoteStartedTime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SelectedGameListStruct? updateSelectedGameListStruct(
  SelectedGameListStruct? selectedGameList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    selectedGameList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSelectedGameListStructData(
  Map<String, dynamic> firestoreData,
  SelectedGameListStruct? selectedGameList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (selectedGameList == null) {
    return;
  }
  if (selectedGameList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && selectedGameList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final selectedGameListData =
      getSelectedGameListFirestoreData(selectedGameList, forFieldValue);
  final nestedData =
      selectedGameListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = selectedGameList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSelectedGameListFirestoreData(
  SelectedGameListStruct? selectedGameList, [
  bool forFieldValue = false,
]) {
  if (selectedGameList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(selectedGameList.toMap());

  // Handle nested data for "game_info" field.
  addMainInfoStructData(
    firestoreData,
    selectedGameList.hasGameInfo() ? selectedGameList.gameInfo : null,
    'game_info',
    forFieldValue,
  );

  // Handle nested data for "game_result" field.
  addResultInfoStructData(
    firestoreData,
    selectedGameList.hasGameResult() ? selectedGameList.gameResult : null,
    'game_result',
    forFieldValue,
  );

  // Handle nested data for "gameTieInfo" field.
  addGameTieInfoStructData(
    firestoreData,
    selectedGameList.hasGameTieInfo() ? selectedGameList.gameTieInfo : null,
    'gameTieInfo',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(selectedGameList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSelectedGameListListFirestoreData(
  List<SelectedGameListStruct>? selectedGameLists,
) =>
    selectedGameLists
        ?.map((e) => getSelectedGameListFirestoreData(e, true))
        .toList() ??
    [];
