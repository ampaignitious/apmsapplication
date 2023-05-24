import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TemperatureDataReading extends StatefulWidget {
  const TemperatureDataReading({Key? key}) : super(key: key);

  @override
  State<TemperatureDataReading> createState() => _TemperatureDataReadingState();
}

class _TemperatureDataReadingState extends State<TemperatureDataReading> {
  late Future<List<TemperatureReading>> temperatureDataFuture;

  @override
  void initState() {
    super.initState();
    temperatureDataFuture = fetchTemperatureData();
  }

  Future<List<TemperatureReading>> fetchTemperatureData() async {
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

      return temperatureData;
    } else {
      throw Exception('Failed to load temperature data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TemperatureReading>>(
        future: temperatureDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Center(child: Text("Check your internet connection to load the data")));
            // Text('Error: ${snapshot.error}'
          } else if (snapshot.hasData) {
            List<TemperatureReading> temperatureData = snapshot.data!;
            return ListView.builder(
              itemCount: temperatureData.length,
              itemBuilder: (context, index) {
                TemperatureReading data = temperatureData[index];
                return Card(
                  child: ListTile(
                    title: Text('System ID: ${data.systemId}'),
                    subtitle:data.temperatureReading > 27? 
                      // ListItem(title: 'led control', date: DateTime.now(), message: "Reading: 30*C"),
                    Text('Temperature Reading: ${data.temperatureReading} C', style: TextStyle(color: Colors.red),): Text('Temperature Reading: ${data.temperatureReading} C'),
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

class TemperatureReading {
  final String systemId;
  final double temperatureReading;

  TemperatureReading({required this.systemId, required this.temperatureReading});
}
