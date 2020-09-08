import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';
import 'package:wipentrepreneur/views/posts/postHeader.dart';
import 'package:wipentrepreneur/views/userActions/subscribeDialog.dart';
import 'package:like_button/like_button.dart';

class ReadPost extends StatefulWidget {
  final Posts showPost;
  ReadPost({Key key, this.showPost}) : super(key: key);

  @override
  _ReadPostState createState() => _ReadPostState();
}

class _ReadPostState extends State<ReadPost> {
  int noOfLikes = 0;
  TextEditingController commentController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.showPost.likes != null) {
      noOfLikes = widget.showPost.likes;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          PostHeader(showAdminOps: false),
          FormattedText(
              widget.showPost.title, 50, Colors.black, TextAlign.center),
          FormattedText(
              widget.showPost.subtitle, 20, Colors.black, TextAlign.center),
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
                          Container(
                              height: 50,
                              width: 170,
                              child: RaisedButton.icon(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(color: Colors.red)),
                                onPressed: () {
                                  donate(
                                      "https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=UMG6565EH4QKC&currency_code=CAD&source=url");
                                },
                                padding: EdgeInsets.all(0.0),
                                icon: Image.asset(
                                    'drink.png'), //Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
                                label: Text("Buy me a coffee"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: 150,
                            child: RaisedButton.icon(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Colors.red)),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        SubscribeDialog());
                              },
                              padding: EdgeInsets.all(0.0),
                              icon: Image.asset(
                                  'subscribe.png'), //Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
                              label: Text("Subscribe"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              LikeButton(
                                onTap: (isLiked) {
                                  return DbOperations().onLikeButtonTapped(
                                      isLiked, widget.showPost.id);
                                },
                                size: 40,
                                circleColor: CircleColor(
                                    start: Colors.red, end: Colors.pink),
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: Colors.pink,
                                  dotSecondaryColor: Colors.pink,
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.favorite,
                                    color: isLiked
                                        ? Colors.deepPurpleAccent[100]
                                        : Colors.pink,
                                    size: 30,
                                  );
                                },
                                likeCount: widget.showPost.likes,
                                countBuilder:
                                    (int count, bool isLiked, String text) {
                                  var color = isLiked
                                      ? Colors.deepPurpleAccent[100]
                                      : Colors.pink;
                                  Widget result;
                                  if (count == 0) {
                                    result = Text(
                                      "love",
                                      style: TextStyle(
                                          color: Colors.pink,
                                          fontSize: 15,
                                          decoration: TextDecoration.none),
                                    );
                                  } else
                                    result = Text(
                                      text,
                                      style: TextStyle(
                                          color: color,
                                          fontSize: 15,
                                          decoration: TextDecoration.none),
                                    );

                                  return result;
                                },
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              // Icon(
                              //   Icons.comment,
                              //   color: Colors.black,
                              //   size: 20.0,
                              //   semanticLabel: 'No of comments on this post',
                              // ),
                              // FormattedText(
                              //     //"10",
                              //     widget.showPost.comments.length.toString(),
                              //     10,
                              //     Colors.black,
                              //     TextAlign.center)
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
                            SizedBox(
                              height: 20,
                            ),
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
                          ],
                        )),
                  ])))
            ],
          ),
          SizedBox(
            height: 30,
          ),
          PostHeader(showAdminOps: false),
        ],
      ),
    );
  }
}
