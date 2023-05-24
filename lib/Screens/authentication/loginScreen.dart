import 'package:ampsapp/Screens/authentication/registerScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../defaultPageScreen.dart';
import 'loginLogic.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
    final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
      void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }
  final AuthService _authService = AuthService();

  // sign logic
  //   void _signIn() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //       print('Signed in as ${userCredential.user!.email}');
  //                Navigator.push(context, MaterialPageRoute(builder: (context){
  //                     return DefaultPageScreen();
  //                   }));
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'user-not-found') {
  //         print('No user found for that email.');
  //       } else if (e.code == 'wrong-password') {
  //         print('Wrong password provided for that user.');
  //       }
  //     }
  //   }
  // }
  void _signIn() async {
  if (_formKey.currentState!.validate()) {
    try {
      UserCredential? userCredential = await _authService.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (userCredential != null) {
        print('Signed in as ${userCredential.user!.uid}');
        // Navigate to HomeScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DefaultPageScreen()),
        );
      } else {
        print('Sign in failed.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}

  // 
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height*0.10,),
              Center(child: Text("APMS", style: TextStyle(fontSize: size.height*0.06, fontWeight: FontWeight.bold, color: Colors.blue,))),
              Center(child: Text("Automated Poultry Monitoring System", style: TextStyle(fontSize: size.height*0.012, fontWeight: FontWeight.bold, color: Colors.blue.withOpacity(0.6)),)),
              SizedBox(height: size.height*0.03,),
              Center(
                child: CircleAvatar(
                  radius: size.height*0.06,
                  backgroundImage: AssetImage("assets/image1.png"),),
              ),
            SizedBox(height: size.height*0.03,),
                      Center(child: Text("enter user details to login", style: TextStyle(color: Colors.black.withOpacity(0.4),),)),
            SizedBox(height: size.height*0.03,),
            Text("username", style: TextStyle(color: Colors.blue,),),
              SizedBox(height: size.height*0.014,),
              TextFormField(
                controller: _emailController,
                autocorrect: true,
                // initialValue: "Ampa Ignitious",
                decoration: InputDecoration(
                  hintText: "email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  )
                ),
                    validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
              ),
             SizedBox(height: size.height*0.02,),
              Text("password", style: TextStyle(color: Colors.blue,),),
              SizedBox(height: size.height*0.014,),
               TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "password",
                  border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(25))
                  )
                ),
                 validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            SizedBox(height: size.height*0.047,),
              Center(
                child: InkWell(
                  onTap: (){
                       _signIn();
                  },
                  child: Container(
                    height: size.height*0.09,
                    width: size.width*0.6,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(child: Text("Login", style: TextStyle(
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
                    return RegisterScreen();
                  }));
                },
                child: Center(child: Text("Create account?", style: TextStyle(color: Colors.red),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}