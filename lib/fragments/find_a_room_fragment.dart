import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/search_results_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:csc2022_app/managers/find_a_room_manager.dart';

class FindARoomFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FindARoomState();
  }
}

class _FindARoomState extends State<FindARoomFragment> {

  ///Form keys and textEditingController
  ///For more info on TextEditingController, see https://pub.dartlang.org/packages/flutter_typeahead#-readme-tab-
  final GlobalKey<FormState> _findARoomFormKey = GlobalKey<FormState>();

  ///Controller for the first  and second s
  final TextEditingController _typeAheadControllerFirst = TextEditingController();
  final TextEditingController _typeAheadControllerSecond = TextEditingController();

  ///Strings to store results from the form text fields
  String _destinationRoom;
  String _currentRoom;

  ///List of Strings to send the results of the form to the algorithm on valid submission.
  List<String> _formParameters = new List<String>();

  ///List to store the text of default suggestions (frequently used room names)
  List<String> _frequentlyUsedRoomNames = [
    "Cafe", "Lecture Theater", "Flat Floor", "Floor 2 Room", "MSc"
  ];

  ///Create method to create ListTile to display default suggestions to TextFields
  List<Widget> _createDefaultSuggestions(){
    //Create List of ListTiles
    List<ListTile> defaultSuggestions = new List<ListTile>();

    //Iterate over _frequentlyUsedRoomNames and create new list tiles
    _frequentlyUsedRoomNames.forEach((elem) =>
      defaultSuggestions.add(new ListTile(title: new Text(elem))),
    );

    return defaultSuggestions;
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              ],
            ),
           ),

                //@todo Improve styling - https://medium.com/flutter-community/breaking-layouts-in-rows-and-columns-in-flutter-8ea1ce4c1316
                //@todo Hard code suggestion dropdowns
                //@todo add new search page
                ///Form to submit start and end points for the route finding algorithm /algorithm/
           Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Form(
                   key: this._findARoomFormKey,
                   child: Padding(
                     padding: EdgeInsets.all(15.0),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Padding(
                           padding: EdgeInsets.all(15.0),

                           ///First TextField (Enter Destination)
                           child: TypeAheadFormField(
                             textFieldConfiguration: TextFieldConfiguration(
                                 controller: this._typeAheadControllerFirst,
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
                               this._typeAheadControllerFirst.text = suggestion;
                             },

                             ///Validation method @todo add more comprehensive checks
                             validator: (value) {
                               if (value.isEmpty) {
                                 //If empty, return default suggestions
                                 return 'Please select a room';
                               }
                             },

                             noItemsFoundBuilder: (BuildContext context) =>
                              ListView(
                                children: _createDefaultSuggestions()
                              ),

                             ///Set string to selected value
                             onSaved: (value) => this._destinationRoom = value,
                           ),
                         ),

                         Padding(
                           padding: EdgeInsets.all(15.0),
                           ///Second TextField (Enter Current Location)
                           child: TypeAheadFormField(
                             textFieldConfiguration: TextFieldConfiguration(
                                 controller: this._typeAheadControllerSecond,
                                 autofocus: false,
                                 decoration: InputDecoration(
                                   border: OutlineInputBorder(),
                                   labelText: 'Enter Current Location',
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
                               this._typeAheadControllerSecond.text = suggestion;
                             },

                             ///Validation method @todo add more comprehensive checks
                             validator: (value) {
                               if (value.isEmpty) {
                                 //If empty, return default suggestions
                                 return 'Please select a room';
                               }
                             },

                             noItemsFoundBuilder: (BuildContext context) =>
                                 ListView(
                                     children: _createDefaultSuggestions()
                                 ),

                             ///Set string to selected value
                             onSaved: (value) => this._currentRoom = value,
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
                              if (this._findARoomFormKey.currentState.validate()) {
                                this._findARoomFormKey.currentState.save();

                                ///Add TextField results to list and pass to the SearchResultsPage
                                _formParameters.add(_destinationRoom);
                                _formParameters.add(_currentRoom);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SearchResultsPage(formRooms: _formParameters)),
                                );
                              }

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
               ]
           ),
        ],
      ),
    );
  }
}