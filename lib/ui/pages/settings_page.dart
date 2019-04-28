/// Author: Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

_ColorScheme _selectedColorScheme = _colorSchemes[0];
List<_ColorScheme> _colorSchemes = <_ColorScheme>[
  _ColorScheme(
      'Default',
      Color(0xFF96B24A),
      Color(0xFFBDBDBD),
      Color(0xFF96B24A),
      Colors.white,
      Color(0xFFD5E3AF),
      Color(0xFFD5E3AF),
      Color(0xFF96B24A),
      Colors.black,
      Colors.white,
      Colors.white
  ),
];

class _ColorScheme {
  String name;
  Color primaryColor;
  Color backgroundColor;
  Color accentColor;
  Color accentIconColor;
  Color indicatorColor;
  Color splashColor;
  Color tabBarLabelColor;
  Color tabBarUnselectedLabelColor;
  Color appBarIconThemeColor;
  Color appBarTextThemeColor;

  _ColorScheme(
      this.name,
      this.primaryColor,
      this.backgroundColor,
      this.accentColor,
      this.accentIconColor,
      this.indicatorColor,
      this.splashColor,
      this.tabBarLabelColor,
      this.tabBarUnselectedLabelColor,
      this.appBarIconThemeColor,
      this.appBarTextThemeColor
  );
}

class SettingsPage extends StatelessWidget {

  Future<void> _setColorScheme(_ColorScheme scheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('primaryColor', scheme.primaryColor.value);
    prefs.setInt('backgroundColor', scheme.backgroundColor.value);
    prefs.setInt('accentColor', scheme.accentColor.value);
    prefs.setInt('accentIconColor', scheme.accentIconColor.value);
    prefs.setInt('indicatorColor', scheme.indicatorColor.value);
    prefs.setInt('splashColor', scheme.splashColor.value);
    prefs.setInt('tabBarLabelColor', scheme.tabBarLabelColor.value);
    prefs.setInt('tabBarUnselectedLabelColor', scheme.tabBarUnselectedLabelColor.value);
    prefs.setInt('appBarIconThemeColor', scheme.appBarIconThemeColor.value);
    prefs.setInt('appBarTextThemeColor', scheme.appBarTextThemeColor.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Text Theme: '),
                DropdownButton<_ColorScheme>(
                  value: _selectedColorScheme,
                  onChanged: _setColorScheme,
                  items: _colorSchemes.map((_ColorScheme value) {
                    return DropdownMenuItem<_ColorScheme>(
                      child: Text(value.name),
                      value: value,
                    );
                  }).toList(),
                ),
              ],
            )
          ],
        )
      )
    );
  }
}