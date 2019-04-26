/// Author: Mason Powell.
/// Student No. 170256018.

import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:photo_view/photo_view.dart';
import 'package:csc2022_app/algorithm/graph.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'package:csc2022_app/algorithm/navigation.dart';
import 'package:csc2022_app/managers/navigation_manager.dart';

class Floor {
  //Stores info for each floor.
  Floor(this.name, this.path, this.floorNumber);

  final String name;
  final String path;
  final int floorNumber;
  Graph graph;
}

class BuildingMapFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BuildingMapState();
}

class _BuildingMapState extends State<BuildingMapFragment> {
  Floor floor0 = Floor('Ground floor', 'assets/images/floor0.png', 0);
  Floor floor1 = Floor('Floor 1', 'assets/images/floor1.png', 1);
  Floor floor2 = Floor('Floor 2', 'assets/images/floor2.png', 2);
  Floor floor3 = Floor('Floor 3', 'assets/images/floor3.png', 3);
  Floor floor4 = Floor('Floor 4', 'assets/images/floor4.png', 4);
  Floor selectedFloor;
  Floor dropdownValue;
  int floorNum;
  List<Floor> floors;
  Map<String, Node> nodes;

  Node _source;
  Node _target;
  _Route route;

  Queue<Node> path = new Queue<Node>();
  List<List<Node>> floorNodes = new List<List<Node>>();

  bool sourceListOpen = false;
  bool targetListOpen = false;

  @override
  void initState() {
    super.initState();
    floors = <Floor>[floor0, floor1, floor2, floor3, floor4];
    for (int i = 0; i < 5; i++) {
      floorNodes.add(new List<Node>());
    }
    _loadElements(floorNodes, floors);

    //Initialisation for the floor selection.
    selectedFloor = floor0;
    dropdownValue = floor0;
    floorNum = 0;

  }

  Future<void> _loadNodes(int floor, List<Node> floorList) async {
    nodes = await NavigationManager.getNodes(floor);

    setState(() {
      for (Node n in nodes.values) {
        floorList.add(n);
      }
    });
  }

  Future<void> _loadGraph(Floor floor) async {
    floor.graph = await NavigationManager.getGraph(floor.floorNumber);
    setState(() {});
  }

