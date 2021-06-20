import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();

showErrorDialog(BuildContext context, String err) {
  FocusScope.of(context).requestFocus(FocusNode());
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

Future<FirebaseUser> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await auth.signInWithCredential(credential);

    FirebaseUser user = await auth.currentUser();
    print(user.uid);

    return user;
  }
}

var twitterLogin = new TwitterLogin(
  consumerKey: 't0nEZhCbozKwSvSZTUOK0Gccf',
  consumerSecret: 'eCesrt6H7NqOFuU8jqvG65MQ1UJkI6fZeHa9PPcafBGZ5aU9bt',
);

Future<FirebaseUser> twitterSignIn() async{
  final TwitterLoginResult result = await twitterLogin.authorize();

  switch (result.status) {
    case TwitterLoginStatus.loggedIn:
      var session = result.session;
      print(session.username);

      AuthCredential _authCredential = TwitterAuthProvider.getCredential(
          authToken: session.token,
          authTokenSecret: session.secret
      );

      AuthResult _currentUser = await auth.signInWithCredential(_authCredential);

      FirebaseUser user = await auth.currentUser();
      return user;
      //_sendTokenAndSecretToServer(session.token, session.secret);
      break;
    case TwitterLoginStatus.cancelledByUser:
      //_showCancelMessage();
      print('Cancelled by user');
      break;
    case TwitterLoginStatus.error:
      print('Error occurred');
      break;
  }
}


Future<bool> signOutUser() async {
  FirebaseUser user = await auth.currentUser();
  print(user.providerData[1].providerId);
  if (user.providerData[1].providerId == 'google.com') {
    await gooleSignIn.disconnect();
  }
  await auth.signOut();
  return Future.value(true);
}