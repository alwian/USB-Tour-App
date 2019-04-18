/// Author: Alex Anderson
/// Student No: 170453905

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

/// Represents an Urban Observatory sensor in the Urban Sciences Building.
class Sensor {

  /// The value the [Sensor] is measuring.
  String metric;

  /// The value the [Sensor] has measured.
  String value;

  /// The unit for the value the [Sensor] has measured.
  String unit;

  /// Defines a [Sensor].
  Sensor(this.metric, this.value, this.unit);
}

/// Handles data retrieval for an [UrbanObservatoryFragmentState].
class UrbanObservatoryManager {

  /// Conversion table for translating full units into abbreviations.
  static final Map<String, String> _units = <String, String>{
    'degrees celsius' : '°C',
    'parts per million' : 'ppm',
    'percent' : '%',
    'unknown' : '',
    'luxes' : 'luxes',
    'percent relative humidity' : '%',
    'no units' : ''
  };

  /// Returns a [List] of [Sensor]s for a given room.
  static Future<List<Sensor>> getSensorData(String room) async {
    String json = await  _getJson(room);
    List<Sensor> extractedData = _extractSensorData(json);
    return extractedData;
  }

  /// Returns the JSON representation of sensor data.
  static Future<String> _getJson(String room) async {
    String url = 'https://api.usb.urbanobservatory.ac.uk/api/v2.0a/sensors/entity/?meta:roomNumber=' + room;
    http.Response response = await http.get(url);
    return response.body;
  }

  /// Returns the relevant sensor data extracted from JSON.
  static List<Sensor> _extractSensorData(String json) {
    List<Sensor> sensorData = [];
    RegExp zoneExp = RegExp('Zone [0-9]+');
    Map decoded = jsonDecode(json);
    // The zones in a room.
    List items = decoded['items'];
    for(Map item in items) {
      // Only display sensors if they are in a zone.
      if (zoneExp.hasMatch(item['name'])) {
        // Add separator with the correct zone number.
        sensorData.add(Sensor(zoneExp.firstMatch(item['name']).group(0), '0', 'separator'));
      // If only 1 zone, define as zone 0 as it represents the whole room.
      } else if (items.length == 1) {
        sensorData.add(Sensor('Zone 0', '0', 'separator'));
      }
      // The sensors for a zone.
      List feeds = item['feed'];
      // Regex to identify irrelevant sensors.
      RegExp exclude = RegExp('CLCZ[0-9]+DimValStatus');
      // Go through all sensors in a zone.
      for (Map feed in feeds) {
        // Try to add a sensor, if exception occurs not all data available.
        try {
          if (!exclude.hasMatch(feed['metric'])) {
            sensorData.add(
                Sensor(
                    // What the sensor is measuring.
                    feed['metric'],
                    // The latest value for the sensor.
                    feed['timeseries'][0]['latest']['value'] == null ?
                    'unavailable' : feed['timeseries'][0]['latest']['value'].toString(),
                    // The unit the sensor measures in.
                    _units[feed['timeseries'][0]['unit']['name']]
                )
            );
          }
        } catch (e) {}
      }
    }
    return sensorData;
  }
}