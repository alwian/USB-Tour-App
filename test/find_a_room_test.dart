import 'package:test/test.dart';
import 'package:csc2022_app/managers/find_a_room_manager.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'dart:collection';
import 'package:sqflite/sqflite.dart';

/// @Author: Connor Harris
/// @StudentNo: 170346489
/// File to test find_a_room

/// Main method to run tests
void main() {

  // Test for retrieving all room ids from database
  group('Getting all Rooms data', () {
    //Test not empty
    test('Getting room data', () async {
      List<String> data = await FindARoomManager.getAllRooms();
      expect(data, isNotEmpty);
    });
  });

  // Known valid input
  String validSuggestion = '1.00';

  // Known invalid input
  String invalidSuggestion = 'L.99';

  // Known specific valid suggestion
  String specificSuggestion = "1.002";

  // Test for getting room suggestions
  group('Getting room ID suggestions', () {
    //Test valid suggestions return
    test('Using valid suggestion', () async {
      List<String> suggestions = await FindARoomManager.getRoomSuggestions(validSuggestion);
      expect(suggestions, isNotEmpty);
    });

    //Test invalid suggestion return
    test('Using invalid suggestion', () async {
      List<String> suggestions = await FindARoomManager.getRoomSuggestions(invalidSuggestion);
      expect(suggestions, isEmpty);
    });


    // Expected output
    List<String> expected = ['1.002'];

    //Test valid suggestions return for specific id
    test('Using specific valid suggestion', () async {
      List<String> suggestions = await FindARoomManager.getRoomSuggestions(specificSuggestion);
      expect(suggestions, expected);
    });
  });

  // Test for getting directions as a [Queue] of [Node]s
  group('Getting route as a Queue of Nodes', () {
    // Known invalid input
    List<String> invalidEqual = ['Q', 'Q'];

    // Test invalid room ids as input
    test('Using invalid room input', () async {
      Queue<Node> route = await FindARoomManager.getDirectionsQueue(invalidEqual);
      expect(route, isEmpty);
    });

    // Known valid input
    List<String> validInput = ['1.002', '1.006'];

    // Nodes in expected output
    Node one = new Node('1.002');
    Node two = new Node('1.005');
    Node three = new Node('1.006');

    // Expected returned Queue
    Queue<Node> expectedOutput;
    expectedOutput.add(one);
    expectedOutput.add(two);
    expectedOutput.add(three);

    // Test valid input room ids as input
    test('Using valid room input', () async {
      Queue<Node> route = await FindARoomManager.getDirectionsQueue(validInput);
      expect(route, expectedOutput);
    });
  });

  // Test for getting List of directions
  group('', () {

  });


}