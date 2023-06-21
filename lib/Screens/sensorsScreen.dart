import 'package:flutter/material.dart';

import '../widgets/appbarWidget.dart';
import '../widgets/sensoConfigurationScreenWidgets/footerTitleLink.dart';
import '../widgets/sensoConfigurationScreenWidgets/headerTitle.dart';
import '../widgets/sensoConfigurationScreenWidgets/sensorDisplayWidget.dart';
import '../widgets/sensoConfigurationScreenWidgets/sensorReport.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  State<SensorsScreen> createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
                      // SizedBox(height: size.height*0.035,),
            // selfmade appbar structure
      // AppbarWidget(),
      // 
      // first container displaying "configure system sensors"
      SizedBox(height: size.height*0.018,),
      HeaderTitle(),
      // 
      SizedBox(height: size.height*0.014,),
      Text("click to activate or deactivate sensor", style: TextStyle(color: Colors.red.withOpacity(0.4)),),
      // container displaying the available sensors
      SizedBox(height: size.height*0.014,),
      SensorDisplayWidget(),
          ],
        ),
      ),
    );
  }
}