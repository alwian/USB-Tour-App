import 'package:flutter/material.dart';
import 'package:csc2022_app/managers/explore_a_floor_manager.dart';
import 'package:csc2022_app/pages/room_feature_list_page.dart';

class FloorFeatureListPage extends StatefulWidget {
  final int _floor;

  FloorFeatureListPage(this._floor);

  @override
  State<StatefulWidget> createState() {
    return _FloorFeatureListPageState();
  }
}

class _FloorFeatureListPageState extends State<FloorFeatureListPage> {
  List<Room> _rooms;

  @override
  void initState() {
    _loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floor ' + widget._floor.toString()),
      ),
      body: _rooms == null ? Center(
        child: CircularProgressIndicator(),
      ) : _listUI()
    );
  }

  Future<void> _loadRooms() async {
    _rooms = await ExploreAFloorManager.getRooms(widget._floor);
    setState(() {

    });
  }

  Widget _listUI() {
    return ListView.builder(
      itemCount: _rooms.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.only(
                bottom: index != _rooms.length - 1 ? 30.0 : 0.0
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RoomFeatureListPage(_rooms[index].name))
                );
              },
              child: Stack(
                children: <Widget>[
                  Image.asset('assets/images/' + _rooms[index].image),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    padding: EdgeInsets.only(left: 10.0, top: 7.5, right: 20.0, bottom: 7.5),
                    color: Color(0xFFB3B3B3),
                    child: Text(
                      _rooms[index].name,
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
    );
  }
}