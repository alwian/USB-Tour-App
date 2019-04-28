/// Author: Mason Powell.
/// Student No. 170256018.

import 'package:csc2022_app/navigation/graph.dart';
import 'package:csc2022_app/navigation/node.dart';
import 'dart:collection';

/// Returns the [graph] with the [shortestPath] and [distance] set relative to the [source].
class Navigation {

  /// Calculates the [shortestPath] to the [source] from every other [Node].
  ///
  /// Goes through each [Node] in the [graph] and calculates the [shortestPath] to the
  /// [source] for that Node along with setting that Nodes [distance] to the source
  static Graph calculateShortestPathFromSource(Graph graph, Node source) {
    Node nSource;
    // Matches the passed in [source] with the one stored in the [graph] with the required data.
    for (Node u in graph.nodes) {
      if (u.name == source.name) {
        nSource = u;
        break;
      }
    }
    nSource.distance = 0;

    // The [Node]s that we are done looking at.
    Set<Node> settledNodes =
        {};
    // The [Node]s that are connected to the [currentNode] that we are looking at.
    Set<Node> unsettledNodes =
        {};

    unsettledNodes.add(nSource);

    while (unsettledNodes.length != 0) {
      // [unsettledNodes] should always have at least one [Node] in it until all nodes have been looked at.
      Node currentNode = _getLowestDistanceNode(unsettledNodes);
      unsettledNodes.remove(currentNode);

      for (MapEntry<Node, int> adjacencyPair
          in currentNode.adjacentNodes.entries) {

        // AdjacencyPair stores the key-value mapping.
        Node adjacentNode = adjacencyPair.key;
        // distance from [currentNode].
        int edgeWeight = adjacencyPair.value;
        if (!settledNodes.contains(adjacentNode)) {
          _calculateMinimumDistance(adjacentNode, edgeWeight, currentNode);
          unsettledNodes.add(adjacentNode);
        }
      }
      settledNodes.add(currentNode);
    }
    return graph;
  }

  /// Finds a [Node] with a lower [distance] than the previous.
  ///
  /// Goes through the [unsettledNodes] and compares the [distance] of the selected node
  /// with the currently set [lowestDistance], if it's lower then the [lowestDistanceNode]
  /// becomes the selected node and the lowest distance becomes the [nodeDistance].
  static Node _getLowestDistanceNode(Set<Node> unsettledNodes) {
    Node lowestDistanceNode;
    int lowestDistance = 9223372036854775807; //No max value constant in Dart.

    for (Node node in unsettledNodes) {
      int nodeDistance = node.distance;

      if (nodeDistance < lowestDistance) {
        lowestDistance = nodeDistance;
        lowestDistanceNode = node;
      }
    }

    return lowestDistanceNode;
  }

  /// Sets the [shortestPath] for the [evaluationNode].
  ///
  /// Checks if the [sourceNode.distance] + the [evaluationNode]s [edgeWeight] is less than
  /// the [evaluationNode.distance] and changes it to that if true, the
  /// [evaluationNode.shortestPath] is then set.
  static void _calculateMinimumDistance(Node evaluationNode, int edgeWeight, Node sourceNode) {
    int sourceDistance = sourceNode.distance;

    if (sourceDistance + edgeWeight < evaluationNode.distance) {
      evaluationNode.distance = (sourceDistance + edgeWeight);
      List<Node> shortestPath = new List.from(sourceNode.shortestPath);

      shortestPath.add(sourceNode);
      evaluationNode.shortestPath = shortestPath;

    }
  }

  /// Returns a [Queue] containing the path of [Node]s with [target] being the first entry.
  ///
  /// The returned Queue has its data input in a way that emulates a stack, by adding the data last,
  /// [Queue.removeLast()] then takes the "top" off of the Queue, the method adds the target to the queue
  /// then goes back through the [shortestPath] to get the nearest node and sets that as the next node
  /// to add.
  static Queue pathToTarget(Graph graph, Node source, Node target) {

    Queue<Node> path = new Queue(); //No stack object in Dart, a Queue can be used for FILO data structures
    Node nTarget;
    Node nSource;

    for (Node w in graph.nodes) {
      if (w.name == target.name) {
        nTarget = w;
        break;
      }
    }

    for (Node v in graph.nodes) {
      if (v.name == source.name) {
        nSource = v;
        break;
      }
    }

    // Only if the [Node] is reachable should we do something.
    if (nTarget == nSource || nTarget.shortestPath.isNotEmpty) {

      while (nTarget != null) {
        path.addLast(nTarget); // [addLast()] and [removeLast()] let the Queue represent a stack

        if (nTarget.shortestPath.isNotEmpty) {
          nTarget = nTarget.shortestPath.last;
          // ShortestPath has the path of nodes to the source,
          // with the last node also being the closest
          // node to our current.
        } else {
          return path;
        }
      }
    }
    return path;
  }
}
