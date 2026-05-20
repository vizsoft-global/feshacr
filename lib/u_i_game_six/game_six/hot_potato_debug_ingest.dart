import 'dart:convert';
import 'dart:io';

/// Debug-mode NDJSON sink for Cursor agent (session `e2033a`).
class HotPotatoDebugIngest {
  HotPotatoDebugIngest._();

  static const String _path =
      '/Users/wb/Desktop/feshah/.cursor/debug-e2033a.log';
  static const String _session = 'e2033a';

  static void log({
    required String hypothesisId,
    required String location,
    required String message,
    Map<String, Object?> data = const {},
  }) {
    try {
      final m = <String, Object?>{
        'sessionId': _session,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'hypothesisId': hypothesisId,
        'location': location,
        'message': message,
        'data': data,
      };
      File(_path).writeAsStringSync(
        '${jsonEncode(m)}\n',
        mode: FileMode.append,
        flush: true,
      );
    } catch (_) {}
  }
}
