import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/search_results_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:csc2022_app/managers/find_a_room_manager.dart';
class SearchFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchFormState();
  }
}

class _SearchFormState extends State<SearchFormPage> {

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
    "Cafe", "Lecture Theater", "Flat Floor", "MSc"
  ];

  ///List to store the id of default suggestions (frequently used room ids)
  List<String> _frequentlyUsedRoomId = [
    "G.071", "1.006", "3.015", "4.005"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Create method that creates widgets to display default suggestions to TextFields
  ///[bool] input to determine TextController to edit
  List<Widget> _createDefaultSuggestions(bool first) {
    //Create List to store suggestion widgets
    List<Material> defaultSuggestions = new List<Material>();

    //Iterate over _frequentlyUsedRoomNames and create new list tiles
    for(int i = 0; i < _frequentlyUsedRoomNames.length; i++) {
      defaultSuggestions.add(
        Material(
          color: Colors.black12,
          child: InkWell(
            child: ListTile(
              title: new Text(_frequentlyUsedRoomNames[i]),
              ///Set TextField value to suggestion
              onTap: () {
                //Edit firstTextField
                if (first) {
                  _typeAheadControllerFirst.text = _frequentlyUsedRoomId[i];
                } else {
                  //Edit second form field
                  _typeAheadControllerSecond.text = _frequentlyUsedRoomId[i];
                }
              },
            ),
          ),
        ),
      );
    }

    return defaultSuggestions;
  }


  /// Method to create [Widget] tree containing the form to search for a room
  Form _createForm() {
    return Form(
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero)
                    ),
                    labelText: 'Enter Destination',
                    labelStyle: TextStyle(fontSize: 20.0, color: Colors.black, shadows:
                      <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.white70,
                        ),
                      ]
                    ),
                    fillColor: Colors.black12,
                    filled: true,
                  )
                ),

                ///Method to get suggestions to populate dropdown
                suggestionsCallback: (pattern) {
                  //Call method to find rooms with similar name
                  return FindARoomManager.getRoomSuggestions(pattern);
                }, //suggestionsCallback

                ///Build Dropdown menu
                itemBuilder: (context, suggestion) {
                  return Material(
                    color: Colors.black12,
                    child: InkWell(
                      child: ListTile(
                        title: Text(suggestion),
                      ),
                      splashColor: Theme.of(context).primaryColor,
                    )
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
                        //If no suggestions then create default suggestions.
                        //true param to act on first TextField
                        children: _createDefaultSuggestions(true)
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero)
                      ),
                      labelText: 'Enter Current Location',
                      labelStyle: TextStyle(fontSize: 20.0, color: Colors.black, shadows:
                        <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Colors.white70,
                          ),
                        ]
                      ),
                      fillColor: Colors.black12,
                      filled: true,
                    )
                ),

                ///Method to get suggestions to populate dropdown
                suggestionsCallback: (pattern) {
                  //Call method to find rooms with similar name
                  return FindARoomManager.getRoomSuggestions(pattern);
                }, //suggestionsCallback

                ///Build Dropdown menu
                itemBuilder: (context, suggestion) {
                  return Material(
                    color: Colors.black12,
                    child: InkWell(
                      child: ListTile(
                        title: Text(suggestion),
                      ),
                      splashColor: Theme.of(context).primaryColor,
                    )

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
                    MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                          children: _createDefaultSuggestions(false)
                      ),
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
            Container(
              height: (MediaQuery.of(context).size.height) / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment(-.2, 0),
                      image: AssetImage('assets/images/search_room_form_background.png'),
                      fit: BoxFit.cover),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Search for a room here!",
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(color: Colors.black),
                ),
              ),

            //@todo Improve styling - https://medium.com/flutter-community/breaking-layouts-in-rows-and-columns-in-flutter-8ea1ce4c1316
            //@todo Hard code suggestion dropdowns
            //@todo add new search page
            ///Form to submit start and end points for the route finding algorithm /algorithm/
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _createForm()
                ]
            ),
          ],
        ),
      ),
    );
  }
}