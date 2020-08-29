import 'package:flutter/material.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';

class AdminOperations extends StatefulWidget {
  AdminOperations({Key key}) : super(key: key);

  @override
  _AdminOperationsState createState() => _AdminOperationsState();
}

class _AdminOperationsState extends State<AdminOperations> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FormattedText("Please add a text editor here", 30, Colors.black,
                TextAlign.center),
          ],
        ),
      ),
    ));
  }
}
