import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameHistoryRecord extends FirestoreRecord {
  GameHistoryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "game_history_ID" field.
  int? _gameHistoryID;
  int get gameHistoryID => _gameHistoryID ?? 0;
  bool hasGameHistoryID() => _gameHistoryID != null;

  // "game_id" field.
  int? _gameId;
  int get gameId => _gameId ?? 0;
  bool hasGameId() => _gameId != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "room_id" field.
  int? _roomId;
  int get roomId => _roomId ?? 0;
  bool hasRoomId() => _roomId != null;

  // "result_info" field.
  ResultInfoStruct? _resultInfo;
  ResultInfoStruct get resultInfo => _resultInfo ?? ResultInfoStruct();
  bool hasResultInfo() => _resultInfo != null;

  // "session_id" field.
  int? _sessionId;
  int get sessionId => _sessionId ?? 0;
  bool hasSessionId() => _sessionId != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _gameHistoryID = castToType<int>(snapshotData['game_history_ID']);
    _gameId = castToType<int>(snapshotData['game_id']);
    _userId = snapshotData['user_id'] as String?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _roomId = castToType<int>(snapshotData['room_id']);
    _resultInfo = snapshotData['result_info'] is ResultInfoStruct
        ? snapshotData['result_info']
        : ResultInfoStruct.maybeFromMap(snapshotData['result_info']);
    _sessionId = castToType<int>(snapshotData['session_id']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('game_history');

  static Stream<GameHistoryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GameHistoryRecord.fromSnapshot(s));

  static Future<GameHistoryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GameHistoryRecord.fromSnapshot(s));

  static GameHistoryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GameHistoryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GameHistoryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GameHistoryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GameHistoryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GameHistoryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGameHistoryRecordData({
  DateTime? createdAt,
  DateTime? updatedAt,
  int? gameHistoryID,
  int? gameId,
  String? userId,
  DocumentReference? userRef,
  int? roomId,
  ResultInfoStruct? resultInfo,
  int? sessionId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'updated_at': updatedAt,
      'game_history_ID': gameHistoryID,
      'game_id': gameId,
      'user_id': userId,
      'user_ref': userRef,
      'room_id': roomId,
      'result_info': ResultInfoStruct().toMap(),
      'session_id': sessionId,
    }.withoutNulls,
  );

  // Handle nested data for "result_info" field.
  addResultInfoStructData(firestoreData, resultInfo, 'result_info');

  return firestoreData;
}

class GameHistoryRecordDocumentEquality implements Equality<GameHistoryRecord> {
  const GameHistoryRecordDocumentEquality();

  @override
  bool equals(GameHistoryRecord? e1, GameHistoryRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.gameHistoryID == e2?.gameHistoryID &&
        e1?.gameId == e2?.gameId &&
        e1?.userId == e2?.userId &&
        e1?.userRef == e2?.userRef &&
        e1?.roomId == e2?.roomId &&
        e1?.resultInfo == e2?.resultInfo &&
        e1?.sessionId == e2?.sessionId;
  }

  @override
  int hash(GameHistoryRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.updatedAt,
        e?.gameHistoryID,
        e?.gameId,
        e?.userId,
        e?.userRef,
        e?.roomId,
        e?.resultInfo,
        e?.sessionId
      ]);

  @override
  bool isValidKey(Object? o) => o is GameHistoryRecord;
}
