import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';

import '/backend/cloud_functions/cloud_functions.dart';

/// Edge + RTDB Hot Potato: LiveKit Cloud voice for humans in the arena.
/// Tokens come from Firebase Callable [getLiveKitVoiceToken].
enum HotPotatoVoiceConnectionState {
  idle,
  connecting,
  connected,
  error,
}

class HotPotatoVoiceSession extends ChangeNotifier {
  Room? _room;
  HotPotatoVoiceConnectionState _state = HotPotatoVoiceConnectionState.idle;
  String? _errorMessage;
  bool _micEnabled = true;

  HotPotatoVoiceConnectionState get connectionState => _state;
  String? get errorMessage => _errorMessage;

  /// When connected, false means the local mic track is disabled (others cannot hear you).
  bool get micEnabled => _micEnabled;

  bool get isConnected => _state == HotPotatoVoiceConnectionState.connected;

  /// Start LiveKit room + publish microphone (after OS permission). No-op on web.
  Future<void> connect({
    required String roomId,
    required String participantPath,
  }) async {
    if (kIsWeb) {
      _errorMessage = 'Voice chat is not available in the web build.';
      _state = HotPotatoVoiceConnectionState.error;
      notifyListeners();
      return;
    }
    if (_state == HotPotatoVoiceConnectionState.connecting) return;

    _state = HotPotatoVoiceConnectionState.connecting;
    _errorMessage = null;
    notifyListeners();

    final mic = await Permission.microphone.request();
    if (!mic.isGranted) {
      _errorMessage = 'Microphone permission is required for voice chat.';
      _state = HotPotatoVoiceConnectionState.error;
      notifyListeners();
      return;
    }

    try {
      final session = await AudioSession.instance;
      await session.configure(
        AudioSessionConfiguration(
          avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
          avAudioSessionCategoryOptions:
              AVAudioSessionCategoryOptions.defaultToSpeaker |
                  AVAudioSessionCategoryOptions.allowBluetooth,
          avAudioSessionMode: AVAudioSessionMode.voiceChat,
          androidAudioAttributes: const AndroidAudioAttributes(
            contentType: AndroidAudioContentType.speech,
            usage: AndroidAudioUsage.voiceCommunication,
          ),
          androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
          androidWillPauseWhenDucked: true,
        ),
      );

      final map = await makeCloudCall('getLiveKitVoiceToken', {
        'roomId': roomId,
        'participantPath': participantPath,
      });
      final url = map['url']?.toString() ?? '';
      final token = map['token']?.toString() ?? '';
      if (url.isEmpty || token.isEmpty) {
        _errorMessage = 'Could not get voice token from server.';
        _state = HotPotatoVoiceConnectionState.error;
        notifyListeners();
        return;
      }

      _room = Room();
      await _room!.connect(url, token);
      _micEnabled = true;
      await _room!.localParticipant?.setMicrophoneEnabled(true);
      _state = HotPotatoVoiceConnectionState.connected;
      notifyListeners();
    } catch (e, st) {
      debugPrint('HotPotatoVoiceSession connect error: $e $st');
      await _tearDownRoom();
      _errorMessage = 'Voice connection failed.';
      _state = HotPotatoVoiceConnectionState.error;
      notifyListeners();
    }
  }

  Future<void> setMicEnabled(bool enabled) async {
    _micEnabled = enabled;
    await _room?.localParticipant?.setMicrophoneEnabled(enabled);
    notifyListeners();
  }

  Future<void> toggleMic() => setMicEnabled(!_micEnabled);

  Future<void> disconnect() async {
    await _tearDownRoom();
    await _restoreIdleAudioSession();
    _state = HotPotatoVoiceConnectionState.idle;
    _errorMessage = null;
    _micEnabled = true;
    notifyListeners();
  }

  Future<void> _tearDownRoom() async {
    final r = _room;
    _room = null;
    if (r != null) {
      try {
        await r.disconnect();
      } catch (_) {}
    }
  }

  Future<void> _restoreIdleAudioSession() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
    } catch (_) {}
  }

  @override
  void dispose() {
    unawaited(() async {
      await _tearDownRoom();
      await _restoreIdleAudioSession();
    }());
    super.dispose();
  }
}

/// Compact mic / connect control for the arena HUD.
class HotPotatoVoiceHud extends StatelessWidget {
  const HotPotatoVoiceHud({
    super.key,
    required this.session,
    required this.roomId,
    required this.participantPath,
    required this.iconColor,
  });

  final HotPotatoVoiceSession session;
  final String roomId;
  final String participantPath;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) {
        final s = session.connectionState;
        Widget child;
        VoidCallback? onTap;

        if (kIsWeb) {
          child = Icon(
            Icons.mic_off_outlined,
            size: 18,
            color: iconColor.withValues(alpha: 0.35),
          );
          onTap = null;
        } else {
          switch (s) {
            case HotPotatoVoiceConnectionState.idle:
              child = Icon(Icons.headset_mic_outlined, size: 18, color: iconColor);
              onTap = () => session.connect(
                    roomId: roomId,
                    participantPath: participantPath,
                  );
              break;
            case HotPotatoVoiceConnectionState.connecting:
              child = SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: iconColor,
                ),
              );
              onTap = null;
              break;
            case HotPotatoVoiceConnectionState.connected:
              child = Icon(
                session.micEnabled ? Icons.mic_none_rounded : Icons.mic_off_rounded,
                size: 20,
                color: iconColor,
              );
              onTap = () => session.toggleMic();
              break;
            case HotPotatoVoiceConnectionState.error:
              child = Icon(Icons.headset_off_outlined, size: 18, color: iconColor.withValues(alpha: 0.7));
              onTap = () => session.connect(
                    roomId: roomId,
                    participantPath: participantPath,
                  );
              break;
          }
        }

        return Tooltip(
          message: _tooltip(s, session),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }

  String _tooltip(HotPotatoVoiceConnectionState s, HotPotatoVoiceSession session) {
    if (kIsWeb) return 'Voice not available on web';
    switch (s) {
      case HotPotatoVoiceConnectionState.idle:
        return 'Tap to join voice (LiveKit)';
      case HotPotatoVoiceConnectionState.connecting:
        return 'Connecting…';
      case HotPotatoVoiceConnectionState.connected:
        return session.micEnabled ? 'Tap to mute' : 'Tap to unmute';
      case HotPotatoVoiceConnectionState.error:
        final m = session.errorMessage;
        return m == null || m.isEmpty ? 'Voice failed — tap to retry' : m;
    }
  }
}
