import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';

const firebaseConfig  = FirebaseOptions(
  apiKey: "AIzaSyDQxlkbexfMlwfT7se3GF_uE0_ZIYC83kg",
  authDomain: "legattofatec.firebaseapp.com",
  projectId: "legattofatec",
  storageBucket: "legattofatec.appspot.com",
  messagingSenderId: "891678356185",
  appId: "1:891678356185:web:98e632c66c3bd1a9ad84c8",
  measurementId: "G-CX4CB2NLG3"
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: firebaseConfig);
  runApp(const App());
}