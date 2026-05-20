import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameRecord extends FirestoreRecord {
  GameRecord._(
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

  // "game_ID" field.
  int? _gameID;
  int get gameID => _gameID ?? 0;
  bool hasGameID() => _gameID != null;

  // "game_status" field.
  String? _gameStatus;
  String get gameStatus => _gameStatus ?? '';
  bool hasGameStatus() => _gameStatus != null;

  // "game_info" field.
  MainInfoStruct? _gameInfo;
  MainInfoStruct get gameInfo => _gameInfo ?? MainInfoStruct();
  bool hasGameInfo() => _gameInfo != null;

  // "game_point" field.
  int? _gamePoint;
  int get gamePoint => _gamePoint ?? 0;
  bool hasGamePoint() => _gamePoint != null;

  // "game_info_translate" field.
  TranslateInfoStruct? _gameInfoTranslate;
  TranslateInfoStruct get gameInfoTranslate =>
      _gameInfoTranslate ?? TranslateInfoStruct();
  bool hasGameInfoTranslate() => _gameInfoTranslate != null;

  // "game_info_manual_translate" field.
  TranslateInfoStruct? _gameInfoManualTranslate;
  TranslateInfoStruct get gameInfoManualTranslate =>
      _gameInfoManualTranslate ?? TranslateInfoStruct();
  bool hasGameInfoManualTranslate() => _gameInfoManualTranslate != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _gameID = castToType<int>(snapshotData['game_ID']);
    _gameStatus = snapshotData['game_status'] as String?;
    _gameInfo = snapshotData['game_info'] is MainInfoStruct
        ? snapshotData['game_info']
        : MainInfoStruct.maybeFromMap(snapshotData['game_info']);
    _gamePoint = castToType<int>(snapshotData['game_point']);
    _gameInfoTranslate = snapshotData['game_info_translate']
            is TranslateInfoStruct
        ? snapshotData['game_info_translate']
        : TranslateInfoStruct.maybeFromMap(snapshotData['game_info_translate']);
    _gameInfoManualTranslate =
        snapshotData['game_info_manual_translate'] is TranslateInfoStruct
            ? snapshotData['game_info_manual_translate']
            : TranslateInfoStruct.maybeFromMap(
                snapshotData['game_info_manual_translate']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('game');

  static Stream<GameRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GameRecord.fromSnapshot(s));

  static Future<GameRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GameRecord.fromSnapshot(s));

  static GameRecord fromSnapshot(DocumentSnapshot snapshot) => GameRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GameRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GameRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GameRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GameRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGameRecordData({
  DateTime? createdAt,
  DateTime? updatedAt,
  int? gameID,
  String? gameStatus,
  MainInfoStruct? gameInfo,
  int? gamePoint,
  TranslateInfoStruct? gameInfoTranslate,
  TranslateInfoStruct? gameInfoManualTranslate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'updated_at': updatedAt,
      'game_ID': gameID,
      'game_status': gameStatus,
      'game_info': MainInfoStruct().toMap(),
      'game_point': gamePoint,
      'game_info_translate': TranslateInfoStruct().toMap(),
      'game_info_manual_translate': TranslateInfoStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "game_info" field.
  addMainInfoStructData(firestoreData, gameInfo, 'game_info');

  // Handle nested data for "game_info_translate" field.
  addTranslateInfoStructData(
      firestoreData, gameInfoTranslate, 'game_info_translate');

  // Handle nested data for "game_info_manual_translate" field.
  addTranslateInfoStructData(
      firestoreData, gameInfoManualTranslate, 'game_info_manual_translate');

  return firestoreData;
}

class GameRecordDocumentEquality implements Equality<GameRecord> {
  const GameRecordDocumentEquality();

  @override
  bool equals(GameRecord? e1, GameRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.gameID == e2?.gameID &&
        e1?.gameStatus == e2?.gameStatus &&
        e1?.gameInfo == e2?.gameInfo &&
        e1?.gamePoint == e2?.gamePoint &&
        e1?.gameInfoTranslate == e2?.gameInfoTranslate &&
        e1?.gameInfoManualTranslate == e2?.gameInfoManualTranslate;
  }

  @override
  int hash(GameRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.updatedAt,
        e?.gameID,
        e?.gameStatus,
        e?.gameInfo,
        e?.gamePoint,
        e?.gameInfoTranslate,
        e?.gameInfoManualTranslate
      ]);

  @override
  bool isValidKey(Object? o) => o is GameRecord;
}
