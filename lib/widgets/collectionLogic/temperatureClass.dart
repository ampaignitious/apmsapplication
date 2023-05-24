import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TemperatureReading {
  final String systemId;
  final double temperatureReading;

  TemperatureReading({required this.systemId, required this.temperatureReading});
}

class TemperatureProvider with ChangeNotifier{
  List<TemperatureReading> _tempReading =[];
  List<TemperatureReading> get readings => _tempReading;
    Future<void>  fetchTemperatureData() async {
    final response = await http.get(Uri.parse('https://apms-production.up.railway.app/api/temperature'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
            print(jsonData);
      List<TemperatureReading> temperatureData = jsonData.map((item) {
        return TemperatureReading(
          systemId: item['systemId'],
          temperatureReading: item['temperatureReading'].toDouble(),
        );
      }).toList();
      _tempReading = temperatureData;
      print(_tempReading);
     notifyListeners();
    } else {
      throw Exception('Failed to load temperature data');
    }
  }
 
}