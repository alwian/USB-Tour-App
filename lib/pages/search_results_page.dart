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
      body: FutureBuilder<List<String>>(
        future: _directions(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                String item = snapshot.data[index];
                return ListTile(
                  title: Text(item),
                  leading: Text(item),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
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