import 'dart:async';

import 'package:ampsapp/widgets/collectionScreenWidgets/currentFeedData.dart';
import 'package:ampsapp/widgets/collectionScreenWidgets/waterData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../../Screens/collectionScreen.dart';
import '../collectionScreenWidgets/tempData.dart';
import 'dataCollectionWidget.dart';

// used for containers to get the ui display
class SystemReadingWidget extends StatefulWidget {
  const SystemReadingWidget({super.key});

  @override
  State<SystemReadingWidget> createState() => _SystemReadingWidgetState();
}

class _SystemReadingWidgetState extends State<SystemReadingWidget> {

    List icons=[
    Icons.temple_buddhist, 
    Icons.monitor_weight_outlined, 
    Icons.water, 
    Icons.alarm, 
    ];

        List sensorName=[
      "Temperature sensor",
      "Weight sensor",
      "Water sensor",
      "Alarm sensor",

    ];


   void initState() {
    super.initState();

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
  // 

    // Show local push notification
void showNotification(String systemId, double reading , String alertname) async {
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
    '$alertname',
    'System ID: $systemId\n Sensor reading: $reading ',
    platformChannelSpecifics,
  );
}
//  variables used to keep state of the system sensor reading  value status
 String temperatureSensorStatus='';
  String weightSensorStatus='';
  String waterSensorStatus='';
  String alarmSensorStatus ='Safe';
// 

  Widget build(BuildContext context) {
    // reading current temperature sensor vlaue, sending notifiction if there is temperature raise
        final temperatureProvider = Provider.of<TemperatureProvider>(context);
        if (double.parse(temperatureProvider.temperatureReading) > 27) {
                  setState(() {
                    temperatureSensorStatus = "High temperature";
                  });
        showNotification(temperatureProvider.SystemId, double.parse(temperatureProvider.temperatureReading), temperatureProvider.AlertName);
        }else if( double.parse(temperatureProvider.temperatureReading) < 27){
                  setState(() {
                    temperatureSensorStatus = "Normal range";
                  });
        }

    // end of the reading temperature


    // reading current water sensor vlaue, sending notifiction if there is water raise
         final waterProvider = Provider.of<WaterProvider>(context);
        if (double.parse(waterProvider.waterReading) < 100) {
                  setState(() {
                    waterSensorStatus = "Low water";
                  });
          
          showNotification(waterProvider.SystemId, double.parse(waterProvider.waterReading), waterProvider.AlertName);
        }else if( double.parse(waterProvider.waterReading) >200 ){
                  setState(() {
                    waterSensorStatus = "Enough water";
                  });
        }
    // 

    // reading current feed sensor vlaue, sending notifiction if feeds are low
        final feedProvider = Provider.of<FeedProvider>(context);
        if (double.parse(feedProvider.feedReading) < 9) {
                  setState(() {
                    weightSensorStatus = "low feeds";
                  });
        showNotification(feedProvider.SystemId, double.parse(feedProvider.feedReading), feedProvider.AlertName);
        }else if( double.parse(feedProvider.feedReading) > 10){
                  setState(() {
                    weightSensorStatus = "Enough feeds";
                  });
        }

    // end of the reading temperature
      List Statuses=[
      temperatureSensorStatus,
      weightSensorStatus,
      waterSensorStatus,
      alarmSensorStatus,

       ];
      List readings=[
      "${temperatureProvider.temperatureReading} C",
      "${feedProvider.feedReading} kgs",
      "${waterProvider.waterReading} ltrs",
       "Safe",

    ];
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
              Text(Statuses[index], style: TextStyle(color: Colors.red),)
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