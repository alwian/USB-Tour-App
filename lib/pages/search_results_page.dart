import 'package:flutter/material.dart';
import 'package:csc2022_app/managers/find_a_room_manager.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'dart:developer';

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
class _SearchResultsState extends State<SearchResultsPage> {

  ///List of [String]s to store the route directions
  Future<List<String>> _directions() async {
    List<String> dir = await FindARoomManager.getDirections(widget.formRooms);
    return dir;
  }

  ///Method to build ListTiles as directions
  Widget _createDirectionTiles(BuildContext context) {
    FutureBuilder<List<String>>(
      future: _directions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Store directions
          List<String> values = snapshot.data;
          return ListView.builder(
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(values[index]),
                  ),
                  Divider(height: 2.0,),
                ],
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ///Method to build map content
  Widget _buildMapBody(BuildContext context) {
    return Container(
      height: 350.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
            alignment: Alignment(-.2, 0),
            image: AssetImage('assets/images/lecture_theatre.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }

  ///Method to build [ListTiles] to display route instructions.
  //Widget _buildInstructionDisplay(BuildContext context) {
    //return
  //}

  @override
  Widget build(BuildContext context) {
    log('LOG');
    return Scaffold(
      appBar: AppBar(
        title: Text("Find a room"),
      ),
      body: Column(
        children: <Widget>[
          ///@todo replace image with map when finished
          _buildMapBody(context),

          /*Expanded(
            //ListView
            child: ListView(
              children: <Widget>[
                //Destination [ListTile]
                ListTile(
                  title: Text(widget.formRooms[0], textAlign: TextAlign.start,),
                  subtitle: Text('From ' + widget.formRooms[1], textAlign: TextAlign.start,),
                ),
              ],
            ),
          ),*/
          FutureBuilder(
            future: _directions(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return new Center(
                    child: CircularProgressIndicator()
                  );
                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return createListView(context, snapshot);
              }
            },
          ),
        ]
      )
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(values[index]),
            ),
            new Divider(height: 2.0,),
          ],
        );
      },
    );
  }

}