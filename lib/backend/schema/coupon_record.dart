import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CouponRecord extends FirestoreRecord {
  CouponRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "coupon_created_at" field.
  DateTime? _couponCreatedAt;
  DateTime? get couponCreatedAt => _couponCreatedAt;
  bool hasCouponCreatedAt() => _couponCreatedAt != null;

  // "coupon_discount_amount_value" field.
  double? _couponDiscountAmountValue;
  double get couponDiscountAmountValue => _couponDiscountAmountValue ?? 0.0;
  bool hasCouponDiscountAmountValue() => _couponDiscountAmountValue != null;

  // "coupon_discount_type" field.
  String? _couponDiscountType;
  String get couponDiscountType => _couponDiscountType ?? '';
  bool hasCouponDiscountType() => _couponDiscountType != null;

  // "coupon_end_date" field.
  DateTime? _couponEndDate;
  DateTime? get couponEndDate => _couponEndDate;
  bool hasCouponEndDate() => _couponEndDate != null;

  // "coupon_for" field.
  String? _couponFor;
  String get couponFor => _couponFor ?? '';
  bool hasCouponFor() => _couponFor != null;

  // "coupon_id" field.
  int? _couponId;
  int get couponId => _couponId ?? 0;
  bool hasCouponId() => _couponId != null;

  // "coupon_main_info" field.
  MainInfoStruct? _couponMainInfo;
  MainInfoStruct get couponMainInfo => _couponMainInfo ?? MainInfoStruct();
  bool hasCouponMainInfo() => _couponMainInfo != null;

  // "coupon_maximum_amount" field.
  double? _couponMaximumAmount;
  double get couponMaximumAmount => _couponMaximumAmount ?? 0.0;
  bool hasCouponMaximumAmount() => _couponMaximumAmount != null;

  // "coupon_maximum_discount" field.
  double? _couponMaximumDiscount;
  double get couponMaximumDiscount => _couponMaximumDiscount ?? 0.0;
  bool hasCouponMaximumDiscount() => _couponMaximumDiscount != null;

  // "coupon_member_limit" field.
  int? _couponMemberLimit;
  int get couponMemberLimit => _couponMemberLimit ?? 0;
  bool hasCouponMemberLimit() => _couponMemberLimit != null;

  // "coupon_minimum_amount" field.
  double? _couponMinimumAmount;
  double get couponMinimumAmount => _couponMinimumAmount ?? 0.0;
  bool hasCouponMinimumAmount() => _couponMinimumAmount != null;

  // "coupon_start_date" field.
  DateTime? _couponStartDate;
  DateTime? get couponStartDate => _couponStartDate;
  bool hasCouponStartDate() => _couponStartDate != null;

  // "coupon_status" field.
  String? _couponStatus;
  String get couponStatus => _couponStatus ?? '';
  bool hasCouponStatus() => _couponStatus != null;

  // "coupon_user_list" field.
  List<String>? _couponUserList;
  List<String> get couponUserList => _couponUserList ?? const [];
  bool hasCouponUserList() => _couponUserList != null;

  // "coupon_user_type" field.
  String? _couponUserType;
  String get couponUserType => _couponUserType ?? '';
  bool hasCouponUserType() => _couponUserType != null;

  // "coupon_value" field.
  String? _couponValue;
  String get couponValue => _couponValue ?? '';
  bool hasCouponValue() => _couponValue != null;

  // "coupon_used_user_list" field.
  List<String>? _couponUsedUserList;
  List<String> get couponUsedUserList => _couponUsedUserList ?? const [];
  bool hasCouponUsedUserList() => _couponUsedUserList != null;

  void _initializeFields() {
    _couponCreatedAt = snapshotData['coupon_created_at'] as DateTime?;
    _couponDiscountAmountValue =
        castToType<double>(snapshotData['coupon_discount_amount_value']);
    _couponDiscountType = snapshotData['coupon_discount_type'] as String?;
    _couponEndDate = snapshotData['coupon_end_date'] as DateTime?;
    _couponFor = snapshotData['coupon_for'] as String?;
    _couponId = castToType<int>(snapshotData['coupon_id']);
    _couponMainInfo = snapshotData['coupon_main_info'] is MainInfoStruct
        ? snapshotData['coupon_main_info']
        : MainInfoStruct.maybeFromMap(snapshotData['coupon_main_info']);
    _couponMaximumAmount =
        castToType<double>(snapshotData['coupon_maximum_amount']);
    _couponMaximumDiscount =
        castToType<double>(snapshotData['coupon_maximum_discount']);
    _couponMemberLimit = castToType<int>(snapshotData['coupon_member_limit']);
    _couponMinimumAmount =
        castToType<double>(snapshotData['coupon_minimum_amount']);
    _couponStartDate = snapshotData['coupon_start_date'] as DateTime?;
    _couponStatus = snapshotData['coupon_status'] as String?;
    _couponUserList = getDataList(snapshotData['coupon_user_list']);
    _couponUserType = snapshotData['coupon_user_type'] as String?;
    _couponValue = snapshotData['coupon_value'] as String?;
    _couponUsedUserList = getDataList(snapshotData['coupon_used_user_list']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('coupon');

  static Stream<CouponRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CouponRecord.fromSnapshot(s));

  static Future<CouponRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CouponRecord.fromSnapshot(s));

  static CouponRecord fromSnapshot(DocumentSnapshot snapshot) => CouponRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CouponRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CouponRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CouponRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CouponRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCouponRecordData({
  DateTime? couponCreatedAt,
  double? couponDiscountAmountValue,
  String? couponDiscountType,
  DateTime? couponEndDate,
  String? couponFor,
  int? couponId,
  MainInfoStruct? couponMainInfo,
  double? couponMaximumAmount,
  double? couponMaximumDiscount,
  int? couponMemberLimit,
  double? couponMinimumAmount,
  DateTime? couponStartDate,
  String? couponStatus,
  String? couponUserType,
  String? couponValue,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'coupon_created_at': couponCreatedAt,
      'coupon_discount_amount_value': couponDiscountAmountValue,
      'coupon_discount_type': couponDiscountType,
      'coupon_end_date': couponEndDate,
      'coupon_for': couponFor,
      'coupon_id': couponId,
      'coupon_main_info': MainInfoStruct().toMap(),
      'coupon_maximum_amount': couponMaximumAmount,
      'coupon_maximum_discount': couponMaximumDiscount,
      'coupon_member_limit': couponMemberLimit,
      'coupon_minimum_amount': couponMinimumAmount,
      'coupon_start_date': couponStartDate,
      'coupon_status': couponStatus,
      'coupon_user_type': couponUserType,
      'coupon_value': couponValue,
    }.withoutNulls,
  );

  // Handle nested data for "coupon_main_info" field.
  addMainInfoStructData(firestoreData, couponMainInfo, 'coupon_main_info');

  return firestoreData;
}

