import 'package:flutter/material.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';
import 'package:wipentrepreneur/views/home/customDrawer.dart';
import 'package:wipentrepreneur/views/home/homePageHeroDesktop.dart';
import 'package:wipentrepreneur/views/home/homepageHero.dart';
import 'package:wipentrepreneur/views/posts/featuredPost.dart';
import 'package:wipentrepreneur/views/posts/postHeader.dart';
import 'package:wipentrepreneur/views/posts/postsOnHomePage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
            child: Column(children: [
          if (isSmallScreen) HomePageHero() else HomePageHeroDesktop(),
          FutureBuilder<Posts>(
              future: DbOperations().getFeaturedPost(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FeaturedPost(
                    featuredPost: snapshot.data,
                  );
                } else if (snapshot.hasError) {
                  print("Error getting featured post : ${snapshot.error}");
                  return Text(
                      "Sorry we are unable to process your request right now, try again in a few minutes");
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
          PostsOnHomePage(),
          SizedBox(
            height: 50,
          ),
          if (isSmallScreen) HomePageHero() else PostHeader(showAdminOps: false)
        ])));
  }
}
