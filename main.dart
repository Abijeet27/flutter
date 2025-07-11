import 'package:firebase_auth/firebase_auth.dart' as Auth show FirebaseAuth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/SignUp.dart';
import 'package:flutter_application_1/my_app_state.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

import 'firebase_options.dart' show DefaultFirebaseOptions;


dynamic read(x) async{
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    var snapshot = await ref.child(x.toString()).get();
    if (snapshot.exists){
      return snapshot;
    }
  }
void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String data ="";
  runApp(MyApp());
  
}
var name = "";
var page2context;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: SignUp(),
      ),
    );
  }
}
var selectedIndex = 0;
var usernames = [];
var descs = [];
var x = 0;
var rows = [
  Row(
    children: []
    ),
];