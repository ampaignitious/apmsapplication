import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'Screens/authentication/loginLogic.dart';
import 'Screens/authentication/loginScreen.dart';
import 'Screens/defaultPageScreen.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
final AuthService _authService = AuthService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'apms',
      home:_authService.isUserLoggedIn() ? DefaultPageScreen() : LoginScreen(),
    );
  }
}

 
 