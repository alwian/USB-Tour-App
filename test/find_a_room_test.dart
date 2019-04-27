import 'package:test/test.dart';
import 'package:csc2022_app/managers/find_a_room_manager.dart';
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
  });


}