import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF9DAF59),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize: 25.0
            )
          )
        )
      ),
      routes: {
        '/' : (context) => HomePage()
      },
    );
  }
}