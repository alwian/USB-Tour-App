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

  /// Test for retrieving all room ids from database
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

  /// Test for getting room suggestions
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

  /// Test for getting directions as a [Queue] of [Node]s
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
    Node one = new Node('1.006');
    Node two = new Node('1.005');
    Node three = new Node('1.002');

    // Expected returned Queue
    Queue<Node> expectedOutput;
    expectedOutput.add(one);
    expectedOutput.add(two);
    expectedOutput.add(three);

    // Test valid input room ids as input
    test('Using valid room input', () async {
      Queue<Node> route = await FindARoomManager.getDirectionsQueue(validInput);

      // Check strings for actual and expected outputs for equality,
      // as actual has many more generated details
      for(int i = 0; i < route.length; i++) {
        expect(route.removeFirst().toString(), expectedOutput.removeFirst().toString());
      }
    });
  });

  // Test for getting [List] of directions
  group('Getting list of suggestions', () {
    // Nodes in known valid input
    Node one = new Node('1.006');
    Node two = new Node('1.005');
    Node three = new Node('1.002');

    // Valid input Queue
    Queue<Node> validInput;
    validInput.add(one);
    validInput.add(two);
    validInput.add(three);

    // Expected output from given valid input
    List<String> expectedFromValid = ['Facing the front of the lecture theatre, go to the bottom of the stairs and go round the left corner.',
    'With the window of your left, walk through the double doors in front of you.'];

    // Test valid input
    test('Using valid input', () async {
      List<String> actualOutput = await FindARoomManager.getDirectionDetails(validInput);

      // Iterate over [actualOutput] and compare values to [expectedFromValid]
      for(int i = 0; i < actualOutput.length; i++) {
        expect(actualOutput[i], expectedFromValid[i]);
      }
    });

    // Nodes in known invalid input
    Node invalidOne = new Node('G.062A');
    Node invalidTwo = new Node('G.062');

    // Invalid input [Queue]
    Queue<Node> invalidInput;
    invalidInput.add(invalidOne);
    invalidInput.add(invalidTwo);
    
    // Expected output from invalid inputs
    List<String> expectedFromInvalid = ['No route could be found'];
    
    // Test using invalid input
    test('Using invalid input', () async {
      List<String> actualOutput = await FindARoomManager.getDirectionDetails(
          invalidInput);

      expect(actualOutput[0], expectedFromInvalid[0]);
    });
  });
  
  /// Integration test on getDirections method
  group('Getting list of suggestions from input list (integration)', () {
    // Known invalid input
    List<String> invalidList = ['G.063', 'G.063'];

    // Expected output from invalid input
    List<String> expectedOutputFromInvalid = ['You are already at your destination'];

    // Test using invalid input
    test('Using invalid input', () async {
      List<String> actualOutput = await FindARoomManager.getDirections(invalidList);
      expect(actualOutput[0], expectedOutputFromInvalid[0]);
    });

    // Known valid input
    List<String> validList = ['1.002', '1.006'];

    // Expected output from valid input
    List<String> expectedOutputFromValid = ['Facing the front of the lecture theatre, go to the bottom of the stairs and go round the left corner.',
    'With the window of your left, walk through the double doors in front of you.'];

    // Test using known valid input
    test('Using valid input', () async {
      List<String> actualOutput = await FindARoomManager.getDirections(validList);

      // Iterate over [actualOutput] and compare values to [expectedFromValid]
      for(int i = 0; i < actualOutput.length; i++) {
        expect(actualOutput[i], expectedOutputFromValid[i]);
      }
    });
  });


}