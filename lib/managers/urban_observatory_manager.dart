import 'dart:convert';
import 'package:http/http.dart' as http;

class UrbanObservatoryManager {

  static final Map<String, String> _units = {
    'degrees celcius' : '°C',
    'parts per million' : 'ppm',
    'percent' : '%',
    'unknown' : '',
    'luxes' : 'luxes'
  };

  static Future<List<String>> getSensorData(room) async {
    String json = await  _getJson(room);
    List<String> extractedData = _extractSensorData(json);
    return extractedData;
  }

  static Future<String> _getJson(room) async {
    String url = 'https://api.usb.urbanobservatory.ac.uk/api/v2.0a/sensors/entity/?meta:roomNumber=' + room;
    http.Response response = await http.get(url);
    return response.body;
  }

  static List<String> _extractSensorData(json) {
    List<String> sensorData = [];
    Map decoded = jsonDecode(json);
    List items = decoded['items'];
    Map firstItem = items[0];
    List feeds = firstItem['feed'];
    for (Map feed in feeds) {
      try {
        sensorData.add(
            feed['metric'] + ': ' + feed['timeseries'][0]['latest']['value'].toString()
                + ' ' + _units[feed['timeseries'][0]['unit']['name']]);
      } catch (e) {}
    }
    return sensorData;
  }
}