import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';
import 'package:wipentrepreneur/views/userActions/subscribeDialog.dart';

class PostLayoutPhone extends StatefulWidget {
  final Posts showPost;
  PostLayoutPhone({Key key, this.showPost}) : super(key: key);

  @override
  _PostLayoutPhoneState createState() => _PostLayoutPhoneState();
}

class _PostLayoutPhoneState extends State<PostLayoutPhone> {
  donate(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: MarkdownWidget(
                      data: widget.showPost.body,
                      styleConfig: StyleConfig(
                        preConfig: PreConfig(
                            textStyle:
                                TextStyle(fontFamily: 'Roboto', fontSize: 15)),
                        pConfig: PConfig(
                            textConfig: TextConfig(textAlign: TextAlign.left),
                            linkStyle: TextStyle(
                              fontFamily: 'Roboto',
                              height: 1.5,
                              color: Colors.blue,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                            ),
                            onLinkTap: (url) {
                              launch(url);
                            },
                            textStyle: TextStyle(
                              fontFamily: 'Roboto',
                              height: 1.5,
                              color: Colors.black45,
                              fontSize: 18,
                              decoration: TextDecoration.none,
                            )),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                FormattedText("-The WIP Entrepreneur", 20, Colors.black,
                    TextAlign.center),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: IconButton(
                        icon: Image.asset('phone_donate.png'),
                        onPressed: () {
                          donate(
                              "https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=UMG6565EH4QKC&currency_code=CAD&source=url");
                        },
                        tooltip: "Buy me a coffee",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        flex: 2,
                        child: Container(
                          child: IconButton(
                            icon: Image.asset(
                                'subscribe_phone.png'), //Icons made by <a href="https://www.flaticon.com/authors/alfredo-hernandez" title="Alfredo Hernandez">Alfredo Hernandez</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      SubscribeDialog());
                            },
                            tooltip: "Subscribe",
                          ),
                        )),
                    Flexible(
                      flex: 2,
                      child: LikeButton(
                        onTap: (isLiked) {
                          return DbOperations()
                              .onLikeButtonTapped(isLiked, widget.showPost.id);
                        },
                        size: 40,
                        circleColor:
                            CircleColor(start: Colors.red, end: Colors.pink),
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
                        countBuilder: (int count, bool isLiked, String text) {
                          var color = isLiked
                              ? Colors.deepPurpleAccent[100]
                              : Colors.pink;
                          Widget result;
                          if (count == 0) {
                            result = Text(
                              "",
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
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    //TODO : Add logic for used to login and add a comment (nice-to-have)
                  ],
                ),
              ])
        ]));
  }
}
