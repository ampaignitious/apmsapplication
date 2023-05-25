// https://apms-production.up.railway.app/api/water/current/?waterLevelReading=230.5

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WaterProvider with ChangeNotifier {
  String _waterReading = '0';
  String _sensorId='';
  String alertName ="Low water levels alert";
  List<dynamic> waterList = [];

  Future<List<dynamic>> fetchWaterReading() async {
    final response = await http.get(Uri.parse('https://apms-production.up.railway.app/api/water/current/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List.from(data);
    } else {
      throw Exception('Failed to fetch water reading');
    }
  }

  void startPollingWater() {
    Timer.periodic(Duration(seconds: 1), (_) {
      fetchWaterReading().then((List<dynamic> waterReading) {
        waterList = waterReading;

        if (waterList.isNotEmpty) {
          String latestWaterReading = waterList.last['waterLevelReading'].toString();
          _waterReading = latestWaterReading;
          _sensorId = waterList.last['systemId'];
          notifyListeners();
        }
      }).catchError((error) {
        print('Error: $error');
      });
    });
  }

  WaterProvider() {
    startPollingWater();
  }

  String get waterReading => _waterReading;
    String get SystemId => _sensorId;
    String get AlertName =>alertName ;
}
