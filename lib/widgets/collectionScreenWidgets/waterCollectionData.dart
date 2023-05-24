import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WaterCollection extends StatefulWidget {
  const WaterCollection({Key? key}) : super(key: key);

  @override
  State<WaterCollection> createState() => _WaterCollectionState();
}

class _WaterCollectionState extends State<WaterCollection> {
  late Future<List<WaterReading>> temperatureDataFuture;

  @override
  void initState() {
    super.initState();
    temperatureDataFuture = fetchTemperatureData();
  }

  Future<List<WaterReading>> fetchTemperatureData() async {
    final response = await http.get(Uri.parse('https://apms-production.up.railway.app/api/water'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
            print(jsonData);
      List<WaterReading> temperatureData = jsonData.map((item) {
        return WaterReading(
          systemId: item['systemId'],
          waterReading: item['waterLevelReading'].toDouble(),
        );
      }).toList();

      return temperatureData;
    } else {
      throw Exception('Failed to load temperature data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<WaterReading>>(
        future: temperatureDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Center(child: Text("Check your internet connection to load the data")));
            // Text('Error: ${snapshot.error}'
          } else if (snapshot.hasData) {
            List<WaterReading> temperatureData = snapshot.data!;
            return ListView.builder(
              itemCount: temperatureData.length,
              itemBuilder: (context, index) {
                WaterReading data = temperatureData[index];
                return Card(
                  child: ListTile(
                    title: Text('System ID: ${data.systemId}'),
                    subtitle:data.waterReading > 15? 
                      // ListItem(title: 'led control', date: DateTime.now(), message: "Reading: 30*C"),
                    Text('Water reading: ${data.waterReading} ltrs', style: TextStyle(color: Colors.red),): Text('Water reading: ${data.waterReading} ltrs'),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class WaterReading {
  final String systemId;
  final double waterReading;

  WaterReading({required this.systemId, required this.waterReading});
}
