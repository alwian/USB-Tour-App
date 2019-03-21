import 'package:flutter/material.dart';

class UrbanObservatoryFragment extends StatelessWidget {

  final _dataPoints = [
    'Temperature',
    'Temperature',
    'Temperature',
    'Temperature',
    'Temperature',
    'Temperature',
    'Temperature',
    'Temperature',
    'Temperature',
    'Temperature',
  ];

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
                  Scaffold(
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: Color(0xFF96B24A),
                      child: Icon(Icons.refresh),
                      onPressed: () => {}
                    ),
                    body: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              TextField(),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 16.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _dataPoints.length,
                                      itemBuilder: (context, index) {
                                        return DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFBDBDBD),
                                              border: Border.all(color: Colors.black),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Text(_dataPoints[index]),
                                            )
                                        );
                                      }
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                    ),
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