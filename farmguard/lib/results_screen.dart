import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String disease;
  final String recommendations;

  ResultsScreen({required this.disease, required this.recommendations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosis Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Disease: $disease', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Recommendations:', style: TextStyle(fontSize: 18)),
            Text(recommendations),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Save & Return'),
            )
          ],
        ),
      ),
    );
  }
}