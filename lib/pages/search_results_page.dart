import 'package:flutter/material.dart';

class SearchResultsPage extends StatelessWidget {

  final backgroundImage = new Container(
    height: 250.00,
    decoration: new BoxDecoration(
      image: new DecorationImage(
          image: AssetImage('assets/images/lecture_theatre.jpg'),
          fit: BoxFit.cover,
      ),
    ),
  );

  final onImageContent = new Container(

  );

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.all(8.0),
      height: 250.0,
      child: new Stack(
        children: <Widget>[
          backgroundImage,
          onImageContent,
        ],
      ),
    );
  }

}