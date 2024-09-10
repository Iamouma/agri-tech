import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final results = ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Disease Detection Results:'),
            SizedBox(height: 20),
            Text(results.toString()), // Display results
          ],
        ),
      ),
    );
  }
}