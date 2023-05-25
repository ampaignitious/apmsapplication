
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedProvider with ChangeNotifier {
  String _feedReading = '0';
  String _sensorId='';
  String alertName ="Low feed levels";
  List<dynamic> FeedList = [];

  Future<List<dynamic>> fetchFeedReading() async {
    final response = await http.get(Uri.parse('https://apms-production.up.railway.app/api/feed/current/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List.from(data);
    } else {
      throw Exception('Failed to fetch feed reading');
    }
  }

  void startPollingFeed() {
    Timer.periodic(Duration(seconds: 1), (_) {
      fetchFeedReading().then((List<dynamic> feedReading) {
        FeedList = feedReading;

        if (FeedList.isNotEmpty) {
          String latestFeedReading = FeedList.last['feedLevelReading'].toString();
          _feedReading = latestFeedReading;
          _sensorId = FeedList.last['systemId'];
          notifyListeners();
        }
      }).catchError((error) {
        print('Error: $error');
      });
    });
  }

  FeedProvider() {
    startPollingFeed();
  }

  String get feedReading => _feedReading;
    String get SystemId => _sensorId;
    String get AlertName =>alertName ;
}
