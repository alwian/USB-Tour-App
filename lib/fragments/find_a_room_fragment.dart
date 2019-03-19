import 'package:flutter/material.dart';

class FindARoomFragment extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Color(0xFFFFFF)
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset('assets/images/lecture_theatre.jpg'),
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                color: Color(0xFF313131),
                child: Text(
                  'Search for a room!',
                  //@todo center text in stack
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}