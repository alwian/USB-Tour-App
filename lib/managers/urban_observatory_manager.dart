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

  /// Returns a [String] representation of a [Sensor].
  @override
  String toString() {
    return '$metric: $value $unit';
  }
}

/// Handles data retrieval for an [UrbanObservatoryFragmentState].
class UrbanObservatoryManager {

  /// Conversion table for translating full units into abbreviations.
  static final Map<String, String> _units = {
    'degrees celsius' : '°C',
    'parts per million' : 'ppm',
    'percent' : '%',
    'unknown' : '',
    'luxes' : 'luxes',
    'percent relative humidity' : '%',
    'no units' : ''
  };

  /// Returns a [List] of [Sensor]s for a given room.
  static Future<List<Sensor>> getSensorData(room) async {
    String json = await  _getJson(room);
    List<Sensor> extractedData = _extractSensorData(json);
    return extractedData;
  }

  /// Returns the JSON representation of sensor data.
  static Future<String> _getJson(room) async {
    String url = 'https://api.usb.urbanobservatory.ac.uk/api/v2.0a/sensors/entity/?meta:roomNumber=' + room;
    http.Response response = await http.get(url);
    return response.body;
  }

  /// Returns the relevant sensor data extracted from JSON.
  static List<Sensor> _extractSensorData(json) {
    List<Sensor> sensorData = [];
    RegExp zoneExp = RegExp('Zone [0-9]+');
    Map decoded = jsonDecode(json);
    List items = decoded['items'];
    for(Map item in items) {
      if (zoneExp.hasMatch(item['name'])) {
        sensorData.add(Sensor(zoneExp.firstMatch(item['name']).group(0), '0', 'separator'));
      } else if (items.length == 1) {
        sensorData.add(Sensor('Zone 0', '0', 'separator'));
      }
      List feeds = item['feed'];
      RegExp exclude = RegExp('CLCZ[0-9]+DimValStatus');
      for (Map feed in feeds) {
        try {
          if (!exclude.hasMatch(feed['metric'])) {
            sensorData.add(
                Sensor(
                    feed['metric'],
                    feed['timeseries'][0]['latest']['value'] == null ?
                    'unavailable' : feed['timeseries'][0]['latest']['value'].toString(),
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