import 'package:flutter/material.dart';
import 'package:csc2022_app/managers/explore_a_floor_manager.dart';

class RoomFeatureListPage extends StatefulWidget {
  final String roomName;

  RoomFeatureListPage(this.roomName);

  @override
  State<StatefulWidget> createState() {
    return _RoomFeatureListPageState();
  }
}

class _RoomFeatureListPageState extends State<RoomFeatureListPage> {
  List<RoomFeature> _features;

  @override
  void initState() {
    _loadFeatures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.roomName),
        ),
        body: _features == null ? Center(
          child: CircularProgressIndicator(),
        ) : _listUI()
    );
  }

  Future<void> _loadFeatures() async {
    _features = await ExploreAFloorManager.getRoomFeatures(widget.roomName);
    setState(() {

    });
  }

  Widget _listUI() {
    return ListView.builder(
        itemCount: _features.length,
        itemBuilder: (context, index) {
          return  Card(
            margin: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/images/' + _features[index].image),
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
    );
  }
}