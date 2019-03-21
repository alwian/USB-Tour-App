import 'package:flutter/material.dart';

class UrbanObservatoryFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.info)),
                Tab(icon: Icon(Icons.search)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Text('Info'),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          TextField(),
                        ],
                      ),
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}