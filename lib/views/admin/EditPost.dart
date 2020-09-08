import 'package:flutter/material.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';
import 'package:wipentrepreneur/views/posts/postHeader.dart';
import '../../router.dart' as router;

class EditPost extends StatefulWidget {
  final Posts postToEdit;
  EditPost({Key key, this.postToEdit}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = new TextEditingController();
    TextEditingController subtitleController = new TextEditingController();
    TextEditingController postBodyController = new TextEditingController();
    return Material(
        child: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        PostHeader(
          showAdminOps: true,
        ),
        SizedBox(
          height: 30,
        ),
        FormattedText("Editing Area", 15, Colors.black, TextAlign.center),
        SizedBox(
          height: 30,
        ),
        Padding(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: Container(
                height: 55,
                child: Material(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                      child: TextField(
                        controller: titleController
                          ..text = widget.postToEdit.title,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Color(0xFFE1E1E1), fontSize: 14)),
                      ),
                    )))),
        SizedBox(
          height: 5,
        ),
        Padding(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: Container(
                height: 55,
                child: Material(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                      child: TextField(
                        controller: subtitleController
                          ..text = widget.postToEdit.subtitle,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Color(0xFFE1E1E1), fontSize: 14)),
                      ),
                    )))),
        Padding(
            padding: EdgeInsets.only(right: 50, left: 50),
            child: Container(
                height: MediaQuery.of(context).size.height - 150,
                child: Material(
                  elevation: 2,
                  color: Colors.grey[350],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.postToEdit.body,
                      ),
                      controller: postBodyController
                        ..text = widget.postToEdit.body,
                    ),
                  ),
                ))),
        SizedBox(
          height: 30,
        ),
        RaisedButton(
          onPressed: () {
            DbOperations()
                .editPost(widget.postToEdit.id, postBodyController.text,
                    subtitleController.text, titleController.text)
                .then((value) => Navigator.pushReplacementNamed(
                      this.context,
                      router.ADMINOPS,
                    ));
          },
          child: Text("Save"),
        ),
      ],
    )));
    // SizedBox(
    //   width: 10,
    // ),
    // Expanded(
    //     child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //       FormattedText("Preview", 15, Colors.black, TextAlign.center),
    //       SizedBox(
    //         height: 30,
    //       ),
    //       DefaultTextStyle(
    //           style: TextStyle(
    //               height: 2,
    //               letterSpacing: 1.0,
    //               color: Colors.red,
    //               fontSize: 35,
    //               decoration: TextDecoration.none),
    //           child: Container(
    //               height: MediaQuery.of(context).size.height - 150,
    //               child: MarkdownWidget(
    //                 data: postBody,
    //                 styleConfig: StyleConfig(
    //                   preConfig: PreConfig(
    //                       textStyle: TextStyle(
    //                           color: Colors.black45, fontSize: 15)),
    //                   pConfig: PConfig(
    //                       textStyle: TextStyle(
    //                     height: 2,
    //                     letterSpacing: 1.0,
    //                     color: Colors.black45,
    //                     fontSize: 20,
    //                     decoration: TextDecoration.none,
    //                   )),
    //                 ),
    //               )))
    //     ]))
    //   ],
    // ),
    //]
    //)
    //)
    //);
  }
}
