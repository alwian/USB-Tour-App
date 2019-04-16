import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/search_results_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class FindARoomFragment extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration( color: Color(0xFFFFFF)),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset('assets/images/lecture_theatre.jpg'),
                    Container(
                      margin: EdgeInsets.all(50.0),
                      padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                      color: Color(0xFF313131),
                      child: Center(child: new Text(
                        'Search for a room!',
                        //@todo center text in stack
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),),

                    ),
                  ],
                ),

                //@todo Improve styling - https://medium.com/flutter-community/breaking-layouts-in-rows-and-columns-in-flutter-8ea1ce4c1316
                //@todo Hard code suggestion dropdowns
                //@todo add new search page

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Destination'
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Current Location'
                    ),
                  ),
                ),

                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: RaisedButton(
                        child: new Text('Find your room'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SearchResultsPage()),
                          );
                        }
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}