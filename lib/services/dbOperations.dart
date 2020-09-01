import 'package:firebase/firestore.dart';
import 'package:wipentrepreneur/models/posts.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:intl/intl.dart';

class DbOperations {
  final CollectionReference postCollectionReference;
  Map<String, dynamic> data;
  DbOperations() : postCollectionReference = fb.firestore().collection("Posts");
  void insertPost() {}

  Future<List<Posts>> getAllPosts() async {
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
                    postinDb.data()["Date"]),
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
                      querySnapshot.docs[0].data()['Date'])
                }
            });
    return featuredPost;
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
        'isFeatured': data['isFeatured']
      };
      postCollectionReference.doc(id).set(newData, SetOptions(merge: true));
    });
  }

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
}
