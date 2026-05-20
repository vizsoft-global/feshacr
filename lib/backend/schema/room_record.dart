import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomRecord extends FirestoreRecord {
  RoomRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "room_status" field.
  String? _roomStatus;
  String get roomStatus => _roomStatus ?? '';
  bool hasRoomStatus() => _roomStatus != null;

  // "room_created_at" field.
  DateTime? _roomCreatedAt;
  DateTime? get roomCreatedAt => _roomCreatedAt;
  bool hasRoomCreatedAt() => _roomCreatedAt != null;

  // "room_main_info" field.
  MainInfoStruct? _roomMainInfo;
  MainInfoStruct get roomMainInfo => _roomMainInfo ?? MainInfoStruct();
  bool hasRoomMainInfo() => _roomMainInfo != null;

  // "room_member_limit" field.
  int? _roomMemberLimit;
  int get roomMemberLimit => _roomMemberLimit ?? 0;
  bool hasRoomMemberLimit() => _roomMemberLimit != null;

  // "room_current_user_id" field.
  int? _roomCurrentUserId;
  int get roomCurrentUserId => _roomCurrentUserId ?? 0;
  bool hasRoomCurrentUserId() => _roomCurrentUserId != null;

  // "room_updated_at" field.
  DateTime? _roomUpdatedAt;
  DateTime? get roomUpdatedAt => _roomUpdatedAt;
  bool hasRoomUpdatedAt() => _roomUpdatedAt != null;

  // "room_ID" field.
  int? _roomID;
  int get roomID => _roomID ?? 0;
  bool hasRoomID() => _roomID != null;

  // "room_info" field.
  RoomInfoStruct? _roomInfo;
  RoomInfoStruct get roomInfo => _roomInfo ?? RoomInfoStruct();
  bool hasRoomInfo() => _roomInfo != null;

  // "room_created_by_uid" field.
  String? _roomCreatedByUid;
  String get roomCreatedByUid => _roomCreatedByUid ?? '';
  bool hasRoomCreatedByUid() => _roomCreatedByUid != null;

  // "room_created_by" field.
  String? _roomCreatedBy;
  String get roomCreatedBy => _roomCreatedBy ?? '';
  bool hasRoomCreatedBy() => _roomCreatedBy != null;

  // "room_created_userRef" field.
  DocumentReference? _roomCreatedUserRef;
  DocumentReference? get roomCreatedUserRef => _roomCreatedUserRef;
  bool hasRoomCreatedUserRef() => _roomCreatedUserRef != null;

  // "room_user_list" field.
  List<RoomUserListStruct>? _roomUserList;
  List<RoomUserListStruct> get roomUserList => _roomUserList ?? const [];
  bool hasRoomUserList() => _roomUserList != null;

  // "is_room_wallet_status" field.
  bool? _isRoomWalletStatus;
  bool get isRoomWalletStatus => _isRoomWalletStatus ?? false;
  bool hasIsRoomWalletStatus() => _isRoomWalletStatus != null;

  // "room_wallet_total_point" field.
  int? _roomWalletTotalPoint;
  int get roomWalletTotalPoint => _roomWalletTotalPoint ?? 0;
  bool hasRoomWalletTotalPoint() => _roomWalletTotalPoint != null;

  // "room_wallet_order_info" field.
  List<RoomWalletOrderInfoStruct>? _roomWalletOrderInfo;
  List<RoomWalletOrderInfoStruct> get roomWalletOrderInfo =>
      _roomWalletOrderInfo ?? const [];
  bool hasRoomWalletOrderInfo() => _roomWalletOrderInfo != null;

  // "selected_game_list" field.
  List<SelectedGameListStruct>? _selectedGameList;
  List<SelectedGameListStruct> get selectedGameList =>
      _selectedGameList ?? const [];
  bool hasSelectedGameList() => _selectedGameList != null;

  // "room_code" field.
  int? _roomCode;
  int get roomCode => _roomCode ?? 0;
  bool hasRoomCode() => _roomCode != null;

  // "room_present_status" field.
  String? _roomPresentStatus;
  String get roomPresentStatus => _roomPresentStatus ?? '';
  bool hasRoomPresentStatus() => _roomPresentStatus != null;

  // "room_type" field.
  String? _roomType;
  String get roomType => _roomType ?? '';
  bool hasRoomType() => _roomType != null;

  // "room_attended_question_list" field.
  List<int>? _roomAttendedQuestionList;
  List<int> get roomAttendedQuestionList =>
      _roomAttendedQuestionList ?? const [];
  bool hasRoomAttendedQuestionList() => _roomAttendedQuestionList != null;

  // "room_app_launch_time" field.
  bool? _roomAppLaunchTime;
  bool get roomAppLaunchTime => _roomAppLaunchTime ?? false;
  bool hasRoomAppLaunchTime() => _roomAppLaunchTime != null;

  void _initializeFields() {
    _roomStatus = snapshotData['room_status'] as String?;
    _roomCreatedAt = snapshotData['room_created_at'] as DateTime?;
    _roomMainInfo = snapshotData['room_main_info'] is MainInfoStruct
        ? snapshotData['room_main_info']
        : MainInfoStruct.maybeFromMap(snapshotData['room_main_info']);
    _roomMemberLimit = castToType<int>(snapshotData['room_member_limit']);
    _roomCurrentUserId = castToType<int>(snapshotData['room_current_user_id']);
    _roomUpdatedAt = snapshotData['room_updated_at'] as DateTime?;
    _roomID = castToType<int>(snapshotData['room_ID']);
    _roomInfo = snapshotData['room_info'] is RoomInfoStruct
        ? snapshotData['room_info']
        : RoomInfoStruct.maybeFromMap(snapshotData['room_info']);
    _roomCreatedByUid = snapshotData['room_created_by_uid'] as String?;
    _roomCreatedBy = snapshotData['room_created_by'] as String?;
    _roomCreatedUserRef =
        snapshotData['room_created_userRef'] as DocumentReference?;
    _roomUserList = getStructList(
      snapshotData['room_user_list'],
      RoomUserListStruct.fromMap,
    );
    _isRoomWalletStatus = snapshotData['is_room_wallet_status'] as bool?;
    _roomWalletTotalPoint =
        castToType<int>(snapshotData['room_wallet_total_point']);
    _roomWalletOrderInfo = getStructList(
      snapshotData['room_wallet_order_info'],
      RoomWalletOrderInfoStruct.fromMap,
    );
    _selectedGameList = getStructList(
      snapshotData['selected_game_list'],
      SelectedGameListStruct.fromMap,
    );
    _roomCode = castToType<int>(snapshotData['room_code']);
    _roomPresentStatus = snapshotData['room_present_status'] as String?;
    _roomType = snapshotData['room_type'] as String?;
    _roomAttendedQuestionList =
        getDataList(snapshotData['room_attended_question_list']);
    _roomAppLaunchTime = snapshotData['room_app_launch_time'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('room');

  static Stream<RoomRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RoomRecord.fromSnapshot(s));

  static Future<RoomRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RoomRecord.fromSnapshot(s));

  static RoomRecord fromSnapshot(DocumentSnapshot snapshot) {
    final raw = snapshot.data();
    final Map<String, dynamic> data = raw is Map<String, dynamic>
        ? raw
        : <String, dynamic>{};
    return RoomRecord._(
      snapshot.reference,
      mapFromFirestore(data),
    );
  }

  static RoomRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RoomRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RoomRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RoomRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRoomRecordData({
  String? roomStatus,
  DateTime? roomCreatedAt,
  MainInfoStruct? roomMainInfo,
  int? roomMemberLimit,
  int? roomCurrentUserId,
  DateTime? roomUpdatedAt,
  int? roomID,
  RoomInfoStruct? roomInfo,
  String? roomCreatedByUid,
  String? roomCreatedBy,
  DocumentReference? roomCreatedUserRef,
  bool? isRoomWalletStatus,
  int? roomWalletTotalPoint,
  int? roomCode,
  String? roomPresentStatus,
  String? roomType,
  bool? roomAppLaunchTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'room_status': roomStatus,
      'room_created_at': roomCreatedAt,
      'room_main_info': MainInfoStruct().toMap(),
      'room_member_limit': roomMemberLimit,
      'room_current_user_id': roomCurrentUserId,
      'room_updated_at': roomUpdatedAt,
      'room_ID': roomID,
      'room_info': RoomInfoStruct().toMap(),
      'room_created_by_uid': roomCreatedByUid,
      'room_created_by': roomCreatedBy,
      'room_created_userRef': roomCreatedUserRef,
      'is_room_wallet_status': isRoomWalletStatus,
      'room_wallet_total_point': roomWalletTotalPoint,
      'room_code': roomCode,
      'room_present_status': roomPresentStatus,
      'room_type': roomType,
      'room_app_launch_time': roomAppLaunchTime,
    }.withoutNulls,
  );

  // Handle nested data for "room_main_info" field.
  addMainInfoStructData(firestoreData, roomMainInfo, 'room_main_info');

  // Handle nested data for "room_info" field.
  addRoomInfoStructData(firestoreData, roomInfo, 'room_info');

  return firestoreData;
}

