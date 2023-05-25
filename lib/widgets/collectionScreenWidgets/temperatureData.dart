import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

    // Initialize the FlutterLocalNotificationsPlugin
    initializeNotifications();
  }

  // Initialize the FlutterLocalNotificationsPlugin
  void initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  }

  Future<List<TemperatureReading>> fetchTemperatureData() async {
    final response = await http.get(Uri.parse('https://apms-production.up.railway.app/api/temperature'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      print(jsonData);
      List<TemperatureReading> temperatureData = jsonData.map((item) {
        return TemperatureReading(
          systemId: item['systemId'],
          date: item['created_at'],
          temperatureReading: item['temperatureReading'].toDouble(),
        );
      }).toList();

      // Check for temperature greater than 27 and trigger notification
      temperatureData.forEach((reading) {
        if (reading.temperatureReading > 27) {
          showNotification(reading.systemId, reading.temperatureReading);
        }
      });

      return temperatureData;
    } else {
      throw Exception('Failed to load temperature data');
    }
  }

  // Show local push notification
void showNotification(String systemId, double temperatureReading) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    // 'channel_description',
    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker',
    styleInformation: BigTextStyleInformation(''),
    // Add other customizations as needed
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await FlutterLocalNotificationsPlugin().show(
    0,
    'High Temperature Alert',
    'System ID: $systemId\nTemperature: $temperatureReading C',
    platformChannelSpecifics,
  );
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
            return Center(
              child: Text("Check your internet connection to load the data"),
            );
          } else if (snapshot.hasData) {
            List<TemperatureReading> temperatureData = snapshot.data!;
            return ListView.builder(
              itemCount: temperatureData.length,
              itemBuilder: (context, index) {
                TemperatureReading data = temperatureData[index];
                return Card(
                  child: ListTile(
                    title: Text('System ID: ${data.systemId}'),
                    subtitle: data.temperatureReading > 37
                        ? Text(
                            'Temperature Reading: ${data.temperatureReading} C',
                            style: TextStyle(color: Colors.red),
                          )
                        : Text('Temperature Reading: ${data.temperatureReading} C'),
                        trailing: Text("${data.date.substring(0, 16)}"),
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
  final String date;
  final double temperatureReading;

  TemperatureReading({required this.systemId, required this.temperatureReading, required this.date});
}
