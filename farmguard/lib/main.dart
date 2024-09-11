import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'my_app.dart'; // Import the MyApp widget from my_app.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp()); // Run the MyApp widget
}