import 'package:flutter/material.dart';

import '../defaultPageScreen.dart';
import 'loginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  final TextEditingController _controllerUsername =TextEditingController();
    final TextEditingController _controllerPassword =TextEditingController();
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
            resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height*0.075,),
            Center(child: Text("APMS", style: TextStyle(fontSize: size.height*0.06, fontWeight: FontWeight.bold, color: Colors.blue,))),
            Center(child: Text("Automated Poultry Monitoring System", style: TextStyle(fontSize: size.height*0.012, fontWeight: FontWeight.bold, color: Colors.blue.withOpacity(0.6)),)),
            SizedBox(height: size.height*0.03,),
            Center(
              child: CircleAvatar(
                radius: size.height*0.06,
                backgroundImage: AssetImage("assets/image1.png"),),
            ),
            SizedBox(height: size.height*0.03,),
                      Center(child: Text("create an account to login", style: TextStyle(color: Colors.black.withOpacity(0.4),),)),
            SizedBox(height: size.height*0.03,),
            Text("username", style: TextStyle(color: Colors.blue,),),
            SizedBox(height: size.height*0.014,),
            TextFormField(
              controller: _controllerUsername,
              autocorrect: true,
              
              // initialValue: "Ampa Ignitious",
              decoration: InputDecoration(
                hintText: "username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                )
              ),
            ),
           SizedBox(height: size.height*0.02,),
            Text("password", style: TextStyle(color: Colors.blue,),),
            SizedBox(height: size.height*0.014,),
             TextFormField(
              controller: _controllerPassword,
              obscureText: true,
               expands: false,
              decoration: InputDecoration(
                hintText: "password",
                border: OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(25))
                )
              ),
            ),
            SizedBox(height: size.height*0.02,),
            Text("confirm password", style: TextStyle(color: Colors.blue,),),
            SizedBox(height: size.height*0.014,),
             TextFormField(
              controller: _controllerPassword,
               expands: false,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "confirm password",
                border: OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(25))
                )
              ),
            ),
          SizedBox(height: size.height*0.022,),
            Center(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return DefaultPageScreen();
                  }));
                },
                child: Container(
                  height: size.height*0.09,
                  width: size.width*0.6,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Text("Register", style: TextStyle(
                    color: Colors.white,
                    fontSize: size.height*0.023,
                  ),)),
                ),
              ),
            ),
             SizedBox(height: size.height*0.018,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ontext){
                  return LoginScreen();
                }));
              },
              child: Center(child: Text("Already have account!, login to continue", style: TextStyle(color: Colors.red),)),
            )
          ],
        ),
      ),
    );
  }
}