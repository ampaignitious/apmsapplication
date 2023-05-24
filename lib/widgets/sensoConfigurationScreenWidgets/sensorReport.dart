import 'package:flutter/material.dart';

class SensorReport extends StatefulWidget {
  const SensorReport({super.key});

  @override
  State<SensorReport> createState() => _SensorReportState();
}

class _SensorReportState extends State<SensorReport> {
  @override
  List sensorName=[
"Temperature sensors",
"Water sensors",
"Weight sensors",
"Alarm sensors",
"Sound sensors"
"Camera"
  ];
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        title: Text("Sensor report"),
        elevation: 0,) ,
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Text(sensorName[index]),
                subtitle: Row(
                  children: [
                    Row(
                                            children: [
                        Text("Total installed:"),
                        Text(" 5", style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(width: size.width*0.025,),
                                        Row(
                      children: [
                        Text("Fault sensors:"),
                        Text(" 0", style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(width: size.width*0.025,),
                                        Row(
                      children: [
                        Text("Running:"),
                        Text(" 5", style: TextStyle(color: Colors.red),)
                      ],
                    ),
                  ],
                ),
              ),
            );
        })
    );
  }
}