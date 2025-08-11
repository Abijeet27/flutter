import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

var lists = [];
var x = lists.length;
var page5context;
List<Widget> app = [];

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  State<Page5> createState() => _Page5State();
}

dynamic snapshot;

class _Page5State extends State<Page5> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
  var first_loading_page_5 = true;

  var link1;
  var link2;
  var link3;
  List<Widget> tileList = [];
  List<Widget> newList = [];
  
  var loading = false;
  @override
  Widget build(BuildContext context) {
    var myApp = context.watch<MyAppState>();
    var firstP5 = true;
    Future<List<Widget>> tile() async {
      List<Widget> tileList = [];
      myApp.resetUser();
      var len = await myApp.length();
      ShapeBorder shape = BoxBorder.all();
      if (myApp.user?.email == "admin@gmail.com" && firstP5) {
        firstP5 = false;
        var name = "";
        var pres = "";
        var vp = "";
        var secretary = "";
        var treasurer = "";
        var Epres = "";
        var Evp = "";
        var Esecretary = "";
        var Etreasurer = "";
        var Ename = "";
        var link1_ = "";
        var link2_ = "";
        var link3_ = "";
        newList.add(
          ElevatedButton(
            child: Text("Add New Club"),
            onPressed: () async {
              showDialog<void>(
                context: page5context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: ListView(
                      children: [
                        TextField(
                          decoration: InputDecoration(hintText: "Club Name"),
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Club President",
                          ),
                          onChanged: (value) {
                            pres = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Club Email"),
                          onChanged: (value) {
                            Ename = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "President Email",
                          ),
                          onChanged: (value) {
                            Epres = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Club Vice President",
                          ),
                          onChanged: (value) {
                            vp = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Vice President Email",
                          ),
                          onChanged: (value) {
                            Evp = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Club Secrertary",
                          ),
                          onChanged: (value) {
                            secretary = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Secrertary Email",
                          ),
                          onChanged: (value) {
                            Esecretary = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Club Treasurer",
                          ),
                          onChanged: (value) {
                            treasurer = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Treasurer Email",
                          ),
                          onChanged: (value) {
                            Etreasurer = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Social Media Link 1",
                          ),
                          onChanged: (value) {
                            link1_ = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Social Media Link 2",
                          ),
                          onChanged: (value) {
                            link2_ = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Social Media Link 3",
                          ),
                          onChanged: (value) {
                            link3_ = value;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            var refLength = await myApp.length();
                            Navigator.of(context).pop();
                            await ref.update({"$refLength/Club Name": name});
                            await ref.update({"$refLength/President": pres});
                            await ref.update({
                              "$refLength/Treasurer": treasurer,
                            });
                            await ref.update({
                              "$refLength/Vice President": vp,
                            });
                            await ref.update({
                              "$refLength/Secretary": secretary,
                            });
                            await ref.update({
                              "$refLength/President Email": Epres,
                            });
                            await ref.update({
                              "$refLength/Treasurer Email": Etreasurer,
                            });
                            await ref.update({
                              "$refLength/Vice President Email": Evp,
                            });
                            await ref.update({
                              "$refLength/Secretary Email": Esecretary,
                            });
                            await ref.update({
                             "$refLength/members": "", 
                            });
                            await ref.update({"$refLength/Club Email": Ename});
                            await ref.update({"$refLength/link1": link1_});
                            await ref.update({"$refLength/link2": link2_});
                            await ref.update({"$refLength/link3": link3_});
                            
                            Navigator.of(context).pop();
                            first_loading_page_5= true;
                            setState(() {});
                          },
                          child: Text("Save and Close"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Back"),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      }
      for (var j = 0; j < len; j++) {
        var num = j;
        await myApp.file(j);
        dynamic snapshot = await ref.child(num.toString()).get();
        if (snapshot.exists) {
          snapshot = snapshot.value;
        }
        if (snapshot["link1"] != null) {
          link1 = snapshot["link1"];
        } else {
          print("1");
          link1 = "";
        }
        if (snapshot["link2"] != null) {
          link2 = snapshot["link2"];
        } else {
          print("2");
          link2 = "";
        }
        if (snapshot["link3"] != null) {
          link3 = snapshot["link3"];
        } else {
          print("3");
          link3 = "";
        }
       
        var email2 = myApp.user?.email.toString().split("@")[0];
        dynamic snapshot2 = await ref.child("$j/registry/$email2").get();
        if (!snapshot2.exists) {
          if (myApp.user?.email == snapshot["Pres Email"] ||
              myApp.user?.email == snapshot["VP Email"] ||
              myApp.user?.email == snapshot["Sec Email"] ||
              myApp.user?.email == snapshot["Treas Email"]) {
            newList.add(
              SizedBox(
                height: 230,
                child: Card(
                  shape: shape,
                  color: Color.fromARGB(217, 27, 195, 237),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          snapshot["Club Name"],
                        ),
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
                          ],
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            showDialog<void>(
                              context: page5context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    children: [
                                      TextFormField(
                                        initialValue: link1,
                                        decoration: InputDecoration(
                                          helperText:
                                              "Social Media Link 1 (eg. Discord, Instagram, Facebook)",
                                        ),
                                        onChanged: (input) async {
                                          link1 = input;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: link2,
                                        decoration: InputDecoration(
                                          helperText:
                                              "Social Media Link 2 (eg. Discord, Instagram, Facebook)",
                                        ),
                                        onChanged: (input) async {
                                          link2 = input;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: link3,
                                        decoration: InputDecoration(
                                          helperText:
                                              "Social Media Link 3 (eg. Discord, Instagram, Facebook)",
                                        ),
                                        onChanged: (input) async {
                                          link3 = input;
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await ref.update({
                                          "$num/link1": link1,
                                        });
                                        await ref.update({
                                          "$num/link2": link2,
                                        });
                                        await ref.update({
                                          "$num/link3": link3,
                                        });
                                        Navigator.of(context).pop();
                                        first_loading_page_5= true;
                                        setState(() {});
                                      },
                                      child: Text("Save and Close"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(Icons.settings),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            newList.add(
              SizedBox(
                height: 230,
                child: Card(
                  shape: shape,
                  color: Color.fromARGB(217, 27, 195, 237),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          snapshot["Club Name"],
                        ),
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
                          ],
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            showDialog<void>(
                              context: page5context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: ListView(
                                    children: [
                                      Text(snapshot["link1"]),
                                      Text(snapshot["link2"]),
                                      Text(snapshot["link3"]),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await myApp.register(num);
                                        Navigator.of(context).pop();
                                        first_loading_page_5= true;
                                        setState(() {});
                                      },
                                      child: Text("Register"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Back"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text("Register"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        }
      }

      return newList;
    }

    wait() async {
      print("started");
      setState(() {
        tileList = [
          SizedBox(height: 200),
          LoadingAnimationWidget.inkDrop(
            color: Color.fromARGB(217, 27, 195, 237),
            size: 100,
          ),
          SizedBox(height: 100),
          Text(textAlign: TextAlign.center, "DO NOT LEAVE THIS PAGE UNLESS IT LOADS FOR OVER A MINUTE")
        ];
      });
      newList = await tile();
      print("tileList: ${newList.toString()}");
      setState(() {
        print("reloading");
        tileList = newList;
      });
    }

    if (first_loading_page_5) {
      print("are waiting");
      first_loading_page_5= false;
      wait();
    }
    else{
      tileList = newList;
    }
    page5context = context;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Unregistered Clubs")),
        body: RefreshIndicator(
          child: ListView(children: tileList),
          onRefresh: () async {
            wait();
          },
        ),
      ),
    );
  }
}
