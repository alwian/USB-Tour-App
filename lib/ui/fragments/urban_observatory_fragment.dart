/// Author: Alex Anderson
/// Student No: 170453905

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:csc2022_app/managers/urban_observatory_manager.dart';

/// Allows users to view sensor data about rooms in the Urban Sciences Building.
class UrbanObservatoryFragment extends StatefulWidget {

  /// The text to display in the about section of the page.
  final String _aboutText = "The Urban Observatory provides real time sendor data from all over Newcastle,"
      " including the Urban Sciences Building.\n\nData collected will provide a long time baseline for "
      "urban research in Newcastle.\n\nUse the 'Pick a Room' tab to search different rooms in the "
      "building and see their recent sensor data.";

  /// Returns a [UrbanObservatoryFragmentState].
  @override
  State<StatefulWidget> createState() {
    return _UrbanObservatoryFragmentState();
  }
}

/// A [State] of a [UrbanObservatoryFragment].
class _UrbanObservatoryFragmentState extends State<UrbanObservatoryFragment> {

  /// Sensors that need to be displayed.
  List<Sensor> _dataPoints;

  /// Whether data is currently being fetched.
  bool _fetching = false;

  /// Whether a refresh was triggered by a pull to refresh.
  bool _pullRefresh = false;

  /// Whether there is an internet connection.
  bool _connection = true;

  /// Controller for the room input field.
  final TextEditingController _controller = TextEditingController();

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
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (_currentRoom != null) {
        _loadSensorData(_currentRoom);
      }
    });
  }

  /// Loads the sensor data for [room].
  Future<void> _loadSensorData(String room) async {
    // Set current room so data can be refreshed.
    _currentRoom = room;
    // Only load data if there is an internet connection.
    if (await _checkConnection()) {
      setState(() {
        _connection = true;
        _fetching = true;
      });
      _dataPoints = await UrbanObservatoryManager.getSensorData(room);
      setState(() {
        _fetching = false;
      });
    } else {
      setState(() {
        _connection = false;
      });
    }
  }

  /// Checks for an internet connection.
  Future<bool> _checkConnection() async {
    // Try to connect to the Urban Observatory website.
    try {
      final List<InternetAddress> result = await InternetAddress.lookup('api.usb.urbanobservatory.ac.uk');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Returns a [Widget] containing the values for the sensors in [_currentRoom].
  Widget _listUI() {
    return Padding(
        key: Key('sensor_data'),
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
                        : Container(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.body1,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: _dataPoints[index].metric + ': ',
                                  ),
                                  TextSpan(
                                      text: _dataPoints[index].value + ' ' + _dataPoints[index].unit,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  )
              );
            }
        ),
    );
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
                Tab(
                  // Key used for testing
                  key: Key('pick_a_room_tab'),
                  text: 'Pick a room',
                ),
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
                          child: Text(widget._aboutText),
                        )
                      ],
                    ),
                  ),
                  Scaffold(
                    floatingActionButton: FloatingActionButton(
                        key: Key('sensor_refresh'),
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
                                key: Key('room_input'),
                                controller: _controller,
                                style: TextStyle(
                                    fontSize: 20.0
                                ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter a room...',
                                    suffixIcon: IconButton(
                                        key: Key('search_btn'),
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
                                  child: !_connection ? Center(
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
}