import 'package:ampsapp/Screens/collectionScreen.dart';
import 'package:ampsapp/Screens/notificationScreen.dart';
import 'package:ampsapp/Screens/sensorsScreen.dart';
import 'package:ampsapp/Screens/settingScreen.dart';
import 'package:flutter/material.dart';

import '../widgets/appDrawer/appDrawer.dart';
import '../widgets/userAccountWidgets/userConfigurationPage.dart';
import 'homeScreen.dart';

class DefaultPageScreen extends StatefulWidget {
  const DefaultPageScreen({super.key});

  @override
  State<DefaultPageScreen> createState() => _DefaultPageScreenState();
}

class _DefaultPageScreenState extends State<DefaultPageScreen> {
  @override
        int _selectedIndex = 0;
  List Page = [
 HomeScreen(),
 SensorsScreen(),
 CollectionScreen(),
 SettingScreen(),

        ];
    void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Column(
            children: [
              Text("APMS", style: TextStyle(fontSize: size.height*0.05, fontWeight: FontWeight.bold)),
              Text("Making poultry farming efficient with technology", style: TextStyle(fontSize: size.height*0.009),)
        
            ],
          ),
        ),
        actions: [
                    InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return UserConfigurationPage();
              }));
            },
            child: Padding(
              padding: EdgeInsets.only(right: size.width*0.03),
              child: CircleAvatar(backgroundImage: AssetImage("assets/image1.png"),),
            ))
        ],
      ),
      body: Page[_selectedIndex],
bottomNavigationBar: BottomNavigationBar(
  backgroundColor:Colors.blue[200],
        currentIndex: _selectedIndex,
        onTap: ((value) => onItemTapped(value)),
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        // type: BottomNavigationBarType.shifting,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 39, 37, 37),
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.network_wifi), label: 'Sensors'),
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: 'collection'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings'),

        ],
      ),
    );
  }
}