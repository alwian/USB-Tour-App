//Author: Mason Powell
//StuNo: 170256018
//Purpose: Represents a graph, just a set of nodes but could be expanded

import 'node.dart';

class Graph {
   Set<Node> nodes = {};

   void addNode(Node nodeA) {
     nodes.add(nodeA);
   }
}