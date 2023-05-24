import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SensorData {
  final int sensor_id;
  final double temperature;
  final double humidity;
  final double water_level;
  final double feed_level;
  final String  timestamp;


  SensorData({required this.sensor_id, required this.temperature, required this.humidity, required this.water_level, required this.feed_level, required this.timestamp});

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      sensor_id: json['sensor_id'],
      temperature: json['temperature'],
      humidity: json['humidity'],
      water_level: json['water_level'],
      feed_level: json['feed_level'],
      timestamp: json['timestap']
    );
  }

}