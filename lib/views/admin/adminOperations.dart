import 'package:flutter/material.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';
import 'package:date_format/date_format.dart';
import 'package:wipentrepreneur/views/posts/postHeader.dart';
import '../../helpers/formatted-text.dart';
import '../../router.dart' as router;

class AdminOperations extends StatelessWidget {
  final Posts postToDisplay;
  const AdminOperations({Key key, this.postToDisplay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
      PostHeader(
        showAdminOps: true,
      ),
      SizedBox(
        height: 20,
      ),
      FutureBuilder<List<Posts>>(
        future: DbOperations().getAllPoststoEdit(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Posts> allPosts = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: allPosts.length,
              itemBuilder: (context, index) {
                final Posts post = snapshot.data[index];
                DateTime publishedDate = DateTime.parse(post.publishedDate);
                return InkWell(
                    onTap: () {
                      //Edit Post
                      Navigator.pushNamed(context, router.EDIT,
                          arguments: post);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(right: 30, left: 30),
                        child: Card(
                            child: Row(children: <Widget>[
                          Expanded(
                            child: Column(children: <Widget>[
                              FormattedText("Published On", 10, Colors.black,
                                  TextAlign.center),
                              FormattedText(
                                  formatDate(
                                      publishedDate, [MM, ' ', dd, ', ', yyyy]),
                                  12,
                                  Colors.black,
                                  TextAlign.center),
                            ]),
                          ),
                          Expanded(
                              flex: 6,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FormattedText(post.title, 20, Colors.black,
                                      TextAlign.center),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ))
                        ]))));
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      SizedBox(
        height: 20,
      ),
    ])));
  }
}
