/// Author: Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'package:csc2022_app/managers/explore_a_floor_manager.dart';
import 'package:csc2022_app/ui/pages/room_feature_list_page.dart';

/// A Page for displaying features in a room in the Urban Sciences Building.
class FloorFeatureListPage extends StatefulWidget {

  /// The floor to display the [Room]s for.
  final int _floor;

  /// Defines a [FloorFeatureListPage].
  FloorFeatureListPage(this._floor);

  /// Returns a [_FloorFeatureListPageState].
  @override
  State<StatefulWidget> createState() {
    return _FloorFeatureListPageState();
  }
}

/// A [State] of a [FloorFeatureListPage].
class _FloorFeatureListPageState extends State<FloorFeatureListPage> {

  /// The [Room]s to display.
  List<Room> _rooms;

  /// Load [_rooms] when the [State] is created.
  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  /// Gets a [List] of [Rooms]s to display.
  Future<void> _loadRooms() async {
    _rooms = await ExploreAFloorManager.getRooms(widget._floor);
    setState(() {}); // Update the state to show the rooms.
  }

  /// Returns a [Widget] containing a floors [Room]s.
  Widget _listUI() {
    return ListView.builder(
      itemCount: _rooms.length,
      itemBuilder: (context, index) {
        return Padding(
            key: Key('room_btn_' + index.toString()),
            padding: EdgeInsets.only(
                bottom: index != _rooms.length - 1 ? 30.0 : 0.0
            ),
            child: GestureDetector(
              onTap: () {
                // Go to feature page when tapped.
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RoomFeatureListPage(_rooms[index].name, widget._floor))
                );
              },
              // Represents a room.
              child: Stack(
                children: <Widget>[
                  Image.asset(
                      'assets/images/explore_a_floor/floor_'
                          + widget._floor.toString()
                          + '/'
                          + _rooms[index].image),
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

  /// Builds the page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Current floor.
          title: Text('Floor ' + widget._floor.toString()),
        ),
        // Until features are loaded display a loading indicator.
        body: _rooms == null ? Center(
          child: CircularProgressIndicator(),
        ) : _rooms.isEmpty ? Center(
          // Display when no rooms found.
          child: Text('No rooms found on this floor'),
        ) : _listUI()
    );
  }
}