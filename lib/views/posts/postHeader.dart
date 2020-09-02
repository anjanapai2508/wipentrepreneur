import 'package:flutter/material.dart';
import 'package:wipentrepreneur/views/userActions/getInTouch.dart';
import 'package:wipentrepreneur/views/userActions/subscribeDialog.dart';
import '../../router.dart' as router;
import '../../helpers/formatted-text.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        child: FormattedText(
                            "Get in touch", 15, Colors.white, TextAlign.center),
                      )),
                ],
              ))
            ],
          )),
    );
  }
}
