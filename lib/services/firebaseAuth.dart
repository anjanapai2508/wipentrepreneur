import 'package:firebase/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseAuthService with ChangeNotifier {
  Future<User> signIn(String email, String password);
}

class FirebaseAuthService extends BaseAuthService {
  FirebaseAuthService({Auth firebaseAuth, GoogleAuthProvider googleSignin})
      : _firebaseAuth = firebaseAuth ?? auth();

  final Auth _firebaseAuth;

  // setGlobalLoggedIn(String displayName) {
  //   var global = new Global();
  //   global.isLoggedIn = true;
  //   global.currentUserName = displayName;
  // }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      var auth =
          await _firebaseAuth.signInWithEmailAndPassword(email, password);
      return auth.user;
    } catch (e) {
      print("Error signin in with given credentials : " + e.toString());
    }
    return null;
  }
}
