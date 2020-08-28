import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WIPEntrepreneur',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:
              Theme.of(context).textTheme.apply(fontFamily: 'Open Sans')),
      onGenerateRoute: router.generateRoute,
      initialRoute: '/',
    );
  }
}
