/// Author: Mason Powell.
/// Student No. 170256018.

import 'dart:collection';
import 'package:csc2022_app/helpers/database_helper.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'package:csc2022_app/algorithm/graph.dart';

/// A manager to deal with database operations
///
/// Can obtain [Node]s from the Room table and can use the Edge
/// table to generate a [Graph].
class NavigationManager {

  static Map<String, Node> nodes = new HashMap<String, Node>();

  /// Returns a [Future] of all the [Node]s for a given [floor].
  ///
  /// ```dart
  /// nodes = await NavigationManager.getNodes(floor);
  /// ```
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

  /// Returns a [Future] of a [Graph] for the given [floor]
  ///
  /// Queries the Edge table for all IDs and related weights for IDs that begin
  /// with the [floor] number along with associated staircases, then adds
  /// these edges to the [Node]s in [nodes] and finally adds these [Node]s
  /// to the [Graph].
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

      // Adds a 0 onto the end of IDs that had their output shortened
      // for example, 1.01 becomes 1.010.
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

  /// Returns a [Graph] of all nodes in the database
  static Future<Graph> allNodeGraph() async {
    //Variable to store number of floors (s included) to remove magic number
    int floorNo = 6;

    //Graph for output
    Graph graph = new Graph();

    //First, populate static nodes HashMap with all nodes from every floor (inc. s)

    //Add nodes for each floor in loop
    //
    for(int i = 0; i < floorNo; i++) {
      NavigationManager.getNodesById(i);
    }

    //Add nodes from every floor to graph
    for(int j = 0; j < floorNo; j++) {
      graph = await NavigationManager.getGraph(j);
    }

    return graph;
  }

  /// Returns a [Future] of all the [Node]s for a given [floor].
  ///
  /// ```dart
  /// nodes = await NavigationManager.getNodes(floor);
  /// ```
  static void getNodesById(int floor) async {
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
      nodes[m['ID']] = Node.fromDB(m['ID'], m['XCoord'].toDouble(), m['YCoord'].toDouble());
    }

  }
}