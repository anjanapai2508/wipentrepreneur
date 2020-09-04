import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';
import 'package:wipentrepreneur/views/posts/postHeader.dart';
import 'package:wipentrepreneur/views/userActions/subscribeDialog.dart';

class ReadPost extends StatefulWidget {
  final Posts showPost;
  ReadPost({Key key, this.showPost}) : super(key: key);

  @override
  _ReadPostState createState() => _ReadPostState();
}

class _ReadPostState extends State<ReadPost> {
  TextEditingController commentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> listOfComments = [];
    if (widget.showPost.comments != null &&
        widget.showPost.comments.length > 0) {
      listOfComments = widget.showPost.comments;
    }

    donate(String url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          PostHeader(),
          FormattedText(
              widget.showPost.title, 60, Colors.black, TextAlign.center),
          FormattedText(
              widget.showPost.subtitle, 30, Colors.black, TextAlign.center),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: FittedBox(
                      fit: BoxFit.fill,
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: FormattedText("The WIP \nEntrepreneur", 30,
                                  Colors.black, TextAlign.center)),
                          RaisedButton(
                            onPressed: () {
                              donate(
                                  "https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=UMG6565EH4QKC&currency_code=CAD&source=url");
                            },
                            child: Text("Buy me a coffee"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      SubscribeDialog());
                            },
                            child: Text("Subscribe"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.favorite,
                                color: Colors.pink,
                                size: 20.0,
                                semanticLabel: 'No of likes on this post',
                              ),
                              if (widget.showPost.likes != null)
                                FormattedText(widget.showPost.likes.toString(),
                                    10, Colors.black, TextAlign.center),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.comment,
                                color: Colors.black,
                                size: 20.0,
                                semanticLabel: 'No of comments on this post',
                              ),
                              FormattedText(
                                  //"10",
                                  widget.showPost.comments.length.toString(),
                                  10,
                                  Colors.black,
                                  TextAlign.center)
                            ],
                          ),
                        ],
                      ))),
              Expanded(
                  flex: 8,
                  child: Container(
                      child: Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Card(
                              elevation: 0,
                              child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: MarkdownWidget(
                                    data: widget.showPost.body,
                                    styleConfig: StyleConfig(
                                      preConfig: PreConfig(
                                          textStyle: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 15)),
                                      pConfig: PConfig(
                                          textStyle: TextStyle(
                                        height: 2,
                                        letterSpacing: 1.0,
                                        color: Colors.black45,
                                        fontSize: 20,
                                        decoration: TextDecoration.none,
                                      )),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            FormattedText(
                                "Comments :", 20, Colors.black, TextAlign.left),
                            SizedBox(
                              height: 20,
                            ),
                            Material(
                              elevation: 1,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5),
                                      topRight: Radius.circular(5))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 20, top: 0),
                                child: Container(
                                    height: 150,
                                    child: TextField(
                                      controller: commentController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              "What are your thoughts on this post?",
                                          hintStyle: TextStyle(
                                              color: Color(0xFFE1E1E1),
                                              fontSize: 20)),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FloatingActionButton.extended(
                                  onPressed: () {
                                    listOfComments.add(commentController.text);
                                    setState(() {});
                                    DbOperations().addComment(
                                        commentController.text,
                                        widget.showPost.id);
                                    commentController.clear();
                                  },
                                  label: Text('Respond'),
                                  backgroundColor: Colors.grey,
                                ),
                              ],
                            ),
                            if (listOfComments != null)
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: listOfComments.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                        elevation: 2,
                                        child: ListTile(
                                          title: FormattedText(
                                              listOfComments[index],
                                              15,
                                              Colors.black,
                                              TextAlign.left),
                                        ));
                                  }),
                          ],
                        )),
                  ])))
            ],
          ),
          SizedBox(
            height: 30,
          ),
          PostHeader(),
        ],
      ),
    );
  }
}
