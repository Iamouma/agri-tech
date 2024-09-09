import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'register_screen.dart';
import 'login_screen.dart';
import 'camera_screen.dart';
import 'results_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop Monitoring App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/camera': (context) => CameraScreen(),
        '/results': (context) => ResultsScreen(),
      },
    );
  }
}