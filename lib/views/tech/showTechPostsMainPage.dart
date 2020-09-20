import 'package:flutter/material.dart';
import 'package:wipentrepreneur/helpers/formatted-text.dart';
import 'package:wipentrepreneur/views/posts/postHeader.dart';
import '../../router.dart' as router;

class ShowTechPostsMainPage extends StatefulWidget {
  static const String route = '/tech';
  ShowTechPostsMainPage({Key key}) : super(key: key);

  @override
  _ShowTechPostsMainPageState createState() => _ShowTechPostsMainPageState();
}

class Technology {
  const Technology({this.title, this.image});

  final String title;

  final AssetImage image;
}

const List<Technology> techFolders = const [
  const Technology(title: "Google Flutter", image: AssetImage('flutter.png')),
  const Technology(title: "Heroku", image: AssetImage('heroku.png'))
];

class _ShowTechPostsMainPageState extends State<ShowTechPostsMainPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      PostHeader(
        showAdminOps: false,
      ),
      SizedBox(
        height: 30,
      ),
      FormattedText("All things Tech!", 50, Colors.grey, TextAlign.center),
      SizedBox(
        height: 30,
      ),
      GridView.builder(
          itemCount: techFolders.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 20.0 / 12.0,
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Material(
                child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          this.context, router.TECHBLOGSUB,
                          arguments: techFolders[index].title);
                    },
                    child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Card(
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: techFolders[index].image,
                                          fit: BoxFit.fill),
                                    ),
                                  )),
                                  Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                        child: FormattedText(
                                            techFolders[index].title,
                                            15,
                                            Colors.black,
                                            TextAlign.center),
                                      ))
                                ])))));
          })
    ]));
  }
}
