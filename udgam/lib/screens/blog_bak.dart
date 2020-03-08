import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udgam/models//post.dart';
import 'package:udgam/models/likes.dart';
import 'package:udgam/models/add_post_dialog.dart';
import 'package:udgam/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:cache_image/cache_image.dart';
import 'package:udgam/models/show_image.dart';
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
  List<Post> postsData = <Post>[];
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
    _database.reference().child(postsNode).onChildAdded.listen(_childAdded);

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
                query:
                    _database.reference().child(postsNode).orderByChild('date'),
                itemBuilder: (_, DataSnapshot snap, Animation<double> animation,
                    int index) {
                  return Column(

                    children: <Widget>[
                      Container(

                        decoration: BoxDecoration(border: Border.all(width: 0, color: Colors.white), color: Colors.white),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
                        child: Column(
                          children: <Widget>[
                            ListTile(

                              subtitle: Text('College Name'),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.account_circle)
                              ),
                              title: Text('${postsData[index].by}', style: TextStyle(fontWeight: FontWeight.w600)),
                              trailing: Icon(Icons.more_vert),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(0,0,0,0),
                              child: GestureDetector(
                                child: FadeInImage(
                                  fadeOutDuration:
                                      new Duration(milliseconds: 20),
                                  fadeInDuration:
                                      new Duration(milliseconds: 60),
                                  fit: BoxFit.cover,
                                  image: CacheImage(
                                    'gs://udgamblog.appspot.com/blogimg/${postsData[index].key}.${postsData[index].ext}',
                                  ),
                                  placeholder:
                                      AssetImage('assets/images/loader.gif'),
                                ),
                                onDoubleTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return ShowImage(
                                            imglnk:
                                                'gs://udgamblog.appspot.com/blogimg/${postsData[index].key}.${postsData[index].ext}');
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            Align(

                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8,10,8,0),
                                child: Text(postsData[index].body, textAlign: TextAlign.justify,),
                              ),

                            ),
                            Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[



                                Row(
                                  children: <Widget>[
                                    IconButton(icon: Icon(Icons.favorite, color: Colors.red), onPressed: (){},),


                                    GestureDetector(child: Text('5k'), onTap: (){
                                      Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LikesPage()),
                                  );
                                    },),
                                  ],
                                ),


                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0, 15,0),
                                      child: Text(DateFormat('dd MMM yyyy - KK:mm a').format(DateTime.fromMillisecondsSinceEpoch(postsData[index].date)).toString(), textAlign: TextAlign.right,),
                                    ),

                                  ],
                                ),



//                                child: ListTile(
//                                leading: FlatButton.icon(
//                                icon: true ? Icon(Icons.favorite_border):Icon(Icons.favorite),
//                                label: Text("postsData[index].likes"),
//                                onPressed: () {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => LikesPage()),
//                                  );
//                                },
//                              ),
//
//                              trailing: Text(DateFormat('dd MMM yyyy - KK:mm a').format(DateTime.fromMillisecondsSinceEpoch(postsData[index].date)).toString()),
//                            )
                            )
                          ],
                        ),
                      ),
                    ],
                  );

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

  _childAdded(Event event) {
    setState(
      () {
        _newpost = true;

        postsData.insert(
          0,
          Post.fromSnapshot(event.snapshot),
        );
      },
    );
  }
}
