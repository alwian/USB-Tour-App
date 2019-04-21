/// Author: Mason Powell
/// Student No. 170256018

import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:photo_view/photo_view.dart';
import 'package:csc2022_app/algorithm/graph.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'package:csc2022_app/algorithm/navigation.dart';

class Floor {
  //Stores info for each floor
  const Floor(this.name, this.path, this.floorNumber);

  final String name;
  final String path;
  final int floorNumber;
}

class BuildingMapFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BuildingMapState();
}

class _BuildingMapState extends State<BuildingMapFragment> {
  Floor floor0 = Floor('Ground floor', 'assets/images/floor0_temp.png', 0);
  Floor floor1 = Floor('Floor 1', 'assets/images/floor1.png', 1);
  Floor floor2 = Floor('Floor 2', 'assets/images/floor2.png', 2);
  Floor floor3 = Floor('Floor 3', 'assets/images/floor3.png', 3);
  Floor floor4 = Floor('Floor 4', 'assets/images/floor4.png', 4);
  Floor selectedFloor;
  Floor dropdownValue;
  int floorNum;
  List<Floor> floors;

  Node _source;
  Node _target;
  _Route route;
  Queue path = new Queue();
  List<List<Node>> floorNodes = new List<List<Node>>();

  //test code
  //final Node a = new Node('a');
  //final Node g = new Node('g');

  bool sourceListOpen = false;
  bool targetListOpen = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      floorNodes.add(new List<Node>());
    }
    floors = <Floor>[floor0, floor1, floor2, floor3, floor4];

    //Initial test code until connection to database is established
    //floorNodes[1].add(a);
    //floorNodes[1].add(g);

    //initialisation for the floor selection
    selectedFloor = floor0;
    dropdownValue = floor0;
    floorNum = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (sourceListOpen == true) {
      return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount:
              floorNodes[floorNum].length, //list of all the nodes on the specified floor (floorNum)
          itemBuilder: (context, i) {
            return new ListTile(
                title: Text(floorNodes[floorNum][i].name),  //the name of node i in list floorNum
                onTap: () {
                  if (floorNodes[floorNum][i] == _target) {
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content:
                          new Text("Can't have matching source and target"),
                    ));
                  } else {
                    setState(() {
                      _source = floorNodes[floorNum][i];
                      sourceListOpen = false; //closes list
                    });
                  }
                });
          });
    } else if (targetListOpen == true) {
      return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount:
              floorNodes[floorNum].length, //list of all the nodes on the specified floor (floorNum)
          itemBuilder: (context, i) {
            return new ListTile(
                title: Text(floorNodes[floorNum][i].name),  //the name of node i in list floorNum
                onTap: () {
                  if (floorNodes[floorNum][i] == _source) {
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content:
                          new Text("Can't have matching source and target"),
                    ));
                  } else {
                    setState(() {
                      _target = floorNodes[floorNum][i];
                      targetListOpen = false; //closes list
                    });
                  }
                });
          });
    } else {
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
                  path = new Queue(); //empties the path
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
                  childSize: Size(4961, 3508),  //the height of the currently used images, need changing from magic numbers
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
                    sourceListOpen = true;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.lens),
                onPressed: () {
                  setState(() {
                    targetListOpen = true;
                  });
                },
              ),
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                path = _Route(_source, _target).generateRoute();
              });
            },
            tooltip: 'draw route',
            child: Icon(Icons.near_me),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                  path = new Queue(); //empties the path
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
                    sourceListOpen = true;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.lens),
                onPressed: () {
                  setState(() {
                    targetListOpen = true;
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
                    content: new Text(
                        "Both source and target must be selected first"),
                  ));
                } else {
                  path = _Route(_source, _target).generateRoute();
                }
              });
            },
            tooltip: 'draw route',
            child: Icon(Icons.near_me),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      }
    }
  }
}

class RoutePainter extends CustomPainter {
  ListQueue path;
  RoutePainter(Queue path) {
    this.path = Queue.from(path);
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
  Graph graph = new Graph();
  Queue route;

  //these nodes would already be in the database, but for now they're just local for testing
  /*Node a = new Node("a");
  Node b = new Node("b");
  Node c = new Node("c");
  Node d = new Node("d");
  Node e = new Node("e");
  Node f = new Node("f");
  Node g = new Node("g");*/

  _Route(Node source, Node target) {
    //pre-initialisation test code start
    /*a.addDestination(b, 10);
    a.addDestination(c, 15);
    a.coordsX = 3112;
    a.coordsY = 1176;

    b.addDestination(d, 12);
    b.addDestination(f, 15);
    b.coordsX = 1812;
    b.coordsY = 1137;

    c.addDestination(e, 10);
    c.coordsX = 1455;
    c.coordsY = 1065;

    d.addDestination(e, 2);
    d.addDestination(f, 1);
    d.coordsX = 1377;
    d.coordsY = 1399;

    f.addDestination(e, 5);
    f.addDestination(g, 5);
    f.coordsX = 1377;
    f.coordsY = 2800;

    e.coordsX = 602;
    e.coordsY = 3100;

    g.coordsX = 964;
    g.coordsY = 2872;

    graph.addNode(a);
    graph.addNode(b);
    graph.addNode(c);
    graph.addNode(d);
    graph.addNode(e);
    graph.addNode(f);
    graph.addNode(g);*/
    //end

    this.source = source;
    this.target = target;

    graph = Navigation.calculateShortestPathFromSource(graph, this.source);
  }

  Queue generateRoute() {
    route = Queue.from(Navigation.pathToTarget(graph, source, target));
    return route;
  }
}
