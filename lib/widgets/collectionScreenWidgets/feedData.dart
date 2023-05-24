import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FeedData extends StatefulWidget {
  const FeedData({Key? key}) : super(key: key);

  @override
  State<FeedData> createState() => _FeedDataState();
}

class _FeedDataState extends State<FeedData> {
  late Future<List<FeedReading>> feedDataFuture;

  @override
  void initState() {
    super.initState();
    feedDataFuture = fetchTemperatureData();
  }

  Future<List<FeedReading>> fetchTemperatureData() async {
    final response = await http.get(Uri.parse('https://apms-production.up.railway.app/api/feed'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
            print(jsonData);
      List<FeedReading> temperatureData = jsonData.map((item) {
        return FeedReading(
          systemId: item['systemId'],
          feedLevelReading: item['feedLevelReading'].toDouble(),
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
      body: FutureBuilder<List<FeedReading>>(
        future: feedDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Center(child: Text("Check your internet connection to load the data")));
            // Text('Error: ${snapshot.error}'
          } else if (snapshot.hasData) {
            List<FeedReading> temperatureData = snapshot.data!;
            return ListView.builder(
              itemCount: temperatureData.length,
              itemBuilder: (context, index) {
                FeedReading data = temperatureData[index];
                return Card(
                  child: ListTile(
                    title: Text('System ID: ${data.systemId}'),
                    subtitle:data.feedLevelReading > 27? 
                      // ListItem(title: 'led control', date: DateTime.now(), message: "Reading: 30*C"),
                    Text('Feed Reading: ${data.feedLevelReading} kgs', style: TextStyle(color: Colors.red),): Text('Feed Reading: ${data.feedLevelReading} kgs'),
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

class FeedReading {
  final String systemId;
  final double feedLevelReading;

  FeedReading({required this.systemId, required this.feedLevelReading});
}
