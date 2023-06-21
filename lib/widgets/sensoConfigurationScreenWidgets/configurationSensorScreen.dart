import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ConfigurationSensorScreen extends StatefulWidget {
  final String sensorName;
  final int sensorNumber;
  final IconData iconSensor;
  const ConfigurationSensorScreen({super.key, required this.sensorName, required this.sensorNumber, required this.iconSensor});
  @override
  State<ConfigurationSensorScreen> createState() => _ConfigurationSensorScreenState(this.sensorName, this.sensorNumber, this.iconSensor);
}

class _ConfigurationSensorScreenState extends State<ConfigurationSensorScreen> {
  @override
    final String sensorName;
  final int sensorNumber;
    final IconData iconSensor;
   _ConfigurationSensorScreenState(this.sensorName, this.sensorNumber, this.iconSensor);
    //  var url = Uri.parse('https://apmspoultry.free.beeceptor.com/');
      final url = 'http://192.168.43.70:5000/sensor-data';
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:Center(child: Text( "${sensorName}", style: TextStyle(fontSize: size.height*0.020),)),
        elevation: 0,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sensorNumber,
        itemBuilder: (context, index){
          return Card(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical:10,
                  ),
                  height: size.height*0.112,
                  width: size.width*0.95,
                  decoration: BoxDecoration(
                    // color: Colors.blue
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.044),
                        child: Text("${index + 1}", style: TextStyle(color: Colors.blue),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.04),
                        child: Icon(iconSensor, size: size.height*0.065, color: Colors.blue,),
                      ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
    //  trying api call and sending, sensor section with configuration value
                          try {
      final response = await http.post(
      Uri.parse(url),
      body: {
      'data': '1',
      'sensorCategory':'${sensorName}',
      'sensorId':'${index + 1}'
      }
  
    );

    
    if (response.statusCode == 200) {
      // Data sent successfully
      print('Data sent successfully');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sensor activated successfully")));

      // print('Response: ${response.body}');
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Error occurred
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("sensor failed to connect, check your internet connection.")));
    print('Error sending data: $e');
  }
},
                        // 
                    
                          
    child: Container(
      margin: EdgeInsets.only(right: size.width*0.06),
      height: size.height*0.07,
      width: size.width*0.22,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Center(child: Text("on", style: TextStyle(color: Colors.white, fontSize: size.height*0.03),)),
    ),
  ),
  InkWell(
onTap: () async {
    //  trying api call and sending, sensor section with configuration value
    try {
      final response = await http.post(
      Uri.parse(url),
      body: {
      'data': '0',
      'sensorCategory':'${sensorName}',
      'sensorId':'${index+1}'
      }
      ,
    );

    
    if (response.statusCode == 200) {
      // Data sent successfully
      print('Data sent successfully');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sensor deactivated succesfully")));

      // print('Response: ${response.body}');
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Error occurred
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("sensor failed to connect, check your internet connection.")));
    print('Error sending data: $e');
  }
},
    child: Container(
      margin: EdgeInsets.only(right: size.width*0.04),
      height: size.height*0.07,
      width: size.width*0.22,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child:Center(child: Text("off", style: TextStyle(color: Colors.white, fontSize: size.height*0.03))),
    ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
      }),
    );
  }
}