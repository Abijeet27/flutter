import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/page1.dart';
import 'package:flutter_application_1/page2.dart';
import 'package:flutter_application_1/page3.dart';
import 'package:flutter_application_1/page5.dart';
import 'package:flutter_application_1/my_app_state.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> options = [Page1(), Page2(), Page3(), Page5()];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(child: options.elementAt(selectedIndex)),
          bottomNavigationBar:
              BottomNavigationBar(
                unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
                selectedItemColor:Color.fromARGB(169, 252, 5, 5), 
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.face_2),
                      label: "Page 1",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.face_3),
                      label: "Page 2",
                    ),
                    BottomNavigationBarItem(
                      icon:Icon(Icons.face),
                      label: "Page 3",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.face_4),
                      label: "Page 4",
                    )
                  ],
                  currentIndex: selectedIndex,
                  onTap: (value) {
                    MyAppState().tile();
                    MyAppState().tileRegister();
                    setState(() {
                      selectedIndex = value;
                    });
                  },
              )
        );
      }
    );
  }
}