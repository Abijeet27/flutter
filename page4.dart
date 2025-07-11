import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_app_state.dart';
import 'package:provider/provider.dart';

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    var myApp = context.watch<MyAppState>();
    return Scaffold(
      backgroundColor: myApp.colors,
      body: Center(
        child: Column(
           children: [
            myApp.name,
            myApp.desc,
          ]
        )
      )
    );
  }
}