/// Author Mason Powell
/// Student No. 170256018

import 'package:csc2022_app/helpers/database_helper.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'package:csc2022_app/algorithm/graph.dart';

class Floor {
  //Stores info for each floor
  const Floor(this.name, this.path, this.floorNumber);

  final String name;
  final String path;
  final int floorNumber;
}

class NavigationManager {

  static Map<String, Node> nodes;

  /// Returns all the notable [Node]s for a given floor.
  static Future<Map<String, Node>> getRooms(int floor) async {
    // Execute query to get required database rows.
    List<Map<String, dynamic>> queryResults = await DatabaseHelper.query(
        'SELECT Name, XCoord, YCoord FROM Room WHERE ID LIKE $floor%'
    );

    // Create a [Node] for all rows returned from the DB query.
    for (Map<String, dynamic> m in queryResults) {
      nodes[m['ID']] = Node.fromDB(m['Name'],m['XCoord'],m['YCoord']);
    }

    return nodes;
  }

}