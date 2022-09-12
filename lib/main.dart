import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:radio_app/sliver_notification.dart';
import 'package:firebase_functions_desktop/firebase_functions_desktop.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAKycN8X2vIb8be8qc1hL7cFxuTff7u7mU",
      appId: "1:1003888243983:web:e159aa6b79fd22dbbffa7a",
      messagingSenderId: "1003888243983",
      projectId: "notify-cc847",
    ),
  );
  runApp(
    MaterialApp(
      home: Notificat(),
    ),
  );
}
