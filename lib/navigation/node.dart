/// Author: Mason Powell
/// Student No: 170256018

/// Represents a node and the necessary describing data.
class Node {

  /// The name of the area this represents.
  String _name;

  /// The unique id for the area this represents.
  String _id;

  /// A [List] of nodes for the shortest path to start node.
  List<Node> _shortestPath = [];

  /// An [int] initialised with the max possible value.
  int _distance = 9223372036854775807;  //No max value constant in Dart

  /// The X coordinate of this.
  double coordsX = 0;

  /// The Y coordinate of this.
  double coordsY = 0;

  /// Returns the distance assigned to this.
  int get distance => _distance;

  /// Sets distance.
  set distance(int value) {
    _distance = value;
  }

  /// The shortest path to this from a different [Node].
  List<Node> get shortestPath => _shortestPath;

  /// Sets the shortest path to this.
  set shortestPath(List<Node> value) {
    _shortestPath = value;
  }

  /// Returns the name of this.
  String get name => _name;

  /// Returns the id og this.
  String get id => _id;

  /// A [Map] of the nodes and their [distance]s reachable from this [Node].
  Map<Node, int> adjacentNodes = {};

  /// Defines a [Node].
  Node(this._name);
  Node.fromDB(this._name, this.coordsX, this.coordsY, this._id);

  /// Adds a reachable [destination] and its [distance] to [adjacentNodes].
  void addDestination(Node destination, int distance) {
    if(destination == this || distance < 0) {
      throw new ArgumentError("Invalid input");
    } else {
      if (distance == 0) {
        distance = 1;
      }
      adjacentNodes[destination] = distance;
    }
  }

  /// Returns the [String] representation of this.
  String toString(){
    return _name;
  }

  /// Creates a safe copy of this [Node].
  Node copy() {
    Node n = new Node.fromDB(_name, this.coordsX, this.coordsY, this._id);
    n.adjacentNodes = Map.from(this.adjacentNodes);
    n.distance = this.distance;
    n.shortestPath = List.from(this.shortestPath);

    return n;
  }

}