import 'package:firebase_database/firebase_database.dart'
    show DatabaseReference, FirebaseDatabase;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/my_app_state.dart';
import 'package:flutter_application_1/my_home_page.dart';
import 'package:flutter_application_1/page5.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

List<Widget> newList2 = [];
class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  List<Widget> newList2 = [];
  var first_loading = true;
  @override
  Widget build(BuildContext context) {
    page2context = context;
    var myApp = context.watch<MyAppState>();
    myApp.resetUser();    
    List<Widget> registerList = [];
    Future<void> unregister(var num) async {
      var email2 = myApp.user?.email.toString().split("@")[0];
      
      dynamic snapshot = await ref.child("${num.toString()}/registry").get();
      if (snapshot.exists) {
        snapshot = snapshot.value;
      }
      ref.update({"${num.toString()}/registry/$email2":null});
    }

    Future<List<Widget>> tileRegister() async {
      var len = await myApp.length();
      registerList = [];
      var email = myApp.user?.email;
      var email2 = myApp.user?.email.toString().split("@")[0];
      for (var j = 0; j < len; j++) {
        print(j);
        ShapeBorder shape = BoxBorder.all();
        dynamic snapshot = await ref.child(j.toString()).get();
        if (snapshot.exists){
          snapshot = snapshot.value;
        }
        dynamic snapshot2 = await ref.child("$j/registry/$email2").get();
        if (snapshot2.exists) {
          registerList.add(
            SizedBox(
              height: 230,
              child: Card(
                shape: shape,
                color: Color.fromARGB(217, 27, 195, 237),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(textAlign: TextAlign.center, snapshot["Club Name"]),
                      SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            snapshot["President"],
                          ),
                          Text( 
                            textAlign: TextAlign.center,
                            snapshot["Vice President"],
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            snapshot["Treasurer"],
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            snapshot["Secretary"],
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            child: Text("Unregister"),
                            onPressed: () async {
                              return showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                return AlertDialog(
                                  content: ListView(
                                    children: [
                                      Text(
                                        "Are you sure you want to unregister from this club",
                                      ),
                                      SizedBox(height: 100),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          unregister(j);
                                          first_loading = true;
                                          setState((){newList2 = registerList;});
                                        },
                                        child: Text("unregister"),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          
        }
      }
      return registerList;
    }

    print(registerList);
    wait() async{
      print("started");
      setState(() {
        newList2 = [
          SizedBox(height: 200),
          LoadingAnimationWidget.inkDrop(
            color: Color.fromARGB(217, 27, 195, 237),
            size: 100,
          ),
          SizedBox(height: 100),
          Text(textAlign: TextAlign.center, "DO NOT LEAVE THIS PAGE UNLESS IT LOADS FOR OVER A MINUTE")
        ];
      });
      registerList = await tileRegister();
      print("tileList: ${newList2.toString()}");
      setState((){newList2 = registerList;});
    }
    if (first_loading){
      first_loading = false;
      wait();
    }
       return Scaffold(
      appBar: AppBar(
        title: Text("Registered clubs"),
        backgroundColor:Color.fromARGB(255, 212, 176, 62)),
      backgroundColor: Color.fromARGB(255, 212, 176, 62),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              wait();
            });
          },
          child: ListView(children: newList2),
        ),
      ),
    );
  }
}
