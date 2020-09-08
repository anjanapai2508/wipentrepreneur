import 'package:flutter/material.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';
import 'package:wipentrepreneur/views/posts/featuredPost.dart';
import 'package:wipentrepreneur/views/home/homepageHero.dart';
import 'package:wipentrepreneur/views/posts/postHeader.dart';
import 'package:wipentrepreneur/views/posts/postsOnHomePage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Posts>(
            future: DbOperations().getFeaturedPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                    child: Column(children: [
                  HomePageHero(),
                  FeaturedPost(
                    featuredPost: snapshot.data,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  PostsOnHomePage(),
                  SizedBox(
                    height: 50,
                  ),
                  PostHeader(showAdminOps: false)
                ]));
              } else if (snapshot.hasError) {
                print("Error getting featured post : ${snapshot.error}");
                return Text(
                    "Sorry we are unable to process your request right now, try again in a few minutes");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
