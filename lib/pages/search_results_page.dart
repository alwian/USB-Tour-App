import 'package:flutter/material.dart';
import 'package:csc2022_app/managers/find_a_room_manager.dart';
import 'package:csc2022_app/fragments/building_map_fragment.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'package:photo_view/photo_view.dart';

class SearchResultsPage extends StatefulWidget {
  ///List of Strings to store the current and destination rooms from form in FindARoom fragment
  final List<String> formRooms;

  @override
  State<StatefulWidget> createState() {
    return _SearchResultsState();
  }

  ///Constructor
  SearchResultsPage({Key key, @required this.formRooms}) : super(key: key);
}

///Builds the state
class _SearchResultsState extends State<SearchResultsPage> {

  // Init local variables
  Future<List<String>> _directionList;
  Queue<Node> _path;

  /// Load [_directionList] when the [State] is created.
  @override
  void initState() {
    super.initState();

    // initial load
    _directionList = updateAndGetList();
    updateAndGetQueue();
  }

  void refreshList() {
    // reload
    setState(() {
      widget.formRooms[0] = "G.063";
      _directionList = updateAndGetList();
      updateAndGetQueue();
      debugPrint(_path.toString());
    });
  }

  /// Get [List] of directions from FindARoomManager
  Future<List<String>> updateAndGetList() async {
    await FindARoomManager.getDirections(widget.formRooms);

    // return the list here
    return FindARoomManager.getDirections(widget.formRooms);
  }

  /// Set [_path] to [Queue] of [Node] directions from FindARoomManager
  Future<void> updateAndGetQueue() async {
    _path = await FindARoomManager.getDirectionsQueue(widget.formRooms);

    // return the list here
    setState(() {});
  }

  ///Method to build return a [FutureBuilder] that generates a [ListView] of directions
  FutureBuilder<List<String>> _createDirectionTiles(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _directionList,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return MediaQuery.removePadding(
              removeTop: true,
              removeBottom: true,
              context: context,
              child: ListView.builder(
                key: Key('directions_list'),
                padding: EdgeInsets.all(0.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  String item = snapshot.data[index];

                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(item, style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Divider(height: 7.0,)
                    ],
                  );
                },
              )
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  ///Method to build map content
  Widget _buildMapBody(BuildContext context) {
    //Get floor plan to return
    int floor;

    if(widget.formRooms[0].substring(0, 1) == "G" || widget.formRooms[0].substring(0, 1) == "S") {
      floor = 0;
    } else {
      floor = int.parse(widget.formRooms[0].substring(0, 1));
    }

    return Container(
      height: (MediaQuery.of(context).size.height) / 2,
        // If data has not loaded, display progress indicator
        child: _path  == null ? Center(child: CircularProgressIndicator()) : PhotoView.customChild(
          child: new CustomPaint(
            key: Key('map_image'),
            foregroundPainter: RoutePainter(_path),
              child: Image(image: AssetImage('assets/images/floor' + floor.toString() + '.png'))),
        minScale: PhotoViewComputedScale.contained,
        maxScale: 1.5,
        //The height of the currently used images, need changing from magic numbers.
        childSize: Size(4961, 3508),
        backgroundDecoration: new BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }

  ///Method to build [ListTiles] to display route instructions.
  Widget _buildInstructionDisplay(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 0.0, top: 8.0, bottom: 0.0, right: 0.0),
            child: ListTile(
              // Title is the Destination from form (formRooms)
                title: Text("To " + widget.formRooms[0], style: TextStyle(fontSize: 24.0),),
                // Leading is source
                subtitle: Text("From " + widget.formRooms[1], style: TextStyle(fontSize: 16.0),)
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find a room"),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              _buildMapBody(context),

              _buildInstructionDisplay(context),
              Divider(height: 20.0, color: Colors.black,),

              // Build ListView
              _createDirectionTiles(context)
            ]
        ),
      ),
      bottomNavigationBar: Opacity(opacity: 0.90,
        child: Container(
          height: 60.0,
          color: Colors.black87,
          child: FlatButton(
              onPressed: () {
                refreshList();
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.search, color: Colors.black, size: 40.0),
                  Text("Find nearest exit", style: TextStyle(color: Colors.white, fontSize: 20.0, letterSpacing: 1.0, wordSpacing: 2.5),),
                ],
              )
          ),
        ),
      ),
    );
  }
}