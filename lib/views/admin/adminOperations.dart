import 'package:flutter/material.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:markdown_widget/markdown_widget.dart';

class AdminOperations extends StatefulWidget {
  AdminOperations({Key key}) : super(key: key);

  @override
  _AdminOperationsState createState() => _AdminOperationsState();
}

class _AdminOperationsState extends State<AdminOperations> {
  String text= "";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (String t){
                setState(() {
                  this.text = t;
                });
              },
            ),),
            Expanded(child:
            MarkdownWidget(data:  text
             )
            ),

            FormattedText("Please add a text editor here", 30, Colors.black,
                TextAlign.center),
          ],
        ),
      ),
    ));
  }
}