class CouponRecordDocumentEquality implements Equality<CouponRecord> {
  const CouponRecordDocumentEquality();

  @override
  bool equals(CouponRecord? e1, CouponRecord? e2) {
    const listEquality = ListEquality();
    return e1?.couponCreatedAt == e2?.couponCreatedAt &&
        e1?.couponDiscountAmountValue == e2?.couponDiscountAmountValue &&
        e1?.couponDiscountType == e2?.couponDiscountType &&
        e1?.couponEndDate == e2?.couponEndDate &&
        e1?.couponFor == e2?.couponFor &&
        e1?.couponId == e2?.couponId &&
        e1?.couponMainInfo == e2?.couponMainInfo &&
        e1?.couponMaximumAmount == e2?.couponMaximumAmount &&
        e1?.couponMaximumDiscount == e2?.couponMaximumDiscount &&
        e1?.couponMemberLimit == e2?.couponMemberLimit &&
        e1?.couponMinimumAmount == e2?.couponMinimumAmount &&
        e1?.couponStartDate == e2?.couponStartDate &&
        e1?.couponStatus == e2?.couponStatus &&
        listEquality.equals(e1?.couponUserList, e2?.couponUserList) &&
        e1?.couponUserType == e2?.couponUserType &&
        e1?.couponValue == e2?.couponValue &&
        listEquality.equals(e1?.couponUsedUserList, e2?.couponUsedUserList);
  }

  @override
  int hash(CouponRecord? e) => const ListEquality().hash([
        e?.couponCreatedAt,
        e?.couponDiscountAmountValue,
        e?.couponDiscountType,
        e?.couponEndDate,
        e?.couponFor,
        e?.couponId,
        e?.couponMainInfo,
        e?.couponMaximumAmount,
        e?.couponMaximumDiscount,
        e?.couponMemberLimit,
        e?.couponMinimumAmount,
        e?.couponStartDate,
        e?.couponStatus,
        e?.couponUserList,
        e?.couponUserType,
        e?.couponValue,
        e?.couponUsedUserList
      ]);

  @override
  bool isValidKey(Object? o) => o is CouponRecord;
}
