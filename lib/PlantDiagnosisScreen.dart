import 'package:flutter/material.dart';

class PlantDiagnosisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plant Diagnosis')),
      body: Center(child: Text('Plant Diagnosis Screen', style: TextStyle(fontSize: 24))),
    );
  }
}
