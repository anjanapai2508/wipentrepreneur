import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:wipentrepreneur/services/dbOperations.dart';
import 'package:wipentrepreneur/views/home/customDrawer.dart';
import 'package:wipentrepreneur/views/home/homePageHeroDesktop.dart';
import 'package:wipentrepreneur/views/home/homepageHero.dart';
import 'package:wipentrepreneur/views/posts/featuredPost.dart';
import 'package:wipentrepreneur/views/posts/postHeader.dart';
import 'package:wipentrepreneur/views/posts/postsOnHomePage.dart';
import 'package:wipentrepreneur/views/userActions/subscribeDialog.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
          if (isSmallScreen)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Flexible(
                flex: 1,
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
                width: 20,
              ),
              Flexible(
                  flex: 1,
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
            ])
          else
            PostHeader(showAdminOps: false)
        ])));
  }
}
