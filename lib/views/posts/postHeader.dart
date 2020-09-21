import 'package:flutter/material.dart';
import 'package:wipentrepreneur/views/home/customDrawer.dart';
import 'package:wipentrepreneur/views/userActions/getInTouch.dart';
import 'package:wipentrepreneur/views/userActions/subscribeDialog.dart';
import '../../router.dart' as router;
import '../../helpers/formatted-text.dart';

class PostHeader extends StatelessWidget {
  final showAdminOps;
  const PostHeader({Key key, this.showAdminOps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    bool isSmallScreen = MediaQuery.of(context).size.width < 600 ? true : false;
    return Container(
      child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned.fill(
                  child: Image.asset(
                'main_background.jpg',
                fit: BoxFit.fitWidth,
                color: Colors.black.withOpacity(0.2),
                colorBlendMode: BlendMode.softLight,
              )),
              if (!isSmallScreen)
                Center(
                    child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white)),
                          color: Colors.transparent,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              router.HOME,
                            );
                          },
                          child: FormattedText(
                              "Home", 15, Colors.white, TextAlign.center),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white)),
                          color: Colors.transparent,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    SubscribeDialog());
                          },
                          child: FormattedText(
                              "Subscribe", 15, Colors.white, TextAlign.center),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white)),
                          color: Colors.transparent,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    GetInTouchDialog());
                          },
                          child: FormattedText("Get in touch", 15, Colors.white,
                              TextAlign.center),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white)),
                          color: Colors.transparent,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            Navigator.pushNamed(context, router.TECHBLOGSMAIN);
                          },
                          child: FormattedText(
                              "Tech Blogs", 15, Colors.white, TextAlign.center),
                        )),
                    if (showAdminOps)
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.white)),
                            color: Colors.transparent,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                router.WRITE,
                              );
                            },
                            child: FormattedText(
                                "Write", 15, Colors.white, TextAlign.center),
                          )),
                    if (showAdminOps)
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.white)),
                            color: Colors.transparent,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                router.ADMINOPS,
                              );
                            },
                            child: FormattedText(
                                "Edit", 15, Colors.white, TextAlign.center),
                          ))
                  ],
                ))
            ],
          )),
    );
  }
}
