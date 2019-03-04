import 'package:flutter/material.dart';

class FloorFeatureListPage extends StatelessWidget {
  final int _floor;

  FloorFeatureListPage(this._floor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floor ' + _floor.toString()),
      ),
    );
  }
}