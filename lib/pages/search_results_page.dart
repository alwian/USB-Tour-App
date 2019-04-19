import 'package:flutter/material.dart';

class SearchResultsPage extends StatelessWidget {
  ///List of Strings to store the current and destination rooms from form in FindARoom fragment
  final List<String> formRooms;

  ///Constructor
  SearchResultsPage({Key key, @required this.formRooms}) : super(key: key);

  ///Method to create background image
  final _backgroundImage = new Container(
    height: 250.00,
    decoration: new BoxDecoration(
      image: new DecorationImage(
          image: AssetImage('assets/images/lecture_theatre.jpg'),
          fit: BoxFit.cover,
      ),
    ),
  );

  ///Method to display title on Image
  final _onImageContent = new Container(

  );

  @override
  Widget build(BuildContext context) {
    ///@todo change to Scaffold 
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8.0),
      height: 250.0,
      child: new Stack(
        children: <Widget>[
          _backgroundImage,
          _onImageContent,
        ],
      ),
    );
  }

}