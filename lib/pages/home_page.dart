import 'package:flutter/material.dart';
import 'package:csc2022_app/fragments/home_fragment.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedFragmentIndex = 0;

  _getSelectedFragment() {
    switch(_selectedFragmentIndex) {
      case 0:
        return HomeFragment();
      default:
        return Text('Error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project App'),
      ),
      body: _getSelectedFragment(),
    );
  }
}