import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, String>> diagnosisHistory = [
    {'date': '2024-09-01', 'disease': 'Leaf Blight'},
    {'date': '2024-08-27', 'disease': 'Healthy'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosis History'),
      ),
      body: ListView.builder(
        itemCount: diagnosisHistory.length,
        itemBuilder: (context, index) {
          final diagnosis = diagnosisHistory[index];
          return ListTile(
            title: Text(diagnosis['disease']!),
            subtitle: Text('Date: ${diagnosis['date']}'),
          );
        },
      ),
    );
  }
}