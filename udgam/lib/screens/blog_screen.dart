import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udgam/models/blog_data.dart';
import 'package:udgam/widgets/add_post_dialog.dart';
import 'package:udgam/services/authentication_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:udgam/widgets/main_drawer.dart';

///Post Backend end
class Blog extends StatefulWidget {
  @override
  Blog({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  static const String screenTitle = "Feed";

  @override
  State<StatefulWidget> createState() => new _BlogState();
}

class _BlogState extends State<Blog> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String postsNode = "posts";


  String _name;
  //  bool _newpost = false;
//
//  bool _hideScrollTop = true;

  void getName() async {
    String result = (await FirebaseDatabase.instance
            .reference()
            .child("users/${widget.userId}/Name")
            .once())
        .value;
    _name = result;
  }

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
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

        textTheme: Theme.of(context).appBarTheme.textTheme,
        title: Text(Blog.screenTitle),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: FirebaseAnimatedList(
                controller: _scrollController,
                sort: (a, b) => b.key.compareTo(a.key),
                defaultChild: Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(),
                  ),
                ),

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
                      return AddPostDial(
                        name: _name,
                        uid: widget.userId,
                      );
                    },
                  );
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
        ),
      ),
    );
  }
}
