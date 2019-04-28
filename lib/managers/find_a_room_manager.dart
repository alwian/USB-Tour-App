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

/// @Author Connor Harris
/// @StudentNo 170346489

/// Handles data retrieval for a [SearchFormPage] or a [SearchResultsPage]
class FindARoomManager {

  /// Returns all ids as a [List] of [String]s.
  /// Adapted from managers/explore_a_floor_manager getRooms method
  static Future<List<String>> getAllRooms() async {
    // Execute query to get required database rows.
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        'SELECT * FROM Room'
    );

    List<String> roomsId = List<String>();
    // Add id to list for all rows returned from the DB query.
    for (Map<String, dynamic> m in queryResults) {
      roomsId.add(m['ID'].toString());
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
    // If source and destinatoin are equal, return error message
    if(formRooms[0] == formRooms[1]) {
      List<String> errorOut = ['You are already at your destination'];

      return errorOut;
    }

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
    }

    //Import nodes and populate Graph of Nodes
    Graph startGraph = await NavigationManager.allNodeGraph();

    Node source;
    Node destination;

    // Store room as source [Node]
    for (Node w in startGraph.nodes) {
      if (w.name == rooms[1]) {
        source = w;

        break;
      }
    }

    // Store room as target [Node]
    for (Node v in startGraph.nodes) {
      if (v.name == rooms[0]) {

        destination = v;
        break;
      }
    }

    //Init graph
    startGraph = Navigation.calculateShortestPathFromSource(startGraph, source);

    // Store directions from algorithm
    Queue<Node> directions = Navigation.pathToTarget(startGraph, source, destination);

    String s = directions.toString();

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

      //Query edge table for edge between the first and second nodes
      List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
          'SELECT A_to_B FROM Edge where Room_1_ID = \'$destA\' AND Room_2_ID = \'$destB\''
      );

      //For results, add to directions list
      for (Map<String, dynamic> m in queryResults) {
        r1 = m["A_to_B"].toString();
      }

      //Search for link in other direction
      //Query edge table for edge between the first and second nodes
      List<Map<String, dynamic>> queryResults2 = await DatabaseHelper.query(
          'SELECT B_to_A FROM Edge where Room_1_ID = \'$destB\' AND Room_2_ID = \'$destA\''
      );

      //For results, add to directions list
      for (Map<String, dynamic> n in queryResults2) {
        r2 = n["B_to_A"].toString();
      }

      //Check if directions are null or have text null as directions
      if(r1 != null && r1 != "NULL") {
        //Result 1 has results. Populate list
        directions.add(r1);
      } else if (r2 != null && r2 != "NULL") {
        //r1 is null, r2 not. Add r2
        directions.add(r2);
      }
    }

    //If list has no items, add error message
    if(directions.isEmpty) {
      directions.add("No route could be found");
    }

    return directions;
  }
}