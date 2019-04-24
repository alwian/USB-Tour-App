/// @Author: Connor Harris
/// @Email c dot harris99@hotmail dot co dot uk

import 'package:csc2022_app/helpers/database_helper.dart';
import 'package:csc2022_app/managers/explore_a_floor_manager.dart';
import 'package:csc2022_app/algorithm/navigation.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'package:csc2022_app/algorithm/graph.dart';
import 'package:csc2022_app/managers/navigation_manager.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'dart:developer';

class FindARoomManager {

  /// Returns all [Room]s.
  /// Adapted from managers/explore_a_floor_manager getRooms method
  static Future<List<Room>> getAllRooms() async {
    // Execute query to get required database rows.
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        'SELECT * FROM rooms'
    );
    List<Room> rooms = <Room>[];
    // Create a [Room] for a ll rows returned from the DB query.
    for (Map<String, dynamic> m in queryResults) {
      rooms.add(
          Room(m['name'], m['image'])
      );
    }
    return rooms;
  }

  /// Returns all [Room]s where name exists in the database.
  static Future<List<Room>> getRoom(String room) async {
    // Execute query, return rows
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        "SELECT * FROM rooms WHERE room='$room'"
    );
    List<Room> rooms = <Room>[];
    // Create a [Room] for a ll rows returned from the DB query.
    for (Map<String, dynamic> m in queryResults) {
      rooms.add(
          Room(m['name'], m['image'])
      );
    }
    return rooms;
  }

  /// Returns all [Room]s where name is similar to a name in the database.
  static Future<List<String>> getRoomSuggestions(String pattern) async {
    // Execute query, return rows
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        'SELECT ID FROM Room WHERE ID LIKE \'$pattern%\''
    );
    List<String> rooms = <String>[];
    // Create a [Room] for a ll rows returned from the DB query.
    for (Map<String, dynamic> m in queryResults) {
      rooms.add(
           m['ID']
      );
    }
    return rooms;
  }

  /// Easy user interface method to take rooms as [List] of [String]s
  /// and return directions as [List] of [String]s
  static Future<List<String>> getDirections(List<String> formRooms) async {
    Queue<Node> directionsQueue = await getDirectionsQueue(formRooms);
    List<String> directionsList = await getDirectionDetails(directionsQueue);

    return directionsList;
  }

  /// Return [Queue] of [Node]s of order between rooms given a [List] of [String]s containing
  /// the current room name and destination room name
  static Future<Queue<Node>> getDirectionsQueue(List<String> rooms) async {
    // Store startRoom floor as an integer
    int startFloor;
    if(rooms[0].substring(0, 1) == "G") {
      startFloor = 0;
    } else {
      //startFloor = int.parse(rooms[0].substring(0, 1));
    }

    //Import Nodes
    Map<String, Node> nodes = await NavigationManager.getNodes(1);
    //nodes = await NavigationManager.getNodes(1);
    //nodes = await NavigationManager.getNodes(2);
    //nodes = await NavigationManager.getNodes(3);
    //nodes = await NavigationManager.getNodes(4);
    nodes = await NavigationManager.getNodes(5);

    // Build Graph for floor of start node
    Graph startGraph = await NavigationManager.getGraph(1);
    //startGraph = await NavigationManager.getGraph(1);
    //startGraph = await NavigationManager.getGraph(2);
    //startGraph = await NavigationManager.getGraph(3);
    //startGraph = await NavigationManager.getGraph(4);
    startGraph = await NavigationManager.getGraph(5);

    Node source;
    Node destination;

    // Store rooms as source and target nodes
    for (Node w in startGraph.nodes) {
      if (w.id == rooms[0]) {
        source = w;

        break;
      }
    }

    for (Node v in startGraph.nodes) {
      if (v.id == rooms[1]) {

        destination = v;
        break;
      }
    }

    //Init graph
    startGraph = Navigation.calculateShortestPathFromSource(startGraph, source);

    // Store directions from algorithm
    Queue<Node> directions = Navigation.pathToTarget(startGraph, source, destination);

    String s = directions.toString();
    debugPrint('s: $s');
    log('s: $s');

    return directions;
  }
  
  /// Return [List] of [String]s storing directions given a queue of [Node]s
  static Future<List<String>> getDirectionDetails(Queue<Node> nodeQueue) async {

    //List to store directions
    List<String> directions = new List<String>();
    List<Node> nodeList = nodeQueue.toList();

    //Iterate over all but last node
    for(int i = nodeList.length-1; i >= 1; i--) {
      //Store name of node and if not null next node
      String destA = nodeList[i-1].id;
      String destB = nodeList[i].id;

      debugPrint('dd: $destA');
      debugPrint('db: $destB');

      //Query edge table for edge between the first and second nodes
      List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
          'SELECT A_to_B FROM Edge where Room_1_ID = \'$destA\' AND Room_2_ID = \'$destB\''
      );

      debugPrint('Got here 1');
      debugPrint(queryResults.toString());

      //For results, add to directions list
      for (Map<String, dynamic> m in queryResults) {
        debugPrint(m["A_to_B"].toString());
        directions.add(m["A_to_B"].toString());
      }
    }

    return directions;
  }
}