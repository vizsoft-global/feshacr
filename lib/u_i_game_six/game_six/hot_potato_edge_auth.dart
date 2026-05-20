import 'package:cloud_functions/cloud_functions.dart';

import '/backend/cloud_functions/cloud_functions.dart';

class HotPotatoEdgeToken {
  const HotPotatoEdgeToken({
    required this.token,
    required this.roomId,
    required this.edgeLocationHint,
    required this.workerUrl,
  });

  final String token;
  final String roomId;
  final String edgeLocationHint;
  final String workerUrl;
}

/// Mint a short-lived JWT via Firebase Callable `getHotPotatoEdgeToken`.
Future<HotPotatoEdgeToken?> fetchHotPotatoEdgeToken({
  required String roomId,
  required String participantPath,
}) async {
  try {
    final map = await makeCloudCall(
      'getHotPotatoEdgeToken',
      {
        'roomId': roomId,
        'participantPath': participantPath,
      },
    );
    if (map.isEmpty) return null;
    final token = map['token']?.toString();
    if (token == null || token.isEmpty) return null;
    return HotPotatoEdgeToken(
      token: token,
      roomId: map['roomId']?.toString() ?? roomId,
      edgeLocationHint: map['edgeLocationHint']?.toString() ?? 'apac',
      workerUrl: map['workerUrl']?.toString() ?? '',
    );
  } on FirebaseFunctionsException {
    return null;
  } catch (_) {
    return null;
  }
}
