/// Author: Alex Anderson
/// Student No: 170453905

import 'package:test/test.dart';
import 'package:csc2022_app/managers/urban_observatory_manager.dart';

/// Main test method
void main() {
  // Known good/bad room values.
  String validRoomNumber = 'G.009';
  String invalidRoomNumber = '_____';

  // List to store results in.
  List<Sensor> sensors;

  // Tests for retrieving sensor data.
  group('Getting sensor data', () {

    // Testing a valid room.
    test('Using a valid room number', () async {
      // Testing with a valid room number
      sensors = await UrbanObservatoryManager.getSensorData(validRoomNumber);
      expect(sensors, isNotEmpty);
    });

    // Testing an invalid room.
    test('Using an invalid room number', () async {
      // Testing with an invalid room number
      sensors = await UrbanObservatoryManager.getSensorData(invalidRoomNumber);
      expect(sensors, isEmpty);
    });
  });
}