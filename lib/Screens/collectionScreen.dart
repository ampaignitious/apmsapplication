import 'package:flutter/material.dart';

import '../widgets/appbarWidget.dart';
import '../widgets/collectionScreenWidgets/allDataAvailable.dart';
import '../widgets/collectionScreenWidgets/feedData.dart';
import '../widgets/collectionScreenWidgets/imageDisplay.dart';
import '../widgets/collectionScreenWidgets/temperatureData.dart';
import '../widgets/collectionScreenWidgets/waterCollectionData.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
      TabController _tabController = TabController(length: 5, vsync: this);
      final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
        children: [
        // SizedBox(height: size.height*0.035,),
      // selfmade appbar structure
      // AppbarWidget(),
      // 
                 SizedBox(
                  height: size.height*0.022,
                ),
          Center(child: Text("Data collection screen", style: TextStyle(
            color: Colors.black.withOpacity(0.4),
              ))),
              Container(
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black54,
                    unselectedLabelColor: Colors.black26,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(text: "Temperature"),
                      Tab(text: "Water"),
                      Tab(text: "Feeding"),
                      Tab(text: "Security reports"),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                  height: size.height*0.65,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      // color: Color.fromARGB(171, 214, 211, 211),
                      ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // AllDataAvailable(),
                      TemperatureDataReading(),
                      WaterCollection(),
                      FeedData(),
                      RandomImagesWidget()
                      // Center(child: Text("This will display security reports")),
                    ],
                  ),
                ),
                
          
        ],
         ),
      ),
    );
  }
}