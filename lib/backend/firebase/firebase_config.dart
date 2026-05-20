import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBAzMB7o1dbwYLmyxUW2PfJriEfgkVBfNE",
            authDomain: "feshah-thbit.firebaseapp.com",
            projectId: "feshah-thbit",
            storageBucket: "feshah-thbit.firebasestorage.app",
            messagingSenderId: "761026372518",
            appId: "1:761026372518:web:931cac2418f99b4e60a567",
            measurementId: "G-YQHM85DVYZ",
            // Required for Realtime Database (Hot Potato arena positions). Region matches
            // the RTDB instance in Firebase console (europe-west1).
            databaseURL:
                "https://feshah-thbit-default-rtdb.europe-west1.firebasedatabase.app"));
  } else {
    await Firebase.initializeApp();
  }
}
