import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csc2022_app/managers/urban_observatory_manager.dart';

class UrbanObservatoryFragment extends StatefulWidget {
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
  State<StatefulWidget> createState() {
    return UrbanObservatoryFragmentState();
  }
}

class UrbanObservatoryFragmentState extends State<UrbanObservatoryFragment> {
  List<Sensor> _dataPoints;
  bool _fetching = false;
  bool connection = true;
  final _controller = TextEditingController();
  String _currentRoom;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                          child: Text(widget._placeholderAbout),
                        )
                      ],
                    ),
                  ),
                  Scaffold(
                    floatingActionButton: FloatingActionButton(
                        backgroundColor: Color(0xFF96B24A),
                        child: Icon(Icons.refresh),
                        onPressed: () => _currentRoom != null ? _loadSensorData(_currentRoom) : {}
                    ),
                    body: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: _controller,
                                style: TextStyle(
                                    fontSize: 20.0
                                ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter a room...',
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.search),
                                        onPressed: () => {
                                          FocusScope.of(context).requestFocus(FocusNode()),
                                          _loadSensorData(_controller.text)
                                        }
                                    )
                                ),
                              ),
                              Expanded(
                                child: !connection ? Center(
                                  child: Text("Please check your internet connection"),
                                ) : _fetching ? Center(
                                  child: CircularProgressIndicator(),
                                ) : !_fetching && _dataPoints == null ? Center(
                                  child: Text('No data requested'),
                                ) : _dataPoints.length == 0 ? Center(
                                  child: Text('No sensors available in this room'),
                                ) :_listUI(),
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

  Future<void> _loadSensorData(room) async {
    _currentRoom = room;
    if (await checkConnection()) {
      setState(() {
        connection = true;
        _fetching = true;
      });
      _dataPoints = await UrbanObservatoryManager.getSensorData(room);
      setState(() {
        _fetching = false;
      });
    } else {
      setState(() {
        connection = false;
      });
    }
  }

  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('api.usb.urbanobservatory.ac.uk');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Widget _listUI() {
    return Padding(
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
                    child: _dataPoints[index].unit == 'separator' ?
                        Text(
                            _dataPoints[index].metric,
                            style: TextStyle(
                              fontSize: 22.0
                            ),
                        )
                        : Text(_dataPoints[index].toString()),
                  )
              );
            }
        ),
    );
  }
}