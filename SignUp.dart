import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_app_state.dart';
import 'package:flutter_application_1/my_home_page.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_application_1/page5.dart';
class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override

  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(), // new
            ],
          );
        }
        MyAppState().resetUser();
        
        return const MyHomePage();
      },
    );
  }
}
