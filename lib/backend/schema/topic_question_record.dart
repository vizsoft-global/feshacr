import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TopicQuestionRecord extends FirestoreRecord {
  TopicQuestionRecord._(
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

  // "question_ID" field.
  int? _questionID;
  int get questionID => _questionID ?? 0;
  bool hasQuestionID() => _questionID != null;

  // "question_status" field.
  String? _questionStatus;
  String get questionStatus => _questionStatus ?? '';
  bool hasQuestionStatus() => _questionStatus != null;

  // "question_Info" field.
  QuestionInfoStruct? _questionInfo;
  QuestionInfoStruct get questionInfo => _questionInfo ?? QuestionInfoStruct();
  bool hasQuestionInfo() => _questionInfo != null;

  // "question_point" field.
  int? _questionPoint;
  int get questionPoint => _questionPoint ?? 0;
  bool hasQuestionPoint() => _questionPoint != null;

  // "topic_ref" field.
  DocumentReference? _topicRef;
  DocumentReference? get topicRef => _topicRef;
  bool hasTopicRef() => _topicRef != null;

  // "topic_id" field.
  int? _topicId;
  int get topicId => _topicId ?? 0;
  bool hasTopicId() => _topicId != null;

  // "question_type" field.
  String? _questionType;
  String get questionType => _questionType ?? '';
  bool hasQuestionType() => _questionType != null;

  // "question_Info_translate" field.
  QuestionInfoTranslateStruct? _questionInfoTranslate;
  QuestionInfoTranslateStruct get questionInfoTranslate =>
      _questionInfoTranslate ?? QuestionInfoTranslateStruct();
  bool hasQuestionInfoTranslate() => _questionInfoTranslate != null;

  // "question_Info_translate_manual" field.
  QuestionInfoTranslateStruct? _questionInfoTranslateManual;
  QuestionInfoTranslateStruct get questionInfoTranslateManual =>
      _questionInfoTranslateManual ?? QuestionInfoTranslateStruct();
  bool hasQuestionInfoTranslateManual() => _questionInfoTranslateManual != null;

  // "question_main_id" field.
  String? _questionMainId;
  String get questionMainId => _questionMainId ?? '';
  bool hasQuestionMainId() => _questionMainId != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _questionID = castToType<int>(snapshotData['question_ID']);
    _questionStatus = snapshotData['question_status'] as String?;
    _questionInfo = snapshotData['question_Info'] is QuestionInfoStruct
        ? snapshotData['question_Info']
        : QuestionInfoStruct.maybeFromMap(snapshotData['question_Info']);
    _questionPoint = castToType<int>(snapshotData['question_point']);
    _topicRef = snapshotData['topic_ref'] as DocumentReference?;
    _topicId = castToType<int>(snapshotData['topic_id']);
    _questionType = snapshotData['question_type'] as String?;
    _questionInfoTranslate =
        snapshotData['question_Info_translate'] is QuestionInfoTranslateStruct
            ? snapshotData['question_Info_translate']
            : QuestionInfoTranslateStruct.maybeFromMap(
                snapshotData['question_Info_translate']);
    _questionInfoTranslateManual =
        snapshotData['question_Info_translate_manual']
                is QuestionInfoTranslateStruct
            ? snapshotData['question_Info_translate_manual']
            : QuestionInfoTranslateStruct.maybeFromMap(
                snapshotData['question_Info_translate_manual']);
    _questionMainId = snapshotData['question_main_id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('topic_question');

  static Stream<TopicQuestionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TopicQuestionRecord.fromSnapshot(s));

  static Future<TopicQuestionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TopicQuestionRecord.fromSnapshot(s));

  static TopicQuestionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TopicQuestionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TopicQuestionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TopicQuestionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TopicQuestionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TopicQuestionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTopicQuestionRecordData({
  DateTime? createdAt,
  DateTime? updatedAt,
  int? questionID,
  String? questionStatus,
  QuestionInfoStruct? questionInfo,
  int? questionPoint,
  DocumentReference? topicRef,
  int? topicId,
  String? questionType,
  QuestionInfoTranslateStruct? questionInfoTranslate,
  QuestionInfoTranslateStruct? questionInfoTranslateManual,
  String? questionMainId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'updated_at': updatedAt,
      'question_ID': questionID,
      'question_status': questionStatus,
      'question_Info': QuestionInfoStruct().toMap(),
      'question_point': questionPoint,
      'topic_ref': topicRef,
      'topic_id': topicId,
      'question_type': questionType,
      'question_Info_translate': QuestionInfoTranslateStruct().toMap(),
      'question_Info_translate_manual': QuestionInfoTranslateStruct().toMap(),
      'question_main_id': questionMainId,
    }.withoutNulls,
  );

  // Handle nested data for "question_Info" field.
  addQuestionInfoStructData(firestoreData, questionInfo, 'question_Info');

  // Handle nested data for "question_Info_translate" field.
  addQuestionInfoTranslateStructData(
      firestoreData, questionInfoTranslate, 'question_Info_translate');

  // Handle nested data for "question_Info_translate_manual" field.
  addQuestionInfoTranslateStructData(firestoreData, questionInfoTranslateManual,
      'question_Info_translate_manual');

  return firestoreData;
}

class TopicQuestionRecordDocumentEquality
    implements Equality<TopicQuestionRecord> {
  const TopicQuestionRecordDocumentEquality();

  @override
  bool equals(TopicQuestionRecord? e1, TopicQuestionRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.questionID == e2?.questionID &&
        e1?.questionStatus == e2?.questionStatus &&
        e1?.questionInfo == e2?.questionInfo &&
        e1?.questionPoint == e2?.questionPoint &&
        e1?.topicRef == e2?.topicRef &&
        e1?.topicId == e2?.topicId &&
        e1?.questionType == e2?.questionType &&
        e1?.questionInfoTranslate == e2?.questionInfoTranslate &&
        e1?.questionInfoTranslateManual == e2?.questionInfoTranslateManual &&
        e1?.questionMainId == e2?.questionMainId;
  }

  @override
  int hash(TopicQuestionRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.updatedAt,
        e?.questionID,
        e?.questionStatus,
        e?.questionInfo,
        e?.questionPoint,
        e?.topicRef,
        e?.topicId,
        e?.questionType,
        e?.questionInfoTranslate,
        e?.questionInfoTranslateManual,
        e?.questionMainId
      ]);

  @override
  bool isValidKey(Object? o) => o is TopicQuestionRecord;
}
