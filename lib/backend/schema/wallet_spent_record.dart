import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WalletSpentRecord extends FirestoreRecord {
  WalletSpentRecord._(
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

  // "wallet_spent_ID" field.
  int? _walletSpentID;
  int get walletSpentID => _walletSpentID ?? 0;
  bool hasWalletSpentID() => _walletSpentID != null;

  // "wallet_spent_status" field.
  String? _walletSpentStatus;
  String get walletSpentStatus => _walletSpentStatus ?? '';
  bool hasWalletSpentStatus() => _walletSpentStatus != null;

  // "wallet_spent_point" field.
  int? _walletSpentPoint;
  int get walletSpentPoint => _walletSpentPoint ?? 0;
  bool hasWalletSpentPoint() => _walletSpentPoint != null;

  // "wallet_spent_room_ref" field.
  DocumentReference? _walletSpentRoomRef;
  DocumentReference? get walletSpentRoomRef => _walletSpentRoomRef;
  bool hasWalletSpentRoomRef() => _walletSpentRoomRef != null;

  // "wallet_spent_game_ref" field.
  DocumentReference? _walletSpentGameRef;
  DocumentReference? get walletSpentGameRef => _walletSpentGameRef;
  bool hasWalletSpentGameRef() => _walletSpentGameRef != null;

  // "wallet_spent_user_ref" field.
  DocumentReference? _walletSpentUserRef;
  DocumentReference? get walletSpentUserRef => _walletSpentUserRef;
  bool hasWalletSpentUserRef() => _walletSpentUserRef != null;

  // "wallet_spent_prev_point" field.
  int? _walletSpentPrevPoint;
  int get walletSpentPrevPoint => _walletSpentPrevPoint ?? 0;
  bool hasWalletSpentPrevPoint() => _walletSpentPrevPoint != null;

  // "wallet_spent_present_point" field.
  int? _walletSpentPresentPoint;
  int get walletSpentPresentPoint => _walletSpentPresentPoint ?? 0;
  bool hasWalletSpentPresentPoint() => _walletSpentPresentPoint != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _walletSpentID = castToType<int>(snapshotData['wallet_spent_ID']);
    _walletSpentStatus = snapshotData['wallet_spent_status'] as String?;
    _walletSpentPoint = castToType<int>(snapshotData['wallet_spent_point']);
    _walletSpentRoomRef =
        snapshotData['wallet_spent_room_ref'] as DocumentReference?;
    _walletSpentGameRef =
        snapshotData['wallet_spent_game_ref'] as DocumentReference?;
    _walletSpentUserRef =
        snapshotData['wallet_spent_user_ref'] as DocumentReference?;
    _walletSpentPrevPoint =
        castToType<int>(snapshotData['wallet_spent_prev_point']);
    _walletSpentPresentPoint =
        castToType<int>(snapshotData['wallet_spent_present_point']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('wallet_spent');

  static Stream<WalletSpentRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WalletSpentRecord.fromSnapshot(s));

  static Future<WalletSpentRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WalletSpentRecord.fromSnapshot(s));

  static WalletSpentRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WalletSpentRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WalletSpentRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WalletSpentRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WalletSpentRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WalletSpentRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWalletSpentRecordData({
  DateTime? createdAt,
  DateTime? updatedAt,
  int? walletSpentID,
  String? walletSpentStatus,
  int? walletSpentPoint,
  DocumentReference? walletSpentRoomRef,
  DocumentReference? walletSpentGameRef,
  DocumentReference? walletSpentUserRef,
  int? walletSpentPrevPoint,
  int? walletSpentPresentPoint,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'updated_at': updatedAt,
      'wallet_spent_ID': walletSpentID,
      'wallet_spent_status': walletSpentStatus,
      'wallet_spent_point': walletSpentPoint,
      'wallet_spent_room_ref': walletSpentRoomRef,
      'wallet_spent_game_ref': walletSpentGameRef,
      'wallet_spent_user_ref': walletSpentUserRef,
      'wallet_spent_prev_point': walletSpentPrevPoint,
      'wallet_spent_present_point': walletSpentPresentPoint,
    }.withoutNulls,
  );

  return firestoreData;
}

class WalletSpentRecordDocumentEquality implements Equality<WalletSpentRecord> {
  const WalletSpentRecordDocumentEquality();

  @override
  bool equals(WalletSpentRecord? e1, WalletSpentRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.walletSpentID == e2?.walletSpentID &&
        e1?.walletSpentStatus == e2?.walletSpentStatus &&
        e1?.walletSpentPoint == e2?.walletSpentPoint &&
        e1?.walletSpentRoomRef == e2?.walletSpentRoomRef &&
        e1?.walletSpentGameRef == e2?.walletSpentGameRef &&
        e1?.walletSpentUserRef == e2?.walletSpentUserRef &&
        e1?.walletSpentPrevPoint == e2?.walletSpentPrevPoint &&
        e1?.walletSpentPresentPoint == e2?.walletSpentPresentPoint;
  }

  @override
  int hash(WalletSpentRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.updatedAt,
        e?.walletSpentID,
        e?.walletSpentStatus,
        e?.walletSpentPoint,
        e?.walletSpentRoomRef,
        e?.walletSpentGameRef,
        e?.walletSpentUserRef,
        e?.walletSpentPrevPoint,
        e?.walletSpentPresentPoint
      ]);

  @override
  bool isValidKey(Object? o) => o is WalletSpentRecord;
}
