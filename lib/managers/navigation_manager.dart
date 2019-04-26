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
    int s;
    int s2;

    if (floor == 0) {
      f = 'G';
      s = 1;
      s2 = 1;
    } else {
      f = floor.toString();
      s = floor;
      s2 = floor + 1;
    }
    // Execute query to get required database rows.
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        'SELECT ID, Name, XCoord, YCoord FROM Room WHERE ID LIKE \'$f%\' OR (ID = \'S.00$s\' OR ID = \'S.00$s2\')'
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
    int s;
    int s2;
    String id;
    String id2;

    if (floor == 0) {
      f = 'G';
      s = 1;
      s2 = 1;
    } else {
      f = floor.toString();
      s = floor;
      s2 = floor + 1;

    }

    // Execute query to get required database rows.
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        'SELECT Room_1_ID, Room_2_ID, Weight FROM Edge WHERE (Room_1_ID LIKE \'$f%\' OR (Room_1_ID = \'S.00$s\' OR Room_1_ID = \'S.00$s2\')) AND (Room_2_ID LIKE \'$f%\' OR (Room_2_ID = \'S.00$s\' OR Room_2_ID = \'S.00$s2\'))'
    );

    for (Map<String, dynamic> m in queryResults) {

      id = m['Room_1_ID'].toString().padRight(5, '0');
      id2 = m['Room_2_ID'].toString().padRight(5, '0');

      nodes[id].addDestination(nodes[id2], m['Weight']);
      nodes[id2].addDestination(nodes[id], m['Weight']);
    }

    nodes.forEach((key, value) {
      graph.addNode(value);
    });
    return graph;
  }


}