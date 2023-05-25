import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TemperatureProvider with ChangeNotifier {
  String _temperatureReading = '0';
  String _sensorId='';
    String alertName ="High Temperature Alert";
  List<dynamic> temperatureList = [];

  Future<List<dynamic>> fetchTemperatureReading() async {
    final response = await http.get(Uri.parse('https://apms-production.up.railway.app/api/temperature/current/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List.from(data);
    } else {
      throw Exception('Failed to fetch temperature reading');
    }
  }

  void startPollingTemperature() {
    Timer.periodic(Duration(seconds: 1), (_) {
      fetchTemperatureReading().then((List<dynamic> temperatureReading) {
        temperatureList = temperatureReading;

        if (temperatureList.isNotEmpty) {
          String latestTemperatureReading = temperatureList.last['temperatureReading'].toString();
          _temperatureReading = latestTemperatureReading;
          _sensorId = temperatureList.last['systemId'];
          notifyListeners();
        }
      }).catchError((error) {
        print('Error: $error');
      });
    });
  }

  TemperatureProvider() {
    startPollingTemperature();
  }

  String get temperatureReading => _temperatureReading;
    String get SystemId => _sensorId;
        String get AlertName =>alertName ;
}
