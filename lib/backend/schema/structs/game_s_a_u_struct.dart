// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameSAUStruct extends FFFirebaseStruct {
  GameSAUStruct({
    int? roundID,
    DateTime? roundStartAt,
    DateTime? roundEndAt,
    String? roundStatus,
    DocumentReference? suspectUserRef,
    int? roundTopicId,
    int? roundQuestionId,
    int? roundQuestionIndex,
    int? roundPlayerIndex,
    DateTime? voteStartTime,
    DateTime? voteEndTime,
    int? voteTimeLimit,
    List<GameSAUVoteUserStruct>? voteUser,
    String? voteWinnerUserUid,
    int? winnerVoteCount,
    DateTime? suspectRevealTime,
    DateTime? roundResultTime,
    DateTime? roundAnswerRevealTime,
    List<GameSAURoundUserStruct>? roundUserPoint,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _roundID = roundID,
        _roundStartAt = roundStartAt,
        _roundEndAt = roundEndAt,
        _roundStatus = roundStatus,
        _suspectUserRef = suspectUserRef,
        _roundTopicId = roundTopicId,
        _roundQuestionId = roundQuestionId,
        _roundQuestionIndex = roundQuestionIndex,
        _roundPlayerIndex = roundPlayerIndex,
        _voteStartTime = voteStartTime,
        _voteEndTime = voteEndTime,
        _voteTimeLimit = voteTimeLimit,
        _voteUser = voteUser,
        _voteWinnerUserUid = voteWinnerUserUid,
        _winnerVoteCount = winnerVoteCount,
        _suspectRevealTime = suspectRevealTime,
        _roundResultTime = roundResultTime,
        _roundAnswerRevealTime = roundAnswerRevealTime,
        _roundUserPoint = roundUserPoint,
        super(firestoreUtilData);

  // "round_ID" field.
  int? _roundID;
  int get roundID => _roundID ?? 0;
  set roundID(int? val) => _roundID = val;

  void incrementRoundID(int amount) => roundID = roundID + amount;

  bool hasRoundID() => _roundID != null;

  // "round_start_at" field.
  DateTime? _roundStartAt;
  DateTime? get roundStartAt => _roundStartAt;
  set roundStartAt(DateTime? val) => _roundStartAt = val;

  bool hasRoundStartAt() => _roundStartAt != null;

  // "round_end_at" field.
  DateTime? _roundEndAt;
  DateTime? get roundEndAt => _roundEndAt;
  set roundEndAt(DateTime? val) => _roundEndAt = val;

  bool hasRoundEndAt() => _roundEndAt != null;

  // "round_status" field.
  String? _roundStatus;
  String get roundStatus => _roundStatus ?? '';
  set roundStatus(String? val) => _roundStatus = val;

  bool hasRoundStatus() => _roundStatus != null;

  // "suspect_user_ref" field.
  DocumentReference? _suspectUserRef;
  DocumentReference? get suspectUserRef => _suspectUserRef;
  set suspectUserRef(DocumentReference? val) => _suspectUserRef = val;

  bool hasSuspectUserRef() => _suspectUserRef != null;

  // "round_topic_id" field.
  int? _roundTopicId;
  int get roundTopicId => _roundTopicId ?? 0;
  set roundTopicId(int? val) => _roundTopicId = val;

  void incrementRoundTopicId(int amount) =>
      roundTopicId = roundTopicId + amount;

  bool hasRoundTopicId() => _roundTopicId != null;

  // "round_question_id" field.
  int? _roundQuestionId;
  int get roundQuestionId => _roundQuestionId ?? 0;
  set roundQuestionId(int? val) => _roundQuestionId = val;

  void incrementRoundQuestionId(int amount) =>
      roundQuestionId = roundQuestionId + amount;

  bool hasRoundQuestionId() => _roundQuestionId != null;

  // "round_question_index" field.
  int? _roundQuestionIndex;
  int get roundQuestionIndex => _roundQuestionIndex ?? 0;
  set roundQuestionIndex(int? val) => _roundQuestionIndex = val;

  void incrementRoundQuestionIndex(int amount) =>
      roundQuestionIndex = roundQuestionIndex + amount;

  bool hasRoundQuestionIndex() => _roundQuestionIndex != null;

  // "round_player_index" field.
  int? _roundPlayerIndex;
  int get roundPlayerIndex => _roundPlayerIndex ?? 0;
  set roundPlayerIndex(int? val) => _roundPlayerIndex = val;

  void incrementRoundPlayerIndex(int amount) =>
      roundPlayerIndex = roundPlayerIndex + amount;

  bool hasRoundPlayerIndex() => _roundPlayerIndex != null;

  // "vote_start_time" field.
  DateTime? _voteStartTime;
  DateTime? get voteStartTime => _voteStartTime;
  set voteStartTime(DateTime? val) => _voteStartTime = val;

  bool hasVoteStartTime() => _voteStartTime != null;

  // "vote_end_time" field.
  DateTime? _voteEndTime;
  DateTime? get voteEndTime => _voteEndTime;
  set voteEndTime(DateTime? val) => _voteEndTime = val;

  bool hasVoteEndTime() => _voteEndTime != null;

  // "vote_time_limit" field.
  int? _voteTimeLimit;
  int get voteTimeLimit => _voteTimeLimit ?? 0;
  set voteTimeLimit(int? val) => _voteTimeLimit = val;

  void incrementVoteTimeLimit(int amount) =>
      voteTimeLimit = voteTimeLimit + amount;

  bool hasVoteTimeLimit() => _voteTimeLimit != null;

  // "vote_user" field.
  List<GameSAUVoteUserStruct>? _voteUser;
  List<GameSAUVoteUserStruct> get voteUser => _voteUser ?? const [];
  set voteUser(List<GameSAUVoteUserStruct>? val) => _voteUser = val;

  void updateVoteUser(Function(List<GameSAUVoteUserStruct>) updateFn) {
    updateFn(_voteUser ??= []);
  }

  bool hasVoteUser() => _voteUser != null;

  // "vote_winner_user_uid" field.
  String? _voteWinnerUserUid;
  String get voteWinnerUserUid => _voteWinnerUserUid ?? '';
  set voteWinnerUserUid(String? val) => _voteWinnerUserUid = val;

  bool hasVoteWinnerUserUid() => _voteWinnerUserUid != null;

  // "winner_vote_count" field.
  int? _winnerVoteCount;
  int get winnerVoteCount => _winnerVoteCount ?? 0;
  set winnerVoteCount(int? val) => _winnerVoteCount = val;

  void incrementWinnerVoteCount(int amount) =>
      winnerVoteCount = winnerVoteCount + amount;

  bool hasWinnerVoteCount() => _winnerVoteCount != null;

  // "suspect_reveal_time" field.
  DateTime? _suspectRevealTime;
  DateTime? get suspectRevealTime => _suspectRevealTime;
  set suspectRevealTime(DateTime? val) => _suspectRevealTime = val;

  bool hasSuspectRevealTime() => _suspectRevealTime != null;

  // "round_result_time" field.
  DateTime? _roundResultTime;
  DateTime? get roundResultTime => _roundResultTime;
  set roundResultTime(DateTime? val) => _roundResultTime = val;

  bool hasRoundResultTime() => _roundResultTime != null;

  // "round_answer_reveal_time" field.
  DateTime? _roundAnswerRevealTime;
  DateTime? get roundAnswerRevealTime => _roundAnswerRevealTime;
  set roundAnswerRevealTime(DateTime? val) => _roundAnswerRevealTime = val;

  bool hasRoundAnswerRevealTime() => _roundAnswerRevealTime != null;

  // "round_user_point" field.
  List<GameSAURoundUserStruct>? _roundUserPoint;
  List<GameSAURoundUserStruct> get roundUserPoint =>
      _roundUserPoint ?? const [];
  set roundUserPoint(List<GameSAURoundUserStruct>? val) =>
      _roundUserPoint = val;

  void updateRoundUserPoint(Function(List<GameSAURoundUserStruct>) updateFn) {
    updateFn(_roundUserPoint ??= []);
  }

  bool hasRoundUserPoint() => _roundUserPoint != null;

  static GameSAUStruct fromMap(Map<String, dynamic> data) => GameSAUStruct(
        roundID: castToType<int>(data['round_ID']),
        roundStartAt: data['round_start_at'] as DateTime?,
        roundEndAt: data['round_end_at'] as DateTime?,
        roundStatus: data['round_status'] as String?,
        suspectUserRef: data['suspect_user_ref'] as DocumentReference?,
        roundTopicId: castToType<int>(data['round_topic_id']),
        roundQuestionId: castToType<int>(data['round_question_id']),
        roundQuestionIndex: castToType<int>(data['round_question_index']),
        roundPlayerIndex: castToType<int>(data['round_player_index']),
        voteStartTime: data['vote_start_time'] as DateTime?,
        voteEndTime: data['vote_end_time'] as DateTime?,
        voteTimeLimit: castToType<int>(data['vote_time_limit']),
        voteUser: getStructList(
          data['vote_user'],
          GameSAUVoteUserStruct.fromMap,
        ),
        voteWinnerUserUid: data['vote_winner_user_uid'] as String?,
        winnerVoteCount: castToType<int>(data['winner_vote_count']),
        suspectRevealTime: data['suspect_reveal_time'] as DateTime?,
        roundResultTime: data['round_result_time'] as DateTime?,
        roundAnswerRevealTime: data['round_answer_reveal_time'] as DateTime?,
        roundUserPoint: getStructList(
          data['round_user_point'],
          GameSAURoundUserStruct.fromMap,
        ),
      );

  static GameSAUStruct? maybeFromMap(dynamic data) =>
      data is Map ? GameSAUStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'round_ID': _roundID,
        'round_start_at': _roundStartAt,
        'round_end_at': _roundEndAt,
        'round_status': _roundStatus,
        'suspect_user_ref': _suspectUserRef,
        'round_topic_id': _roundTopicId,
        'round_question_id': _roundQuestionId,
        'round_question_index': _roundQuestionIndex,
        'round_player_index': _roundPlayerIndex,
        'vote_start_time': _voteStartTime,
        'vote_end_time': _voteEndTime,
        'vote_time_limit': _voteTimeLimit,
        'vote_user': _voteUser?.map((e) => e.toMap()).toList(),
        'vote_winner_user_uid': _voteWinnerUserUid,
        'winner_vote_count': _winnerVoteCount,
        'suspect_reveal_time': _suspectRevealTime,
        'round_result_time': _roundResultTime,
        'round_answer_reveal_time': _roundAnswerRevealTime,
        'round_user_point': _roundUserPoint?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'round_ID': serializeParam(
          _roundID,
          ParamType.int,
        ),
        'round_start_at': serializeParam(
          _roundStartAt,
          ParamType.DateTime,
        ),
        'round_end_at': serializeParam(
          _roundEndAt,
          ParamType.DateTime,
        ),
        'round_status': serializeParam(
          _roundStatus,
          ParamType.String,
        ),
        'suspect_user_ref': serializeParam(
          _suspectUserRef,
          ParamType.DocumentReference,
        ),
        'round_topic_id': serializeParam(
          _roundTopicId,
          ParamType.int,
        ),
        'round_question_id': serializeParam(
          _roundQuestionId,
          ParamType.int,
        ),
        'round_question_index': serializeParam(
          _roundQuestionIndex,
          ParamType.int,
        ),
        'round_player_index': serializeParam(
          _roundPlayerIndex,
          ParamType.int,
        ),
        'vote_start_time': serializeParam(
          _voteStartTime,
          ParamType.DateTime,
        ),
        'vote_end_time': serializeParam(
          _voteEndTime,
          ParamType.DateTime,
        ),
        'vote_time_limit': serializeParam(
          _voteTimeLimit,
          ParamType.int,
        ),
        'vote_user': serializeParam(
          _voteUser,
          ParamType.DataStruct,
          isList: true,
        ),
        'vote_winner_user_uid': serializeParam(
          _voteWinnerUserUid,
          ParamType.String,
        ),
        'winner_vote_count': serializeParam(
          _winnerVoteCount,
          ParamType.int,
        ),
        'suspect_reveal_time': serializeParam(
          _suspectRevealTime,
          ParamType.DateTime,
        ),
        'round_result_time': serializeParam(
          _roundResultTime,
          ParamType.DateTime,
        ),
        'round_answer_reveal_time': serializeParam(
          _roundAnswerRevealTime,
          ParamType.DateTime,
        ),
        'round_user_point': serializeParam(
          _roundUserPoint,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static GameSAUStruct fromSerializableMap(Map<String, dynamic> data) =>
      GameSAUStruct(
        roundID: deserializeParam(
          data['round_ID'],
          ParamType.int,
          false,
        ),
        roundStartAt: deserializeParam(
          data['round_start_at'],
          ParamType.DateTime,
          false,
        ),
        roundEndAt: deserializeParam(
          data['round_end_at'],
          ParamType.DateTime,
          false,
        ),
        roundStatus: deserializeParam(
          data['round_status'],
          ParamType.String,
          false,
        ),
        suspectUserRef: deserializeParam(
          data['suspect_user_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        roundTopicId: deserializeParam(
          data['round_topic_id'],
          ParamType.int,
          false,
        ),
        roundQuestionId: deserializeParam(
          data['round_question_id'],
          ParamType.int,
          false,
        ),
        roundQuestionIndex: deserializeParam(
          data['round_question_index'],
          ParamType.int,
          false,
        ),
        roundPlayerIndex: deserializeParam(
          data['round_player_index'],
          ParamType.int,
          false,
        ),
        voteStartTime: deserializeParam(
          data['vote_start_time'],
          ParamType.DateTime,
          false,
        ),
        voteEndTime: deserializeParam(
          data['vote_end_time'],
          ParamType.DateTime,
          false,
        ),
        voteTimeLimit: deserializeParam(
          data['vote_time_limit'],
          ParamType.int,
          false,
        ),
        voteUser: deserializeStructParam<GameSAUVoteUserStruct>(
          data['vote_user'],
          ParamType.DataStruct,
          true,
          structBuilder: GameSAUVoteUserStruct.fromSerializableMap,
        ),
        voteWinnerUserUid: deserializeParam(
          data['vote_winner_user_uid'],
          ParamType.String,
          false,
        ),
        winnerVoteCount: deserializeParam(
          data['winner_vote_count'],
          ParamType.int,
          false,
        ),
        suspectRevealTime: deserializeParam(
          data['suspect_reveal_time'],
          ParamType.DateTime,
          false,
        ),
        roundResultTime: deserializeParam(
          data['round_result_time'],
          ParamType.DateTime,
          false,
        ),
        roundAnswerRevealTime: deserializeParam(
          data['round_answer_reveal_time'],
          ParamType.DateTime,
          false,
        ),
        roundUserPoint: deserializeStructParam<GameSAURoundUserStruct>(
          data['round_user_point'],
          ParamType.DataStruct,
          true,
          structBuilder: GameSAURoundUserStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'GameSAUStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is GameSAUStruct &&
        roundID == other.roundID &&
        roundStartAt == other.roundStartAt &&
        roundEndAt == other.roundEndAt &&
        roundStatus == other.roundStatus &&
        suspectUserRef == other.suspectUserRef &&
        roundTopicId == other.roundTopicId &&
        roundQuestionId == other.roundQuestionId &&
        roundQuestionIndex == other.roundQuestionIndex &&
        roundPlayerIndex == other.roundPlayerIndex &&
        voteStartTime == other.voteStartTime &&
        voteEndTime == other.voteEndTime &&
        voteTimeLimit == other.voteTimeLimit &&
        listEquality.equals(voteUser, other.voteUser) &&
        voteWinnerUserUid == other.voteWinnerUserUid &&
        winnerVoteCount == other.winnerVoteCount &&
        suspectRevealTime == other.suspectRevealTime &&
        roundResultTime == other.roundResultTime &&
        roundAnswerRevealTime == other.roundAnswerRevealTime &&
        listEquality.equals(roundUserPoint, other.roundUserPoint);
  }

  @override
  int get hashCode => const ListEquality().hash([
        roundID,
        roundStartAt,
        roundEndAt,
        roundStatus,
        suspectUserRef,
        roundTopicId,
        roundQuestionId,
        roundQuestionIndex,
        roundPlayerIndex,
        voteStartTime,
        voteEndTime,
        voteTimeLimit,
        voteUser,
        voteWinnerUserUid,
        winnerVoteCount,
        suspectRevealTime,
        roundResultTime,
        roundAnswerRevealTime,
        roundUserPoint
      ]);
}

GameSAUStruct createGameSAUStruct({
  int? roundID,
  DateTime? roundStartAt,
  DateTime? roundEndAt,
  String? roundStatus,
  DocumentReference? suspectUserRef,
  int? roundTopicId,
  int? roundQuestionId,
  int? roundQuestionIndex,
  int? roundPlayerIndex,
  DateTime? voteStartTime,
  DateTime? voteEndTime,
  int? voteTimeLimit,
  String? voteWinnerUserUid,
  int? winnerVoteCount,
  DateTime? suspectRevealTime,
  DateTime? roundResultTime,
  DateTime? roundAnswerRevealTime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GameSAUStruct(
      roundID: roundID,
      roundStartAt: roundStartAt,
      roundEndAt: roundEndAt,
      roundStatus: roundStatus,
      suspectUserRef: suspectUserRef,
      roundTopicId: roundTopicId,
      roundQuestionId: roundQuestionId,
      roundQuestionIndex: roundQuestionIndex,
      roundPlayerIndex: roundPlayerIndex,
      voteStartTime: voteStartTime,
      voteEndTime: voteEndTime,
      voteTimeLimit: voteTimeLimit,
      voteWinnerUserUid: voteWinnerUserUid,
      winnerVoteCount: winnerVoteCount,
      suspectRevealTime: suspectRevealTime,
      roundResultTime: roundResultTime,
      roundAnswerRevealTime: roundAnswerRevealTime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GameSAUStruct? updateGameSAUStruct(
  GameSAUStruct? gameSAU, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    gameSAU
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGameSAUStructData(
  Map<String, dynamic> firestoreData,
  GameSAUStruct? gameSAU,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (gameSAU == null) {
    return;
  }
  if (gameSAU.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && gameSAU.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final gameSAUData = getGameSAUFirestoreData(gameSAU, forFieldValue);
  final nestedData = gameSAUData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = gameSAU.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGameSAUFirestoreData(
  GameSAUStruct? gameSAU, [
  bool forFieldValue = false,
]) {
  if (gameSAU == null) {
    return {};
  }
  final firestoreData = mapToFirestore(gameSAU.toMap());

  // Add any Firestore field values
  mapToFirestore(gameSAU.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGameSAUListFirestoreData(
  List<GameSAUStruct>? gameSAUs,
) =>
    gameSAUs?.map((e) => getGameSAUFirestoreData(e, true)).toList() ?? [];
