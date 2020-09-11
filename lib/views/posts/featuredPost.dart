import 'package:flutter/material.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/models/posts.dart';
import '../../router.dart' as router;

class FeaturedPost extends StatelessWidget {
  final Posts featuredPost;
  const FeaturedPost({Key key, this.featuredPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          //Display Post
          Navigator.pushNamed(context, router.READ_POST,
              arguments: featuredPost);
        },
        child: Padding(
            padding: EdgeInsets.all(50),
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Image.asset(
                        'boss.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FormattedText(featuredPost.title, 40, Colors.black,
                                TextAlign.center),
                            FormattedText(featuredPost.subtitle, 20,
                                Colors.black, TextAlign.center),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  color: Colors.pink,
                                  size: 24.0,
                                  semanticLabel: 'No of likes on this post',
                                ),
                                FormattedText(featuredPost.likes.toString(), 15,
                                    Colors.black, TextAlign.center),
                                // SizedBox(
                                //   width: 30,
                                // ),
                                // Icon(
                                //   Icons.comment,
                                //   color: Colors.black,
                                //   size: 24.0,
                                //   semanticLabel: 'No of comments on this post',
                                // ),
                                // FormattedText(featuredPost.comments.length.toString(),
                                //     15, Colors.black, TextAlign.center),
                              ],
                            )
                          ]),
                    )
                  ],
                ))),
      ),
    );
  }
}
