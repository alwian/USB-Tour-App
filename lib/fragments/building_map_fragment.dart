import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:photo_view/photo_view.dart';
import 'package:csc2022_app/algorithm/graph.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'package:csc2022_app/algorithm/navigation.dart';

class BuildingMapFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BuildingMapState();
}

class _BuildingMapState extends State<BuildingMapFragment> {
  final String selectedImage = 'assets/images/floor1_temp.png';
  int i = 1;
  final Node a = new Node('a');
  final Node f = new Node('f');
  Node _source;
  Node _target;
  _Route route;
  Queue path = new Queue();

  @override
  void initState() {
    super.initState();
    print("initialised");
    path.addLast(f);
    path.addLast(a);
    print(path.isNotEmpty);
    _source = a;
    _target = f;
    path = _Route(_source, _target).generateRoute();
    print(path.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    //if (path.isNotEmpty) {
     return Scaffold(
        body: Container(
          child: PhotoView.customChild(
            child: new CustomPaint(
                foregroundPainter: RoutePainter(path),
                child: Image(image: AssetImage(selectedImage))),
            minScale: PhotoViewComputedScale.contained,
           maxScale: 1.5,
            childSize: Size(4961, 3508),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.trip_origin),
              onPressed: () {
                  setState(() {
                    _sourceList();
                  });
                /*ListView(children: <Widget>[
                  Container(
                      child: RaisedButton(
                    onPressed: () {
                      source = a;
                    },
                    child: const Text('Node a'),
                  )),
                ]);*/
              },
            ),
            IconButton(
              icon: Icon(Icons.lens),
              onPressed: () {
                ListView(children: <Widget>[
                  Container(
                      child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _target = f;
                      });
                    },
                    child: const Text('Node a'),
                  )),
                ]);
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    /*} else {
      return Scaffold(
        body: Container(
          /*child: PhotoView(
            imageProvider: AssetImage(selectedImage),
            minScale: PhotoViewComputedScale.contained,
            maxScale: 1.5,
          ),*/
          child: PhotoView.customChild(
            child: new CustomPaint(
                foregroundPainter: RoutePainter(path),
                child: Image(image: AssetImage(selectedImage))),
            minScale: PhotoViewComputedScale.contained,
            maxScale: 1.5,
            childSize: Size(4961, 3508),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.trip_origin),
              onPressed: () {
                setState(() {
                  _sourceList();
                });
                /*ListView(children: <Widget>[
                  Container(
                      child: RaisedButton(
                    onPressed: () {
                      source = a;
                    },
                    child: const Text('Node a'),
                  )),
                ]);*/
              },
            ),
            IconButton(
              icon: Icon(Icons.lens),
              onPressed: () {
                setState(() {
                  ListView(children: <Widget>[
                    Container(
                        child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _target = f;
                        });
                      },
                      child: const Text('Node a'),
                    )),
                  ]);
                });
              },
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //path = _Route(source, _target).generateRoute();
          },
          tooltip: 'draw route',
          child: Icon(Icons.near_me),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );*/
    }


  Widget _sourceList() {
    print("working1");
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (context, i) {
          print("working2");
          return _buildRow();
        });
  }

  Widget _buildRow() {
    return new ListTile(title: Text(a.name));
  }
}

class RoutePainter extends CustomPainter {
  Queue path;
  RoutePainter(Queue path) {
    this.path = Queue.from(path);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.indigoAccent;
    paint.strokeWidth = 5;

    /* Path p = new Path();
    p.lineTo(size.height - , size.width);

    canvas.drawPath(p,paint); */

    /*Node node1 = path.removeLast();
    Node node2 = path.removeLast();
    int length = path.length;
    for (int i = 0; i < length; i++) {
      canvas.drawLine(Offset(node1.coordsY, node1.coordsX),
          Offset(node2.coordsY, node2.coordsX), paint);
      node1 = node2;
      node2 = path.removeLast();
      print("painting1");
    }*/
    canvas.drawLine(Offset(0, 0),
        Offset(-10, -10), paint);
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

  Node a = new Node("a");
  Node b = new Node("b");
  Node c = new Node("c");
  Node d = new Node("d");
  Node e = new Node("e");
  Node f = new Node("f");

  _Route(Node source, Node target) {
    a.addDestination(b, 10);
    a.addDestination(c, 15);

    b.addDestination(d, 12);
    b.addDestination(f, 15);

    c.addDestination(e, 10);

    d.addDestination(e, 2);
    d.addDestination(f, 1);

    f.addDestination(e, 5);
    print(a.adjacentNodes);

    graph.addNode(a);
    graph.addNode(b);
    graph.addNode(c);
    graph.addNode(d);
    graph.addNode(e);
    graph.addNode(f);


    this.source = source;
    this.target = target;

    graph = Navigation.calculateShortestPathFromSource(graph, this.source);
  }

  Queue generateRoute() {
    print(source.name);
    print(target.name);
    print(graph.nodes);
    route = Queue.from(Navigation.pathToTarget(graph, source, target));
    return route;
  }
}
