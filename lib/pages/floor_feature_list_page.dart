import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/room_feature_list_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Floor ' + _floor.toString()),
      ),
      body: ListView.builder(
        itemCount: _features.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: index != _features.length - 1 ? 30.0 : 0.0
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RoomFeatureListPage(_features[index].name))
                );
              },
              child: Stack(
                children: <Widget>[
                  Image.asset(_features[index].image),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    padding: EdgeInsets.only(left: 10.0, top: 7.5, right: 20.0, bottom: 7.5),
                    color: Color(0xFFB3B3B3),
                    child: Text(
                      _features[index].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                  )
                ],
              ),
            )
          );
        },
      ),
    );
  }
}