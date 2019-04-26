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

  /// Returns all ids as a [List] of [String]s.
  /// Adapted from managers/explore_a_floor_manager getRooms method
  static Future<List<String>> getAllRooms() async {
    // Execute query to get required database rows.
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        'SELECT * FROM Rooms'
    );
    List<String> roomsId;
    // Create a [Room] for a ll rows returned from the DB query.
    for (Map<String, dynamic> m in queryResults) {
      roomsId.add(m['ID']);
    }

    return roomsId;
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

    debugPrint(directionsList.toString());

    return directionsList;
  }

  /// Return [Queue] of [Node]s of order between rooms given a [List] of [String]s containing
  /// the current room name and destination room name
  static Future<Queue<Node>> getDirectionsQueue(List<String> rooms) async {
    // Store startRoom floor as an integer
    int startFloor;
    if(rooms[0].substring(0, 1) == "G") {
      startFloor = 0;
    }

    //Import nodes and populate Graph of Nodes
    Graph startGraph = await NavigationManager.allNodeGraph();

    Node source;
    Node destination;

    // Store rooms as source and target nodes
    for (Node w in startGraph.nodes) {
      if (w.name == rooms[0]) {
        source = w;

        break;
      }
    }

    for (Node v in startGraph.nodes) {
      if (v.name == rooms[1]) {

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
      String destA = nodeList[i].name;
      String destB = nodeList[i-1].name;

      String r1;
      String r2;

      debugPrint('dd: $destA');
      debugPrint('db: $destB');

      //Query edge table for edge between the first and second nodes
      List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
          'SELECT B_to_A FROM Edge where Room_1_ID = \'$destA\' AND Room_2_ID = \'$destB\''
      );

      debugPrint(queryResults.toString());

      //For results, add to directions list
      for (Map<String, dynamic> m in queryResults) {
        debugPrint("r1: " + m["B_to_A"].toString());
        r1 = m["B_to_A"].toString();
      }

      //Search for link in other direction
      //Query edge table for edge between the first and second nodes
      List<Map<String, dynamic>> queryResults2 = await DatabaseHelper.query(
          'SELECT A_to_B FROM Edge where Room_1_ID = \'$destB\' AND Room_2_ID = \'$destA\''
      );

      debugPrint(queryResults.toString());

      //For results, add to directions list
      for (Map<String, dynamic> n in queryResults2) {
        debugPrint("r2: " + n["A_to_B"].toString());
        r2 = n["A_to_B"].toString();
      }

      //Check if directions are null
      if(r1 != null) {
        //Result 1 has results. Populate list
        directions.add(r1);
      } else if (r2 != null) {
        //r1 is null, r2 not. Add r2
        directions.add(r2);
      } else {
        //Error. Add error text and return list
        directions.add("Error. No route found between nodes: " + destA
            + ", " + destB);
        return directions;
      }
    }

    return directions;
  }
}