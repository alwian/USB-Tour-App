import 'package:flutter/material.dart';

class RoomFeatureListPage extends StatelessWidget {
  String roomName;

  RoomFeatureListPage(this.roomName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
      ),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/flat_floor.jpg'),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              color: Color(0xFFE0E0E0),
              child: Row(
                children: <Widget>[
                  Padding(
                    child: Text('Placeholder text...'),
                    padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 10.0, bottom: 10.0),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}