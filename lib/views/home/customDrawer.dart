import 'package:flutter/material.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/views/userActions/getInTouch.dart';
import 'package:wipentrepreneur/views/userActions/subscribeDialog.dart';
import '../../router.dart' as router;

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/main_background.jpg"),
                        fit: BoxFit.cover)),
                child: FormattedText(
                    "The WIP Entrepreneur", 20, Colors.white, TextAlign.center),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(children: [
              ListTile(
                title: Text("Home"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(
                    context,
                    router.HOME,
                  );
                },
              ),
              ListTile(
                title: Text("Subscribe"),
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => SubscribeDialog());
                },
              ),
              ListTile(
                title: Text("Get in touch"),
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => GetInTouchDialog());
                },
              ),
              ListTile(
                title: Text("Tech Blogs"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, router.TECHBLOGSMAIN);
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
