import 'package:flutter/material.dart';

class _RoomFeature {
  String image;
  String description;

  _RoomFeature(this.image, this.description);
}

class RoomFeatureListPage extends StatelessWidget {
  final String roomName;

  RoomFeatureListPage(this.roomName);

  final _features = [
    _RoomFeature('assets/images/flat_floor.jpg', 'Placeholder text...'),
    _RoomFeature('assets/images/flat_floor.jpg', 'Placeholder text...'),
    _RoomFeature('assets/images/flat_floor.jpg', 'Placeholder text...'),
    _RoomFeature('assets/images/flat_floor.jpg', 'Placeholder text...'),
    _RoomFeature('assets/images/flat_floor.jpg', 'Placeholder text...'),
    _RoomFeature('assets/images/flat_floor.jpg', 'Placeholder text...'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
      ),
      body: ListView.builder(
        itemCount: _features.length,
        itemBuilder: (context, index) {
          return  Card(
            margin: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(_features[index].image),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  color: Color(0xFFE0E0E0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        child: Text(_features[index].description),
                        padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 10.0, bottom: 10.0),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      )
    );
  }
}