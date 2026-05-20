import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/u_i_game_six/game_six/hot_potato_qr_join.dart';
import '/u_i_game_six/game_six/hot_potato_room_code.dart';

/// Creates a fresh Firestore room for Hot Potato and writes a pointer on the
/// finished [sourceRoom] so other clients on the results screen can auto-follow.
///
/// Returns the new room reference, or `null` if the caller is not the room host
/// or required id-map / game metadata is missing.
Future<DocumentReference?> createHotPotatoRematchRoom({
  required RoomRecord sourceRoom,
}) async {
  if (currentUserReference == null) return null;
  final creator = sourceRoom.roomCreatedUserRef;
  if (creator != null && creator.path != currentUserReference!.path) {
    return null;
  }

  final idmap = await queryIDmapRecordOnce(
    queryBuilder: (r) => r.where('type', isEqualTo: 'Main'),
    singleRecord: true,
  ).then((s) => s.firstOrNull);
  if (idmap == null) return null;

  final games = await queryGameRecordOnce(
    queryBuilder: (g) => g.where(
      'game_ID',
      isEqualTo: HotPotatoQrJoin.hotPotatoGameFirestoreId,
    ),
    singleRecord: true,
  );
  final gameRow = games.firstOrNull;
  if (gameRow == null) return null;

  final activeUsers = sourceRoom.roomUserList
      .where((e) => e.roomUserStatus == 'active')
      .toList();
  final roomUserFirestore = activeUsers.isNotEmpty
      ? getRoomUserListListFirestoreData(activeUsers)
      : <Map<String, dynamic>>[
          getRoomUserListFirestoreData(
            updateRoomUserListStruct(
              RoomUserListStruct(
                roomUserJoinTime: getCurrentTimestamp,
                roomUserId: valueOrDefault(currentUserDocument?.userId, 0),
                roomUserRef: currentUserReference,
                roomUserStatus: 'active',
                roomUserUpdatedTime: getCurrentTimestamp,
                roomUserOnlineStatus: 'active',
              ),
              clearUnsetFields: false,
              create: true,
            ),
            true,
          ),
        ];

  final code = await allocateUnusedHotPotatoRoomCode();
  final newRef = RoomRecord.collection.doc();

  await newRef.set({
    ...createRoomRecordData(
      roomStatus: 'active',
      roomCreatedAt: getCurrentTimestamp,
      roomCreatedBy:
          valueOrDefault(currentUserDocument?.userId, 0).toString(),
      roomMemberLimit:
          sourceRoom.roomMemberLimit > 0 ? sourceRoom.roomMemberLimit : 999,
      roomMainInfo: updateMainInfoStruct(
        MainInfoStruct(
          name: sourceRoom.roomMainInfo.name.isNotEmpty
              ? sourceRoom.roomMainInfo.name
              : currentUserDisplayName,
          mainImage: sourceRoom.roomMainInfo.mainImage.isNotEmpty
              ? sourceRoom.roomMainInfo.mainImage
              : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/nx4yo2w3wqhm/%F0%9F%8F%A0.png',
        ),
        clearUnsetFields: false,
        create: true,
      ),
      roomCurrentUserId: valueOrDefault(currentUserDocument?.userId, 0),
      roomUpdatedAt: getCurrentTimestamp,
      roomID: idmap.roomId,
      roomCreatedByUid: currentUserUid,
      roomCreatedUserRef: sourceRoom.roomCreatedUserRef ?? currentUserReference,
      isRoomWalletStatus: sourceRoom.isRoomWalletStatus,
      roomWalletTotalPoint: sourceRoom.roomWalletTotalPoint,
      roomPresentStatus: 'create',
      roomType: sourceRoom.roomType.isNotEmpty ? sourceRoom.roomType : 'solo',
      roomCode: code,
    ),
    ...mapToFirestore({
      'room_user_list': roomUserFirestore,
    }),
  });

  await idmap.reference.update(
    mapToFirestore({'room_id': FieldValue.increment(1)}),
  );

  final gameUserListForRow = activeUsers.isNotEmpty
      ? activeUsers
      : <RoomUserListStruct>[
          RoomUserListStruct(
            roomUserJoinTime: getCurrentTimestamp,
            roomUserId: valueOrDefault(currentUserDocument?.userId, 0),
            roomUserRef: currentUserReference,
            roomUserStatus: 'active',
            roomUserUpdatedTime: getCurrentTimestamp,
            roomUserOnlineStatus: 'active',
          ),
        ];

  await newRef.update({
    ...createRoomRecordData(roomUpdatedAt: getCurrentTimestamp),
    ...mapToFirestore({
      'selected_game_list': FieldValue.arrayUnion([
        getSelectedGameListFirestoreData(
          updateSelectedGameListStruct(
            SelectedGameListStruct(
              gameId: HotPotatoQrJoin.hotPotatoGameFirestoreId,
              gameStartTime: getCurrentTimestamp,
              gameSelectedByUid:
                  valueOrDefault(currentUserDocument?.userId, 0).toString(),
              gameSelectedByUserRef: currentUserReference,
              gameSelectedPoint: gameRow.gamePoint,
              gameInfo: gameRow.gameInfo,
              selectedGameID: idmap.selectGameId,
              selectedGameIndex: 0,
              selectedGameUserList: gameUserListForRow,
              teamLimit: 2,
              gameSAUStarterUserref: currentUserReference,
            ),
            clearUnsetFields: false,
          ),
          true,
        ),
      ]),
    }),
  });

  await idmap.reference.update(
    mapToFirestore({'select_game_id': FieldValue.increment(1)}),
  );

  await sourceRoom.reference.update(
    mapToFirestore({
      'hot_potato_rematch_room_ref': newRef,
      'hot_potato_rematch_at': FieldValue.serverTimestamp(),
    }),
  );

  return newRef;
}
