import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PointRecord extends FirestoreRecord {
  PointRecord._(
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

  // "main_info" field.
  MainInfoStruct? _mainInfo;
  MainInfoStruct get mainInfo => _mainInfo ?? MainInfoStruct();
  bool hasMainInfo() => _mainInfo != null;

  // "point_info" field.
  PointInfoStruct? _pointInfo;
  PointInfoStruct get pointInfo => _pointInfo ?? PointInfoStruct();
  bool hasPointInfo() => _pointInfo != null;

  // "point_status" field.
  String? _pointStatus;
  String get pointStatus => _pointStatus ?? '';
  bool hasPointStatus() => _pointStatus != null;

  // "point_ID" field.
  int? _pointID;
  int get pointID => _pointID ?? 0;
  bool hasPointID() => _pointID != null;

  // "main_info_translate" field.
  TranslateInfoStruct? _mainInfoTranslate;
  TranslateInfoStruct get mainInfoTranslate =>
      _mainInfoTranslate ?? TranslateInfoStruct();
  bool hasMainInfoTranslate() => _mainInfoTranslate != null;

  // "main_info_manual_translate" field.
  TranslateInfoStruct? _mainInfoManualTranslate;
  TranslateInfoStruct get mainInfoManualTranslate =>
      _mainInfoManualTranslate ?? TranslateInfoStruct();
  bool hasMainInfoManualTranslate() => _mainInfoManualTranslate != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _mainInfo = snapshotData['main_info'] is MainInfoStruct
        ? snapshotData['main_info']
        : MainInfoStruct.maybeFromMap(snapshotData['main_info']);
    _pointInfo = snapshotData['point_info'] is PointInfoStruct
        ? snapshotData['point_info']
        : PointInfoStruct.maybeFromMap(snapshotData['point_info']);
    _pointStatus = snapshotData['point_status'] as String?;
    _pointID = castToType<int>(snapshotData['point_ID']);
    _mainInfoTranslate = snapshotData['main_info_translate']
            is TranslateInfoStruct
        ? snapshotData['main_info_translate']
        : TranslateInfoStruct.maybeFromMap(snapshotData['main_info_translate']);
    _mainInfoManualTranslate =
        snapshotData['main_info_manual_translate'] is TranslateInfoStruct
            ? snapshotData['main_info_manual_translate']
            : TranslateInfoStruct.maybeFromMap(
                snapshotData['main_info_manual_translate']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('point');

  static Stream<PointRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PointRecord.fromSnapshot(s));

  static Future<PointRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PointRecord.fromSnapshot(s));

  static PointRecord fromSnapshot(DocumentSnapshot snapshot) => PointRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PointRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PointRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PointRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PointRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPointRecordData({
  DateTime? createdAt,
  DateTime? updatedAt,
  MainInfoStruct? mainInfo,
  PointInfoStruct? pointInfo,
  String? pointStatus,
  int? pointID,
  TranslateInfoStruct? mainInfoTranslate,
  TranslateInfoStruct? mainInfoManualTranslate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'updated_at': updatedAt,
      'main_info': MainInfoStruct().toMap(),
      'point_info': PointInfoStruct().toMap(),
      'point_status': pointStatus,
      'point_ID': pointID,
      'main_info_translate': TranslateInfoStruct().toMap(),
      'main_info_manual_translate': TranslateInfoStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "main_info" field.
  addMainInfoStructData(firestoreData, mainInfo, 'main_info');

  // Handle nested data for "point_info" field.
  addPointInfoStructData(firestoreData, pointInfo, 'point_info');

  // Handle nested data for "main_info_translate" field.
  addTranslateInfoStructData(
      firestoreData, mainInfoTranslate, 'main_info_translate');

  // Handle nested data for "main_info_manual_translate" field.
  addTranslateInfoStructData(
      firestoreData, mainInfoManualTranslate, 'main_info_manual_translate');

  return firestoreData;
}

class PointRecordDocumentEquality implements Equality<PointRecord> {
  const PointRecordDocumentEquality();

  @override
  bool equals(PointRecord? e1, PointRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.mainInfo == e2?.mainInfo &&
        e1?.pointInfo == e2?.pointInfo &&
        e1?.pointStatus == e2?.pointStatus &&
        e1?.pointID == e2?.pointID &&
        e1?.mainInfoTranslate == e2?.mainInfoTranslate &&
        e1?.mainInfoManualTranslate == e2?.mainInfoManualTranslate;
  }

  @override
  int hash(PointRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.updatedAt,
        e?.mainInfo,
        e?.pointInfo,
        e?.pointStatus,
        e?.pointID,
        e?.mainInfoTranslate,
        e?.mainInfoManualTranslate
      ]);

  @override
  bool isValidKey(Object? o) => o is PointRecord;
}
