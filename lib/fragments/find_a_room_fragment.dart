import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/search_results_page.dart';
import 'package:csc2022_app/pages/search_form_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:csc2022_app/managers/find_a_room_manager.dart';

class FindARoomFragment extends StatelessWidget {

  ///Method to build button
  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 35.0, right: 15.0, bottom: 35.0),
      child: MaterialButton(
        height: 75.0,
        minWidth: 125.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchFormPage()),
          );
        },

        splashColor: Theme
            .of(context)
            .primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.search,
              size: 45.0,
              color: Colors.black
            ),
            Text(
              'Search for a room',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Method to build map content
  Widget _buildMapBody(BuildContext context) {
    return Container(
      height: 375.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
            alignment: Alignment(-.2, 0),
            image: AssetImage('assets/images/lecture_theatre.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ///@todo replace image with map when finished
          _buildMapBody(context),
          _buildButton(context)
        ]
      ),
    );
  }
}