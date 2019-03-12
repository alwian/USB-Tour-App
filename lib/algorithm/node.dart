class Node {

  String _name;

  List<Node> _shortestPath = [];

  int _distance = 9223372036854775807;  //No max value constant in Dart

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