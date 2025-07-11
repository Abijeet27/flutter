import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page5.dart';
var registercontext;
class Register extends StatelessWidget{
  const Register({super.key});
  @override
  Widget build(BuildContext context){
    registercontext = context;
    return Scaffold(
      body:Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text("https://discord.gg/1293994949399399"),
          ElevatedButton(
            onPressed: (){Navigator.push(context, CupertinoPageRoute(builder:(context) => Page5()));}, 
            child: Text("Back")
            )]
      ))
      );
  }
}