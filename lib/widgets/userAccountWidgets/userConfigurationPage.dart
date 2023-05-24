import 'package:flutter/material.dart';

class UserConfigurationPage extends StatefulWidget {
  const UserConfigurationPage({super.key});

  @override
  State<UserConfigurationPage> createState() => _UserConfigurationPageState();
}

class _UserConfigurationPageState extends State<UserConfigurationPage> {
  @override
    final TextEditingController _controllerUsername =TextEditingController();
    final TextEditingController _controllerPassword =TextEditingController();
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
            resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text("User detail edit page", style: TextStyle(fontSize: size.height*0.019),)),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height*0.04,),
            Center(
              child: CircleAvatar(
                radius: size.height*0.06,
                backgroundImage: AssetImage("assets/image1.png"),),
            ),
            Text("username"),
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
            Text("password"),
            SizedBox(height: size.height*0.014,),
             TextFormField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "password",
                border: OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(25))
                )
              ),
            ),
          SizedBox(height: size.height*0.047,),
            Center(
              child: Container(
                height: size.height*0.09,
                width: size.width*0.6,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(child: Text("update details", style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height*0.023,
                ),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}