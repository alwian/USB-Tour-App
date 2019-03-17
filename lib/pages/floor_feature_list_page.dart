import 'package:flutter/material.dart';

class _FloorFeature {
  String name;
  String image;

  _FloorFeature(this.name, this.image);
}

class FloorFeatureListPage extends StatelessWidget {
  final int _floor;
  final _features = [
    _FloorFeature('Lecture Theatre', 'assets/images/lecture_theatre.jpg'),
    _FloorFeature('Lecture Theatre', 'assets/images/lecture_theatre.jpg'),
    _FloorFeature('Lecture Theatre', 'assets/images/lecture_theatre.jpg'),
    _FloorFeature('Lecture Theatre', 'assets/images/lecture_theatre.jpg'),
    _FloorFeature('Lecture Theatre', 'assets/images/lecture_theatre.jpg'),
    _FloorFeature('Lecture Theatre', 'assets/images/lecture_theatre.jpg'),
  ];

  FloorFeatureListPage(this._floor);

  _buildFeatureList() {
    var list = <Widget>[];
    for(int i = 0; i < _features.length; i++) {
      list.add(
        Stack(
          children: <Widget>[
            Image.asset(_features[i].image),
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.only(left: 10.0, top: 7.5, right: 20.0, bottom: 7.5),
              color: Color(0xFFB3B3B3),
              child: Text(
                _features[i].name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                ),
              ),
            )
          ],
        )
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Floor ' + _floor.toString()),
      ),
      body: ListView(
        children: _buildFeatureList()
      ),
    );
  }
}