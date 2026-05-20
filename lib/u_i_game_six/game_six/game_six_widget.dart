import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/custom_code/actions/index.dart' as actions;
import '/feshah_game_zone/main/home/home_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/u_i_game_six/hotpotatotimer/hotpotatotimer_widget.dart';
import '/u_i_game_six/hot_potato/arena/hot_potato_arena_widget.dart';
import '/u_i_game_six/minutes/minutes_widget.dart';
import '/u_i_game_six/powerups/powerups_widget.dart';
import '/u_i_game_six/powerups1/powerups1_widget.dart';
import '/u_i_game_six/rounds/rounds_widget.dart';
import 'hot_potato_live.dart';
import 'hot_potato_pickup_spawner.dart';
import 'hot_potato_positions_rtdb.dart';
import 'hot_potato_qr_join.dart';
import 'hot_potato_rematch.dart';
import 'hot_potato_room_code.dart';
import 'hot_potato_rtdb_routing.dart';
import 'hot_potato_edge_config.dart';
import 'hot_potato_edge_routing.dart';
import 'hot_potato_settings_parser.dart';
import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'game_six_model.dart';
import 'hot_potato_display_utils.dart';
export 'game_six_model.dart';

int _hotPotatoResultsPointsBaseline(RoomRecord room) {
  final row = room.selectedGameList.firstWhereOrNull(
    (e) => e.gameId == HotPotatoQrJoin.hotPotatoGameFirestoreId,
  );
  final p = row?.gameSelectedPoint ?? 0;
  if (p > 0) return p;
  return 400;
}

int _hotPotatoResultsPointsForRank({
  required int rankIndex0,
  required int totalPlayers,
  required int baselinePoints,
}) {
  if (totalPlayers <= 0) return 0;
  final place = (totalPlayers - rankIndex0).clamp(1, totalPlayers);
  return ((baselinePoints * place * 1.35) / totalPlayers).round();
}

int _resolvedJoinScanSelectedGameId(RoomRecord room) {
  final pref = currentUserDocument?.presentRoomGameInfo;
  if (pref != null &&
      pref.hasRoomRef() &&
      pref.roomRef?.path == room.reference.path) {
    final id = pref.roomSelectedGameID;
    if (id != 0) return id;
  }
  for (var i = room.selectedGameList.length - 1; i >= 0; i--) {
    final g = room.selectedGameList[i];
    if (g.gameId == HotPotatoQrJoin.hotPotatoGameFirestoreId &&
        g.selectedGameID != 0) {
      return g.selectedGameID;
    }
  }
  return 0;
}

/// Offline bot mode is only safe when no other human has an active seat (invite
/// stubs without a [roomUserRef] count as blocking — someone could still join).
bool _hotPotatoOfflineBotsEligibleForActiveList(
  List<RoomUserListStruct> activeUsers,
) {
  final me = currentUserReference?.path;
  if (me == null) return false;
  for (final u in activeUsers) {
    if (u.roomUserStatus != 'active') continue;
    final p = u.roomUserRef?.path;
    if (p == null) return false;
    if (p != me) return false;
  }
  return true;
}

const List<String> _hotPotatoEditableAvatars = [
  '🦊',
  '🦕',
  '🐋',
  '🦚',
  '🐙',
  '🐵',
  '💀',
  '🦀',
  '🐼',
  '🐱',
  '🐰',
  '🦋',
];

class _HotPotatoIdentityDraft {
  const _HotPotatoIdentityDraft({
    required this.name,
    required this.avatar,
  });

  final String name;
  final String avatar;
}

/// Hot Potato — Game Six: settings + arena (milestone 1: local timer / stubs).
class GameSixWidget extends StatefulWidget {
  const GameSixWidget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  static String routeName = 'GameSix';
  static String routePath = '/GameSix';

  @override
  State<GameSixWidget> createState() => _GameSixWidgetState();
}

