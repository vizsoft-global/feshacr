import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TopicRecord extends FirestoreRecord {
  TopicRecord._(
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

  // "topic_ID" field.
  int? _topicID;
  int get topicID => _topicID ?? 0;
  bool hasTopicID() => _topicID != null;

  // "topic_status" field.
  String? _topicStatus;
  String get topicStatus => _topicStatus ?? '';
  bool hasTopicStatus() => _topicStatus != null;

  // "topic_info" field.
  MainInfoStruct? _topicInfo;
  MainInfoStruct get topicInfo => _topicInfo ?? MainInfoStruct();
  bool hasTopicInfo() => _topicInfo != null;

  // "game_ref" field.
  List<DocumentReference>? _gameRef;
  List<DocumentReference> get gameRef => _gameRef ?? const [];
  bool hasGameRef() => _gameRef != null;

  // "game_ID" field.
  List<int>? _gameID;
  List<int> get gameID => _gameID ?? const [];
  bool hasGameID() => _gameID != null;

  // "topic_info_translate" field.
  TranslateInfoStruct? _topicInfoTranslate;
  TranslateInfoStruct get topicInfoTranslate =>
      _topicInfoTranslate ?? TranslateInfoStruct();
  bool hasTopicInfoTranslate() => _topicInfoTranslate != null;

  // "topic_info_manual_translate" field.
  TranslateInfoStruct? _topicInfoManualTranslate;
  TranslateInfoStruct get topicInfoManualTranslate =>
      _topicInfoManualTranslate ?? TranslateInfoStruct();
  bool hasTopicInfoManualTranslate() => _topicInfoManualTranslate != null;

  // "topic_main_id" field.
  String? _topicMainId;
  String get topicMainId => _topicMainId ?? '';
  bool hasTopicMainId() => _topicMainId != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _topicID = castToType<int>(snapshotData['topic_ID']);
    _topicStatus = snapshotData['topic_status'] as String?;
    _topicInfo = snapshotData['topic_info'] is MainInfoStruct
        ? snapshotData['topic_info']
        : MainInfoStruct.maybeFromMap(snapshotData['topic_info']);
    _gameRef = getDataList(snapshotData['game_ref']);
    _gameID = getDataList(snapshotData['game_ID']);
    _topicInfoTranslate =
        snapshotData['topic_info_translate'] is TranslateInfoStruct
            ? snapshotData['topic_info_translate']
            : TranslateInfoStruct.maybeFromMap(
                snapshotData['topic_info_translate']);
    _topicInfoManualTranslate =
        snapshotData['topic_info_manual_translate'] is TranslateInfoStruct
            ? snapshotData['topic_info_manual_translate']
            : TranslateInfoStruct.maybeFromMap(
                snapshotData['topic_info_manual_translate']);
    _topicMainId = snapshotData['topic_main_id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('topic');

  static Stream<TopicRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TopicRecord.fromSnapshot(s));

  static Future<TopicRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TopicRecord.fromSnapshot(s));

  static TopicRecord fromSnapshot(DocumentSnapshot snapshot) => TopicRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TopicRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TopicRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TopicRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TopicRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTopicRecordData({
  DateTime? createdAt,
  DateTime? updatedAt,
  int? topicID,
  String? topicStatus,
  MainInfoStruct? topicInfo,
  TranslateInfoStruct? topicInfoTranslate,
  TranslateInfoStruct? topicInfoManualTranslate,
  String? topicMainId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'updated_at': updatedAt,
      'topic_ID': topicID,
      'topic_status': topicStatus,
      'topic_info': MainInfoStruct().toMap(),
      'topic_info_translate': TranslateInfoStruct().toMap(),
      'topic_info_manual_translate': TranslateInfoStruct().toMap(),
      'topic_main_id': topicMainId,
    }.withoutNulls,
  );

  // Handle nested data for "topic_info" field.
  addMainInfoStructData(firestoreData, topicInfo, 'topic_info');

  // Handle nested data for "topic_info_translate" field.
  addTranslateInfoStructData(
      firestoreData, topicInfoTranslate, 'topic_info_translate');

  // Handle nested data for "topic_info_manual_translate" field.
  addTranslateInfoStructData(
      firestoreData, topicInfoManualTranslate, 'topic_info_manual_translate');

  return firestoreData;
}

class TopicRecordDocumentEquality implements Equality<TopicRecord> {
  const TopicRecordDocumentEquality();

  @override
  bool equals(TopicRecord? e1, TopicRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.topicID == e2?.topicID &&
        e1?.topicStatus == e2?.topicStatus &&
        e1?.topicInfo == e2?.topicInfo &&
        listEquality.equals(e1?.gameRef, e2?.gameRef) &&
        listEquality.equals(e1?.gameID, e2?.gameID) &&
        e1?.topicInfoTranslate == e2?.topicInfoTranslate &&
        e1?.topicInfoManualTranslate == e2?.topicInfoManualTranslate &&
        e1?.topicMainId == e2?.topicMainId;
  }

  @override
  int hash(TopicRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.updatedAt,
        e?.topicID,
        e?.topicStatus,
        e?.topicInfo,
        e?.gameRef,
        e?.gameID,
        e?.topicInfoTranslate,
        e?.topicInfoManualTranslate,
        e?.topicMainId
      ]);

  @override
  bool isValidKey(Object? o) => o is TopicRecord;
}
