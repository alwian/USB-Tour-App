import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/search_results_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:csc2022_app/managers/find_a_room_manager.dart';

class FindARoomFragment extends StatelessWidget {

  ///Form keys and textEditingController
  ///For more info on TextEditingController, see https://pub.dartlang.org/packages/flutter_typeahead#-readme-tab-
  final GlobalKey<FormState> _findARoomFormKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  ///Strings to store results from the form text fields
  String _firstSelectedRoom;

  ///Load all [Room]s from database into List


  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration( color: Color(0xFFFFFF)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset('assets/images/lecture_theatre.jpg'),
                    Container(
                      margin: EdgeInsets.all(50.0),
                      padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                      color: Color(0xFF313131),
                      child: Text(
                        'Search for a room!',
                        //@todo Add center wrapper back and chenage image + remove decorated box and text colour
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 27.0,
                        ),
                        textAlign: TextAlign.center,
                      ),

                    ),
                  ],
                ),

                //@todo Improve styling - https://medium.com/flutter-community/breaking-layouts-in-rows-and-columns-in-flutter-8ea1ce4c1316
                //@todo Hard code suggestion dropdowns
                //@todo add new search page

                ///Form to submit start and end points for the route finding algorithm /algorithm/
                Form(
                  key: this._findARoomFormKey,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: TypeAheadFormField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: this._typeAheadController,
                              autofocus: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter Destination',
                              )
                            ),

                            ///Method to get suggestions to populate dropdown
                            suggestionsCallback: (pattern) {
                              //Call method to find rooms with similar name
                              return FindARoomManager.getRoomSuggestions(pattern);
                            }, //suggestionsCallback

                            ///Build Dropdown menu
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            }, //itemBuilder

                            ///Create loading animation
                            transitionBuilder: (context, suggestionsBox, animationController) =>
                              FadeTransition(
                                child: suggestionsBox,
                                opacity: CurvedAnimation(
                                parent: animationController,
                                curve: Curves.fastOutSlowIn
                              ),
                            ),

                            ///Set TextField value to suggestion
                            onSuggestionSelected: (suggestion) {
                              this._typeAheadController.text = suggestion;
                            },

                            ///Validation method @todo add more comprehensive checks
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please select a room';
                              }
                            },

                            ///Set string to selected value
                            onSaved: (value) => this._firstSelectedRoom = value,
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
                          child: MaterialButton(
                            height: 75.0,
                            minWidth: 125.0,
                            color: Colors.black54,
                            textColor: Colors.white,

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SearchResultsPage()),
                              );
                            },

                            splashColor: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Find your room now!',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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