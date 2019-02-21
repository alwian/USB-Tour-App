import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF9DAF59),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Project App'),
        ),
      ),
    );
  }
}