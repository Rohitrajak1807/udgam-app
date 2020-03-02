import 'dart:io';
import 'package:flutter/material.dart';

import 'package:udgam/services/comments.dart';
import 'package:udgam/services/likes.dart';
import 'package:udgam/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cache_image/cache_image.dart';
import 'package:shared_preferences/shared_preferences.dart';


//Blog Backend System
////Post Backend
class Post {
  static const KEY = "key";
  static const DATE = "date";
  static const TITLE = "title";
  static const BODY = "body";

  int date;
  String key;
  String title;
  String body;

  Post(this.date, this.title, this.body);

  Post.fromSnapshot(DataSnapshot snap)
      : this.key = snap.key,
        this.body = snap.value[BODY],
        this.date = snap.value[DATE],
        this.title = snap.value[TITLE];

  Map toMap() {
    return {BODY: body, TITLE: title, DATE: date};
  }
}

class PostService {
  String postsNode = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;

  StorageReference _firebaseStorageRef;
  Map post;
  PostService(this.post);

  uploadPic(_image, imgkey) async {
    _firebaseStorageRef =
        FirebaseStorage.instance.ref().child('blogimg/${imgkey}.jpg');
    StorageUploadTask uploadTask = _firebaseStorageRef.putFile(_image);
    await uploadTask.onComplete;

    _image = null;
  }

  String addPost() {
    //reference to nodes
    String unqkey;
    _databaseReference = database.reference().child(postsNode);
    unqkey = _databaseReference.push().key;
    _databaseReference.child(unqkey).set(post);
    return unqkey;
  }
}

//Blog Backend End

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  void insertPost() {
    final FormState form = formkey.currentState;
    if (form.validate() && _image!=null) {
      form.save();
      form.reset();
      post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService = PostService(post.toMap());
      String imgkey;
      imgkey = postService.addPost();
      postService.uploadPic(_image, imgkey);
      _image = null;
    }
  }

  final GlobalKey<FormState> formkey = new GlobalKey();
  Post post = Post(0, "", "");
  File _image;
  //Picking Image and upload
  
Future _pickImageCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    
  }

  Future _pickImageGall() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
   setState(() {
      _image = image;
    });
    
  }
  addPostDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text("Add Your Post")),
            content: Container(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ClipOval(
                              child: RaisedButton(
                                child: Icon(Icons.camera),
                                onPressed: () {
                                  _pickImageCam();
                                },
                              ),
                            ),
                            ClipOval(
                              child: RaisedButton(
                                child: Icon(Icons.file_upload),
                                onPressed: () {
                                  _pickImageGall();
                                },
                              ),
                            ),
                          ]),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: _image == null
                            ? Text('Upload an image')
                            : Image.file(_image),
                      ),

                      //Title
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Give a Title",
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (val) => post.title = val,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'be creative, give a title';
                            }
                            
                          },
                        ),
                      ),

                      //Caption
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: TextFormField(
                          minLines: 2,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Give a caption',
                            hintText: 'Give a good one',
                            border: OutlineInputBorder(),
                            //contentPadding: new EdgeInsets.symmetric(),
                          ),
                          onSaved: (val) => post.body = val,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MaterialButton(
                      elevation: 5.0,
                      child: Text('Confirm'),
                      onPressed: () {
                        if (_image != null) {
                          insertPost();
                        } else {
                          SnackBar(
                              content: Text('Please upload a beautiful Image')
                            );
                        }
                      },
                    ),
                    MaterialButton(
                      elevation: 5.0,
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ]),
            ],
          );
        });
  }


  FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Post> postsData = <Post>[];
  String postsNode = "posts";
  String uploadedFileURL;

  @override
  void initState() {
    _database.reference().child(postsNode).onChildAdded.listen(_childAdded);
  }

  Widget build(BuildContext context) {
    // TODO: implement build

    

    return Scaffold(
        appBar: AppBar(
          title: Text('Blog'),
          backgroundColor: Colors.black38,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Flexible(
                  child: FirebaseAnimatedList(
                      
                      query: _database
                          .reference()
                          .child(postsNode)
                          .orderByChild('date'),
                      itemBuilder: (_, DataSnapshot snap,
                          Animation<double> animation, int index) {
                        //Returning All the Posts

                        return Column(children: <Widget>[
                          Container(
                              decoration: BoxDecoration(border: Border.all()),
                              margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Column(children: <Widget>[
                                ListTile(title: Text('Posted')),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 8.0, 0),
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    image: CacheImage(
                                      'gs://udgamblog.appspot.com/blogimg/${postsData[index].key}.jpg',
                                    ),
                                    placeholder: AssetImage(''),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(postsData[index].title),
                                    subtitle: Text(postsData[index].body),
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.all(12.0),
                                //   child: Row(
                                //     children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(0),
                                          child: FlatButton.icon(
                                              icon: Icon(Icons.thumb_up),
                                              label: Text('10k'),
                                              onPressed: null
                                              )
                                                ),
                                //       Padding(
                                //           padding: EdgeInsets.all(0),
                                //           child: FlatButton.icon(
                                //               icon: Icon(Icons.comment),
                                //               label: Text('900'),
                                //               onPressed: () {
                                //                   Navigator.push(
                                //                     context,
                                //                     MaterialPageRoute(builder: (context) => CommentsPage(pid: postsData[index].key)),
                                //                   );
                                //                 },
                                //               )),
                                //     ],
                                //   ),
                                // )
                              ]))
                        ]);

                        //End of returning all the posts
                      })),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.blue,
          onPressed: () {
            addPostDialog(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.grey,
          tooltip: 'Add a Post',
        ));
  }

  _childAdded(Event event) {
    setState(() {
      postsData.add(Post.fromSnapshot(event.snapshot));
    });
  }
}



















