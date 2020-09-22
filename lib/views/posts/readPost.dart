import 'package:flutter/material.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/views/home/customDrawer.dart';
import 'package:wipentrepreneur/views/posts/postHeader.dart';
import 'package:wipentrepreneur/views/posts/postLayoutDesktop.dart';
import 'package:wipentrepreneur/views/posts/postLayoutPhone.dart';

class ReadPost extends StatefulWidget {
  final Posts showPost;
  ReadPost({Key key, this.showPost}) : super(key: key);

  @override
  _ReadPostState createState() => _ReadPostState();
}

class _ReadPostState extends State<ReadPost> {
  int noOfLikes = 0;
  TextEditingController commentController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    if (widget.showPost.likes != null) {
      noOfLikes = widget.showPost.likes;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600 ? true : false;
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: isSmallScreen
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
              )
            : null,
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          PostHeader(showAdminOps: false),
          Padding(
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Column(
                children: <Widget>[
                  FormattedText(widget.showPost.title, 50, Colors.black,
                      TextAlign.center),
                  FormattedText(widget.showPost.subtitle, 20, Colors.black,
                      TextAlign.center),
                  if (isSmallScreen)
                    PostLayoutPhone(
                      showPost: widget.showPost,
                    )
                  else
                    PostLayoutDesktop(
                      showPost: widget.showPost,
                    ),

                  //TODO : Add logic for used to login and add a comment (nice-to-have)
                  // FormattedText(
                  //     "Comments :", 20, Colors.black, TextAlign.left),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Material(
                  //   elevation: 1,
                  //   color: Colors.white,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.only(
                  //           bottomRight: Radius.circular(5),
                  //           topRight: Radius.circular(5))),
                  //   child: Padding(
                  //     padding: EdgeInsets.only(
                  //         left: 10, right: 20, top: 0),
                  //     child: Container(
                  //         height: 150,
                  //         child: TextField(
                  //           controller: commentController,
                  //           decoration: InputDecoration(
                  //               border: InputBorder.none,
                  //               hintText:
                  //                   "What are your thoughts on this post?",
                  //               hintStyle: TextStyle(
                  //                   color: Color(0xFFE1E1E1),
                  //                   fontSize: 20)),
                  //         )),
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     RaisedButton(
                  //         onPressed: () {
                  //           listOfComments
                  //               .add(commentController.text);
                  //           setState(() {});
                  //           DbOperations().addComment(
                  //               commentController.text,
                  //               widget.showPost.id);
                  //           commentController.clear();
                  //         },
                  //         child: Text('Respond'),
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius:
                  //                 BorderRadius.circular(15.0),
                  //             side: BorderSide(color: Colors.red))),
                  //   ],
                  // ),
                  // if (listOfComments != null)
                  //   ListView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: listOfComments.length,
                  //       itemBuilder: (context, index) {
                  //         return Card(
                  //             elevation: 2,
                  //             child: ListTile(
                  //               title: FormattedText(
                  //                   listOfComments[index],
                  //                   15,
                  //                   Colors.black,
                  //                   TextAlign.left),
                  //             ));
                  //       }),

                  SizedBox(
                    height: 50,
                  ),
                ],
              )),
          PostHeader(showAdminOps: false),
        ])));
  }
}
