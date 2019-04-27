/// Author: Mason Powell.
/// Student No. 170256018.


import 'node.dart';

/// Represents a graph, just a set of nodes but could be expanded.
class Graph {
   Set<Node> nodes = {};
   int floorNumber;

   Graph();
   Graph.floor(this.floorNumber);

   /// Adds [nodeA] to the [nodes] [Set].
   void addNode(Node nodeA) {
     if(nodeA != null) {
       nodes.add(nodeA);
     }
   }
}