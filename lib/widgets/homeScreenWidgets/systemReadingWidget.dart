import 'package:flutter/material.dart';

import '../../Screens/collectionScreen.dart';
import 'dataCollectionWidget.dart';

// used for containers to get the ui display
class SystemReadingWidget extends StatefulWidget {
  const SystemReadingWidget({super.key});

  @override
  State<SystemReadingWidget> createState() => _SystemReadingWidgetState();
}

class _SystemReadingWidgetState extends State<SystemReadingWidget> {
  @override
      List icons=[
    Icons.temple_buddhist,
    Icons.alarm,  
    Icons.monitor_weight_outlined, 
    Icons.water, 
    ];
    List readings=[
      "30C",
      "Safe",
      "20Kgs",
      "30ltrs",

    ];
        List sensorName=[
      "Temperature sensor",
      "Alarm sensor",
      "Weight sensor",
      "Water sensor",

    ];
        List status=[
      "Medium",
      "On",
      "Low",
      "Low",

    ];
  Widget build(BuildContext context) {
        final size =MediaQuery.of(context).size;
    return Stack(
      children: [
        // this contianer controls the sizing and spacing for any overflow, adjustments have to be made on this section
        Container(
          height: size.height*0.50,
          width: double.maxFinite,
          decoration: BoxDecoration(
            // color: Colors.pink,
          ),
          
        ),
        Positioned(
           top: size.height*0.1,
          child: Container(
             height: size.height*0.640,
            width: size.width*1,
            decoration: BoxDecoration(
          
           borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Colors.white,
                        boxShadow: [
           BoxShadow(color: Colors.black,
                          offset:  Offset(0,-2),
                          blurRadius: 0.1,
                          spreadRadius: 0.2
                          ),
                       BoxShadow(color: Colors.black,
                          offset:  Offset(-2, 0),
                          blurRadius: 0.1,
                          spreadRadius: 0.2
                          ),
            ]
            ),
          ),
        ),
        Container(
          height: size.height*0.25,
          width: double.maxFinite,
          decoration: BoxDecoration(
            // color: Color.fromARGB(255, 33, 243, 44)
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: readings.length,
            itemBuilder: (context, index){
              return Container(
          margin: EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.height*0.008),
          height: size.height*0.13,
          width: size.width*0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
boxShadow:[
                          BoxShadow(color: Colors.white,
                          offset:  Offset(0.0, 0.0),
                          blurRadius: 0.3,
                          spreadRadius: 0.3
                          ),
                          BoxShadow(color: Color.fromARGB(255, 158, 158, 158),
                          offset:  Offset(0.0, 0.0),
                          blurRadius: 0.3,
                          spreadRadius: 0.3
                          ),
                        ],
          ),
          child: Column(
            children: [
              SizedBox(height: size.height*0.040,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icons[index], size: size.height*0.08, color:  Color.fromARGB(255, 8, 51, 92),),
                    Column(
                      children: [
                        Text(sensorName[index], style: TextStyle(color: Colors.blue.withOpacity(0.4)),),
                        Text(readings[index]),
                      ],
                    ),
                  ],
                ),
              ),
             Divider(
                      color:  Color.fromARGB(255, 8, 51, 92),
                    ),
            SizedBox(height: size.height*0.015,),
              Text("${status[index]}", style: TextStyle(color: Colors.red),)
            ],
          ),
              );

          }),
        ),
// displaying the data collection sample widget on the home page
        Positioned(
          top: size.height*0.35,
          child: Padding(
           padding: EdgeInsets.symmetric(horizontal: size.width*0.009),
            child: Row(
              children: [
                DataCollectionWidget(description: "Total water intake", amount: "2000 litres",),
                SizedBox(width: size.width*0.08,),
                DataCollectionWidget(description: "Total feed intake", amount: "2345Kgs",),
              ],
            ),
          )),
// 
                  Positioned(
          top: size.height*0.304,
          child: Padding(
       padding: EdgeInsets.symmetric(horizontal: size.width*0.016),
            child: Row(
               children: [
                Text("Data Collection", style:TextStyle(color: Colors.blue),),
                    SizedBox(width: size.width*0.58,),
                InkWell(
         hoverColor: Colors.amber,
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return CollectionScreen();
          }));
        },
                  child: Text("See all", style: TextStyle(color: Colors.black.withOpacity(0.4)),))
               ],
              ),
          ),
        ),
      ],
    );
  }
}