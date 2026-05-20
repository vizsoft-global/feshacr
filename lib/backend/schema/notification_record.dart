import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationRecord extends FirestoreRecord {
  NotificationRecord._(
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

  // "notification_ID" field.
  int? _notificationID;
  int get notificationID => _notificationID ?? 0;
  bool hasNotificationID() => _notificationID != null;

  // "notification_status" field.
  String? _notificationStatus;
  String get notificationStatus => _notificationStatus ?? '';
  bool hasNotificationStatus() => _notificationStatus != null;

  // "to_userRef" field.
  DocumentReference? _toUserRef;
  DocumentReference? get toUserRef => _toUserRef;
  bool hasToUserRef() => _toUserRef != null;

  // "from_userRef" field.
  DocumentReference? _fromUserRef;
  DocumentReference? get fromUserRef => _fromUserRef;
  bool hasFromUserRef() => _fromUserRef != null;

  // "room_info" field.
  RoomInfoStruct? _roomInfo;
  RoomInfoStruct get roomInfo => _roomInfo ?? RoomInfoStruct();
  bool hasRoomInfo() => _roomInfo != null;

  // "game_info" field.
  GameInfoStruct? _gameInfo;
  GameInfoStruct get gameInfo => _gameInfo ?? GameInfoStruct();
  bool hasGameInfo() => _gameInfo != null;

  // "notification_type" field.
  String? _notificationType;
  String get notificationType => _notificationType ?? '';
  bool hasNotificationType() => _notificationType != null;

  // "notification_from" field.
  String? _notificationFrom;
  String get notificationFrom => _notificationFrom ?? '';
  bool hasNotificationFrom() => _notificationFrom != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _notificationID = castToType<int>(snapshotData['notification_ID']);
    _notificationStatus = snapshotData['notification_status'] as String?;
    _toUserRef = snapshotData['to_userRef'] as DocumentReference?;
    _fromUserRef = snapshotData['from_userRef'] as DocumentReference?;
    _roomInfo = snapshotData['room_info'] is RoomInfoStruct
        ? snapshotData['room_info']
        : RoomInfoStruct.maybeFromMap(snapshotData['room_info']);
    _gameInfo = snapshotData['game_info'] is GameInfoStruct
        ? snapshotData['game_info']
        : GameInfoStruct.maybeFromMap(snapshotData['game_info']);
    _notificationType = snapshotData['notification_type'] as String?;
    _notificationFrom = snapshotData['notification_from'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notification');

  static Stream<NotificationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationRecord.fromSnapshot(s));

  static Future<NotificationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationRecord.fromSnapshot(s));

  static NotificationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationRecordData({
  DateTime? createdAt,
  DateTime? updatedAt,
  int? notificationID,
  String? notificationStatus,
  DocumentReference? toUserRef,
  DocumentReference? fromUserRef,
  RoomInfoStruct? roomInfo,
  GameInfoStruct? gameInfo,
  String? notificationType,
  String? notificationFrom,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'updated_at': updatedAt,
      'notification_ID': notificationID,
      'notification_status': notificationStatus,
      'to_userRef': toUserRef,
      'from_userRef': fromUserRef,
      'room_info': RoomInfoStruct().toMap(),
      'game_info': GameInfoStruct().toMap(),
      'notification_type': notificationType,
      'notification_from': notificationFrom,
    }.withoutNulls,
  );

  // Handle nested data for "room_info" field.
  addRoomInfoStructData(firestoreData, roomInfo, 'room_info');

  // Handle nested data for "game_info" field.
  addGameInfoStructData(firestoreData, gameInfo, 'game_info');

  return firestoreData;
}

class NotificationRecordDocumentEquality
    implements Equality<NotificationRecord> {
  const NotificationRecordDocumentEquality();

  @override
  bool equals(NotificationRecord? e1, NotificationRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.notificationID == e2?.notificationID &&
        e1?.notificationStatus == e2?.notificationStatus &&
        e1?.toUserRef == e2?.toUserRef &&
        e1?.fromUserRef == e2?.fromUserRef &&
        e1?.roomInfo == e2?.roomInfo &&
        e1?.gameInfo == e2?.gameInfo &&
        e1?.notificationType == e2?.notificationType &&
        e1?.notificationFrom == e2?.notificationFrom;
  }

  @override
  int hash(NotificationRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.updatedAt,
        e?.notificationID,
        e?.notificationStatus,
        e?.toUserRef,
        e?.fromUserRef,
        e?.roomInfo,
        e?.gameInfo,
        e?.notificationType,
        e?.notificationFrom
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationRecord;
}
