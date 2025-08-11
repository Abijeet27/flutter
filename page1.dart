import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_app_state.dart';
import 'package:provider/provider.dart';
class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    var myApp = context.watch<MyAppState>();
    myApp.resetUser();
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Container(
              child: Text(
                style: TextStyle(fontSize: 24),
                "${myApp.user?.email}")
            ),
            
            ElevatedButton(
                onPressed: ()async{
                  FirebaseAuth.instance.signOut();
                }, 
                child: Text("Sign Out")),
          ],
        ),
      )
    );
  }
}
