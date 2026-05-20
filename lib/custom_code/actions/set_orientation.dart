// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

Future setOrientation() async {
  try {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Re-arm fullscreen — orientation changes briefly bring the system bars
    // back on Android. Keeping this here means every game screen that locks
    // landscape also gets clean fullscreen without each screen wiring it up.
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: const [],
    );
  } on MissingPluginException catch (e) {
    print('Error setting orientation: MissingPluginException - $e');
  } catch (e) {
    print('An unexpected error occurred while setting orientation: $e');
  }
}
