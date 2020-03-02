import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';





class Comments {
  static const KEY = "key";
  static const DATE = "date";
  static const MESSAGE = "message";
  static const AUTHOR = "author";

  int date;
  String key;
  String message;
  String author;

  Comments(this.date, this.message, this.author);

  Comments.fromSnapshot(DataSnapshot snap)
      : this.key = snap.key,
        this.author = snap.value[AUTHOR],
        this.date = snap.value[DATE],
        this.message = snap.value[MESSAGE];

  Map toMap() {
    return {AUTHOR: author, MESSAGE: message, DATE: date};
  }
}







class CommentsPage extends StatefulWidget {
  final String pid;
  
  const CommentsPage({Key key, this.pid}): super(key: key);

  @override
  createState() => new CommentsPageState();
}

class CommentsPageState extends State<CommentsPage> {
  

  void insertComment() {
    final FormState form = commkey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      comments.date = DateTime.now().millisecondsSinceEpoch;
      CommentsService CommService = CommentsService(comments.toMap());
      String imgkey;
      CommService.addComment(widget.pid);
    }
  }



  final GlobalKey<FormState> commkey = new GlobalKey();
  Comments comments = Comments(0, "", "");

  List<Comments> commentsData = <Comments>[];
  
  @override
   
  void initState() {
    FirebaseDatabase.instance.reference().child('comments').onChildAdded.listen(_childAdded);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('Comments')),
      body: Column(children: <Widget>[
        Form(
          key: commkey,
         child: Column(
           children: <Widget>[
             Padding(
            padding: const EdgeInsets.all(9.0),
            child: TextFormField(
              minLines: 2,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Leave a Comment',
                hintText: 'Be nice',
                border: OutlineInputBorder(),
                //contentPadding: new EdgeInsets.symmetric(),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return 'Give a Comment';
                }
                
              },
              onSaved: (val) => comments.message = val,
            ),
          ),
          RaisedButton(
            child: Text(widget.pid),
            onPressed: (){
              insertComment();
            },
          )
          ]
        )
        ),
        Flexible(
          child: FirebaseAnimatedList(
              reverse: true,
              query:
                  FirebaseDatabase.instance.reference().child('comments/${widget.pid}').orderByChild('date'),
                  itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index) {
                    return Column(children: <Widget>[
                      ListTile(title: Text(commentsData[index].message))
                    ],);
                  }),
        )
      ]),
    );
  }

    _childAdded(Event event) {
    setState(() {
      commentsData.add(Comments.fromSnapshot(event.snapshot));
    });
  }
}



class CommentsService {
  String commNode = "comments";
  
  DatabaseReference _commdatabaseReference;
  Map comments;
  
  CommentsService(this.comments);

  
  addComment(pid) {
    //reference to nodes
    
    _commdatabaseReference = FirebaseDatabase.instance.reference().child('comments/${pid}'); 
    _commdatabaseReference.set(comments);
    }



}
