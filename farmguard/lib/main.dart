import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'home_screen.dart';
import 'camera_screen.dart';
import 'analysis_screen.dart';
import 'results_screen.dart';
import 'history_screen.dart';

void main() {
  runApp(Farmguard());
}

class Farmguard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Remove debug banner
      title: 'farmguard',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/camera': (context) => CameraScreen(),
        '/analysis': (context) => AnalysisScreen(),
        '/results': (context) => ResultsScreen(
              disease: 'Example Disease',
              recommendations: 'Example treatment recommendations',
            ),
        '/history': (context) => HistoryScreen(),
      },
    );
  }
}