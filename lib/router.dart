import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wipentrepreneur/views/admin/adminOperations.dart';
import 'package:wipentrepreneur/views/home/homePage.dart';
import 'package:wipentrepreneur/views/posts/readPost.dart';

const String HOME = '/';
const String READ_POST = 'READ_POST';
const String PRODUCTS = 'PRODUCTS';
const String ADMINOPS = 'ADMINOPS';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HOME:
      return MaterialPageRoute(builder: (context) => HomePage());
      break;
    case READ_POST:
      return MaterialPageRoute(
          builder: (context) => ReadPost(
                showPost: routeSettings.arguments,
              ));
      break;
    case ADMINOPS:
      return MaterialPageRoute(builder: (context) => AdminOperations());
      break;
    default:
      return MaterialPageRoute(builder: (context) => HomePage());
  }
}
