import 'package:flutter/material.dart';

import '../../helpers/formatted-text.dart';

class HomePageHero extends StatelessWidget {
  const HomePageHero({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          height: 150,
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
              Container(
                height: 150,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          flex: 7,
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: FormattedText("The WIP Entrepreneur",
                                        50, Colors.white, TextAlign.center),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: FormattedText(
                                        "Trying to make something out of nothing!",
                                        20,
                                        Colors.white,
                                        TextAlign.center),
                                  )
                                ],
                              )

                              // child: FormattedText("The WIP Entrepreneur", 70,
                              //     Colors.white, TextAlign.center),
                              )),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
