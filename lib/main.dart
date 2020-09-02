import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:wipentrepreneur/views/admin/adminLogin.dart';
import 'router.dart' as router;
import 'package:wipentrepreneur/keys/keys.dart' as keys;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    if (firebase.apps.length == 0) {
      firebase.initializeApp(
        apiKey: keys.fbApiKey,
        authDomain: keys.authDomain,
        databaseURL: keys.projectId,
        projectId: keys.projectId,
        storageBucket: keys.storageBucket,
        messagingSenderId: keys.messagingSenderId,
      );
    }
    return MaterialApp(
      title: 'WIPEntrepreneur',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:
              Theme.of(context).textTheme.apply(fontFamily: 'Open Sans')),
      onGenerateRoute: router.generateRoute,
      initialRoute: '/',
      routes: {AdminLogin.route: (context) => AdminLogin()},
    );
  }
}
