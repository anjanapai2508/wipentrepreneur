import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';
import 'package:wipentrepreneur/views/posts/postHeader.dart';

import '../../helpers/inputWidget.dart';

class CreatePost extends StatefulWidget {
  CreatePost({Key key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String postBody = "Preview will appear here..";

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = new TextEditingController();
    TextEditingController subtitleController = new TextEditingController();
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      PostHeader(
        showAdminOps: true,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              FormattedText("Writing Area", 15, Colors.black, TextAlign.center),
              SizedBox(
                height: 30,
              ),
              InputWidget(10, 10, false, "Enter Post Title", titleController),
              SizedBox(
                height: 5,
              ),
              InputWidget(
                  10, 10, false, "Enter Post Subtitle", subtitleController),
              Container(
                  height: MediaQuery.of(context).size.height - 150,
                  child: Material(
                    elevation: 2,
                    color: Colors.grey[350],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Start typing here...",
                        ),
                        onChanged: (String t) {
                          setState(() {
                            this.postBody = t;
                          });
                        },
                      ),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () {
                  DbOperations().createNewPost(
                      postBody, subtitleController.text, titleController.text);
                  subtitleController.clear();
                  titleController.clear();
                  postBody = "Preview will appear here..";
                },
                child: Text("Save"),
              ),
            ],
          )),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                FormattedText("Preview", 15, Colors.black, TextAlign.center),
                SizedBox(
                  height: 30,
                ),
                DefaultTextStyle(
                    style: TextStyle(
                        height: 2,
                        letterSpacing: 1.0,
                        color: Colors.red,
                        fontSize: 35,
                        decoration: TextDecoration.none),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 150,
                        child: MarkdownWidget(
                          data: postBody,
                          styleConfig: StyleConfig(
                            preConfig: PreConfig(
                                textStyle: TextStyle(
                                    color: Colors.black45, fontSize: 15)),
                            pConfig: PConfig(
                                textStyle: TextStyle(
                              height: 2,
                              letterSpacing: 1.0,
                              color: Colors.black45,
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            )),
                          ),
                        )))
              ]))
        ],
      ),
    ]));
  }
}
