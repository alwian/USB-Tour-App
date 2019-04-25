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
            padding: EdgeInsets.all(8.0),
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              ListTile(
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(values[index])
                  ]
                ),
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
    log('LOG');
    return Scaffold(
      appBar: AppBar(
        title: Text("Find a room"),
      ),
      body: Column(
        children: <Widget>[
          _buildMapBody(context),

          _buildInstructionDisplay(context),
          Divider(height: 20.0, color: Colors.black,),


          FutureBuilder<List<String>>(
              future: _directions(),
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  return MediaQuery.removePadding(
                    removeTop: true,
                    removeBottom: true,
                    context: context,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0.0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        String item = snapshot.data[index];

                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Center(
                                  child: Text(item, style: TextStyle(fontSize: 20.0),)
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
            ),
        ]
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