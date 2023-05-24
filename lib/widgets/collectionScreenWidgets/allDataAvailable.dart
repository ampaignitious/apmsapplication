import 'dart:convert';
// https://apms-production.up.railway.app/api/temperature'
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/dataJsonReading/sensorData.dart';


class AllDataAvailable extends StatefulWidget {
  const AllDataAvailable({super.key});

  @override
  State<AllDataAvailable> createState() => _AllDataAvailableState();
}

class _AllDataAvailableState extends State<AllDataAvailable> {
  @override
    List<SensorData> sensorDataList = [];
//  reading the json file
Future<String> _loadSensorDataAsset() async {
  return await rootBundle.loadString('assets/sensor_readings.json');
}
// 
//  converting the json to list
Future<List<SensorData>> _parseSensorData(String jsonString) async {
  final jsonData = json.decode(jsonString);
  List<SensorData> sensorDataList = [];

  for (var item in jsonData) {
    SensorData sensorData = SensorData(
        sensor_id: item['sensor_id'],
        temperature: item['temperature'],
        humidity: item['humidity'],
        water_level: item['water_level'],
        feed_level: item['feed_level'],
        timestamp: item['timestamp'],
    );
    sensorDataList.add(sensorData);
  }

  return sensorDataList;
}
// 
  @override
  void initState() {
    super.initState();
    _loadSensorData();
  }

  Future<void> _loadSensorData() async {
    String jsonString = await  _loadSensorDataAsset();
    List<SensorData> data = await _parseSensorData(jsonString);
    setState(() {
      sensorDataList = data;
    });
  }
  Widget build(BuildContext context) {
      return ListView.builder(
    itemCount: sensorDataList.length,
    itemBuilder: (context, index) {
      SensorData sensorData = sensorDataList[index];

      return Card(
        child: ListTile(
          title: Text('SensorId: ${sensorData.sensor_id}'),
          subtitle: Text('Value: ${sensorData.temperature}'),
          trailing: Text("${sensorData.timestamp}", style: TextStyle(color: Colors.blue),),
        ),
      );
    },
  );
  }
}