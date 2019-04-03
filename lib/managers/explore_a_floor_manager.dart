import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Room {
  String name;
  String image;

  Room(this.name, this.image);
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
}