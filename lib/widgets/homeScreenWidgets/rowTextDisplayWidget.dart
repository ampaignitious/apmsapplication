import 'package:ampsapp/Screens/collectionScreen.dart';
import 'package:ampsapp/widgets/sensoConfigurationScreenWidgets/sensorReport.dart';
import 'package:flutter/material.dart';

 class RowTextDisplayWidget extends StatelessWidget {
  final String description;
   const RowTextDisplayWidget({super.key, required this.description});
 
   @override
   Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
   return Padding(
     padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
     child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: [
      Text("${description}", style: TextStyle(color: Colors.blue),),
      InkWell(
         hoverColor: Colors.amber,
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return SensorReport();
          }));
        },
        child: Text("See all", style: TextStyle(color: Colors.black.withOpacity(0.4)),))
     ],
    ),
   );
   }
 }

 
 class RowTextDisplayWidget2 extends StatelessWidget {
   final String description;
   const RowTextDisplayWidget2({super.key, required this.description});
 
   @override
   Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     return Padding(
     padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
     child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: [
      Text("${description}", style: TextStyle(color: Colors.blue),),
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
   );
   }
 }