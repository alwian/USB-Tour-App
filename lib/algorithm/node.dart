//Author: Mason Powell
//StuNo: 170256018
//Purpose: represents a node and the necessary describing data

class Node {

  String _name;

  List<Node> _shortestPath = [];  //List of nodes for the shortest path to start node

  int _distance = 9223372036854775807;  //No max value constant in Dart

  int get distance => _distance;

  set distance(int value) {
    _distance = value;
  }

  List<Node> get shortestPath => _shortestPath;

  set shortestPath(List<Node> value) {
    _shortestPath = value;
  }

  Map<Node, int> adjacentNodes = {};

  Node(String name) {
    this._name = name;
  }

  void addDestination(Node destination, int distance) {
    adjacentNodes[destination] = distance;
  }


}