class _GameSixWidgetState extends State<GameSixWidget>
    with WidgetsBindingObserver {
  late GameSixModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Stream<RoomRecord> _roomStream;
  Future<Map<String, int>>? _lobbyRtdbLatencyFuture;
  Future<List<HotPotatoEdgeHintRanked>>? _lobbyEdgeTopFuture;

  /// Set while the app tab is in background / hidden (not [inactive] — too noisy).
  DateTime? _backgroundedAt;

  /// Host or player: if the app stays hidden longer than this, we treat the
  /// session as abandoned (reset match for host-driven rooms, or leave for
  /// non-hosts). Same threshold for everyone.
  static const int _inactiveCloseRoomSeconds = 30;

  /// Avoids double navigation when the rematch pointer appears on the room stream.
  bool _rematchNavigationLock = false;
  String? _scheduledRematchForPath;

  void _refreshLobbyLatencyProbe() {
    if (hotPotatoEdgeAvailable()) {
      // Manual refresh forgets the cached Auto pick so the next match probes
      // fresh and snaps to the truly best region for the host's current
      // network — instead of staying pinned to the 24h-cached choice.
      unawaited(clearCachedAutoEdgeHint());
      _lobbyEdgeTopFuture = topHotPotatoEdgeHintsByLatency(n: 3);
      _lobbyRtdbLatencyFuture = null;
    } else {
      _lobbyRtdbLatencyFuture = probeHotPotatoRtdbLatencyMs();
      _lobbyEdgeTopFuture = null;
    }
  }

  Future<void> _followHotPotatoRematchRoom(DocumentReference newRoomRef) async {
    if (_rematchNavigationLock || !mounted || widget.room == null) return;
    _rematchNavigationLock = true;
    try {
      final newRoom = await RoomRecord.getDocumentOnce(newRoomRef);
      try {
        await applyHotPotatoJoinToFirestore(newRoom);
      } catch (_) {
        // Room may already list this user; still navigate.
      }
      if (!mounted) return;
      context.goNamed(
        GameSixWidget.routeName,
        queryParameters: {
          'room': serializeParam(
            newRoomRef,
            ParamType.DocumentReference,
          ),
        }.withoutNulls,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not join rematch room: $e')),
        );
      }
    } finally {
      _rematchNavigationLock = false;
    }
  }

  void _maybeScheduleRematchFollow(RoomRecord room) {
    if (_model.isStarting) return;
    if (widget.room == null || room.reference.path != widget.room!.path) {
      return;
    }
    final hp =
        HotPotatoFirestoreSettings.fromRoomSnapshotData(room.snapshotData);
    if (!hp.isArena) return;
    final live = HotPotatoLiveState.fromRoomSnapshotData(room.snapshotData);
    if (live == null || !live.matchComplete) return;
    final raw = room.snapshotData['hot_potato_rematch_room_ref'];
    if (raw is! DocumentReference) return;
    if (raw.path == room.reference.path) return;
    if (_scheduledRematchForPath == raw.path) return;
    _scheduledRematchForPath = raw.path;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(_followHotPotatoRematchRoom(raw));
    });
  }

  Future<void> _hostPlayAgainRematch(RoomRecord finishedRoom) async {
    if (!mounted || widget.room == null) return;
    if (_rematchNavigationLock || _model.isStarting) return;
    safeSetState(() => _model.isStarting = true);
    try {
      final newRef = await createHotPotatoRematchRoom(sourceRoom: finishedRoom);
      if (newRef == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Only the room host can start a rematch, or setup data is missing.',
              ),
            ),
          );
        }
        return;
      }
      _scheduledRematchForPath = newRef.path;
      final newRoom = await RoomRecord.getDocumentOnce(newRef);
      await applyHotPotatoJoinToFirestore(newRoom);
      if (!mounted) return;
      context.goNamed(
        GameSixWidget.routeName,
        queryParameters: {
          'room': serializeParam(
            newRef,
            ParamType.DocumentReference,
          ),
        }.withoutNulls,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Play again failed: $e')),
        );
      }
    } finally {
      if (mounted) safeSetState(() => _model.isStarting = false);
    }
  }

  void _rebindRoomStream() {
    final ref = widget.room!;
    // Use the raw room stream. A signature filter was dropping snapshots and
    // could leave the UI stale or blank relative to Firestore.
    _roomStream = RoomRecord.getDocument(ref);
  }

  /// After hiding the app: away ≥ [_inactiveCloseRoomSeconds] while a match is
  /// in progress — host resets Hot Potato for everyone; other players leave
  /// this match (no results screen).
  Future<void> _handleHotPotatoAbsenceOnResume(Duration away) async {
    if (!mounted || widget.room == null) return;
    try {
      final room = await RoomRecord.getDocumentOnce(widget.room!);
      final hp = HotPotatoFirestoreSettings.fromRoomSnapshotData(
        room.snapshotData,
      );
      if (!hp.isArena) return;
      final live = HotPotatoLiveState.fromRoomSnapshotData(room.snapshotData);
      if (live == null || live.matchComplete) return;

      if (away.inSeconds < _inactiveCloseRoomSeconds) return;

      final host = _isRoomHost(room);
      if (host) {
        await _returnToHotPotatoSettings();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'You were inactive for 30+ seconds — the match was reset to setup for everyone.',
              ),
            ),
          );
        }
      } else {
        await _leaveToHome();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'You were inactive for 30+ seconds — you have left this match.',
              ),
            ),
          );
        }
      }
    } catch (_) {
      // Ignore; user can still use Back / Exit.
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (widget.room == null) return;
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _backgroundedAt ??= DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      final t = _backgroundedAt;
      _backgroundedAt = null;
      if (t == null) return;
      final away = DateTime.now().difference(t);
      if (away.inMilliseconds < 400) return;
      unawaited(_handleHotPotatoAbsenceOnResume(away));
    }
  }

  Future<void> _leaveToHome() async {
    if (loggedIn && currentUserReference != null) {
      await currentUserReference!.update(
        createUsersRecordData(
          presentRoomGameInfo: createPresentRoomGameInfoStruct(delete: true),
        ),
      );
    }
    if (mounted) {
      context.goNamed(HomeWidget.routeName);
    }
  }

  void _backOrHome() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(HomeWidget.routeName);
    }
  }

  Future<void> _sendInvite(
    DocumentReference toUserRef,
    String displayName,
  ) async {
    try {
      await NotificationRecord.collection.doc().set(
            createNotificationRecordData(
              createdAt: getCurrentTimestamp,
              updatedAt: getCurrentTimestamp,
              notificationStatus: 'send',
              toUserRef: toUserRef,
              fromUserRef: currentUserReference,
              notificationType: 'game_invite',
              notificationFrom: currentUserDisplayName,
            ),
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invite sent to $displayName')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invite failed: $e')),
        );
      }
    }
  }

  Future<_HotPotatoIdentityDraft?> _showIdentityEditor({
    required String initialName,
    required String initialAvatar,
  }) async {
    final nameController = TextEditingController(text: initialName);
    var selectedAvatar = initialAvatar;
    try {
      return await showDialog<_HotPotatoIdentityDraft>(
        context: context,
        builder: (dialogContext) => StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit profile',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: nameController,
                      maxLength: 18,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Display name',
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _hotPotatoEditableAvatars.map((emoji) {
                        final active = emoji == selectedAvatar;
                        return InkWell(
                          borderRadius: BorderRadius.circular(22),
                          onTap: () =>
                              setDialogState(() => selectedAvatar = emoji),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 140),
                            width: 44,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF3FA),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: active
                                    ? FlutterFlowTheme.of(context).primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(emoji,
                                style: const TextStyle(fontSize: 24)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () {
                            final clean = nameController.text.trim();
                            final finalName = clean.isEmpty ? 'Player' : clean;
                            Navigator.pop(
                              dialogContext,
                              _HotPotatoIdentityDraft(
                                name: finalName,
                                avatar: selectedAvatar,
                              ),
                            );
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } finally {
      nameController.dispose();
    }
  }

  Future<void> _saveMyIdentity(
    RoomRecord room,
    RoomUserListStruct meUser,
  ) async {
    final me = currentUserReference;
    if (me == null || widget.room == null) return;
    final mePath = me.path;
    final fallbackName = meUser.roomUserInfo.userName.isNotEmpty
        ? meUser.roomUserInfo.userName
        : 'Player';
    final settings =
        HotPotatoFirestoreSettings.fromRoomSnapshotData(room.snapshotData);
    final resolvedName =
        hotPotatoPathLabelForRoom(mePath, room, settings).trim();
    final initialName = resolvedName.isEmpty ? fallbackName : resolvedName;
    final initialAvatar = hotPotatoPathAvatarEmoji(
      mePath,
      settings,
      room,
    );
    final draft = await _showIdentityEditor(
      initialName: initialName,
      initialAvatar: initialAvatar,
    );
    if (draft == null) return;

    try {
      final fresh = await RoomRecord.getDocumentOnce(widget.room!);

      RoomUserListStruct patchUser(RoomUserListStruct src) {
        final copy = RoomUserListStruct.fromMap(src.toMap());
        if (src.roomUserRef?.path != mePath) return copy;
        final info = src.roomUserInfo;
        copy.roomUserInfo = createOrderUserMainInfoStruct(
          userEmail: info.hasUserEmail() ? info.userEmail : null,
          userId: info.hasUserId() ? info.userId : null,
          userName: draft.name,
          userPhone: info.hasUserPhone() ? info.userPhone : null,
          userRole: info.hasUserRole() ? info.userRole : null,
          clearUnsetFields: false,
        );
        copy.roomUserUpdatedTime = getCurrentTimestamp;
        return copy;
      }

      final roomUsers = fresh.roomUserList.map(patchUser).toList();
      final selectedGames = fresh.selectedGameList.map((g) {
        final copy = SelectedGameListStruct.fromMap(g.toMap());
        copy.selectedGameUserList =
            g.selectedGameUserList.map(patchUser).toList();
        return copy;
      }).toList();

      final rawProfiles = fresh.snapshotData['hot_potato_player_profiles'];
      final profiles = <String, dynamic>{};
      if (rawProfiles is Map) {
        profiles.addAll(Map<String, dynamic>.from(rawProfiles));
      }
      profiles[Uri.encodeComponent(mePath)] = {
        'name': draft.name,
        'avatar': draft.avatar,
        'updated_at': Timestamp.now(),
      };

      await fresh.reference.update({
        ...createRoomRecordData(roomUpdatedAt: getCurrentTimestamp),
        ...mapToFirestore({
          'room_user_list': getRoomUserListListFirestoreData(roomUsers),
          'selected_game_list': getSelectedGameListListFirestoreData(
            selectedGames,
          ),
          'hot_potato_player_profiles': profiles,
        }),
      });
      if (mounted) {
        safeSetState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save profile: $e')),
        );
      }
    }
  }

  /// Deducts entry fee from the signed-in user (or room wallet) like Game Five.
  /// Returns false if billing failed or should block starting.
  Future<bool> _chargeWalletForHotPotatoIfNeeded(
    BuildContext context,
    RoomRecord roomSnapshot,
  ) async {
    if (!loggedIn || currentUserReference == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be signed in to start.')),
        );
      }
      return false;
    }

    final stackRoomRecord =
        await RoomRecord.getDocumentOnce(roomSnapshot.reference);
    final liveRaw = stackRoomRecord.snapshotData['hot_potato_live'];
    if (liveRaw is Map && liveRaw['wallet_charged'] == true) {
      return true;
    }

    DocumentReference? gameRef =
        currentUserDocument?.presentRoomGameInfo.roomAdminSelectedGameRef;
    GameRecord? stackGameRecord;
    if (gameRef != null) {
      stackGameRecord = await GameRecord.getDocumentOnce(gameRef);
    } else {
      final gid = currentUserDocument?.presentRoomGameInfo.roomGameId ?? 0;
      if (gid != 0) {
        final games = await queryGameRecordOnce(
          queryBuilder: (g) => g.where('game_ID', isEqualTo: gid),
          singleRecord: true,
        );
        stackGameRecord = games.firstOrNull;
      }
    }

    if (stackGameRecord == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not resolve the selected game for billing.'),
          ),
        );
      }
      return false;
    }

    final cost = stackGameRecord.gamePoint;
    if (cost <= 0) {
      return true;
    }

    final soloOrPrivateWallet = stackRoomRecord.roomType == 'solo' ||
        stackRoomRecord.isRoomWalletStatus == false;

    final balance = soloOrPrivateWallet
        ? valueOrDefault(currentUserDocument?.walletPoint, 0)
        : stackRoomRecord.roomWalletTotalPoint;
    if (balance < cost) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              soloOrPrivateWallet
                  ? 'Not enough coins to start this game.'
                  : 'Room wallet does not have enough points for this game.',
            ),
          ),
        );
      }
      return false;
    }

    final idmapGameoneResult = await queryIDmapRecordOnce(
      queryBuilder: (iDmapRecord) =>
          iDmapRecord.where('type', isEqualTo: 'Main'),
      singleRecord: true,
    ).then((s) => s.firstOrNull);

    await WalletSpentRecord.collection.doc().set(
          createWalletSpentRecordData(
            createdAt: getCurrentTimestamp,
            updatedAt: getCurrentTimestamp,
            walletSpentID: idmapGameoneResult?.walletSpentId,
            walletSpentStatus: 'Deduct',
            walletSpentPoint: stackGameRecord.gamePoint,
            walletSpentRoomRef: stackRoomRecord.reference,
            walletSpentGameRef: stackGameRecord.reference,
            walletSpentUserRef: currentUserReference,
            walletSpentPrevPoint: soloOrPrivateWallet
                ? valueOrDefault(currentUserDocument?.walletPoint, 0)
                : stackRoomRecord.roomWalletTotalPoint,
            walletSpentPresentPoint: (soloOrPrivateWallet
                    ? valueOrDefault(currentUserDocument?.walletPoint, 0)
                    : stackRoomRecord.roomWalletTotalPoint) -
                stackGameRecord.gamePoint,
          ),
        );

    if (soloOrPrivateWallet) {
      await currentUserReference!.update(
        createUsersRecordData(
          walletPoint:
              valueOrDefault(currentUserDocument?.walletPoint, 0) - cost,
          walletSpent:
              valueOrDefault(currentUserDocument?.walletSpent, 0) + cost,
        ),
      );
    } else {
      await stackRoomRecord.reference.update(
        createRoomRecordData(
          roomWalletTotalPoint: stackRoomRecord.roomWalletTotalPoint - cost,
        ),
      );
    }

    if (idmapGameoneResult != null) {
      await idmapGameoneResult.reference.update({
        ...mapToFirestore(
          {
            'wallet_spent_id': FieldValue.increment(1),
          },
        ),
      });
    }

    return true;
  }

  Future<void> _startGame(
    RoomRecord roomRecord,
    List<RoomUserListStruct> activeUsers,
  ) async {
    if (widget.room == null) return;
    if (!_isRoomHost(roomRecord)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Only the room host can change settings and start the game.'),
          ),
        );
      }
      return;
    }
    final participantCount = activeUsers.length + _model.localBots.length;
    if (participantCount < 3 || participantCount > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Need between 3 and 10 players (including bots) to start.'),
        ),
      );
      return;
    }
    final paths = <String>[];
    for (final u in activeUsers) {
      if (u.roomUserStatus == 'active' && u.roomUserRef != null) {
        paths.add(u.roomUserRef!.path);
      }
    }
    for (final b in _model.localBots) {
      paths.add('bot:${b.localId}');
    }
    // Solo / edge cases: `room_user_list` can be out of sync with auth. The
    // signed-in starter must appear in `participant_paths` or the arena
    // ticker skips them and the CustomPaint can get zero-height layout on web.
    final mePath = currentUserReference?.path;
    if (mePath != null && !paths.contains(mePath) && paths.length < 10) {
      paths.add(mePath);
    }
    if (paths.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Need at least three participants with valid seats.'),
        ),
      );
      return;
    }
    final holderIndex = Random().nextInt(paths.length);
    final durationSec = (_model.roundMinutes * 60).clamp(60, 180);

    safeSetState(() => _model.isStarting = true);
    try {
      final walletFuture =
          _chargeWalletForHotPotatoIfNeeded(context, roomRecord);
      final walletOk = await walletFuture;
      if (!walletOk) {
        if (mounted) {
          safeSetState(() => _model.isStarting = false);
        }
        return;
      }

      final useEdge = hotPotatoEdgeAvailable();
      String? edgeHint;
      String? edgeWorkerUrl;
      String rtdbUrl = kHotPotatoDefaultRtdbDatabaseUrl;

      if (useEdge) {
        edgeHint = _model.selectedEdgeHint;
        if (edgeHint == null || edgeHint.isEmpty) {
          edgeHint = await probeBestHotPotatoEdgeHint();
        }
        edgeWorkerUrl = hotPotatoEdgeWorkerHttpBase();
      } else {
        final selectedRtdb = _model.selectedRtdbUrl;
        final useManualRtdb =
            selectedRtdb != null && selectedRtdb.trim().isNotEmpty;
        final rtdbFuture = useManualRtdb
            ? Future.value(hotPotatoEffectiveDatabaseUrl(selectedRtdb))
            : probeBestHotPotatoRtdbUrl();
        rtdbUrl = hotPotatoEffectiveDatabaseUrl(await rtdbFuture);
      }

      await widget.room!.update({
        'hot_potato_settings': {
          'round_minutes': _model.roundMinutes,
          'total_rounds': _model.totalRounds,
          'bot_difficulty': _model.botDifficulty,
          'powerups': kHotPotatoPowerupsEnabled
              ? _model.enabledPowerups.toList()
              : const <String>[],
          'bots': _model.localBots
              .map((b) => {
                    'name': b.name,
                    'avatar': b.avatarEmoji,
                    'local_id': b.localId,
                  })
              .toList(),
          'started_at': FieldValue.serverTimestamp(),
          'state': 'arena',
          'rtdb_url': rtdbUrl,
          'offline_bot_mode': useEdge ? false : _model.offlineBotMode,
          'edge_realtime': useEdge,
          if (useEdge) 'edge_location_hint': edgeHint,
          if (useEdge) 'edge_worker_url': edgeWorkerUrl,
        },
        'hot_potato_live': HotPotatoLiveFirestore.buildInitialLiveMap(
          participantPaths: paths,
          holderIndex: holderIndex,
          totalRounds: _model.totalRounds,
          roundDurationSec: durationSec,
          rtdbDatabaseUrl: rtdbUrl,
          walletCharged: true,
        ),
      });
      if (!useEdge) {
        await HotPotatoRtdbPositions.initializePassState(
          databaseUrl: rtdbUrl,
          roomId: widget.room!.id,
          holderPath: paths[holderIndex],
        );
      }
      if (mounted) {
        safeSetState(() {
          _model.isStarting = false;
        });
      }
    } catch (e) {
      if (mounted) {
        safeSetState(() => _model.isStarting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Start failed: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _model = createModel(context, () => GameSixModel());
    _refreshLobbyLatencyProbe();
    if (widget.room != null) {
      _rebindRoomStream();
    }
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {
          await actions.setOrientation();
        }(),
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void didUpdateWidget(covariant GameSixWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.room?.path != widget.room?.path) {
      _scheduledRematchForPath = null;
      _refreshLobbyLatencyProbe();
      if (widget.room != null) {
        _rebindRoomStream();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _model.dispose();
    super.dispose();
  }

  Future<void> _returnToHotPotatoSettings() async {
    if (widget.room == null) return;
    try {
      var rtdbUrl = kHotPotatoDefaultRtdbDatabaseUrl;
      try {
        final snap = await widget.room!.get();
        final d = snap.data();
        if (d is Map<String, dynamic>) {
          final hp = HotPotatoFirestoreSettings.fromRoomSnapshotData(d);
          rtdbUrl = hotPotatoEffectiveDatabaseUrl(hp.rtdbUrl);
          final live = HotPotatoLiveState.fromRoomSnapshotData(d);
          if (live?.rtdbDatabaseUrl != null) {
            rtdbUrl = hotPotatoEffectiveDatabaseUrl(live!.rtdbDatabaseUrl);
          }
        }
      } catch (_) {
        // Fall back to default RTDB URL.
      }
      await widget.room!.update({
        'hot_potato_settings.state': HotPotatoFirestoreSettings.stateSettings,
        'hot_potato_live': FieldValue.delete(),
      });
      // Drop any leftover RTDB positions from the previous arena.
      unawaited(HotPotatoRtdbPositions.clearRoom(widget.room!.id, rtdbUrl));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not return to settings: $e')),
        );
      }
    }
  }

  /// Single recovery action shown on the results screen: clear the finished
  /// match from the room, clear the current user's `presentRoomGameInfo` so
  /// the home redirect doesn't drag them back into this room, then go to
  /// Home. Kept intentionally minimal so the user can never get stuck in a
  /// "Play again" / "Back to settings" loop on a finished match.
  Future<void> _endMatchAndGoHome() async {
    await _returnToHotPotatoSettings();
    if (!mounted) return;
    await _leaveToHome();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.room == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Hot Potato')),
        body: const Center(child: Text('Missing room reference.')),
      );
    }

    return PopScope(
      canPop: false,
      child: StreamBuilder<RoomRecord>(
        stream: _roomStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              appBar: AppBar(title: const Text('Hot Potato')),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: FlutterFlowTheme.of(context).error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Could not load this room.',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodySmall,
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: _backOrHome,
                        child: const Text('Go back'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Loading room…',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          }

          final room = snapshot.data!;
          _maybeScheduleRematchFollow(room);
          final hp = HotPotatoFirestoreSettings.fromRoomSnapshotData(
            room.snapshotData,
          );
          final isHost = _isRoomHost(room);

          if (hp.isArena) {
            final live =
                HotPotatoLiveState.fromRoomSnapshotData(room.snapshotData);
            if (live == null) {
              return _HotPotatoArenaMissingLiveScaffold(
                scaffoldKey: scaffoldKey,
                isHost: isHost,
                onExit: _leaveToHome,
                onBackToSettings: _returnToHotPotatoSettings,
              );
            }
            return _HotPotatoArenaScaffold(
              scaffoldKey: scaffoldKey,
              settings: hp,
              room: room,
              live: live,
              isHost: isHost,
              rematchBusy: _model.isStarting,
              onExit: _leaveToHome,
              onBackToSettings: _returnToHotPotatoSettings,
              onReturnHome: _endMatchAndGoHome,
              onPlayAgainRematch: () => _hostPlayAgainRematch(room),
            );
          }

          final activeUsers = room.roomUserList
              .where((e) => e.roomUserStatus == 'active')
              .toList();
          final participantCount = activeUsers.length + _model.localBots.length;
          // Total rounds cannot exceed (players - 1) — at most every player
          // except the eventual winner is eliminated. Auto-clamp the host's
          // selection so they never start with an unreachable round count.
          final maxAllowedRounds =
              (participantCount - 1).clamp(1, 10);
          if (_model.totalRounds > maxAllowedRounds) {
            _model.totalRounds = maxAllowedRounds;
          }
          final lastUpdated = room.roomUpdatedAt != null
              ? dateTimeFormat(
                  'relative',
                  room.roomUpdatedAt,
                  locale: Localizations.localeOf(context).languageCode,
                )
              : '—';

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _SettingsCard(
                          room: room,
                          model: _model,
                          isHost: isHost,
                          offlineBotsEligible:
                              _hotPotatoOfflineBotsEligibleForActiveList(
                                  activeUsers),
                          useEdgeRealtime: hotPotatoEdgeAvailable(),
                          selectedRtdbUrl: _model.selectedRtdbUrl,
                          selectedEdgeHint: _model.selectedEdgeHint,
                          latencyFuture: _lobbyRtdbLatencyFuture,
                          edgeTopFuture: _lobbyEdgeTopFuture,
                          onSelectRtdbUrl: (url) => safeSetState(() {
                            _model.selectedRtdbUrl = url;
                          }),
                          onSelectEdgeHint: (hint) => safeSetState(() {
                            _model.selectedEdgeHint = hint;
                          }),
                          onRefreshLatencyProbe: () =>
                              safeSetState(_refreshLobbyLatencyProbe),
                          onChanged: () => safeSetState(() {}),
                          onStart: () => _startGame(room, activeUsers),
                          canStart: isHost &&
                              loggedIn &&
                              currentUserReference != null &&
                              participantCount >= 3 &&
                              participantCount <= 10 &&
                              !_model.isStarting,
                          participantCount: participantCount,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _PlayersCard(
                          room: room,
                          settings: hp,
                          canManageLobby: isHost,
                          activeUsers: activeUsers,
                          bots: _model.localBots,
                          lastUpdated: lastUpdated,
                          participantCount: participantCount,
                          onRefresh: () => safeSetState(_rebindRoomStream),
                          onAddBot: () {
                            safeSetState(_model.addRandomBot);
                          },
                          onExit: _leaveToHome,
                          onRemoveBot: (index) {
                            safeSetState(() => _model.removeBotAt(index));
                          },
                          onInvite: _sendInvite,
                          onRemoveStub: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Remove player — coming in next stage',
                                ),
                              ),
                            );
                          },
                          onEditSelf: (meUser) => _saveMyIdentity(room, meUser),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HotPotatoArenaMissingLiveScaffold extends StatelessWidget {
  const _HotPotatoArenaMissingLiveScaffold({
    required this.scaffoldKey,
    required this.isHost,
    required this.onExit,
    required this.onBackToSettings,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isHost;
  final Future<void> Function() onExit;
  final Future<void> Function() onBackToSettings;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.secondaryBackground,
        appBar: AppBar(
          backgroundColor: theme.primaryBackground,
          title: const Text('Hot Potato'),
          leading: TextButton.icon(
            onPressed: () => onBackToSettings(),
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: theme.primary),
            label: Text('Back',
                style: theme.titleSmall.override(color: theme.primary)),
          ),
          actions: [
            TextButton.icon(
              onPressed: onExit,
              icon: Icon(Icons.logout_rounded, size: 18, color: theme.error),
              label: Text('Exit',
                  style: theme.titleSmall.override(color: theme.error)),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cloud_off_outlined,
                    size: 56, color: theme.secondaryText),
                const SizedBox(height: 16),
                Text(
                  'Match data is missing for this room.',
                  textAlign: TextAlign.center,
                  style: theme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  isHost
                      ? 'Return to settings and start again, or exit to Home.'
                      : 'Ask the host to restart the match from settings.',
                  textAlign: TextAlign.center,
                  style: theme.bodySmall,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => onBackToSettings(),
                  child: const Text('Back to settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool _isRoomHost(RoomRecord room) {
  final hostRef = room.roomCreatedUserRef;
  final me = currentUserReference;
  if (me == null) {
    // Without a signed-in user ref, still allow local match driver (dev / edge flows).
    return true;
  }
  if (hostRef == null) {
    // No creator ref on room: allow any signed-in participant to drive round ticks.
    return true;
  }
  return hostRef.path == me.path;
}

class _HotPotatoArenaScaffold extends StatefulWidget {
  const _HotPotatoArenaScaffold({
    required this.scaffoldKey,
    required this.settings,
    required this.room,
    required this.live,
    required this.isHost,
    required this.rematchBusy,
    required this.onExit,
    required this.onBackToSettings,
    required this.onReturnHome,
    required this.onPlayAgainRematch,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final HotPotatoFirestoreSettings settings;
  final RoomRecord room;
  final HotPotatoLiveState live;
  final bool isHost;
  final bool rematchBusy;
  final Future<void> Function() onExit;
  final Future<void> Function() onBackToSettings;

  /// Used only by the results screen — clears live state and navigates Home.
  /// The active arena keeps `onBackToSettings` and `onExit` for in-match
  /// navigation; we deliberately do not expose `onReturnHome` mid-match.
  final Future<void> Function() onReturnHome;

  /// Host-only: creates a new room and signals clients on the results screen.
  final Future<void> Function() onPlayAgainRematch;

  @override
  State<_HotPotatoArenaScaffold> createState() =>
      _HotPotatoArenaScaffoldState();
}

class _HotPotatoArenaScaffoldState extends State<_HotPotatoArenaScaffold> {
  /// Wall clock when the local widget first observed [matchComplete] = true.
  /// While [_kGameOverBannerMs] hasn't elapsed yet we render the "Game Over"
  /// banner instead of jumping straight to the results page, so the player
  /// who got eliminated last (the round-end holder) is announced.
  DateTime? _matchEndedAt;
  static const int _kGameOverBannerMs = 2500;

  @override
  void didUpdateWidget(covariant _HotPotatoArenaScaffold old) {
    super.didUpdateWidget(old);
    if (widget.live.matchComplete && !old.live.matchComplete) {
      _matchEndedAt = DateTime.now();
      // Schedule a rebuild after the banner duration so the results page
      // shows up automatically without requiring user interaction.
      Future.delayed(const Duration(milliseconds: _kGameOverBannerMs), () {
        if (mounted) setState(() {});
      });
    }
  }

  Future<void> _confirmThen(
    Future<void> Function() action, {
    required String title,
    required String body,
    required String confirmLabel,
  }) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    if (ok == true && mounted) await action();
  }

  Future<void> _onBackToSettings() => _confirmThen(
        widget.onBackToSettings,
        title: 'Leave the arena?',
        body:
            'You will return to Hot Potato settings. Other players can keep playing.',
        confirmLabel: 'Leave',
      );

  Future<void> _onExitHome() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Exit to home?'),
        content: Text(
          widget.isHost && !widget.live.matchComplete
              ? 'As host, leaving will end the match for everyone and show final results.'
              : 'You will leave this screen. The room stays open unless you end it from settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;

    if (widget.isHost && !widget.live.matchComplete) {
      final me = currentUserReference?.path;
      if (me != null) {
        try {
          await HotPotatoLiveFirestore.hostAbandonMatchToResults(
            widget.room.reference,
            me,
          );
          return;
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not end match: $e')),
            );
          }
          return;
        }
      }
    }
    await widget.onExit();
  }

  void _onPopInvoked(bool didPop, Object? result) {
    if (didPop) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(_onBackToSettings());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final roundDuration =
        Duration(minutes: widget.settings.roundMinutes.clamp(1, 3));
    final roomRef = widget.room.reference;
    final live = widget.live;
    final canUsePowerup = currentUserReference != null &&
        live.participantPaths.contains(currentUserReference!.path) &&
        !live.matchComplete;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvoked,
      child: Scaffold(
        key: widget.scaffoldKey,
        backgroundColor: theme.secondaryBackground,
        body: SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: true,
          child: live.matchComplete
              ? () {
                  final since = _matchEndedAt;
                  final showGameOver = since != null &&
                      DateTime.now()
                              .difference(since)
                              .inMilliseconds <
                          _kGameOverBannerMs &&
                      live.eliminationOrder.isNotEmpty;
                  if (showGameOver) {
                    final eliminatedPath = live.eliminationOrder.last;
                    final eliminatedName = hotPotatoPathLabelForRoom(
                      eliminatedPath,
                      widget.room,
                      widget.settings,
                    );
                    return Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 360),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 22,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: theme.alternate, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 18,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Game Over',
                              textAlign: TextAlign.center,
                              style: theme.headlineSmall.override(
                                fontWeight: FontWeight.w800,
                                color: theme.error,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '$eliminatedName was eliminated',
                              textAlign: TextAlign.center,
                              style: theme.titleMedium.override(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Showing results…',
                              textAlign: TextAlign.center,
                              style: theme.labelSmall
                                  .override(color: theme.secondaryText),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.paddingOf(context).top + 8,
                      left: 12,
                      right: 12,
                      bottom: 8,
                    ),
                    child: _HotPotatoResultsBody(
                      room: widget.room,
                      settings: widget.settings,
                      live: live,
                      isHost: widget.isHost,
                      rematchBusy: widget.rematchBusy,
                      onReturnHome: widget.onReturnHome,
                      onPlayAgain:
                          widget.isHost ? widget.onPlayAgainRematch : null,
                    ),
                  );
                }()
              : HotPotatoPickupSpawnerScheduler(
                  roomRef: roomRef,
                  live: live,
                  isHost: widget.isHost,
                  settings: widget.settings,
                  child: SizedBox.expand(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: HotPotatoArenaWidget(
                            roomRef: roomRef,
                            room: widget.room,
                            settings: widget.settings,
                            isHost: widget.isHost,
                            onArenaBack: _onBackToSettings,
                            onArenaExit: _onExitHome,
                          ),
                        ),
                        // Drives the round timer + host advance ticks, no UI.
                        Offstage(
                          offstage: true,
                          child: HotpotatotimerWidget(
                            roomRef: roomRef,
                            live: live,
                            isHost: widget.isHost,
                            fallbackRoundDuration: roundDuration,
                            hideVisual: true,
                          ),
                        ),
                        // Power-up bar overlays inside the arena bottom-right.
                        // Hidden globally while [kHotPotatoPowerupsEnabled] is
                        // false — pickups don't spawn in this mode anyway, so
                        // showing an empty inventory is just visual noise.
                        if (kHotPotatoPowerupsEnabled)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Powerups1Widget(
                              allowedPowerups: widget.settings.orderedPowerups,
                              roomRef: roomRef,
                              live: live,
                              settings: widget.settings,
                              canUsePowerup: canUsePowerup,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _HotPotatoResultsBody extends StatefulWidget {
  const _HotPotatoResultsBody({
    required this.room,
    required this.settings,
    required this.live,
    required this.isHost,
    required this.rematchBusy,
    required this.onReturnHome,
    this.onPlayAgain,
  });

  final RoomRecord room;
  final HotPotatoFirestoreSettings settings;
  final HotPotatoLiveState live;
  final bool isHost;
  final bool rematchBusy;
  final Future<void> Function() onReturnHome;
  final Future<void> Function()? onPlayAgain;

  @override
  State<_HotPotatoResultsBody> createState() => _HotPotatoResultsBodyState();
}

class _HotPotatoResultsBodyState extends State<_HotPotatoResultsBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceCtrl;

  static const Color _teal = Color(0xFF5BB5B5);
  static const Color _gold = Color(0xFFFFBF3C);
  static const Color _goldDark = Color(0xFFE5A82E);
  static const Color _resultInk = Color(0xFF1F2933);
  static const Color _resultMuted = Color(0xFF6B7280);

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final winnerPath = widget.live.winnerPath;
    final winnerName = winnerPath != null
        ? hotPotatoPathLabelForRoom(winnerPath, widget.room, widget.settings)
        : '—';
    final winnerEmoji = winnerPath != null
        ? hotPotatoPathAvatarEmoji(winnerPath, widget.settings, widget.room)
        : '🥔';
    final isMeWinner = winnerPath != null &&
        currentUserReference != null &&
        winnerPath == currentUserReference!.path;
    final rank = widget.live.resultsRank.isNotEmpty
        ? widget.live.resultsRank
        : (winnerPath != null ? <String>[winnerPath] : <String>[]);

    final baseline = _hotPotatoResultsPointsBaseline(widget.room);
    int pointsForPlacement(int index0) {
      if (rank.isEmpty) return 0;
      return _hotPotatoResultsPointsForRank(
        rankIndex0: index0,
        totalPlayers: rank.length,
        baselinePoints: baseline,
      );
    }

    final winnerPoints = () {
      if (winnerPath == null || rank.isEmpty) return baseline;
      final ix = rank.indexOf(winnerPath);
      if (ix < 0) return baseline;
      return pointsForPlacement(ix);
    }();

    Widget winnerColumn() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 18,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AnimatedBuilder(
              animation: _bounceCtrl,
              builder: (context, child) {
                final t = Curves.easeInOut.transform(_bounceCtrl.value);
                return Transform.translate(
                  offset: Offset(0, -8 * t),
                  child: child,
                );
              },
              child: Column(
                children: [
                  const Text('👑', style: TextStyle(fontSize: 36)),
                  const SizedBox(height: 4),
                  Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _teal.withValues(alpha: 0.10),
                      border: Border.all(color: _teal, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: _teal.withValues(alpha: 0.30),
                          blurRadius: 22,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      winnerEmoji,
                      style: const TextStyle(fontSize: 42),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              winnerName,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.headlineSmall.override(
                fontWeight: FontWeight.w700,
                fontSize: 38,
                color: _resultInk,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Winner • $winnerPoints pts',
              textAlign: TextAlign.center,
              style: theme.bodyMedium.override(
                fontSize: 13,
                color: _resultMuted,
              ),
            ),
            if (isMeWinner) ...[
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _gold.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🎉', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 8),
                    Text(
                      "That's you! Congratulations!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _goldDark,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const Spacer(),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: FilledButton.tonal(
                    onPressed: widget.rematchBusy
                        ? null
                        : () => unawaited(widget.onReturnHome()),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(42),
                    ),
                    child: const Icon(Icons.home_rounded, size: 20),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 5,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: _teal,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(42),
                      disabledBackgroundColor: _teal.withValues(alpha: 0.45),
                      disabledForegroundColor: _resultInk.withValues(alpha: 0.72),
                    ),
                    onPressed: (widget.rematchBusy ||
                            widget.onPlayAgain == null ||
                            !widget.isHost)
                        ? null
                        : () => unawaited(widget.onPlayAgain!()),
                    child: widget.rematchBusy
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            widget.isHost && widget.onPlayAgain != null
                                ? 'Play again'
                                : 'Waiting host',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            if (widget.isHost && widget.onPlayAgain != null) ...[
              const SizedBox(height: 8),
              Text(
                'Others auto-jump to the new room.',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.labelSmall.override(color: _resultMuted),
              ),
            ],
          ],
        ),
      );
    }

    Widget scoresColumn() {
      return Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scores',
              style: theme.titleLarge.override(
                fontWeight: FontWeight.w800,
                fontSize: 30,
                color: _resultInk,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: rank.isEmpty
                  ? Center(
                      child: Text(
                        'No scores yet',
                        style: theme.bodyMedium.override(color: _resultMuted),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 6),
                      itemCount: rank.length,
                      itemBuilder: (context, i) => _StandingRow(
                        rank: i + 1,
                        room: widget.room,
                        playerPath: rank[i],
                        name: hotPotatoPathLabelForRoom(
                          rank[i],
                          widget.room,
                          widget.settings,
                        ),
                        emoji: hotPotatoPathAvatarEmoji(
                          rank[i],
                          widget.settings,
                          widget.room,
                        ),
                        points: pointsForPlacement(i),
                        isMe: currentUserReference != null &&
                            rank[i] == currentUserReference!.path,
                      ),
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                    ),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, c) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: c.maxWidth >= 760 ? 5 : 4,
              child: winnerColumn(),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: c.maxWidth >= 760 ? 6 : 7,
              child: scoresColumn(),
            ),
          ],
        );
      },
    );
  }
}

class _StandingRow extends StatelessWidget {
  const _StandingRow({
    required this.rank,
    required this.room,
    required this.playerPath,
    required this.name,
    required this.emoji,
    required this.points,
    required this.isMe,
  });

  final int rank;
  final RoomRecord room;
  final String playerPath;
  final String name;
  final String emoji;
  final int points;
  final bool isMe;

  String _idChip() {
    if (playerPath.startsWith('bot:')) return 'BOT';
    for (final u in room.roomUserList) {
      if (u.roomUserRef?.path == playerPath) {
        final id = u.roomUserId;
        if (id != 0) return '$id';
      }
    }
    final parts = playerPath.split('/');
    final tail = parts.isNotEmpty ? parts.last : playerPath;
    if (tail.length <= 6) return tail;
    return tail.substring(tail.length - 6);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    String? medal;
    if (rank == 1) medal = '🥇';
    if (rank == 2) medal = '🥈';
    if (rank == 3) medal = '🥉';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isMe
            ? const Color(0xFF5BB5B5).withValues(alpha: 0.10)
            : theme.alternate.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
        border: isMe
            ? Border.all(color: const Color(0xFF5BB5B5), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (medal != null) ...[
                      Text(medal, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                    ] else ...[
                      Text(
                        '#$rank',
                        style: theme.labelMedium.override(
                          fontWeight: FontWeight.w700,
                          color: _HotPotatoResultsBodyState._resultMuted,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: theme.titleSmall.override(
                          fontWeight: FontWeight.w700,
                          color: _HotPotatoResultsBodyState._resultInk,
                        ),
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 8),
                      const Text(
                        '(You)',
                        style: TextStyle(
                          color: Color(0xFF5BB5B5),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  _idChip(),
                  style: theme.labelSmall.override(
                    color: _HotPotatoResultsBodyState._resultMuted,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '+ $points',
            style: theme.titleSmall.override(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF5BB5B5),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact three-up selector for bot difficulty (easy / medium / hard).
class _BotDifficultyPicker extends StatelessWidget {
  const _BotDifficultyPicker({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  static const _options = <_DiffOpt>[
    _DiffOpt('easy', 'Easy', Color(0xFF2ECC71)),
    _DiffOpt('medium', 'Medium', Color(0xFFF39C12)),
    _DiffOpt('hard', 'Hard', Color(0xFFE74C3C)),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Row(
      children: _options.map((opt) {
        final selected = value == opt.id;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onChanged(opt.id),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 28,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: selected ? opt.color : theme.primaryBackground,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected ? opt.color : theme.alternate,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    opt.label,
                    style: TextStyle(
                      color: selected ? Colors.white : theme.primaryText,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _DiffOpt {
  const _DiffOpt(this.id, this.label, this.color);
  final String id;
  final String label;
  final Color color;
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.room,
    required this.model,
    required this.isHost,
    required this.offlineBotsEligible,
    required this.useEdgeRealtime,
    required this.selectedRtdbUrl,
    required this.selectedEdgeHint,
    required this.latencyFuture,
    required this.edgeTopFuture,
    required this.onSelectRtdbUrl,
    required this.onSelectEdgeHint,
    required this.onRefreshLatencyProbe,
    required this.onChanged,
    required this.onStart,
    required this.canStart,
    required this.participantCount,
  });

  final RoomRecord room;
  final GameSixModel model;
  final bool isHost;
  final bool offlineBotsEligible;
  final bool useEdgeRealtime;
  final String? selectedRtdbUrl;
  final String? selectedEdgeHint;
  final Future<Map<String, int>>? latencyFuture;
  final Future<List<HotPotatoEdgeHintRanked>>? edgeTopFuture;
  final ValueChanged<String?> onSelectRtdbUrl;
  final ValueChanged<String?> onSelectEdgeHint;
  final VoidCallback onRefreshLatencyProbe;
  final VoidCallback onChanged;
  final VoidCallback onStart;
  final bool canStart;
  final int participantCount;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final gameId = _resolvedJoinScanSelectedGameId(room);
    final joinReady = room.roomCode != 0 && gameId != 0;
    final scan = joinReady
        ? HotPotatoQrJoin.encodeScanPayload(
            roomCode: room.roomCode,
            selectedGameId: gameId,
          )
        : '';
    final selectedNorm = selectedRtdbUrl == null || selectedRtdbUrl!.isEmpty
        ? null
        : normalizeHotPotatoDatabaseUrl(selectedRtdbUrl!);

    return _CardShell(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ─── Region row ──────────────────────────────────────────
                  _SectionLabel(
                    label: 'Server',
                    trailing: IconButton(
                      tooltip: 'Refresh latency',
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints(
                          minWidth: 24, minHeight: 24),
                      onPressed: isHost ? onRefreshLatencyProbe : null,
                      icon: Icon(
                        Icons.refresh_rounded,
                        size: 16,
                        color: theme.secondaryText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (useEdgeRealtime)
                    FutureBuilder<List<HotPotatoEdgeHintRanked>>(
                      future: edgeTopFuture,
                      builder: (context, snap) {
                        final top = snap.data ?? const [];
                        final autoBestMs = top.isNotEmpty
                            ? top.first.latencyMs
                            : null;
                        return Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          alignment: WrapAlignment.start,
                          children: [
                            _RegionChip(
                              code: 'AUTO',
                              ms: autoBestMs,
                              selected: selectedEdgeHint == null ||
                                  selectedEdgeHint!.isEmpty,
                              onTap: isHost
                                  ? () => onSelectEdgeHint(null)
                                  : null,
                            ),
                            for (final r in top)
                              _RegionChip(
                                code: r.shortLabel,
                                ms: r.latencyMs,
                                tooltip: r.hint.label,
                                selected: selectedEdgeHint == r.hint.id,
                                onTap: isHost
                                    ? () => onSelectEdgeHint(r.hint.id)
                                    : null,
                              ),
                          ],
                        );
                      },
                    )
                  else
                    FutureBuilder<Map<String, int>>(
                      future: latencyFuture,
                      builder: (context, snap) {
                        final lat = snap.data ?? const <String, int>{};
                        return Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          alignment: WrapAlignment.start,
                          children: [
                            _RegionChip(
                              code: 'AUTO',
                              ms: null,
                              selected: selectedNorm == null,
                              onTap: isHost
                                  ? () => onSelectRtdbUrl(null)
                                  : null,
                            ),
                            for (final c in kHotPotatoRtdbCandidates)
                              () {
                                final norm = normalizeHotPotatoDatabaseUrl(
                                    c.databaseUrl);
                                final ms = lat[norm];
                                final region = hotPotatoRtdbHudRegionLabel(
                                    c.databaseUrl);
                                return _RegionChip(
                                  code: region,
                                  ms: (ms == null || ms >= (1 << 30))
                                      ? null
                                      : ms,
                                  selected: selectedNorm == norm,
                                  onTap: isHost
                                      ? () =>
                                          onSelectRtdbUrl(c.databaseUrl)
                                      : null,
                                );
                              }(),
                          ],
                        );
                      },
                    ),
                  if (!isHost) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Only the host can change settings.',
                      textAlign: TextAlign.center,
                      style:
                          theme.labelSmall.override(color: theme.error),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const _SectionDivider(),

                  // ─── Round time / Total rounds ───────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _SectionLabel(label: 'Round time'),
                            const SizedBox(height: 4),
                            MinutesWidget(
                              value: model.roundMinutes,
                              dense: true,
                              onChanged: (v) {
                                if (!isHost) return;
                                model.roundMinutes = v;
                                onChanged();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _SectionLabel(label: 'Total rounds'),
                            const SizedBox(height: 4),
                            RoundsWidget(
                              value: model.totalRounds,
                              dense: true,
                              maxRounds:
                                  (participantCount - 1).clamp(1, 10),
                              onChanged: (v) {
                                if (!isHost) return;
                                model.totalRounds = v;
                                onChanged();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const _SectionDivider(),

                  // ─── Bot difficulty ──────────────────────────────────────
                  const _SectionLabel(label: 'Bot difficulty'),
                  const SizedBox(height: 4),
                  _BotDifficultyPicker(
                    value: model.botDifficulty,
                    onChanged: (v) {
                      if (!isHost) return;
                      model.botDifficulty = v;
                      onChanged();
                    },
                  ),

                  if (kHotPotatoPowerupsEnabled) ...[
                    const _SectionDivider(),
                    const _SectionLabel(label: 'Power-ups'),
                    const SizedBox(height: 4),
                    PowerupsWidget(
                      selected: model.enabledPowerups,
                      onToggle: (id) {
                        if (!isHost) return;
                        model.togglePowerup(id);
                        onChanged();
                      },
                    ),
                  ],

                  // ─── Room code ───────────────────────────────────────────
                  if (joinReady) ...[
                    const _SectionDivider(),
                    const _SectionLabel(label: 'Room code'),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
                      decoration: BoxDecoration(
                        color: theme.primaryBackground,
                        borderRadius: BorderRadius.circular(14),
                        border:
                            Border.all(color: theme.alternate, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              HotPotatoQrJoin.formatRoomCodeForDisplay(
                                  room.roomCode),
                              style: theme.headlineSmall.override(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 4,
                                fontFamily: 'Courier',
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Copy join code',
                            visualDensity: VisualDensity.compact,
                            onPressed: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: scan));
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Join code copied.')),
                                );
                              }
                            },
                            icon: Icon(Icons.copy_rounded,
                                size: 20, color: theme.primary),
                          ),
                        ],
                      ),
                    ),
                  ] else
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Open Hot Potato from the game grid so this room has a game id.',
                        style: theme.labelSmall
                            .override(color: theme.secondaryText),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  // ─── Offline bot toggle ──────────────────────────────────
                  if (offlineBotsEligible || model.offlineBotMode) ...[
                    const SizedBox(height: 4),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        'Offline bot movement',
                        style: theme.labelLarge
                            .override(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        !isHost
                            ? 'Host-only setting'
                            : offlineBotsEligible
                                ? 'Bots move on-device only. Passes still sync.'
                                : 'Only when you are the sole human in active seats.',
                        style: theme.labelSmall
                            .override(color: theme.secondaryText),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: offlineBotsEligible && model.offlineBotMode,
                      onChanged: offlineBotsEligible && isHost
                          ? (v) {
                              model.offlineBotMode = v;
                              onChanged();
                            }
                          : null,
                    ),
                  ],
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          // ─── Start CTA ───────────────────────────────────────────────────
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: (canStart && isHost)
                  ? [
                      BoxShadow(
                        color: theme.primary.withValues(alpha: 0.28),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : const [],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 42,
              child: FilledButton(
                onPressed: (canStart && isHost) ? onStart : null,
                style: FilledButton.styleFrom(
                  backgroundColor: theme.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      theme.alternate.withValues(alpha: 0.7),
                  disabledForegroundColor:
                      theme.secondaryText.withValues(alpha: 0.85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 0.3,
                  ),
                ),
                child: model.isStarting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(isHost ? 'Start Game' : 'Waiting for host'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small uppercase section label used throughout the redesigned lobby.
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, this.trailing});

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final text = Text(
      label.toUpperCase(),
      style: TextStyle(
        color: theme.secondaryText,
        fontSize: 9,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
        height: 1.0,
      ),
    );
    if (trailing == null) return text;
    return Row(
      children: [
        Expanded(child: text),
        trailing!,
      ],
    );
  }
}

/// Hairline horizontal rule between settings sections.
class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(
        height: 1,
        thickness: 1,
        color: theme.alternate.withValues(alpha: 0.5),
      ),
    );
  }
}

/// Uniform two-line region chip: 3-char code on top, latency below.
/// Selected = primary fill, white text. Idle = cream + alternate border.
class _RegionChip extends StatelessWidget {
  const _RegionChip({
    required this.code,
    required this.ms,
    required this.selected,
    required this.onTap,
    this.tooltip,
  });

  final String code;
  final int? ms;
  final bool selected;
  final VoidCallback? onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final disabled = onTap == null;
    final bg = selected ? theme.primary : theme.primaryBackground;
    final fg = selected ? Colors.white : theme.primaryText;
    final sub = selected
        ? Colors.white.withValues(alpha: 0.85)
        : theme.secondaryText;
    final chip = Opacity(
      opacity: disabled ? 0.6 : 1.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 50,
            height: 42,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected ? theme.primary : theme.alternate,
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  code,
                  style: TextStyle(
                    color: fg,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  ms == null ? '— ms' : '${ms}ms',
                  style: TextStyle(
                    color: sub,
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (tooltip != null) return Tooltip(message: tooltip!, child: chip);
    return chip;
  }
}

class _PlayersCard extends StatelessWidget {
  const _PlayersCard({
    required this.room,
    required this.settings,
    required this.canManageLobby,
    required this.activeUsers,
    required this.bots,
    required this.lastUpdated,
    required this.participantCount,
    required this.onRefresh,
    required this.onAddBot,
    required this.onExit,
    required this.onRemoveBot,
    required this.onInvite,
    required this.onRemoveStub,
    required this.onEditSelf,
  });

  final RoomRecord room;
  final HotPotatoFirestoreSettings settings;
  final bool canManageLobby;
  final List<RoomUserListStruct> activeUsers;
  final List<HotPotatoBot> bots;
  final String lastUpdated;
  final int participantCount;
  final VoidCallback onRefresh;
  final VoidCallback onAddBot;
  final VoidCallback onExit;
  final void Function(int index) onRemoveBot;
  final Future<void> Function(DocumentReference ref, String name) onInvite;
  final VoidCallback onRemoveStub;
  final Future<void> Function(RoomUserListStruct user) onEditSelf;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return _CardShell(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Players',
                      style: theme.titleSmall
                          .override(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '$participantCount/12 · $lastUpdated',
                      style:
                          theme.labelSmall.override(color: theme.secondaryText),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Refresh',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh_rounded, size: 22),
              ),
              IconButton(
                tooltip: 'Add Bot',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                onPressed: canManageLobby ? onAddBot : null,
                icon: const Icon(Icons.smart_toy_outlined, size: 22),
              ),
              const SizedBox(width: 8),
              IconButton(
                tooltip: 'Exit lobby',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                onPressed: onExit,
                icon: Icon(
                  Icons.logout_rounded,
                  size: 22,
                  color: theme.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ...activeUsers.map(
                  (u) => _HumanPlayerTile(
                    room: room,
                    settings: settings,
                    user: u,
                    onInvite: onInvite,
                    onRemoveStub: onRemoveStub,
                    onEditSelf: onEditSelf,
                  ),
                ),
                ...bots.asMap().entries.map(
                      (e) => _BotPlayerTile(
                        bot: e.value,
                        onRemove:
                            canManageLobby ? () => onRemoveBot(e.key) : null,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Material(
      color: theme.primaryBackground,
      elevation: 2,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class _HumanPlayerTile extends StatelessWidget {
  const _HumanPlayerTile({
    required this.room,
    required this.settings,
    required this.user,
    required this.onInvite,
    required this.onRemoveStub,
    required this.onEditSelf,
  });

  final RoomRecord room;
  final HotPotatoFirestoreSettings settings;
  final RoomUserListStruct user;
  final Future<void> Function(DocumentReference ref, String name) onInvite;
  final VoidCallback onRemoveStub;
  final Future<void> Function(RoomUserListStruct user) onEditSelf;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final path = user.roomUserRef?.path;
    final name = path != null
        ? hotPotatoPathLabelForRoom(path, room, settings)
        : (user.roomUserInfo.userName.isNotEmpty
            ? user.roomUserInfo.userName
            : 'Player');
    final idStr = user.roomUserId.toString();
    final isSelf = user.roomUserRef == currentUserReference;
    final avatar = path != null
        ? hotPotatoPathAvatarEmoji(path, settings, room)
        : (name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?');

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: theme.alternate,
            child: Text(
              avatar,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: theme.bodyMedium.override(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isSelf) ...[
                      const SizedBox(width: 6),
                      Icon(Icons.star_rounded, size: 16, color: theme.error),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'You',
                          style: theme.labelSmall.override(
                            color: theme.primary,
                          ),
                        ),
                      ),
                    ],
                    if (isSelf) ...[
                      const SizedBox(width: 6),
                      IconButton(
                        tooltip: 'Edit name/avatar',
                        padding: EdgeInsets.zero,
                        constraints:
                            const BoxConstraints(minWidth: 28, minHeight: 28),
                        onPressed: () => unawaited(onEditSelf(user)),
                        icon: Icon(
                          Icons.edit_rounded,
                          size: 16,
                          color: theme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  'ID: $idStr',
                  style: theme.labelSmall,
                ),
              ],
            ),
          ),
          if (!isSelf && user.roomUserRef != null)
            OutlinedButton(
              onPressed: () => onInvite(user.roomUserRef!, name),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.error,
                side: BorderSide(color: theme.error),
              ),
              child: const Text('Invite'),
            ),
          if (!isSelf && user.roomUserRef != null) ...[
            const SizedBox(width: 4),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert_rounded, color: theme.secondaryText),
              onSelected: (v) {
                if (v == 'remove') onRemoveStub();
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'remove',
                  child: Text('Remove'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _BotPlayerTile extends StatelessWidget {
  const _BotPlayerTile({
    required this.bot,
    required this.onRemove,
  });

  final HotPotatoBot bot;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: theme.alternate,
            child: Text(bot.avatarEmoji, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        bot.name,
                        style: theme.bodyMedium.override(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: theme.alternate,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Bot',
                        style: theme.labelSmall,
                      ),
                    ),
                  ],
                ),
                Text(
                  'bot-${bot.localId}',
                  style: theme.labelSmall,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Remove bot',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            onPressed: onRemove,
            icon: Icon(Icons.close_rounded, size: 20, color: theme.error),
          ),
        ],
      ),
    );
  }
}
