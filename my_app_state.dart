import 'dart:math';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth show FirebaseAuth;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/my_home_page.dart';
import 'package:flutter_application_1/page5.dart';
import 'package:flutter_application_1/register.dart';
import 'package:flutter_application_1/page2.dart';
import 'package:intl/intl.dart';

class MyAppState extends ChangeNotifier {
  Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
  var user;
  void resetUser(){
     user = auth.currentUser;
  }
  var email;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  List<Widget> registerList = [];
  var loading = false;
  String link1="";
  String link2="";
  String link3="";
  List<Widget> tileList = [];
  String data = "";
  var name;
  var desc = Text("");
  var pfp;
  var index = 0;
  var counter = 0;
  
  double randred = 0;
  double randgreen = 0;
  double randblue = 0;
  double randAlpha = 0;
  var colors = Color.fromARGB(100, 227, 30, 8);
  
  void doSomething(){
    counter++;
    if (counter >= 10){
      randred = Random().nextDouble()*255;
      randblue = Random().nextDouble()*255;
      randgreen = Random().nextDouble()*255;
      randAlpha = Random().nextDouble()*100;
      colors = Color.from(alpha:randAlpha, red: randred, green: randgreen, blue: randblue);
    }
    notifyListeners();
  }
  void append(){
    var length1 = rows.length - 1;
    var key1 = ValueKey(0);
    var text = usernames[index];
    var box = ElevatedButton(
      onPressed:(){ 
        name = text;
        for(int i = 0; i < usernames.length; i++){
          if (usernames[i] == text){
            desc = descs[i];
          }
        }
        selectedIndex = 3;
        Navigator.push(page2context, CupertinoPageRoute(builder:(context) => MyHomePage()));
        notifyListeners();
        }, 
      child: text,
    );
    print(usernames.toString());
    if (rows[length1].children.length == 1 || rows[length1].children.isEmpty){
      rows[length1].children.add(box);
    }
    else if (rows[length1].children.length == 2){
      rows.add(Row(children:[box]));
      print("no");
    }
    notifyListeners();
    index++;
  }
  var club;
  Future<void> file(j) async{
    club = await read(j);
    club = club.value;
  } 
  Future<void> register(var num)async{
    var time = DateTime.now().toLocal();
    var  format = DateFormat('yyyy-mm-dd');
    String date = format.format(time);
    print(num);
    resetUser();
    var email2 = user?.email.toString().split("@")[0];
    email = user?.email;
    dynamic snapshot = await ref.child("${num.toString()}/registry").get();
    if(snapshot.exists){
      snapshot = snapshot.value;
    }
    ref.update({"$num/registry/$email2/date": date});
    ref.update({"$num/registry/$email2/$email2": user?.email});
  } 
  Future<int> length() async {
    var j = 0;
    dynamic snapshot = await ref.child(j.toString()).get();
    while (snapshot.exists) {
      j++;
      snapshot = await ref.child(j.toString()).get();
    }
    return j;
  }
  }
