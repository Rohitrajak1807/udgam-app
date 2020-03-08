import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udgam/models//post.dart';
import 'package:udgam/models/blog_data.dart';
import 'package:udgam/models/add_post_dialog.dart';
import 'package:udgam/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:udgam/widgets/main_drawer.dart';


//Blog Backend System
////Post Backend



///Post Backend end
class Blog extends StatefulWidget {
  @override
  Blog({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _BlogState();
}

class _BlogState extends State<Blog> {
  


   FirebaseDatabase _database = FirebaseDatabase.instance;
  //List<Post> postsData = <Post>[];
  String postsNode = "posts";
  // String uploadedFileURL;
  final newPostbar = SnackBar(content: Text('New Post Added, Swipe Down'));
  String _name;
  bool _newpost = false;

  void getName() async {
    String result = (await FirebaseDatabase.instance
            .reference()
            .child("users/${widget.userId}/Name")
            .once())
        .value;
    //print(_name);
    _name = result;
  }



//  void getEmail(String uid) async{
//    String mail =  (await FirebaseDatabase.instance
//        .reference()
//        .child("users/${widget.userId}/Email")
//        .once())
//        .value;
//    uid = mail;
//  }


  ScrollController _scrollController;
  @override
  void initState() {
   // _database.reference().child(postsNode).onChildAdded.listen(_childAdded);

    _scrollController = new ScrollController();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: new Duration(seconds: 2), curve: Curves.ease);
  }

  Widget build(BuildContext context) {
    getName();

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
        "Udgam'20",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        decoration: TextDecoration.none,
        fontFamily: 'IndieFlower',
        fontSize: 23.5,

    ),
        ),
        backgroundColor: Colors.black38,
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          children: <Widget>[

            Expanded(
              child: FirebaseAnimatedList(
                controller: _scrollController,
                defaultChild: Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                        // value: event == null
                        // ? 0
                        // : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                        ),
                  ),
                ),
                reverse: true,
                query:
                    _database.reference().child(postsNode).orderByChild('date'),
                itemBuilder: (_, DataSnapshot snap, Animation<double> animation,
                    int index) {
                  return BlogData(snap);
                  //End of returning all the posts
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return AddPostDial(name: _name, uid: widget.userId,);
                      });

                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey,
                tooltip: 'Add a Post',
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(2.0),
              child: FloatingActionButton(
                onPressed: () {

                  _scrollToTop();
                },
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey,
                tooltip: 'Scroll to Top',
              ),
            ),

          ],
        )
      ),
    );
  }

//  _childAdded(Event event) {
//    setState(
//      () {
//        _newpost = true;
//
//        postsData.insert(
//          0,
//          Post.fromSnapshot(event.snapshot),
//        );
//      },
//    );
//  }
}
