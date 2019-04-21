import 'package:flutter/material.dart';

class SearchResultsPage extends StatelessWidget {
  ///List of Strings to store the current and destination rooms from form in FindARoom fragment
  final List<String> formRooms;

  ///Constructor
  SearchResultsPage({Key key, @required this.formRooms}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Find a room"),
      ),
      body: Column(
        children: <Widget>[
          ///@todo replace image with map when finished
          _buildMapBody(context),

          Expanded(
            //ListView
            child: ListView(
              children: <Widget>[
                //Destination [ListTile]
                ListTile(
                  title: Text(formRooms[0], textAlign: TextAlign.start,),
                  subtitle: Text('From ' + formRooms[1], textAlign: TextAlign.start,),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }

}