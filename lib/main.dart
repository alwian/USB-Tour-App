/// Author Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'helpers/database_helper.dart';
import 'package:csc2022_app/pages/home_page.dart';

/// Calls on the [MyApp] to be ran.
void main() => runApp(MyApp());

/// The main application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Load the database for use by the app.
    DatabaseHelper.loadSingular(context, 'data.db');
    // Return the app
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
        '/' : (context) => HomePage() // Home route
      },
    );
  }
}