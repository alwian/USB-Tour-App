/// Author: Alex Anderson
/// Student No: 170453905

import 'package:flutter/material.dart';
import 'package:csc2022_app/managers/explore_a_floor_manager.dart';

/// A Page for displaying rooms on a floor in the Urban Sciences Building.
class RoomFeatureListPage extends StatefulWidget {

  /// The name of the [Room] this page is about.
  final String roomName;

  /// Defines a [RoomFeatureListPage].
  RoomFeatureListPage(this.roomName);

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
        ) : _listUI()
    );
  }

  /// Gets a [List] of [RoomFeature]s to display.
  Future<void> _loadFeatures() async {
    _features = await ExploreAFloorManager.getRoomFeatures(widget.roomName);
    setState(() {}); // Update the state to show features.
  }

  /// Returns a [Widget] containing a [Room]s [RoomFeature]s.
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