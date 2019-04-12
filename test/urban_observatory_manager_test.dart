/// Author: Alex Anderson
/// Student No: 170453905

import 'package:test/test.dart';
import 'package:csc2022_app/managers/urban_observatory_manager.dart';

void main() {
  String validRoomNumber = 'G.009';
  String invalidRoomNumber = '_____';
  List<Sensor> sensors;

  group('Getting sensor data', () {
    test('Using a valid room number', () async {
      // Testing with a valid room number
      sensors = await UrbanObservatoryManager.getSensorData(validRoomNumber);
      expect(sensors, isNotEmpty);
    });

    test('Using an invalid room number', () async {
      // Testing with an invalid room number
      sensors = await UrbanObservatoryManager.getSensorData(invalidRoomNumber);
      expect(sensors, isEmpty);
    });
  });
}