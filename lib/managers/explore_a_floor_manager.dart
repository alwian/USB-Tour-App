/// Author: Alex Anderson
/// Student No: 170453905

import 'package:csc2022_app/helpers/database_helper.dart';

/// Represents a notable room in the Urban Sciences Building.
class Room {

  /// The name of the [Room].
  String name;

  /// The name of an image to represent the [Room].
  String image;

  /// Defines a [Room].
  Room(this.name, this.image);
}

/// Represents a notable feature in a [Room], inside of the Urban Sciences Building.
class RoomFeature {

  /// A description of the [RoomFeature].
  String description;

  /// The name of an image to represent the [RoomFeature].
  String image;

  /// Defines a [RoomFeature].
  RoomFeature(this.description, this.image);
}

/// Handles data retrieval for a [FloorFeatureListPage] or a [RoomFeatureListPage].
class ExploreAFloorManager {

  /// Returns all the notable [Room]s for a given floor.
  static Future<List<Room>> getRooms(floor) async {
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        'SELECT * FROM rooms WHERE floorId=$floor'
    );
    List<Room> rooms = [];
    for (Map<String, dynamic> m in queryResults) {
      rooms.add(
        Room(m['name'], m['image'])
      );
    }
    return rooms;
  }

  /// Returns all the notable [RoomFeature]s for a [Room].
  static Future<List<RoomFeature>> getRoomFeatures(room) async {
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        "SELECT * FROM room_features WHERE room='$room'"
    );
    List<RoomFeature> features = [];
    for (Map<String, dynamic> m in queryResults) {
      features.add(
          RoomFeature(m['description'], m['image'])
      );
    }
    return features;
  }
}