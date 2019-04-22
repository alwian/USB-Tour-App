/// @Author: Connor Harris
/// @Email c dot harris99@hotmail dot co dot uk

import 'package:csc2022_app/helpers/database_helper.dart';
import 'package:csc2022_app/managers/explore_a_floor_manager.dart';
import 'package:csc2022_app/algorithm/navigation.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'dart:collection';

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
        'SELECT * FROM rooms WHERE name LIKE \'$pattern%\''
    );
    List<String> rooms = <String>[];
    // Create a [Room] for a ll rows returned from the DB query.
    for (Map<String, dynamic> m in queryResults) {
      rooms.add(
          Room(m['name'], m['image']).name
      );
    }
    return rooms;
  }

  /// Return [List] of [String]s storing directions given a queue of [Node]s
  static Future<List<String>> getDirectionDetails(Queue<Node> nodeQueue) async {
    //List to store directions
    List<String> directions = new List<String>();

    //Iterate over all but last node
    for(int i = 0; i < nodeQueue.length -1; i++) {
      //Store name of node and if not null next node
      String destA = nodeQueue.removeLast().name;
      String destB = nodeQueue.removeLast().name;

      //Query edge table for edge between the first and second nodes
      List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
          "SELECT `A to B` FROM `Edge` where `Room 1 ID` = " + destA + " AND `Room 2 ID` = " + destB
      );

      //For results, add to directions list
      for (Map<String, dynamic> m in queryResults) {
        directions.add(m["`A to B`"]);
      }
    }

    return directions;
  }
}