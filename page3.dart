import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/my_app_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/my_home_page.dart';



class Page3 extends StatelessWidget{
  var user = "";
  var description = "";
  void finish(){
    if(user!= "" && description != ""){
      usernames.add(Text(user));
      descs.add(Text(description));
      selectedIndex = 1;
    }
  }
  final TextEditingController textin = TextEditingController();

  Page3({super.key});
  @override
  Widget build(BuildContext context) {
    Widget Screen;
    var myApp = context.watch<MyAppState>();
    return Scaffold(
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Username",
            ),
            onChanged: (String input){
              user = input;
            },
            onSubmitted:(String input){
             finish();
             if(user!= "" && description != ""){
              Navigator.push(context, CupertinoPageRoute(builder:(context) => MyHomePage()));
              myApp.append();
              
             }
            }
          ),
          TextField(
            decoration: InputDecoration(
              hintText:"Description",
            ),
            onChanged: (String input){
             description = input;
            },
            onSubmitted:(String input){
             finish();
             if(user!= "" && description != ""){
              Navigator.push(context, CupertinoPageRoute(builder:(context) => MyHomePage()));
              myApp.append();
             }
            }
          ),
        ],
      )
    );
  }
}