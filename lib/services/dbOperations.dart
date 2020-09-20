import 'package:firebase/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:intl/intl.dart';

class DbOperations {
  final CollectionReference postCollectionReference;
  Map<String, dynamic> data;
  DbOperations() : postCollectionReference = fb.firestore().collection("Posts");
  void insertPost() {}

  Future<List<Posts>> getAllPosts(bool isFeatured, bool isTech) async {
    List<Posts> allPosts = new List<Posts>();
    Posts newPost;
    List commentsInDb;
    List<String> postComments;
    await postCollectionReference
        .where("isFeatured", '==', isFeatured)
        .where("isTech", '==', isTech)
        .get()
        .then((querySnapshot) => {
              querySnapshot.forEach((postinDb) => {
                    postComments = [],
                    commentsInDb = postinDb.data()["Comments"],
                    if (commentsInDb != null && commentsInDb.length != 0)
                      {
                        commentsInDb.forEach((comment) {
                          postComments.add(comment);
                        })
                      },
                    newPost = new Posts(
                        postinDb.id,
                        postinDb.data()["Title"],
                        postinDb.data()["Subtitle"],
                        postComments,
                        postinDb.data()["isFeatured"],
                        postinDb.data()["Likes"],
                        postinDb.data()["Body"],
                        postinDb.data()["Date"],
                        postinDb.data()["isTech"],
                        postinDb.data()["TechName"]),
                    allPosts.add(newPost),
                  })
            });
    allPosts.sort((a, b) {
      var aDate = DateTime.parse(a.publishedDate);
      var bDate = DateTime.parse(b.publishedDate);
      return bDate.compareTo(aDate);
    });
    return allPosts;
  }

  Future<List<Posts>> getAllPoststoEdit() async {
    List<Posts> allPosts = new List<Posts>();
    Posts newPost;
    List commentsInDb;
    List<String> postComments;
    await postCollectionReference.get().then((querySnapshot) => {
          querySnapshot.forEach((postinDb) => {
                postComments = [],
                commentsInDb = postinDb.data()["Comments"],
                if (commentsInDb != null && commentsInDb.length != 0)
                  {
                    commentsInDb.forEach((comment) {
                      postComments.add(comment);
                    })
                  },
                newPost = new Posts(
                    postinDb.id,
                    postinDb.data()["Title"],
                    postinDb.data()["Subtitle"],
                    postComments,
                    postinDb.data()["isFeatured"],
                    postinDb.data()["Likes"],
                    postinDb.data()["Body"],
                    postinDb.data()["Date"],
                    postinDb.data()["isTech"],
                    postinDb.data()["TechName"]),
                allPosts.add(newPost),
              })
        });
    allPosts.sort((a, b) {
      var aDate = DateTime.parse(a.publishedDate);
      var bDate = DateTime.parse(b.publishedDate);
      return bDate.compareTo(aDate);
    });
    return allPosts;
  }

  Future<List<Posts>> getAllTechPosts(String techName) async {
    List<Posts> allPosts = new List<Posts>();
    Posts newPost;
    List commentsInDb;
    List<String> postComments;
    await postCollectionReference
        .where("TechName", '==', techName)
        .get()
        .then((querySnapshot) => {
              querySnapshot.forEach((postinDb) => {
                    postComments = [],
                    commentsInDb = postinDb.data()["Comments"],
                    if (commentsInDb != null && commentsInDb.length != 0)
                      {
                        commentsInDb.forEach((comment) {
                          postComments.add(comment);
                        })
                      },
                    newPost = new Posts(
                        postinDb.id,
                        postinDb.data()["Title"],
                        postinDb.data()["Subtitle"],
                        postComments,
                        postinDb.data()["isFeatured"],
                        postinDb.data()["Likes"],
                        postinDb.data()["Body"],
                        postinDb.data()["Date"],
                        postinDb.data()["isTech"],
                        postinDb.data()["TechName"]),
                    allPosts.add(newPost),
                  })
            });
    allPosts.sort((a, b) {
      var aDate = DateTime.parse(a.publishedDate);
      var bDate = DateTime.parse(b.publishedDate);
      return bDate.compareTo(aDate);
    });
    return allPosts;
  }

  Future<Posts> getFeaturedPost() async {
    Posts featuredPost;
    List<String> commentsOnFeatured = [];
    List commentsInDb;
    await postCollectionReference
        .where("isFeatured", '==', true)
        .get()
        .then((querySnapshot) => {
              if (querySnapshot != null)
                {
                  commentsInDb = querySnapshot.docs[0].data()['Comments'],
                  if (commentsInDb != null)
                    {
                      commentsInDb.forEach((commentInDb) =>
                          {commentsOnFeatured.add(commentInDb)})
                    },
                  featuredPost = new Posts(
                      querySnapshot.docs[0].id,
                      querySnapshot.docs[0].data()['Title'],
                      querySnapshot.docs[0].data()['Subtitle'],
                      commentsOnFeatured,
                      true,
                      querySnapshot.docs[0].data()['Likes'],
                      querySnapshot.docs[0].data()['Body'],
                      querySnapshot.docs[0].data()['Date'],
                      querySnapshot.docs[0].data()['isTech'],
                      querySnapshot.docs[0].data()['TechName'])
                }
            });
    return featuredPost;
  }

