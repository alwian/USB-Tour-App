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

  final _placeholderAbout = 'Lorem ipsum dolor sit amet, consectetur adipiscing'
      ' elit. Aliquam tempus ac risus in iaculis. Quisque placerat a lectus '
      'non pretium. Cras congue aliquam arcu, eget dictum ipsum ornare quis. '
      'Sed quis ipsum nec odio pulvinar ullamcorper eget vel turpis. '
      'Donec molestie neque sit amet pharetra fringilla. Quisque ut '
      'tellus non orci porttitor porttitor. Proin facilisis lorem id '
      'fringilla sagittis. Mauris non magna auctor, tincidunt nibh in, '
      'molestie lacus. Ut pharetra in justo sed luctus. Sed quis sem massa. '
      'In hac habitasse platea dictumst. Donec et dignissim magna. Nunc in '
      'finibus dui. ';

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
              indicatorColor: Color(0xFF96B24A),
              unselectedLabelColor: Colors.black,
              labelColor: Color(0xFF96B24A),
              tabs: <Widget>[
                Tab(text: 'About'),
                Tab(text: 'Pick a room'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/images/observatory.png'),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Text(_placeholderAbout),
                        )
                      ],
                    ),
                  ),
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
                              TextField(
                                style: TextStyle(
                                  fontSize: 20.0
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter a room...',

                                ),
                              ),
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
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.black,
                                                )
                                              )
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