import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather')),
      body: Center(child: Text('Weather Screen', style: TextStyle(fontSize: 24))),
    );
  }
}