  Future<Posts> getTechPosts() async {
    Posts techPost;
    List<String> commentsOnFeatured = [];
    List commentsInDb;
    await postCollectionReference
        .where("isTech", '==', true)
        .get()
        .then((querySnapshot) => {
              if (querySnapshot != null)
                {
                  commentsInDb = querySnapshot.docs[0].data()['Comments'],
                  if (commentsInDb != null)
                    {
                      commentsInDb.forEach((commentInDb) =>
                          {commentsOnFeatured.add(commentInDb)})
                    },
                  techPost = new Posts(
                      querySnapshot.docs[0].id,
                      querySnapshot.docs[0].data()['Title'],
                      querySnapshot.docs[0].data()['Subtitle'],
                      commentsOnFeatured,
                      true,
                      querySnapshot.docs[0].data()['Likes'],
                      querySnapshot.docs[0].data()['Body'],
                      querySnapshot.docs[0].data()['Date'],
                      querySnapshot.docs[0].data()['isTech'],
                      querySnapshot.docs[0].data()['Techname'])
                }
            });
    return techPost;
  }

  addComment(String commentToAdd, String id) async {
    List<String> commentsOnPost = [];
    await postCollectionReference.doc(id).get().then((postInDb) {
      data = postInDb.data();
      List<dynamic> allComments = data['Comments'];
      allComments.forEach((element) {
        commentsOnPost.add(element);
      });
      commentsOnPost.add(commentToAdd);
      var newData = {
        'id': data['id'],
        'Body': data['Body'],
        'Comments': commentsOnPost,
        'Likes': data['Likes'],
        'Subtitle': data['Subtitle'],
        'Title': data['Title'],
        'isFeatured': data['isFeatured'],
        'Date': data['Date'],
        'isTech': data['isTech'],
        'TechName': data['TechName']
      };
      postCollectionReference.doc(id).set(newData, SetOptions(merge: true));
    });
  }

  Future<bool> onLikeButtonTapped(bool isLiked, String id) async {
    List<String> commentsOnPost = [];
    await postCollectionReference.doc(id).get().then((postInDb) {
      data = postInDb.data();
      List<dynamic> allComments = data['Comments'];
      if (allComments != null) {
        allComments.forEach((element) {
          commentsOnPost.add(element);
        });
      }
      int likes = data["Likes"];
      if (isLiked) {
        likes = likes - 1;
      } else {
        likes = likes + 1;
      }
      //int newLikes = likes;
      print("no of likes on this post : $likes");
      var newData = {
        'id': data['id'],
        'Body': data['Body'],
        'Comments': commentsOnPost,
        'Likes': likes,
        'Subtitle': data['Subtitle'],
        'Title': data['Title'],
        'isFeatured': data['isFeatured'],
        'Date': data['Date'],
        'isTech': data['isTech'],
        'TechName': data['TechName']
      };
      postCollectionReference.doc(id).set(newData, SetOptions(merge: true));
    });

    return !isLiked;
  }

  // addLike(String id) async {
  //   List<String> commentsOnPost = [];
  //   await postCollectionReference.doc(id).get().then((postInDb) {
  //     data = postInDb.data();
  //     List<dynamic> allComments = data['Comments'];
  //     if (allComments != null) {
  //       allComments.forEach((element) {
  //         commentsOnPost.add(element);
  //       });
  //     }
  //     var likes = data["Likes"];
  //     int newLikes = likes + 1;
  //     print("no of likes on this post : $newLikes");
  //     var newData = {
  //       'id': data['id'],
  //       'Body': data['Body'],
  //       'Comments': commentsOnPost,
  //       'Likes': newLikes,
  //       'Subtitle': data['Subtitle'],
  //       'Title': data['Title'],
  //       'isFeatured': data['isFeatured'],
  //       'Date': data['Date'],
  //       'Tech': data['Tech']
  //     };
  //     postCollectionReference.doc(id).set(newData, SetOptions(merge: true));
  //   });
  // }

  addSubscriber(subscriberEmail) async {
    String formattedDate =
        DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now());
    var newSubscriber = {'Email': subscriberEmail, 'JoinedOn': formattedDate};
    fb
        .firestore()
        .collection("Subscribers")
        .doc()
        .set(newSubscriber, SetOptions(merge: true));
  }

  createNewPost(String body, String subtitle, String title, bool isTech,
      String techName) async {
    String formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());
    var newPost = {
      'Body': body,
      'Date': formattedDate,
      'Subtitle': subtitle,
      'Title': title,
      'isFeatured': false,
      'likes': 0,
      'id': UniqueKey().toString(),
      'isTech': isTech,
      'TechName': techName
    };
    postCollectionReference.doc().set(newPost, SetOptions(merge: true));
  }

  Future<void> editPost(
      String id, String postBody, String postSubtitle, String postTitle) async {
    List<String> commentsOnPost = [];
    print("post id : " + id);
    await postCollectionReference.doc(id).get().then((postInDb) {
      data = postInDb.data();
      List<dynamic> allComments = data['Comments'];
      if (allComments != null) {
        allComments.forEach((element) {
          commentsOnPost.add(element);
        });
      }
      var newData = {
        'id': data['id'],
        'Body': postBody,
        'Comments': commentsOnPost,
        'Likes': data['Likes'],
        'Subtitle': postSubtitle,
        'Title': postTitle,
        'isFeatured': data['isFeatured'],
        'Date': data['Date'],
        'Tech': data['Tech']
      };
      postCollectionReference.doc(id).set(newData, SetOptions(merge: true));
    });
  }
}
