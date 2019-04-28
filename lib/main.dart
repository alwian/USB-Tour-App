/// Author Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'helpers/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:csc2022_app/ui/pages/home_page.dart';

SharedPreferences prefs;
Set<String> prefKeys;
/// Starts the app.
void main() async {
  prefs = await SharedPreferences.getInstance();
  prefKeys = prefs.getKeys();
  runApp(MyApp());
}

/// The main app.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Load the database for use by the app.
    DatabaseHelper.loadSingular(context, 'data.db');
    // Return the app
    return MaterialApp(
      theme: ThemeData(
        primaryColor: !prefKeys.contains('primaryColor') ? Color(0xFF96B24A) : Color(int.parse(prefs.getString('primaryColor'))),
        backgroundColor: !prefKeys.contains('backgroundColor') ? Color(0xFFBDBDBD) : Color(int.parse(prefs.getString('backgroundColor'))),
        accentColor: !prefKeys.contains('accentColor') ? Color(0xFF96B24A) : Color(int.parse(prefs.getString('accentColor'))),
        accentIconTheme: IconThemeData(
          color: !prefKeys.contains('accentIconThemeColor') ? Colors.white : Color(int.parse(prefs.getString('accentIconThemeColor'))),
        ),
        fontFamily: 'Ayuthaya',
        indicatorColor: !prefKeys.contains('indicatorColor') ? Color(0xFFD5E3AF) : Color(int.parse(prefs.getString('indicatorColor'))),
        splashColor: !prefKeys.contains('primaryColor') ? Color(0xFFD5E3AF) : Color(int.parse(prefs.getString('splashColor'))),
        tabBarTheme: TabBarTheme(
          labelColor: !prefKeys.contains('labelColor') ? Color(0xFF96B24A) : Color(int.parse(prefs.getString('labelColor'))),
          unselectedLabelColor:  !prefKeys.contains('unselectedLabelColor') ? Colors.black : Color(int.parse(prefs.getString('unselectedLabelColor'))),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: !prefKeys.contains('appBarIconThemeColor') ? Colors.white : Color(int.parse(prefs.getString('appBarIconThemeColor')))),
          textTheme: TextTheme(
              title: TextStyle(color: !prefKeys.contains('appBarTextThemeColor') ? Colors.white : Color(int.parse(prefs.getString('appBarTextThemeColor'))), fontSize: 20.0, fontFamily: 'Ayuthaya')
          ),
        ),
      ),
      routes: {
        '/': (context) => HomePage() // Home route
      },
    );
  }
}
