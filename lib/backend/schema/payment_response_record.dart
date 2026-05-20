import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaymentResponseRecord extends FirestoreRecord {
  PaymentResponseRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "order_id" field.
  String? _orderId;
  String get orderId => _orderId ?? '';
  bool hasOrderId() => _orderId != null;

  // "payment_id" field.
  String? _paymentId;
  String get paymentId => _paymentId ?? '';
  bool hasPaymentId() => _paymentId != null;

  // "payment_type" field.
  String? _paymentType;
  String get paymentType => _paymentType ?? '';
  bool hasPaymentType() => _paymentType != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "track_id" field.
  String? _trackId;
  String get trackId => _trackId ?? '';
  bool hasTrackId() => _trackId != null;

  void _initializeFields() {
    _orderId = snapshotData['order_id'] as String?;
    _paymentId = snapshotData['payment_id'] as String?;
    _paymentType = snapshotData['payment_type'] as String?;
    _status = snapshotData['status'] as String?;
    _trackId = snapshotData['track_id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('payment_response');

  static Stream<PaymentResponseRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PaymentResponseRecord.fromSnapshot(s));

  static Future<PaymentResponseRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PaymentResponseRecord.fromSnapshot(s));

  static PaymentResponseRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PaymentResponseRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PaymentResponseRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PaymentResponseRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PaymentResponseRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PaymentResponseRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPaymentResponseRecordData({
  String? orderId,
  String? paymentId,
  String? paymentType,
  String? status,
  String? trackId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'order_id': orderId,
      'payment_id': paymentId,
      'payment_type': paymentType,
      'status': status,
      'track_id': trackId,
    }.withoutNulls,
  );

  return firestoreData;
}

class PaymentResponseRecordDocumentEquality
    implements Equality<PaymentResponseRecord> {
  const PaymentResponseRecordDocumentEquality();

  @override
  bool equals(PaymentResponseRecord? e1, PaymentResponseRecord? e2) {
    return e1?.orderId == e2?.orderId &&
        e1?.paymentId == e2?.paymentId &&
        e1?.paymentType == e2?.paymentType &&
        e1?.status == e2?.status &&
        e1?.trackId == e2?.trackId;
  }

  @override
  int hash(PaymentResponseRecord? e) => const ListEquality()
      .hash([e?.orderId, e?.paymentId, e?.paymentType, e?.status, e?.trackId]);

  @override
  bool isValidKey(Object? o) => o is PaymentResponseRecord;
}
