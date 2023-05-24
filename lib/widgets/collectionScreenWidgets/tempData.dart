import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../collectionLogic/temperatureClass.dart';

class TempData extends StatefulWidget {
  const TempData({super.key});

  @override
  State<TempData> createState() => _TempDataState();
}

class _TempDataState extends State<TempData> {
  @override
  TemperatureProvider instancex = new TemperatureProvider();
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create:(context)=>TemperatureProvider(),
        child: ListView.builder(
          itemCount: instancex.readings.length,
          itemBuilder: (context, index){
          final data = instancex.readings[index];
          return Card(
                  child: ListTile(
                    title: Text('System ID: ${data.systemId}'),
                    subtitle:data.temperatureReading > 27? 
                      // ListItem(title: 'led control', date: DateTime.now(), message: "Reading: 30*C"),
                    Text('Temperature Reading: ${data.temperatureReading}', style: TextStyle(color: Colors.red),): Text('Temperature Reading: ${data.temperatureReading}'),
                  ),
                );
        }),
      ),
    );
  }
}