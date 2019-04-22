/// Author Mason Powell
/// Student No. 170256018

import 'dart:collection';
import 'package:csc2022_app/helpers/database_helper.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'package:csc2022_app/algorithm/graph.dart';

class NavigationManager {

  static Map<String, Node> nodes = new HashMap<String, Node>();

  /// Returns all the [Node]s for a given floor.
  static Future<Map<String, Node>> getNodes(int floor) async {
    nodes = new HashMap<String, Node>();
    String f;

    if (floor == 0) {
      f = 'G';
    } else {
      f = floor.toString();
    }
    // Execute query to get required database rows.
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        'SELECT ID, Name, XCoord, YCoord FROM Room WHERE ID LIKE \'$f%\''
    );

    // Create a [Node] for all rows returned from the DB query.
    for (Map<String, dynamic> m in queryResults) {
      nodes[m['ID']] = Node.fromDB(m['Name'], m['XCoord'].toDouble(), m['YCoord'].toDouble());
    }

    return nodes;
  }

  static Future<Graph> getGraph(int floor) async {
    Graph graph = Graph.floor(floor);
    String f;

    if (floor == 0) {
      f = 'G';
    } else {
      f = floor.toString();
    }

    // Execute query to get required database rows.
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        'SELECT Room_1_ID, Room_2_ID, Weight FROM Edge WHERE Room_1_ID LIKE \'$f%\' AND Room_2_ID LIKE \'$f%\''
    );

    for (Map<String, dynamic> m in queryResults) {
      nodes[m['Room_1_ID']].addDestination(nodes[m['Room_2_ID']], m['Weight']);
      nodes[m['Room_2_ID']].addDestination(nodes[m['Room_1_ID']], m['Weight']);
    }

    nodes.forEach((key, value) {
      graph.addNode(value);
    });

    return graph;
  }


}