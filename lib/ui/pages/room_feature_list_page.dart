/// Author: Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'package:csc2022_app/managers/explore_a_floor_manager.dart';

/// A Page for displaying rooms on a floor in the Urban Sciences Building.
class RoomFeatureListPage extends StatefulWidget {

  /// The name of the [Room] this page is about.
  final String roomName;

  /// The floor this room is on.
  final int floor;

  /// Defines a [RoomFeatureListPage].
  RoomFeatureListPage(this.roomName, this.floor);

  /// Returns a [State] of this page.
  @override
  State<StatefulWidget> createState() {
    return _RoomFeatureListPageState();
  }
}

/// A [State] of a [RoomFeatureListPage].
class _RoomFeatureListPageState extends State<RoomFeatureListPage> {

  /// A [List] of [RoomFeature]s to be displayed.
  List<RoomFeature> _features;

  /// Loads the [RoomFeature] for this page to display.
  @override
  void initState() {
    super.initState();
    _loadFeatures();
  }

  /// Gets a [List] of [RoomFeature]s to display.
  Future<void> _loadFeatures() async {
    _features = await ExploreAFloorManager.getRoomFeatures(widget.roomName);
    setState(() {}); // Update the state to show features.
  }

  /// Returns a [Widget] containing a [Room]s [RoomFeature]s.
  Widget _listUI(BuildContext context) {
    return ListView.builder(
        itemCount: _features.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            // Key used for testing.
            key: Key('feature_btn_' + index.toString()),
            onTap: () => showDialog(context: context, builder: (BuildContext context) {
              // Display full description when tapped.
              return AlertDialog(
                content: Text(_features[index].description),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }),
            child: Card(
              margin: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Image representing the feature.
                  Image.asset(
                      'assets/images/explore_a_floor/floor_'
                          + widget.floor.toString()
                          + '/'
                          + _features[index].image),
                  Container(
                      margin: EdgeInsets.only(top: 10.0),
                      color: Color(0xFFE0E0E0),
                      child: Padding(
                        // Text describing the feature.
                        child: Text(_features[index].description, maxLines: 3, overflow: TextOverflow.ellipsis,),
                        padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 10.0, bottom: 10.0),
                      )
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  /// Builds the page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.roomName),
        ),
        // Until features are loaded display a loading indicator.
        body: _features == null ? Center(
          child: CircularProgressIndicator(),
        ) : _features.isEmpty ? Center(
          // Display when no features found.
          child: Text('No features found in this room'),
        ) : _listUI(context)
    );
  }
}