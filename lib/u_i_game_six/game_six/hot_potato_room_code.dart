import 'dart:math';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/u_i_game_six/game_six/hot_potato_qr_join.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Six-digit numeric join codes for Hot Potato (100000–999999).
bool isHotPotatoSixDigitRoomCode(int code) => code >= 100000 && code <= 999999;

/// Picks a random unused code among active rooms (`room_status == 'active'`).
Future<int> allocateUnusedHotPotatoRoomCode() async {
  final rng = Random();
  const maxAttempts = 40;
  for (var i = 0; i < maxAttempts; i++) {
    final code = 100000 + rng.nextInt(900000);
    final hit = await queryRoomRecordOnce(
      queryBuilder: (roomRecord) => roomRecord
          .where('room_code', isEqualTo: code)
          .where('room_status', isEqualTo: 'active'),
      singleRecord: true,
    ).then((s) => s.firstOrNull);
    if (hit == null) {
      return code;
    }
  }
  throw StateError('Could not allocate a unique Hot Potato room code');
}

/// Active room with this [code] that already has Hot Potato in [selected_game_list].
Future<RoomRecord?> findActiveHotPotatoRoomByCode(int code) async {
  if (!isHotPotatoSixDigitRoomCode(code)) return null;
  final room = await queryRoomRecordOnce(
    queryBuilder: (roomRecord) => roomRecord
        .where('room_code', isEqualTo: code)
        .where('room_status', isEqualTo: 'active'),
    singleRecord: true,
  ).then((s) => s.firstOrNull);
  if (room == null) return null;
  final hasHp = room.selectedGameList.any(
    (e) => e.gameId == HotPotatoQrJoin.hotPotatoGameFirestoreId,
  );
  return hasHp ? room : null;
}

/// Result of [showHotPotatoEntryDialog]: host a new room, or join with [code].
sealed class HotPotatoEntryOutcome {}

final class HotPotatoEntryNewGame extends HotPotatoEntryOutcome {}

final class HotPotatoEntryJoinRoom extends HotPotatoEntryOutcome {
  HotPotatoEntryJoinRoom(this.code);
  final int code;
}

/// One dialog: visible code field, **Join** (enabled for a valid 6-digit code),
/// and **New game**. Avoids a washed-out second step and blank-looking fields.
Future<HotPotatoEntryOutcome?> showHotPotatoEntryDialog(
    BuildContext context) async {
  return showDialog<HotPotatoEntryOutcome>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (ctx) => const _HotPotatoEntryDialog(),
  );
}

class _HotPotatoEntryDialog extends StatefulWidget {
  const _HotPotatoEntryDialog();

  @override
  State<_HotPotatoEntryDialog> createState() => _HotPotatoEntryDialogState();
}

