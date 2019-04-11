/// Author: Alex Anderson
/// Student No: 170453905

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:csc2022_app/managers/urban_observatory_manager.dart';

/// Allows users to view sensor data about rooms in the Urban Sciences Building.
class UrbanObservatoryFragment extends StatefulWidget {

  /// The text to display in the about section of the page.
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

  /// Returns a [UrbanObservatoryFragmentState].
  @override
  State<StatefulWidget> createState() {
    return UrbanObservatoryFragmentState();
  }
}

/// A [State] of a [UrbanObservatoryFragment].
class UrbanObservatoryFragmentState extends State<UrbanObservatoryFragment> {

  /// Sensors that need to be displayed.
  List<Sensor> _dataPoints;

  /// Whether data is currently being fetched.
  bool _fetching = false;

  /// Whether a refresh was triggered by a pull to refresh.
  bool _pullRefresh = false;

  /// Whether there is an internet connection.
  bool connection = true;

  /// Controller for the room input field.
  final _controller = TextEditingController();

  /// The room currently being viewed.
  String _currentRoom;

  /// Disposes of [_controller].
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Runs on initial build of the state.
  @override
  void initState() {
    super.initState();
    // When connection changes, reload data.
    final subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (_currentRoom != null) {
        _loadSensorData(_currentRoom);
      }
    });
  }

  /// Builds the fragment.
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
                        // Only refresh if a room has been selected.
                        onPressed: () => _currentRoom != null ? {
                          _pullRefresh = false,
                          _loadSensorData(_currentRoom)
                        } : {}
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
                                // Display relevant Widget.
                                child: !connection ? Center(
                                  child: Text("Please check your internet connection"),
                                ) : _fetching && !_pullRefresh ? Center(
                                  child: CircularProgressIndicator(),
                                ) : _fetching && _pullRefresh ? Container()
                                  : !_fetching && _dataPoints == null ? Center(
                                  child: Text('No data requested'),
                                ) : _dataPoints.length == 0 ? Center(
                                  child: Text('No sensors available in this room'),
                                ) : RefreshIndicator(
                                  child: _listUI(),
                                  onRefresh: () {
                                    _pullRefresh = true;
                                    return _loadSensorData(_currentRoom);
                                  },
                                )
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

  /// Loads the sensor data for [room].
  Future<void> _loadSensorData(room) async {
    // set current room so data can be refreshed.
    _currentRoom = room;
    // Only load data if there is an internet connection.
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

  /// Checks for an internet connection.
  Future<bool> checkConnection() async {
    // Try to connect to the Urban Observatory website.
    try {
      final result = await InternetAddress.lookup('api.usb.urbanobservatory.ac.uk');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Returns a [Widget] containing the values for the sensors in [_currentRoom].
  Widget _listUI() {
    return Padding(
        padding: EdgeInsets.only(top: 16.0),
        // Create list of sensor data.
        child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
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
                        : Row(
                      children: <Widget>[
                        Text(_dataPoints[index].metric + ': '),
                        Text(
                          _dataPoints[index].value + ' ' + _dataPoints[index].unit,
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  )
              );
            }
        ),
    );
  }
}