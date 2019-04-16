/// @Author: Connor Harris
/// @Email c dot harris99@hotmail dot co dot uk

import 'package:csc2022_app/helpers/database_helper.dart';
import 'package:csc2022_app/managers/explore_a_floor_manager.dart';

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
}