class _HotPotatoEntryDialogState extends State<_HotPotatoEntryDialog> {
  late final TextEditingController _codeController;
  bool _joinEnabled = false;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _syncJoinEnabled() {
    final raw = _codeController.text.trim();
    final v = int.tryParse(raw);
    final next = v != null && isHotPotatoSixDigitRoomCode(v);
    if (next != _joinEnabled) setState(() => _joinEnabled = next);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    const borderGrey = Color(0xFF9CA3AF);

    return Dialog(
      backgroundColor: theme.secondaryBackground,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
        side: BorderSide(
          color: theme.secondary.withValues(alpha: 0.45),
          width: 1.4,
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    surface: theme.secondaryBackground,
                    onSurface: theme.primaryText,
                  ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4F4F2),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: theme.tertiary.withValues(alpha: 0.55),
                          width: 1.4,
                        ),
                      ),
                      child: const Text(
                        '🥔',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Hot Potato',
                        style: theme.headlineSmall.override(
                          color: theme.primaryText,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Join a friend\'s room with their 6-digit code, or start your own as host.',
                  style: theme.bodyMedium.override(
                    color: theme.secondaryText,
                    lineHeight: 1.45,
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autofocus: false,
                  style: theme.headlineSmall.override(
                    color: theme.primaryText,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 4,
                  ),
                  textAlign: TextAlign.center,
                  cursorColor: theme.secondary,
                  decoration: InputDecoration(
                    labelText: 'Room code',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: theme.labelLarge.override(
                      color: theme.primaryText,
                      fontWeight: FontWeight.w700,
                    ),
                    hintText: 'e.g. 482915',
                    hintStyle: theme.titleMedium.override(
                      color: const Color(0xFF6B7280),
                      letterSpacing: 2,
                    ),
                    counterText: '',
                    filled: true,
                    fillColor: theme.primaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: borderGrey,
                        width: 1.6,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: borderGrey,
                        width: 1.6,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: theme.secondary,
                        width: 2.2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                  ),
                  onChanged: (_) => _syncJoinEnabled(),
                ),
                const SizedBox(height: 8),
                Text(
                  _joinEnabled
                      ? 'Tap Join to enter that room.'
                      : 'Enter all 6 digits to enable Join.',
                  style: theme.bodySmall.override(
                    color: _joinEnabled ? theme.tertiary : theme.secondaryText,
                    fontWeight:
                        _joinEnabled ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: _joinEnabled
                      ? () {
                          final v = int.tryParse(_codeController.text.trim());
                          if (v != null && isHotPotatoSixDigitRoomCode(v)) {
                            Navigator.pop(context, HotPotatoEntryJoinRoom(v));
                          }
                        }
                      : null,
                  icon: const Icon(Icons.login_rounded, size: 22),
                  label: const Text('Join game'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        theme.alternate.withValues(alpha: 0.85),
                    disabledForegroundColor: const Color(0xFF9CA3AF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.pop(context, HotPotatoEntryNewGame()),
                  icon: Icon(Icons.add_circle_outline_rounded,
                      color: theme.secondary),
                  label: Text(
                    'New game',
                    style: theme.titleSmall.override(
                      color: theme.secondary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.secondary,
                    backgroundColor: theme.primaryBackground,
                    side: BorderSide(
                      color: theme.secondary,
                      width: 2,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Returns a six-digit int, or `null` if cancelled / invalid.
Future<int?> showHotPotatoSixDigitCodeDialog(BuildContext context) async {
  final controller = TextEditingController();
  try {
    return await showDialog<int>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (ctx) {
        final theme = FlutterFlowTheme.of(ctx);
        const borderGrey = Color(0xFF9CA3AF);
        return Dialog(
          backgroundColor: theme.secondaryBackground,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
            side: BorderSide(
              color: theme.secondary.withValues(alpha: 0.45),
              width: 1.4,
            ),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
              child: Theme(
                data: Theme.of(ctx).copyWith(
                  colorScheme: Theme.of(ctx).colorScheme.copyWith(
                        surface: theme.secondaryBackground,
                        onSurface: theme.primaryText,
                      ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.tag_rounded,
                          color: theme.secondary,
                          size: 26,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Enter 6-digit code',
                            style: theme.headlineSmall.override(
                              color: theme.primaryText,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ask the host for the room code, then type it below.',
                      style: theme.bodySmall.override(
                        color: theme.secondaryText,
                        lineHeight: 1.35,
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autofocus: true,
                      style: theme.headlineMedium.override(
                        color: theme.primaryText,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 6,
                      ),
                      textAlign: TextAlign.center,
                      cursorColor: theme.secondary,
                      decoration: InputDecoration(
                        labelText: 'Room code',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: theme.labelLarge.override(
                          color: theme.primaryText,
                          fontWeight: FontWeight.w700,
                        ),
                        counterText: '',
                        hintText: '000000',
                        hintStyle: theme.headlineMedium.override(
                          color: const Color(0xFF6B7280),
                          letterSpacing: 6,
                        ),
                        filled: true,
                        fillColor: theme.primaryBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: borderGrey,
                            width: 1.6,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: borderGrey,
                            width: 1.6,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: theme.secondary,
                            width: 2.2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                      ),
                      onSubmitted: (_) {
                        final v = int.tryParse(controller.text);
                        if (v != null && isHotPotatoSixDigitRoomCode(v)) {
                          Navigator.pop(ctx, v);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: theme.primaryText,
                              backgroundColor: theme.primaryBackground,
                              side: const BorderSide(
                                color: borderGrey,
                                width: 1.6,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: theme.titleSmall.override(
                                color: theme.primaryText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: FilledButton(
                            onPressed: () {
                              final v = int.tryParse(controller.text.trim());
                              if (v != null && isHotPotatoSixDigitRoomCode(v)) {
                                Navigator.pop(ctx, v);
                              }
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: theme.primary,
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Join',
                              style: theme.titleSmall.override(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  } finally {
    controller.dispose();
  }
}

/// Adds the signed-in user to [room] for Hot Potato (room list + game user list)
/// and updates [currentUserReference] `present_room_game_info` like the QR flow.
Future<void> applyHotPotatoJoinToFirestore(RoomRecord room) async {
  final fresh = await RoomRecord.getDocumentOnce(room.reference);
  final hpIndex = fresh.selectedGameList.indexWhere(
    (e) => e.gameId == HotPotatoQrJoin.hotPotatoGameFirestoreId,
  );
  if (hpIndex < 0) {
    throw StateError('Room has no Hot Potato game');
  }
  final hpRow = fresh.selectedGameList[hpIndex];
  final selectGameId = hpRow.selectedGameID;

  var roomUserList = fresh.roomUserList.toList();
  if (!roomUserList.any((e) => e.roomUserRef == currentUserReference)) {
    roomUserList.add(
      RoomUserListStruct(
        roomUserOnlineStatus: 'active',
        roomUserStatus: 'active',
        roomUserUpdatedTime: getCurrentTimestamp,
        roomUserJoinTime: getCurrentTimestamp,
        roomUserInfo: createOrderUserMainInfoStruct(
          userName: currentUserDisplayName,
          clearUnsetFields: false,
        ),
        roomUserId: valueOrDefault(currentUserDocument?.userId, 0),
        roomUserRef: currentUserReference,
      ),
    );
  }

  var gameUserList = hpRow.selectedGameUserList.toList();
  if (!gameUserList.any((e) => e.roomUserRef == currentUserReference)) {
    gameUserList.add(
      RoomUserListStruct(
        roomUserOnlineStatus: 'active',
        roomUserStatus: 'active',
        roomUserUpdatedTime: getCurrentTimestamp,
        roomUserJoinTime: getCurrentTimestamp,
        roomUserInfo: createOrderUserMainInfoStruct(
          userName: currentUserDisplayName,
          clearUnsetFields: false,
        ),
        roomUserId: valueOrDefault(currentUserDocument?.userId, 0),
        roomUserRef: currentUserReference,
        roomUserNotificationSendStatus: 'stocker',
      ),
    );
  }

  final gameList = fresh.selectedGameList.toList();
  gameList[hpIndex].selectedGameUserList = gameUserList;

  await fresh.reference.update({
    ...createRoomRecordData(
      roomUpdatedAt: getCurrentTimestamp,
    ),
    ...mapToFirestore(
      {
        'room_user_list': getRoomUserListListFirestoreData(roomUserList),
        'selected_game_list': getSelectedGameListListFirestoreData(gameList),
      },
    ),
  });

  final games = await queryGameRecordOnce(
    queryBuilder: (g) => g.where(
      'game_ID',
      isEqualTo: HotPotatoQrJoin.hotPotatoGameFirestoreId,
    ),
    singleRecord: true,
  );
  final gref = games.firstOrNull?.reference;

  await currentUserReference!.update(
    createUsersRecordData(
      presentRoomGameInfo: createPresentRoomGameInfoStruct(
        roomRef: fresh.reference,
        roomAdminRef: fresh.roomCreatedUserRef,
        roomGameAdminStatus: 'start',
        roomSelectedGameID: selectGameId,
        roomGameId: HotPotatoQrJoin.hotPotatoGameFirestoreId,
        clearUnsetFields: false,
      ),
    ),
  );

  if (gref != null) {
    await currentUserReference!.update({
      'present_room_game_info.room_admin_selected_game_ref': gref,
    });
  }
}
