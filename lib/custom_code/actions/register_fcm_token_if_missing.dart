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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future registerFcmTokenIfMissing() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No logged-in user");
      return;
    }
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final userSnap = await userRef.get();
    final existingToken = userSnap.data()?['fcm_token'];
    if (existingToken != null &&
        existingToken is String &&
        existingToken.isNotEmpty) {
      print("FCM token already exists");
      return;
    }
    await FirebaseMessaging.instance.requestPermission();
    final newToken = await FirebaseMessaging.instance.getToken();
    if (newToken == null || newToken.isEmpty) {
      print("Failed to generate FCM token");
      return;
    }
    await userRef.set({'fcm_token': newToken}, SetOptions(merge: true));
    print("New FCM token saved");
  } catch (e) {
    print("Error: $e");
  }
}
