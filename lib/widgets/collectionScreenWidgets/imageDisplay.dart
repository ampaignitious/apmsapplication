import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomImagesWidget extends StatefulWidget {
  @override
  _RandomImagesWidgetState createState() => _RandomImagesWidgetState();
}

class _RandomImagesWidgetState extends State<RandomImagesWidget> {
  List<dynamic> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchRandomImages();
  }

  Future<void> fetchRandomImages() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List urls = data.map((image) => image['url']).toList();

      setState(() {
        imageUrls = urls;
      });
    } else {
      // Handle error
      print('Failed to fetch images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Image.network(
            imageUrls[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
