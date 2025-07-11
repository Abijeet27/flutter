import 'dart:math';
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
  Future<List<Widget>> tile() async{
    tileList = [];
    ShapeBorder shape = BoxBorder.all();
    for(var j = 0; j<100;j++){
      var num = j;
      dynamic snapshot = await ref.child(num.toString()).get();
      if(snapshot.exists){
        snapshot = snapshot.value;
      }
      if(snapshot["link1"]!= null){
        link1 = snapshot["link1"];
      }
      else{
        print("1");
        link1 = "";
      }
      if (snapshot["link2"] != null){
        link2 = snapshot["link2"];
      }
      else{
        print("2");
        link2 = "";
      }
      if (snapshot["link3"] != null){
        link3 = snapshot["link3"];
      }
      else{
        print("3");
        link3 = "";
      }
      
      await file(j);
      resetUser();
      if (user?.email == club["Pres Email"] || user?.email == club["VP Email"] || user?.email == club["Sec Email"]|| user?.email == club["Treas Email"]){
      tileList.add(
        SizedBox(
        height:230,
        child: Card(
              shape: shape,
              color: colors,
              child:Center(
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Text(
                      textAlign: TextAlign.center, 
                      club["Club Name"],
                    ),
                    SizedBox(height:10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children:[Text(
                      textAlign: TextAlign.center, 
                      club["President"]
                    ),
                    Text(
                      textAlign: TextAlign.center, 
                      club["Vice President"]
                    ),
                    Text(
                      textAlign: TextAlign.center, 
                      club["Treasurer"]
                    ),
                    Text(
                      textAlign: TextAlign.center, 
                      club["Secretary"]
                    ),]
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed:()async {
                        showDialog<void>(
                          context: page5context, 
                          builder:(BuildContext context){
                            return AlertDialog(
                              content:
                                Column(
                                  children:[
                                    TextFormField(
                                      initialValue: link1,
                                      decoration: InputDecoration(
                                        helperText: "Social Media Link 1 (eg. Discord, Instagram, Facebook)",
                                      ),
                                      onChanged:(input)async{
                                        link1 = input;
                                      },
                                      ),
                                    TextFormField(
                                      initialValue: link2,
                                      decoration: InputDecoration(
                                        helperText: "Social Media Link 2 (eg. Discord, Instagram, Facebook)",
                                      ),
                                      onChanged:(input)async{
                                        link2 = input;
                                      },
                                    ),
                                    TextFormField(
                                      initialValue: link3,
                                      decoration: InputDecoration(
                                        helperText: "Social Media Link 3 (eg. Discord, Instagram, Facebook)",
                                      ),
                                      onChanged:(input)async{
                                        link3 = input;
                                      },
                                    ),
                                  ]),
                              actions:[ 

                                ElevatedButton(
                                  onPressed: ()async {
                                    await ref.update({num.toString() + "/link1":link1});
                                    await ref.update({num.toString() + "/link2":link2});
                                    await ref.update({num.toString() + "/link3":link3});
                                    Navigator.of(context).pop();
                                  }, 
                                    child: Text("Save and Close")
                                    )
                                  ]   
                            );
                          }
                        );
                      },
                      child:Icon(Icons.settings),
                    ),
                  ]
                )
              ),
            )
        )
      );

      }
      else{
      tileList.add(
        SizedBox(
        height:230,
        child: Card(
              shape: shape,
              color: colors,
              child:Center(
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Text(
                      textAlign: TextAlign.center, 
                      club["Club Name"],
                    ),
                    SizedBox(height:10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children:[Text(
                      textAlign: TextAlign.center, 
                      club["President"]
                    ),
                    Text(
                      textAlign: TextAlign.center, 
                      club["Vice President"]
                    ),
                    Text(
                      textAlign: TextAlign.center, 
                      club["Treasurer"]
                    ),
                    Text(
                      textAlign: TextAlign.center, 
                      club["Secretary"]
                    ),]
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed:()async{
                        showDialog<void>(
                          context: page5context, 
                          builder:(BuildContext context){
                            return AlertDialog(
                              content:
                                Column(
                                  children:[
                                    Text(snapshot["link1"]),
                                    Text(snapshot["link2"]),
                                    Text(snapshot["link3"]),
                                  ]),
                              actions:[ 
                                ElevatedButton(
                                  onPressed:()async{
                                    await register(num);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Register"),
                                ),
                                ElevatedButton(
                                  onPressed: (){Navigator.of(context).pop();}, 
                                    child: Text("Back")
                                    )
                                  ]   
                            );
                          }
                        );
                      },
                      child:Text("Register"),
                    ),
                  ]
                )
              ),
            )
        )
      );

      }
  }  
  notifyListeners();
  return tileList;
  }  
  register(var num)async{
    resetUser();
    email = user?.email;
    dynamic snapshot = await ref.child(num.toString()).get();
    if(snapshot.exists){
      snapshot = snapshot.value;
    }
    var registry = snapshot["members"];
    registry = registry + ", ${email}";
    ref.update({"$num/members":registry});
  } 
  Future<List<Widget>> tileRegister()async{
    registerList = [];
    resetUser();
    email = user?.email;
    for(var j = 0; j < 100; j++){
      ShapeBorder shape = BoxBorder.all();
      dynamic snapshot = await ref.child(j.toString()).get();
      if(snapshot.exists){
        snapshot = snapshot.value;
      }      
      
      if(snapshot["members"].toString().contains(email)){
        registerList.add(
        SizedBox(
          height:230,
          child: Card(
              shape: shape,
              color: colors,
              child:Center(
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Text(
                      textAlign: TextAlign.center, 
                      snapshot["Club Name"],
                    ),
                    SizedBox(height:10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children:[Text(
                      textAlign: TextAlign.center, 
                      snapshot["President"]
                    ),
                    Text(
                      textAlign: TextAlign.center, 
                      snapshot["Vice President"]
                    ),
                    Text(
                      textAlign: TextAlign.center, 
                      snapshot["Treasurer"]
                    ),
                    Text(
                      textAlign: TextAlign.center, 
                      snapshot["Secretary"]
                    ),]
                    ),
                  ]
                )
              )
            )
          )
        );
      }
    }
    print(registerList);
    notifyListeners();
    return registerList;
  }
  void load2() async{
    await MyAppState().tileRegister();
    notifyListeners();
  }
}
