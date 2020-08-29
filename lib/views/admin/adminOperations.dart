import 'package:flutter/material.dart';

class AdminOperations extends StatefulWidget {
  static const String route = '/admin';
  AdminOperations({Key key}) : super(key: key);

  @override
  _AdminOperationsState createState() => _AdminOperationsState();
}

class _AdminOperationsState extends State<AdminOperations> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Need rich text editor here"),
    );
  }
}
