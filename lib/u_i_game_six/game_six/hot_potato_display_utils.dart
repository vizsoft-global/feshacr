import '/backend/backend.dart';
import 'hot_potato_settings_parser.dart';

/// Stable emoji pool used for human players who don't have a bot avatar set.
const List<String> _humanAvatarPool = [
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
  '🦁',
  '🐸',
  '🦄',
  '🐻',
  '🐨',
  '🐯',
  '🐮',
  '🐷',
  '🐧',
  '🐢',
  '🦒',
  '🦓',
  '🦔',
  '🐌',
];

Map<String, dynamic> _playerProfiles(RoomRecord room) {
  final raw = room.snapshotData['hot_potato_player_profiles'];
  if (raw is! Map) return const {};
  return Map<String, dynamic>.from(raw);
}

Map<String, dynamic>? _profileEntryForPath(String path, RoomRecord room) {
  final p = _playerProfiles(room);
  if (p.isEmpty) return null;
  final direct = p[path];
  if (direct is Map) return Map<String, dynamic>.from(direct);
  final encoded = p[Uri.encodeComponent(path)];
  if (encoded is Map) return Map<String, dynamic>.from(encoded);
  return null;
}

/// Shared display name for a participant path (user ref path or `bot:id`).
String hotPotatoPathLabelForRoom(
  String path,
  RoomRecord room,
  HotPotatoFirestoreSettings settings,
) {
  if (path.isEmpty) return '—';
  if (path.startsWith('bot:')) {
    final id = int.tryParse(path.substring(4)) ?? -1;
    for (final b in settings.bots) {
      if (b.localId == id) return b.name;
    }
    return 'Bot';
  }
  final profile = _profileEntryForPath(path, room);
  final overrideName = profile?['name']?.toString().trim() ?? '';
  if (overrideName.isNotEmpty) return overrideName;
  for (final u in room.roomUserList) {
    if (u.roomUserRef?.path == path) {
      final n = u.roomUserInfo.userName;
      return n.isNotEmpty ? n : 'Player';
    }
  }
  return path.split('/').last;
}

/// Emoji avatar for a participant path. Bots use the avatar from settings; humans
/// get a stable emoji derived from the deterministic hash of their user-ref path.
String hotPotatoPathAvatarEmoji(
  String path,
  HotPotatoFirestoreSettings settings,
  RoomRecord? room,
) {
  if (path.isEmpty) return '❓';
  if (path.startsWith('bot:')) {
    final id = int.tryParse(path.substring(4)) ?? -1;
    for (final b in settings.bots) {
      if (b.localId == id) return b.avatarEmoji;
    }
    return '🤖';
  }
  if (room != null) {
    final profile = _profileEntryForPath(path, room);
    final avatar = profile?['avatar']?.toString().trim() ?? '';
    if (avatar.isNotEmpty) return avatar;
  }
  final h =
      path.codeUnits.fold<int>(0, (acc, c) => (acc * 31 + c) & 0x7fffffff);
  return _humanAvatarPool[h % _humanAvatarPool.length];
}
