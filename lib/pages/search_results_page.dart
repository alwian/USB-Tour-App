import 'package:flutter/material.dart';

class SearchResultsPage extends StatelessWidget {

  final backgroundImage = new Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.luminosity),
          image: AssetImage('images/lecture_theatre.jpg'),
          fit: BoxFit.cover,
      ),
    ),
  );

  final onImageContent = new Container(

  );

  @override
  Widget build(BuildContext context) {
    return new Container(
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