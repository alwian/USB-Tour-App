import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class Sensor {
  String metric;
  String value;
  String unit;

  Sensor(this.metric, this.value, this.unit);

  @override
  String toString() {
    return '$metric: $value $unit';
  }
}

class UrbanObservatoryManager {

  static final Map<String, String> _units = {
    'degrees celsius' : '°C',
    'parts per million' : 'ppm',
    'percent' : '%',
    'unknown' : '',
    'luxes' : 'luxes',
    'percent relative humidity' : '%',
    'no units' : ''
  };

  static Future<List<Sensor>> getSensorData(room) async {
    String json = await  _getJson(room);
    List<Sensor> extractedData = _extractSensorData(json);
    return extractedData;
  }

  static Future<String> _getJson(room) async {
    String url = 'https://api.usb.urbanobservatory.ac.uk/api/v2.0a/sensors/entity/?meta:roomNumber=' + room;
    http.Response response = await http.get(url);
    return response.body;
  }

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