import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_integration/login.dart';
import 'package:social_media_integration/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  bool isUser = false;

  Future<bool> getCurrentUser() async {
    try {
      loggedInUser= await _auth.currentUser();
      if(loggedInUser!=null){
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: getCurrentUser(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(snapshot.data){
              return Profile(user: loggedInUser);
            }
          }
          return Login();
        },
      ),
    );
  }
}
