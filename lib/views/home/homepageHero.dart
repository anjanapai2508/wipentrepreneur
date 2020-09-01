import 'package:flutter/material.dart';
import 'package:wipentrepreneur/views/userActions/getInTouch.dart';
import 'package:wipentrepreneur/views/userActions/subscribeDialog.dart';
import '../../router.dart' as router;
import '../../helpers/formatted-text.dart';

class HomePageHero extends StatelessWidget {
  const HomePageHero({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          height: 300,
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
              Positioned.fill(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.fill,
                    child: FormattedText("The WIP Entrepreneur", 70,
                        Colors.white, TextAlign.center),
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: FormattedText(
                        "Trying to make something out of nothing!",
                        25,
                        Colors.white,
                        TextAlign.center),
                  ),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 280,
                  ),
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
                      ))
                ],
              )
            ],
          )),
    );
  }
}
