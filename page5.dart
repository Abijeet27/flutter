import 'package:flutter_application_1/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
var lists = [];
var x = lists.length;
var page5context;
List<Widget> app = [];
void load1() async{
  app = await MyAppState().tile();
}
class Page5 extends StatelessWidget {
  const Page5({super.key});
  @override
  Widget build(BuildContext context){
    page5context = context;
    var myApp = context.watch<MyAppState>();
    load1();
    return SafeArea(
      child:Scaffold(
        body: ListView(
            children: myApp.tileList
        ),
      )
    );
  }
}

    