import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    String dbsPath = await getDatabasesPath();
    String dbPath = join(dbsPath, "data.db");
    
    Database database = await openDatabase(dbPath);
    List<Map<String, dynamic>> queryResults;
    await database.transaction((txn) async {
      String query = "SELECT * FROM rooms WHERE floorId=$floor";
      queryResults = await txn.rawQuery(query);
    });

    List<Room> rooms = [];
    for (Map<String, dynamic> m in queryResults) {
      rooms.add(
        Room(m['name'], m['image'])
      );
    }
    return rooms;
  }

  static Future<List<RoomFeature>> getRoomFeatures(room) async {
    String dbsPath = await getDatabasesPath();
    String dbPath = join(dbsPath, "data.db");

    Database database = await openDatabase(dbPath);
    List<Map<String, dynamic>> queryResults;
    await database.transaction((txn) async {
      String query = "SELECT * FROM room_features WHERE room='$room'";
      queryResults = await txn.rawQuery(query);
    });

    List<RoomFeature> features = [];
    for (Map<String, dynamic> m in queryResults) {
      features.add(
          RoomFeature(m['description'], m['image'])
      );
    }
    return features;
  }
}