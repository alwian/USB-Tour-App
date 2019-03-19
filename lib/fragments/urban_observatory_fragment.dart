import 'package:flutter/material.dart';

class UrbanObservatoryFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.search)),
            ],
          )
        ],
      ),
    );
  }
}