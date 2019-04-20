import 'package:flutter/material.dart';
import 'package:csc2022_app/pages/search_results_page.dart';
import 'package:csc2022_app/pages/search_form_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:csc2022_app/managers/find_a_room_manager.dart';

class FindARoomFragment extends StatelessWidget {

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
                    MaterialPageRoute(builder: (context) => SearchFormPage()),
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
    );
  }
}