import 'package:flutter/material.dart';

class RoomFeatureListPage extends StatelessWidget {
  String roomName;

  RoomFeatureListPage(this.roomName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
      )
    );
  }
}