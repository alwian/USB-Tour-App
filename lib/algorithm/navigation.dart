//Author: Mason Powell
//StuNo: 170256018

import 'graph.dart';
import 'node.dart';

class Navigation {

  static Graph calculateShortestPathFromSource(Graph graph, Node source){
    source.distance = 0;

    Set<Node> settledNodes = {};
    Set<Node> unsettledNodes = {};

    unsettledNodes.add(source);

    while (unsettledNodes.length != 0) {
      Node currentNode = getLowestDistanceNode(unsettledNodes);
      unsettledNodes.remove(currentNode);

      for(MapEntry<Node,int> adjacencyPair in currentNode.adjacentNodes.entries){
        Node adjacentNode = adjacencyPair.key;
        int edgeWeight = adjacencyPair.value;
        if(!settledNodes.contains(adjacentNode)) {
          calculateMinimumDistance(adjacentNode, edgeWeight, currentNode);
          unsettledNodes.add(adjacentNode);
        }
      }
      settledNodes.add(currentNode);
    }
    return graph;

  }

  static Node getLowestDistanceNode(Set<Node> unsettledNodes){
    Node lowestDistanceNode;
    int lowestDistance = 9223372036854775807;

    for(Node node in unsettledNodes){
      int nodeDistance = node.distance;

      if(nodeDistance < lowestDistance) {
        lowestDistance = nodeDistance;
        lowestDistanceNode = node;
      }
    }
    return lowestDistanceNode;
  }

  static void calculateMinimumDistance(Node evaluationNode, int edgeWeigh, Node sourceNode) {
    int sourceDistance = sourceNode.distance;

    if(sourceDistance + edgeWeigh < evaluationNode.distance){
      evaluationNode.distance = (sourceDistance + edgeWeigh);
      List<Node> shortestPath = new List.from(sourceNode.shortestPath);

      shortestPath.add(sourceNode);
      evaluationNode.shortestPath = shortestPath;
    }
  }

}
