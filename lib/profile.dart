import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_integration/auth.dart';
import 'package:social_media_integration/login.dart';

class Profile extends StatefulWidget {

  final FirebaseUser user;
  Profile({@required this.user});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String errormsg='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(widget.user.photoUrl),
              ),
              SizedBox(height: 30,),
              Text(widget.user.displayName,style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800
              ),),
              SizedBox(height: 20,),
              Text(widget.user.email,style: TextStyle(
                  fontSize: 20
              ),),
              SizedBox(height: 50,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () async {
                      if(await signOutUser() != false){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                      }
                      else{
                        setState(() {
                          errormsg='Some error has occurred. Please try again later.';
                        });
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Log out',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
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
      ),
    );
  }
}
