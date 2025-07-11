import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/my_app_state.dart';
import 'package:flutter_application_1/my_home_page.dart';
import 'package:flutter_application_1/page5.dart';
import 'package:provider/provider.dart';


class Page2 extends StatelessWidget {
  const Page2({super.key}); 
  @override
  Widget build(BuildContext context) {
    return reloadPage2(context);
  }
}
Widget reloadPage2(BuildContext context){
  var myApp = context.watch<MyAppState>();
  myApp.load2();
  return Scaffold(
      body:Center(
        child:ListView(
          children: myApp.registerList,
          
        )
        ),
      );
}