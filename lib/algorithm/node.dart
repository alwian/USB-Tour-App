/// Author Mason Powell
/// Student No. 170256018
/// Purpose: represents a node and the necessary describing data

class Node {

  String _name;

  List<Node> _shortestPath = [];  //List of nodes for the shortest path to start node

  int _distance = 9223372036854775807;  //No max value constant in Dart

  double coordsX = 0;
  double coordsY = 0;

  int get distance => _distance;

  set distance(int value) {
    _distance = value;
  }

  List<Node> get shortestPath => _shortestPath;

  set shortestPath(List<Node> value) {
    _shortestPath = value;
  }

  String get name => _name;

  Map<Node, int> adjacentNodes = {};

  Node(this._name);

  Node.fromDB(this._name, this.coordsX, this.coordsY);

  void addDestination(Node destination, int distance) {
    adjacentNodes[destination] = distance;
  }

  String toString(){
    return _name;
  }

  Node copy() {
    Node n = new Node(_name);
    n.coordsY = this.coordsY;
    n.coordsX = this.coordsX;
    n.adjacentNodes = Map.from(this.adjacentNodes);
    n.distance = this.distance;
    n.shortestPath = List.from(this.shortestPath);

    return n;
  }

}