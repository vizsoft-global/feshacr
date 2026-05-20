import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IDmapRecord extends FirestoreRecord {
  IDmapRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "room_id" field.
  int? _roomId;
  int get roomId => _roomId ?? 0;
  bool hasRoomId() => _roomId != null;

  // "point_id" field.
  int? _pointId;
  int get pointId => _pointId ?? 0;
  bool hasPointId() => _pointId != null;

  // "order_id" field.
  int? _orderId;
  int get orderId => _orderId ?? 0;
  bool hasOrderId() => _orderId != null;

  // "game_id" field.
  int? _gameId;
  int get gameId => _gameId ?? 0;
  bool hasGameId() => _gameId != null;

  // "topic_id" field.
  int? _topicId;
  int get topicId => _topicId ?? 0;
  bool hasTopicId() => _topicId != null;

  // "group_id" field.
  int? _groupId;
  int get groupId => _groupId ?? 0;
  bool hasGroupId() => _groupId != null;

  // "question_id" field.
  int? _questionId;
  int get questionId => _questionId ?? 0;
  bool hasQuestionId() => _questionId != null;

  // "team_id" field.
  int? _teamId;
  int get teamId => _teamId ?? 0;
  bool hasTeamId() => _teamId != null;

  // "history_id" field.
  int? _historyId;
  int get historyId => _historyId ?? 0;
  bool hasHistoryId() => _historyId != null;

  // "notification_id" field.
  int? _notificationId;
  int get notificationId => _notificationId ?? 0;
  bool hasNotificationId() => _notificationId != null;

  // "select_game_id" field.
  int? _selectGameId;
  int get selectGameId => _selectGameId ?? 0;
  bool hasSelectGameId() => _selectGameId != null;

  // "wallet_spent_id" field.
  int? _walletSpentId;
  int get walletSpentId => _walletSpentId ?? 0;
  bool hasWalletSpentId() => _walletSpentId != null;

  // "round_id" field.
  int? _roundId;
  int get roundId => _roundId ?? 0;
  bool hasRoundId() => _roundId != null;

  // "round_result_id" field.
  int? _roundResultId;
  int get roundResultId => _roundResultId ?? 0;
  bool hasRoundResultId() => _roundResultId != null;

  // "vote_id" field.
  int? _voteId;
  int get voteId => _voteId ?? 0;
  bool hasVoteId() => _voteId != null;

  // "coupon_id" field.
  int? _couponId;
  int get couponId => _couponId ?? 0;
  bool hasCouponId() => _couponId != null;

  void _initializeFields() {
    _type = snapshotData['type'] as String?;
    _roomId = castToType<int>(snapshotData['room_id']);
    _pointId = castToType<int>(snapshotData['point_id']);
    _orderId = castToType<int>(snapshotData['order_id']);
    _gameId = castToType<int>(snapshotData['game_id']);
    _topicId = castToType<int>(snapshotData['topic_id']);
    _groupId = castToType<int>(snapshotData['group_id']);
    _questionId = castToType<int>(snapshotData['question_id']);
    _teamId = castToType<int>(snapshotData['team_id']);
    _historyId = castToType<int>(snapshotData['history_id']);
    _notificationId = castToType<int>(snapshotData['notification_id']);
    _selectGameId = castToType<int>(snapshotData['select_game_id']);
    _walletSpentId = castToType<int>(snapshotData['wallet_spent_id']);
    _roundId = castToType<int>(snapshotData['round_id']);
    _roundResultId = castToType<int>(snapshotData['round_result_id']);
    _voteId = castToType<int>(snapshotData['vote_id']);
    _couponId = castToType<int>(snapshotData['coupon_id']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('IDmap');

  static Stream<IDmapRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => IDmapRecord.fromSnapshot(s));

  static Future<IDmapRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => IDmapRecord.fromSnapshot(s));

  static IDmapRecord fromSnapshot(DocumentSnapshot snapshot) => IDmapRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static IDmapRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      IDmapRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'IDmapRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is IDmapRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createIDmapRecordData({
  String? type,
  int? roomId,
  int? pointId,
  int? orderId,
  int? gameId,
  int? topicId,
  int? groupId,
  int? questionId,
  int? teamId,
  int? historyId,
  int? notificationId,
  int? selectGameId,
  int? walletSpentId,
  int? roundId,
  int? roundResultId,
  int? voteId,
  int? couponId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'type': type,
      'room_id': roomId,
      'point_id': pointId,
      'order_id': orderId,
      'game_id': gameId,
      'topic_id': topicId,
      'group_id': groupId,
      'question_id': questionId,
      'team_id': teamId,
      'history_id': historyId,
      'notification_id': notificationId,
      'select_game_id': selectGameId,
      'wallet_spent_id': walletSpentId,
      'round_id': roundId,
      'round_result_id': roundResultId,
      'vote_id': voteId,
      'coupon_id': couponId,
    }.withoutNulls,
  );

  return firestoreData;
}

class IDmapRecordDocumentEquality implements Equality<IDmapRecord> {
  const IDmapRecordDocumentEquality();

  @override
  bool equals(IDmapRecord? e1, IDmapRecord? e2) {
    return e1?.type == e2?.type &&
        e1?.roomId == e2?.roomId &&
        e1?.pointId == e2?.pointId &&
        e1?.orderId == e2?.orderId &&
        e1?.gameId == e2?.gameId &&
        e1?.topicId == e2?.topicId &&
        e1?.groupId == e2?.groupId &&
        e1?.questionId == e2?.questionId &&
        e1?.teamId == e2?.teamId &&
        e1?.historyId == e2?.historyId &&
        e1?.notificationId == e2?.notificationId &&
        e1?.selectGameId == e2?.selectGameId &&
        e1?.walletSpentId == e2?.walletSpentId &&
        e1?.roundId == e2?.roundId &&
        e1?.roundResultId == e2?.roundResultId &&
        e1?.voteId == e2?.voteId &&
        e1?.couponId == e2?.couponId;
  }

  @override
  int hash(IDmapRecord? e) => const ListEquality().hash([
        e?.type,
        e?.roomId,
        e?.pointId,
        e?.orderId,
        e?.gameId,
        e?.topicId,
        e?.groupId,
        e?.questionId,
        e?.teamId,
        e?.historyId,
        e?.notificationId,
        e?.selectGameId,
        e?.walletSpentId,
        e?.roundId,
        e?.roundResultId,
        e?.voteId,
        e?.couponId
      ]);

  @override
  bool isValidKey(Object? o) => o is IDmapRecord;
}
