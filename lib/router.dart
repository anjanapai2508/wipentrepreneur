import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wipentrepreneur/views/admin/CreatePost.dart';
import 'package:wipentrepreneur/views/admin/EditPost.dart';
import 'package:wipentrepreneur/views/admin/adminOperations.dart';
import 'package:wipentrepreneur/views/home/homePage.dart';
import 'package:wipentrepreneur/views/posts/readPost.dart';
import 'package:wipentrepreneur/views/tech/showTechPostsMainPage.dart';
import 'package:wipentrepreneur/views/tech/showTechPostsSubPage.dart';

const String HOME = '/';
const String READ_POST = 'READ_POST';
const String PRODUCTS = 'PRODUCTS';
const String ADMINOPS = 'ADMINOPS';
const String WRITE = 'WRITE';
const String EDIT = 'EDIT';
const String TECHBLOGSMAIN = 'TECHBLOGSMAIN';
const String TECHBLOGSUB = 'TECHBLOGSUB';

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
    case WRITE:
      return MaterialPageRoute(builder: (context) => CreatePost());
      break;
    case EDIT:
      return MaterialPageRoute(
          builder: (context) => EditPost(postToEdit: routeSettings.arguments));
      break;
    case TECHBLOGSMAIN:
      return MaterialPageRoute(builder: (context) => ShowTechPostsMainPage());
      break;
    case TECHBLOGSUB:
      return MaterialPageRoute(
          builder: (context) =>
              ShowTechPostsSubPage(techName: routeSettings.arguments));
      break;
    default:
      return MaterialPageRoute(builder: (context) => HomePage());
  }
}
