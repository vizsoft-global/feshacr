import '/flutter_flow/flutter_flow_util.dart';

/// **Hot Potato / Home QR join contract** (plan §E).
///
/// **Scan payload (plain text in QR, not a URL):** `"<room_code> <selected_game_ID>"`
/// — one ASCII space between integers. This matches [functions.str2split] in
/// [HomeQRWidget] (`lib/feshah_game_zone/main/home_q_r/home_q_r_widget.dart`), which
/// splits on spaces and parses `first` as room code and `last` as selected game id.
///
/// After scan, the app resolves `room` via `room_code` + `active`, then routes to
/// Game Six when `gameId == [hotPotatoGameFirestoreId]` (`GameSixWidget`).
///
/// **Deep link (web / share):** same query parameter shape as `go_router`:
/// `/GameSix?room=<serializedDocumentReference>`.
/// Serialize with [serializeParam] + [ParamType.DocumentReference].
abstract final class HotPotatoQrJoin {
  /// Same as `widget.game?.gameID` for Hot Potato on the game grid (`game_grid_widget`).
  static const int hotPotatoGameFirestoreId = 1005;

  static const String gameSixRoutePath = '/GameSix';

  /// QR / clipboard text guests scan (space-separated).
  static String encodeScanPayload({
    required int roomCode,
    required int selectedGameId,
  }) =>
      '$roomCode $selectedGameId';

  /// Human-friendly room code (6 digits). Scan payload still uses raw ints.
  static String formatRoomCodeForDisplay(int roomCode) {
    if (roomCode <= 0) return '------';
    if (roomCode < 1000000) {
      return roomCode.toString().padLeft(6, '0');
    }
    return roomCode.toString();
  }

  /// Inverse of [encodeScanPayload]; returns null if not two integers.
  static ({int roomCode, int selectedGameId})? tryParseScanPayload(String raw) {
    final parts = raw.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return null;
    final rc = int.tryParse(parts.first);
    final gid = int.tryParse(parts.last);
    if (rc == null || gid == null) return null;
    return (roomCode: rc, selectedGameId: gid);
  }

  /// Path + query for Game Six (leading `/`); prefix with your web origin for a full URI.
  static String gameSixLocationQuery(DocumentReference roomRef) {
    final enc = serializeParam(
      roomRef,
      ParamType.DocumentReference,
      isList: false,
    );
    return '$gameSixRoutePath?room=$enc';
  }
}
