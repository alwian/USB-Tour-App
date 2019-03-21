import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:photo_view/photo_view.dart';
import 'package:csc2022_app/algorithm/graph.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'package:csc2022_app/algorithm/navigation.dart';

class BuildingMapFragment extends StatelessWidget {
  String selectedImage = 'assets/images/floor1_temp.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Container(
      child: PhotoView.customChild(
        child: new CustomPaint(
            foregroundPainter: RoutePainter(),
            child: Image(image: AssetImage(selectedImage))),
        minScale: PhotoViewComputedScale.contained,
        maxScale: 1.5,
      ),
    ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _Route.generateRoute(),
        tooltip: 'draw route',
        child: Icon(Icons.near_me),
      ),);
  }
}

class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.indigoAccent;
    paint.strokeWidth = 5;

    /* Path p = new Path();
    p.lineTo(size.height - , size.width);

    canvas.drawPath(p,paint); */

    Node node1 = path.removeLast();
    Node node2 = path.removeLast();
    int length = path.size;
    for (int i = 0; i < length; i++) {
      canvas.drawLine(Offset(node1.coordsY, node1.coordsX),
          Offset(node2.coordsY, node2.coordsX), paint);
      node1 = node2;
      node2 = path.removeLast();
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
    Graph graph;
    Queue route;

  _Route(Node source, Node target) {
    this.source = source;
    this.target = target;

    graph = Navigation.calculateShortestPathFromSource(graph, this.source);
  }

  Queue generateRoute(){
    route = Navigation.pathToTarget(graph, source, target);
    return route;
  }




}
