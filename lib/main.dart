/// Author Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'helpers/database_helper.dart';
import 'package:csc2022_app/pages/home_page.dart';

/// Starts the app.
void main() => runApp(MyApp());

/// The main app.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Load the database for use by the app.
    DatabaseHelper.loadSingular(context, 'data.db');
    // Return the app
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF96B24A),
        backgroundColor: Color(0xFFBDBDBD),
        accentColor: Color(0xFF96B24A),
        accentIconTheme: IconThemeData(color: Colors.white),
        fontFamily: 'Ayuthaya',
        indicatorColor: Color(0xFFD5E3AF),
        splashColor: Color(0xFFD5E3AF),
        tabBarTheme: TabBarTheme(
          labelColor: Color(0xFF96B24A),
          unselectedLabelColor: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
              title: TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'Ayuthaya')
          ),
        ),
      ),
      routes: {
        '/': (context) => HomePage() // Home route
      },
    );
  }
}
