import 'package:flutter/material.dart';

import '../../Screens/authentication/loginLogic.dart';
import '../../Screens/authentication/loginScreen.dart';
import '../sensoConfigurationScreenWidgets/sensorReport.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  final name ="Ampa Ignitious";
    final AuthService _authService = AuthService();
 void _signOut() async {
  _authService.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoginScreen();
                      }));
 }
  Widget build(BuildContext context) {
    return Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.1,
            image: AssetImage("assets/image1.png")) ,
          color: Color.fromARGB(255, 187, 196, 204),
        ),
        child: Center(
          child: UserAccountsDrawerHeader(
            currentAccountPictureSize: Size.square(56),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            currentAccountPicture: CircleAvatar(backgroundImage: AssetImage("assets/image1.png"),),
            accountName: Text("Username: Ampa Ignitious",style: TextStyle(color: Colors.black),), accountEmail: Text("User email: ignitiousampa08@gmail.com",style: TextStyle(color: Colors.black),)),)
          ),
      Card(
        child: ListTile(
          title: const Text('Home'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
          trailing: Icon(Icons.home),
        ),
      ),
      Card(
        child: ListTile(
          title: const Text('Sensor page'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
          trailing: Icon(Icons.sensors),
        ),
      ),
            Card(
              child: ListTile(
                    title: const Text('Notification page'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                    trailing: Icon(Icons.notification_add_sharp),
                  ),
            ),
            Card(
              child: ListTile(
                    title: const Text('Collection page'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                    trailing: Icon(Icons.storage_rounded),
                  ),
            ),
            Card(
              child: ListTile(
                    title: const Text('Settings page'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                    trailing: Icon(Icons.settings),
                  ),
            ),
             Card(
              child: ListTile(
                    title: const Text('Sensor report'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SensorReport();
                      }));
                    },
                    trailing: Icon(Icons.settings),
                  ),
            ),
                        Card(
              child: ListTile(
                    title: const Text('Logout'),
                    onTap: () {
                      // Update the state of the app.
                    _signOut();
                      // ...
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoginScreen();
                      }));
                    },
                    trailing: Icon(Icons.logout),
                  ),
            ),
    ],
  ),
    );
  }
}