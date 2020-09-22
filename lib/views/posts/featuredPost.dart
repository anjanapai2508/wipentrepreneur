import 'package:flutter/material.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/models/posts.dart';
import '../../router.dart' as router;

class FeaturedPost extends StatelessWidget {
  final Posts featuredPost;
  const FeaturedPost({Key key, this.featuredPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width < 600
        ? MediaQuery.of(context).size.width / 5
        : MediaQuery.of(context).size.width / 3;
    double postHeight = MediaQuery.of(context).size.width < 600 ? 150 : 250;
    //bool isSmallScreen = MediaQuery.of(context).size.width < 600 ? true : false;
    return Container(
      child: InkWell(
          onTap: () {
            //Display Post
            Navigator.pushNamed(context, router.READ_POST,
                arguments: featuredPost);
          },
          child:
              // Padding(
              //     padding: EdgeInsets.all(50),
              //     child:
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: postHeight,
                        width: imageWidth,
                        child: Image.asset(
                          'boss.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FormattedText(featuredPost.title, 40,
                                      Colors.black, TextAlign.center),
                                  FormattedText(featuredPost.subtitle, 20,
                                      Colors.black, TextAlign.center), //),
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
                                        semanticLabel:
                                            'No of likes on this post',
                                      ),
                                      FormattedText(
                                          featuredPost.likes.toString(),
                                          15,
                                          Colors.black,
                                          TextAlign.center),
                                    ],
                                  )
                                ])),
                      )
                    ],
                  ))),
    );
  }
}
