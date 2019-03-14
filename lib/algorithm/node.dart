//Author: Mason Powell
//StuNo: 170256018

class Node {

  String _name;

  List<Node> _shortestPath = [];

  List<Node> get shortestPath => _shortestPath;

  set shortestPath(List<Node> value) {
    _shortestPath = value;
  }

  int _distance = 9223372036854775807;  //No max value constant in Dart

  int get distance => _distance;

  set distance(int value) {
    _distance = value;
  }

  Map<Node, int> adjacentNodes = {};

  Node(String name) {
    this._name = name;
  }

  void addDestination(Node destination, int distance) {
    adjacentNodes[destination] = distance;
  }


}