class RoomRecordDocumentEquality implements Equality<RoomRecord> {
  const RoomRecordDocumentEquality();

  @override
  bool equals(RoomRecord? e1, RoomRecord? e2) {
    const listEquality = ListEquality();
    return e1?.roomStatus == e2?.roomStatus &&
        e1?.roomCreatedAt == e2?.roomCreatedAt &&
        e1?.roomMainInfo == e2?.roomMainInfo &&
        e1?.roomMemberLimit == e2?.roomMemberLimit &&
        e1?.roomCurrentUserId == e2?.roomCurrentUserId &&
        e1?.roomUpdatedAt == e2?.roomUpdatedAt &&
        e1?.roomID == e2?.roomID &&
        e1?.roomInfo == e2?.roomInfo &&
        e1?.roomCreatedByUid == e2?.roomCreatedByUid &&
        e1?.roomCreatedBy == e2?.roomCreatedBy &&
        e1?.roomCreatedUserRef == e2?.roomCreatedUserRef &&
        listEquality.equals(e1?.roomUserList, e2?.roomUserList) &&
        e1?.isRoomWalletStatus == e2?.isRoomWalletStatus &&
        e1?.roomWalletTotalPoint == e2?.roomWalletTotalPoint &&
        listEquality.equals(e1?.roomWalletOrderInfo, e2?.roomWalletOrderInfo) &&
        listEquality.equals(e1?.selectedGameList, e2?.selectedGameList) &&
        e1?.roomCode == e2?.roomCode &&
        e1?.roomPresentStatus == e2?.roomPresentStatus &&
        e1?.roomType == e2?.roomType &&
        listEquality.equals(
            e1?.roomAttendedQuestionList, e2?.roomAttendedQuestionList) &&
        e1?.roomAppLaunchTime == e2?.roomAppLaunchTime;
  }

  @override
  int hash(RoomRecord? e) => const ListEquality().hash([
        e?.roomStatus,
        e?.roomCreatedAt,
        e?.roomMainInfo,
        e?.roomMemberLimit,
        e?.roomCurrentUserId,
        e?.roomUpdatedAt,
        e?.roomID,
        e?.roomInfo,
        e?.roomCreatedByUid,
        e?.roomCreatedBy,
        e?.roomCreatedUserRef,
        e?.roomUserList,
        e?.isRoomWalletStatus,
        e?.roomWalletTotalPoint,
        e?.roomWalletOrderInfo,
        e?.selectedGameList,
        e?.roomCode,
        e?.roomPresentStatus,
        e?.roomType,
        e?.roomAttendedQuestionList,
        e?.roomAppLaunchTime
      ]);

  @override
  bool isValidKey(Object? o) => o is RoomRecord;
}
