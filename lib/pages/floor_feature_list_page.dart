import 'package:flutter/material.dart';

class FloorFeatureListPage extends StatelessWidget {
  final int _floor;

  FloorFeatureListPage(this._floor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Floor ' + _floor.toString()),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(16.0),
            shape: BeveledRectangleBorder(),
            color: Color(0xFF313131),
            child: Stack(
              children: <Widget>[
                Image.asset('assets/images/lecture_theatre.jpg'),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.only(left: 10.0, top: 7.5, right: 20.0, bottom: 7.5),
                  color: Color(0xFF313131),
                  child: Text(
                    'Lecture Theatre',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0
                    ),
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}