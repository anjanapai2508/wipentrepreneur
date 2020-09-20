import 'package:flutter/material.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';
import 'package:date_format/date_format.dart';
import '../../helpers/formatted-text.dart';
import '../../router.dart' as router;

class PostsOnHomePage extends StatelessWidget {
  const PostsOnHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Posts>>(
      future: DbOperations().getAllPosts(false, false),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return FormattedText("Watch this space for more interesting posts",
                20, Colors.black, TextAlign.center);
          } else {
            List<Posts> allPosts = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: allPosts.length,
              itemBuilder: (context, index) {
                final Posts post = snapshot.data[index];
                bool showComments = false;
                bool showLikes = false;
                DateTime publishedDate = DateTime.parse(post.publishedDate);
                if (post.comments != null && post.comments.length != 0) {
                  showComments = true;
                }
                if (post.likes != null && post.likes > 0) {
                  showLikes = true;
                }
                return InkWell(
                    onTap: () {
                      //Display Post
                      Navigator.pushNamed(context, router.READ_POST,
                          arguments: post);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(right: 30, left: 30),
                        child: Card(
                            child: Row(children: <Widget>[
                          Expanded(
                            //flex: 1,
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
                                  FormattedText(post.subtitle, 15, Colors.black,
                                      TextAlign.center),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      if (showLikes)
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.pink,
                                          size: 24.0,
                                          semanticLabel:
                                              'No of likes on this post',
                                        ),
                                      if (showLikes)
                                        FormattedText(post.likes.toString(), 15,
                                            Colors.black, TextAlign.center),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      if (showComments)
                                        Icon(
                                          Icons.comment,
                                          color: Colors.black,
                                          size: 24.0,
                                          semanticLabel:
                                              'No of comments on this post',
                                        ),
                                      if (showComments)
                                        FormattedText(
                                            post.comments.length.toString(),
                                            15,
                                            Colors.black,
                                            TextAlign.center),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ))
                        ]))));
              },
            );
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
