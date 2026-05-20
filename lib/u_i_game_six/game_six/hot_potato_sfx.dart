import 'dart:async';

import 'package:just_audio/just_audio.dart';

import '/auth/firebase_auth/auth_util.dart';

/// One-shot Hot Potato sounds (WAV under [assets/audios/]). Honors
/// [UserSettingStruct.isSoundstatus] when a user document exists.
abstract final class HotPotatoSfx {
  static AudioPlayer? _pass;
  static AudioPlayer? _pickup;
  static AudioPlayer? _elim;

  static bool _passReady = false;
  static bool _pickupReady = false;
  static bool _elimReady = false;

  static bool _on() =>
      currentUserDocument?.userSetting.isSoundstatus ?? true;

  static void playPass() => unawaited(_playPass());

  static void playPickup() => unawaited(_playPickup());

  static void playPowerup() => unawaited(_playPickup());

  static void playElimination() => unawaited(_playElimination());

  static Future<void> _playPass() async {
    if (!_on()) return;
    try {
      _pass ??= AudioPlayer();
      if (!_passReady) {
        await _pass!.setAsset('assets/audios/hot_potato_pass.wav');
        await _pass!.setLoopMode(LoopMode.off);
        _passReady = true;
      }
      await _pass!.setVolume(0.34);
      await _pass!.seek(Duration.zero);
      await _pass!.play();
    } catch (_) {}
  }

  static Future<void> _playPickup() async {
    if (!_on()) return;
    try {
      _pickup ??= AudioPlayer();
      if (!_pickupReady) {
        await _pickup!.setAsset('assets/audios/hot_potato_pickup.wav');
        await _pickup!.setLoopMode(LoopMode.off);
        _pickupReady = true;
      }
      await _pickup!.setVolume(0.32);
      await _pickup!.seek(Duration.zero);
      await _pickup!.play();
    } catch (_) {}
  }

  static Future<void> _playElimination() async {
    if (!_on()) return;
    try {
      _elim ??= AudioPlayer();
      if (!_elimReady) {
        await _elim!.setAsset('assets/audios/hot_potato_elimination.wav');
        await _elim!.setLoopMode(LoopMode.off);
        _elimReady = true;
      }
      await _elim!.setVolume(0.38);
      await _elim!.seek(Duration.zero);
      await _elim!.play();
    } catch (_) {}
  }

  /// Release native players when leaving the arena (next match lazily reloads).
  static Future<void> dispose() async {
    await _pass?.dispose();
    await _pickup?.dispose();
    await _elim?.dispose();
    _pass = null;
    _pickup = null;
    _elim = null;
    _passReady = false;
    _pickupReady = false;
    _elimReady = false;
  }
}
