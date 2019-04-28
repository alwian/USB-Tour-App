/// Author: Mason Powell
/// Student No: 170256018

import 'package:csc2022_app/navigation/node.dart';

/// Represents a graph, just a set of nodes but could be expanded.
class Graph {

   /// The nodes in the graph.
   Set<Node> nodes = {};

   /// The floor the graph represents.
   int floorNumber;

   Graph();
   Graph.floor(this.floorNumber);

   /// Adds [nodeA] to the [nodes] [Set].
   void addNode(Node nodeA) {
     nodes.add(nodeA);
   }
}