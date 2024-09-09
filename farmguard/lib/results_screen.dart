import 'package:flutter/material.dart';
import 'dart:io'; // Import the dart:io library to use the File class

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imagePath = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(imagePath)),
            SizedBox(height: 20),
            Text('Disease Detection Results will be shown here.'),
          ],
        ),
      ),
    );
  }
}