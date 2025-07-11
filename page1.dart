import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/my_app_state.dart';
import 'package:provider/provider.dart';
class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    var myApp = context.watch<MyAppState>();
    myApp.resetUser();
    myApp.tile();
    myApp.tileRegister();
    final colors = myApp.colors;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: ElevatedButton(
                onPressed:() {
                  myApp.doSomething;
                },
                style: ElevatedButton.styleFrom(backgroundColor: myApp.colors,),
                child: Text("Press This")),
            ),
            Container(
              color:colors,
              child: //Text(myApp.counter.toString()),
                    Text(myApp.counter.toString()),
            ),
            ElevatedButton(
              onPressed: ()async{
                FirebaseAuth.instance.signOut();
              }, 
              child: Text("Sign Out")),
          Text("${myApp.user?.email}"),
          ],
        ),
      )
    );
  }
}
