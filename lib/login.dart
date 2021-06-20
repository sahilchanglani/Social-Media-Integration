import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_integration/auth.dart';
import 'package:social_media_integration/profile.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String errormsg='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/logo.jpg'),
              ),
            ),
            SizedBox(
              height: 34.0,
            ),
            Center(
              child: TypewriterAnimatedTextKit(
                speed: Duration(milliseconds: 100),
                pause: Duration(seconds: 4),
                text: ['Social Media Integration'],
                textStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Agne',
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(height: 50,),
            Center(
              child: Container(
                width: 280,
                child: FlatButton(
                  onPressed: () async {
                    FirebaseUser user = await googleSignIn();
                    if(user!=null){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Profile(user: user)));
                    }
                  },
                  child: Image.asset('assets/google.png')
                )
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: Container(width: 292,child: FlatButton(onPressed: () async{
                FirebaseUser user = await twitterSignIn();
                if(user!=null){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Profile(user: user)));
                }
              }, child: Image.asset('assets/twitter.png'))),
            ),
            SizedBox(height: 20,),
            Center(
              child: Text(
                errormsg,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.red
                ),),
            )
          ],
        ),
      ),
    );
  }
}
