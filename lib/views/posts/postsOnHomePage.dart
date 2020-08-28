import 'package:flutter/material.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';

import '../formatted-text.dart';
import '../../router.dart' as router;

class PostsOnHomePage extends StatelessWidget {
  final Posts postToDisplay;
  const PostsOnHomePage({Key key, this.postToDisplay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _crossAxisCount = 2;
    var _crossAxisSpacing = 10;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    return FutureBuilder<List<Posts>>(
      future: DbOperations().getAllPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Posts> allPosts = snapshot.data;
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: _width / 400),
            itemCount: allPosts.length,
            itemBuilder: (context, index) {
              final Posts post = snapshot.data[index];
              bool showComments = false;
              bool showLikes = false;
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
                      padding: EdgeInsets.all(30),
                      child:
                          //Card(
                          //child:
                          Column(children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 5, color: Colors.grey)),
                            child: Image.asset(
                              'main_background.jpg',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormattedText(
                            post.title, 20, Colors.black, TextAlign.center),
                        FormattedText(
                            post.subtitle, 15, Colors.black, TextAlign.center),
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
                                semanticLabel: 'No of likes on this post',
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
                                semanticLabel: 'No of comments on this post',
                              ),
                            if (showComments)
                              FormattedText(post.comments.length.toString(), 15,
                                  Colors.black, TextAlign.center),
                          ],
                        )
                      ]) //),
                      ));
            },
          );
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