  Future<void> _loadElements(
      List<List<Node>> floorNodes, List<Floor> floors) async {
    for (int i = 0; i < 5; i++) {
      await _loadNodes(i, floorNodes[i]);
      await _loadGraph(floors[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (path.isNotEmpty) {
      return Scaffold(
        body: Column(children: <Widget>[
          DropdownButton<Floor>(
            value: dropdownValue,
            onChanged: (Floor newValue) {
              setState(() {
                dropdownValue = newValue;
                selectedFloor = newValue;
                floorNum = newValue.floorNumber;

                path = new Queue<Node>(); //Empties the path.
              });
            },
            items: floors.map<DropdownMenuItem<Floor>>((Floor value) {
              return DropdownMenuItem<Floor>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
          ),
          Expanded(
            child: Container(
              child: PhotoView.customChild(
                child: new CustomPaint(
                    foregroundPainter: RoutePainter(path),
                    child: Image(image: AssetImage(selectedFloor.path))),
                minScale: PhotoViewComputedScale.contained,
                maxScale: 1.5,
                //The height of the currently used images, need changing from magic numbers.
                childSize: Size(4961, 3508),
                backgroundDecoration: new BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ]),
        bottomNavigationBar: BottomAppBar(
            child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.trip_origin),
              onPressed: () {
                setState(() {
                  _navigateAndDisplayRoomList(context, 1);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.lens),
              onPressed: () {
                setState(() {
                  _navigateAndDisplayRoomList(context, 2);
                });
              },
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_source == null || _target == null) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content:
                      new Text("Both source and target must be selected first"),
                ));
              } else {
                path = _Route(_source, _target, floorNum, selectedFloor.graph)
                    .generateRoute();
              }
            });
          },
          tooltip: 'draw route',
          child: Icon(Icons.near_me),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    } else {
      return Scaffold(
        body: Column(children: <Widget>[
          DropdownButton<Floor>(
            value: dropdownValue,
            onChanged: (Floor newValue) {
              setState(() {
                dropdownValue = newValue;
                selectedFloor = newValue;
                floorNum = newValue.floorNumber;
                path = new Queue<Node>(); //empties the path
              });
            },
            items: floors.map<DropdownMenuItem<Floor>>((Floor value) {
              return DropdownMenuItem<Floor>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
          ),
          Expanded(
            child: Container(
              child: PhotoView(
                imageProvider: AssetImage(selectedFloor.path),
                minScale: PhotoViewComputedScale.contained,
                maxScale: 1.5,
                backgroundDecoration: new BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
        bottomNavigationBar: BottomAppBar(
            child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.trip_origin),
              onPressed: () {
                setState(() {
                  _navigateAndDisplayRoomList(context, 1);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.lens),
              onPressed: () {
                setState(() {
                  _navigateAndDisplayRoomList(context, 2);
                });
              },
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_source == null || _target == null) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content:
                      new Text("Both source and target must be selected first"),
                ));
              } else {
                path = _Route(_source, _target, floorNum, selectedFloor.graph)
                    .generateRoute();
              }
            });
          },
          tooltip: 'draw route',
          child: Icon(Icons.near_me),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }

  _navigateAndDisplayRoomList(BuildContext context, int sot) async {
    // returns a future that will complete after we call
    // Navigator.pop on RoomList.
    if (sot == 1) {
      _source = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RoomList(sot, floorNum, _source, _target, floorNodes)));
    } else if (sot == 2) {
      _target = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RoomList(sot, floorNum, _source, _target, floorNodes)));
    }
  }
}

class RoomList extends StatelessWidget {
  int sot;
  int floorNum;
  Node _source;
  Node _target;
  List<List<Node>> floorNodes;

  RoomList(@override this.sot, @override this.floorNum, @override this._source,
      @override this._target, @override this.floorNodes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select a room'),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: floorNodes[floorNum].length,
            //List of all the nodes on the specified floor (floorNum).
            itemBuilder: (context, i) {
              return new ListTile(
                  //The name of node i in list floorNum.
                  title: Text(floorNodes[floorNum][i].name),
                  onTap: () {
                    if (sot == 1) {
                      //1 means we are setting the source.
                      if (floorNodes[floorNum][i] == _target) {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content:
                              new Text("Can't have matching source and target"),
                        ));
                      } else {
                        _source = floorNodes[floorNum][i];
                        Navigator.pop(context, _source);
                      }
                    } else if (sot == 2) {
                      //2 means we are setting the target.
                      if (floorNodes[floorNum][i] == _source) {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content:
                              new Text("Can't have matching source and target"),
                        ));
                      } else {
                        _target = floorNodes[floorNum][i];
                        Navigator.pop(context, _target);
                      }
                    }
                  });
            }));
  }
}

class RoutePainter extends CustomPainter {
  ListQueue<Node> path;
  RoutePainter(Queue<Node> path) {
    this.path = Queue<Node>.from(path);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.indigoAccent;
    paint.strokeWidth = 20;

    Node node1 = path.elementAt(path.length - 1);
    Node node2 = path.elementAt(path.length - 2);
    int length = path.length - 3;
    canvas.drawLine(Offset(node1.coordsX, node1.coordsY),
        Offset(node2.coordsX, node2.coordsY), paint);
    canvas.drawCircle(
        Offset(node1.coordsX, node1.coordsY), size.width / 60, paint);

    for (int i = length; i >= 0; i--) {
      node1 = node2.copy();
      node2 = path.elementAt(i);
      canvas.drawLine(Offset(node1.coordsX, node1.coordsY),
          Offset(node2.coordsX, node2.coordsY), paint);
      canvas.drawCircle(
          Offset(node1.coordsX, node1.coordsY), size.width / 90, paint);
      if (i == 0) {
        canvas.drawCircle(
            Offset(node2.coordsX, node2.coordsY), size.width / 60, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _Route {
  Node source;
  Node target;
  Graph currentGraph;
  Queue<Node> route;

  _Route(Node source, Node target, int floor, Graph graph) {
    currentGraph = graph;

    this.source = source;
    this.target = target;
    if (currentGraph != null) {
      currentGraph =
          Navigation.calculateShortestPathFromSource(currentGraph, this.source);
    }
  }

  Queue<Node> generateRoute() {
    route =
        Queue<Node>.from(Navigation.pathToTarget(currentGraph, source, target));
    return route;
  }
}
