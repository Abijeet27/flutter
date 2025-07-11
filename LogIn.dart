import 'package:flutter/material.dart';

class LogIn extends StatelessWidget{
  const LogIn({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Username",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Username",
              ),
            )
          ],
        )
      )
    );
  }
}