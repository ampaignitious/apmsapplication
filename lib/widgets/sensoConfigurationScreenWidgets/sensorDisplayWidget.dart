import 'package:flutter/material.dart';

import 'configurationSensorScreen.dart';

class SensorDisplayWidget extends StatefulWidget {
  const SensorDisplayWidget({super.key});

  @override
  State<SensorDisplayWidget> createState() => _SensorDisplayWidgetState();
}

class _SensorDisplayWidgetState extends State<SensorDisplayWidget> {
  @override
        List icons=[
    Icons.lightbulb,
    Icons.temple_buddhist,
    Icons.alarm,  
    Icons.camera, 
    Icons.water, 
    Icons.security
    ];
    List iconnames=[
      "Light control section",
      "Temperature  Sensor",
      "Alarm  Section",
      "Camera  Sensor",
      "Water sensor",
      "Security Section"
    ];
    List number=[
      3,1,1,1,1,1
    ];
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.53,
      width: double.maxFinite,
      decoration: BoxDecoration(
        // color: Colors.blue
      ),
      child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: iconnames.length,
        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ConfigurationSensorScreen(sensorName: iconnames[index], sensorNumber: number[index], iconSensor: icons[index],);
              }));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.height*0.009, horizontal: size.width*0.04),
              height: size.height*0.22,
              width: size.width*0.9,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Color.fromARGB(255, 8, 75, 121).withOpacity(0.4),
                            offset:  Offset(0.5,2),
                            blurRadius: 0.1,
                            spreadRadius: 0.2
                            ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: Padding(
                padding: EdgeInsets.only(top:size.height*0.022),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: size.width*0.09),
                          height: size.height*0.10,
                          width: size.width*0.22,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            
                          ),
                          child: Center(
                            child: Icon( 
                              icons[index], color: Colors.white,))),
                        Padding(
                          padding: EdgeInsets.only(right: size.width*0.15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${iconnames[index]}", style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: size.height*0.010,),
                              Text("Available sensors: ${number[index]}", style: TextStyle(color: Colors.red),)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.blue,
                    ),
                    SizedBox(height: size.height*0.012,),
                    Text("activate of deactive sensor", style: TextStyle(color: Colors.blue.withOpacity(0.3), fontSize: size.height*0.014),)
                  ],
                ),
              ),
            ),
          );
      }),
    );
  }
}