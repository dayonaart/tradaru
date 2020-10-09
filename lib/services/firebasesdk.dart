import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class FirebaseSdk {
  FirebaseOptions staging = FirebaseOptions(
    projectID: "tradaru-3f345",
    messagingSenderId: "260298365372",
    appId: Platform.isAndroid
        ? "1:260298365372:android:316f004532e2c4be82f3b9"
        : "1:626350561336:ios:212ef79e4753b89d6f6ecd",
    apiKey: "AIzaSyDZ7PmZ61B5ftOqGjgS9jZH2INy9f4TYlA",
    databaseURL: "https://tradaru-3f345.firebaseio.com",
  );

  Future init() async {
    await Firebase.initializeApp(options: staging, name: "tradaru");
  }
}
