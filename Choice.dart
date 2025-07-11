import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/LogIn.dart';
import 'package:flutter_application_1/SignUp.dart';

class Choice extends StatelessWidget{
  const Choice({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SafeArea(
        child:Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed:(){ 
                Navigator.push(context, CupertinoPageRoute(builder:(context) => SignUp()));
              }, 
              child: Text("Sign Up")
            ),
            SizedBox(
              width: 300,
              height: 300,
            ),
            ElevatedButton(
              onPressed:(){ 
                Navigator.push(context, CupertinoPageRoute(builder:(context) => LogIn()));
              }, 
              child: Text("Log In")
            ),
          ],
        )
      )
    )
    );
  }

}