import 'package:csc2022_app/helpers/database_helper.dart';

class Room {
  String name;
  String image;

  Room(this.name, this.image);
}

class RoomFeature {
  String description;
  String image;

  RoomFeature(this.description, this.image);
}

class ExploreAFloorManager {
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