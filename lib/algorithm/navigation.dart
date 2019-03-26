//Author: Mason Powell
//StuNo: 170256018
//Purpose: The algorithm itself

import 'graph.dart';
import 'node.dart';
import 'dart:collection';

class Navigation {
  static Graph calculateShortestPathFromSource(Graph graph, Node source) {
    print("cSPFS running");
    //Returns the graph with the shortestPath value and distance values set relative to the source
    source.distance = 0;

    Set<Node> settledNodes =
        {}; //Settled nodes are nodes that we have finished looking at
    Set<Node> unsettledNodes =
        {}; //Unsettled nodes are the nodes that are connected to the current node

    unsettledNodes.add(source);

    while (unsettledNodes.length != 0) {
      //Unsettled nodes should always have at least one node in it until all nodes have been looked at
      Node currentNode = getLowestDistanceNode(unsettledNodes);
      print("currentNode: " + currentNode.name);
      unsettledNodes.remove(currentNode);
      print("just before the loop");
print(currentNode.adjacentNodes.entries);
      for (MapEntry<Node, int> adjacencyPair
          in currentNode.adjacentNodes.entries) {
        print("running the loop");
        //AdjacencyPair stores the key-value mapping
        Node adjacentNode = adjacencyPair.key;
        print(adjacentNode);
        int edgeWeight = adjacencyPair.value; //Same as distance
        if (!settledNodes.contains(adjacentNode)) {
          calculateMinimumDistance(adjacentNode, edgeWeight, currentNode);
          unsettledNodes.add(adjacentNode);
        }
      }
      settledNodes.add(currentNode);
    }
    return graph;
  }

  static Node getLowestDistanceNode(Set<Node> unsettledNodes) {
    Node lowestDistanceNode;
    int lowestDistance = 9223372036854775807; //No max value constant in Dart

    for (Node node in unsettledNodes) {
      int nodeDistance = node.distance;

      if (nodeDistance < lowestDistance) {
        lowestDistance = nodeDistance;
        lowestDistanceNode = node;
      }
    }
    return lowestDistanceNode;
  }

  static void calculateMinimumDistance(
      Node evaluationNode, int edgeWeigh, Node sourceNode) {
    int sourceDistance = sourceNode.distance;

    if (sourceDistance + edgeWeigh < evaluationNode.distance) {
      evaluationNode.distance = (sourceDistance + edgeWeigh);
      List<Node> shortestPath = new List.from(sourceNode.shortestPath);

      shortestPath.add(sourceNode);
      evaluationNode.shortestPath = shortestPath;
      print("Eval node: " + evaluationNode.name);
      print(evaluationNode.shortestPath.isNotEmpty);
    }
  }

  static Queue pathToTarget(Graph graph, Node source, Node target) {
    //Returns a stack containing the path of nodes with target being the first entry
    Queue<Node> path = new Queue(); //No stack object in Dart, a Queue can be used for FILO data structures
    Node nTarget;
    Node nSource;

    for (Node w in graph.nodes) {
      if (w.name == target.name) {
        print("target found");
        nTarget = w;
        break;
      }
    }

    for (Node v in graph.nodes) {
      if (v.name == source.name) {
        print("source found");
        nSource = v;
        break;
      }
    }

    print(nTarget.shortestPath.isNotEmpty);
    if (nTarget == nSource || nTarget.shortestPath.isNotEmpty) {
      print("running1");
      //Only if the node is reachable should we do something
      while (nTarget != null) {
        print("running2");
        path.addLast(nTarget); //AddLast and removeLast let the Queue represent a stack

        if (nTarget.shortestPath.isNotEmpty) {
          print("running3");
          nTarget = nTarget.shortestPath.last;
          /* ShortestPath has the path of nodes to the source,
           * with the last node also being the closest
           * node to our current */
        } else {
          return path;
        }
      }
    }
    return path;
  }
}
