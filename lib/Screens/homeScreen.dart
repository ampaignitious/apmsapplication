import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/appbarWidget.dart';
import '../widgets/collectionScreenWidgets/currentFeedData.dart';
import '../widgets/collectionScreenWidgets/tempData.dart';
import '../widgets/collectionScreenWidgets/waterData.dart';
import '../widgets/homeScreenWidgets/activeSensorsWidget.dart';
import '../widgets/homeScreenWidgets/rowTextDisplayWidget.dart';
import '../widgets/homeScreenWidgets/systemReadingWidget.dart';
import '../widgets/sensoConfigurationScreenWidgets/sensorReport.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
       final size = MediaQuery.of(context).size;
  return MultiProvider(
  providers: [
    ChangeNotifierProvider<TemperatureProvider>(
      create: (_) => TemperatureProvider(),
    ),
    ChangeNotifierProvider<WaterProvider>(
      create: (_) => WaterProvider(),
    ),
     ChangeNotifierProvider<FeedProvider>(
      create: (_) => FeedProvider(),
    ),
    // Add other providers if needed
  ],

      child: Scaffold(
        body:Column(
          children: [
            // SizedBox(height: size.height*0.035,),
    // selfmade appbar structure
    // AppbarWidget(),
    // 
    SizedBox(height: size.height*0.015,),
    RowTextDisplayWidget(description: "Some of active sensors",),
    // Card displaying some of active sensors
    SizedBox(height: size.height*0.015,),
    Container(
      height: size.height*0.145,
      width: double.maxFinite,
      child: InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SensorReport();
        }));
      },
      // container widget displaying each of the active sensors
      child: ActiveSensorsWidget())),
      // 
    // 
    SizedBox(height: size.height*0.015,),
    RowTextDisplayWidget2(description: "Real time sensor readings",),
    // Card displaying some of system readings
    SizedBox(height: size.height*0.025,),
    SystemReadingWidget(),
    // 
    // card displaying data collection
    // 
          ],
        ),
      ),
    );
  }
}