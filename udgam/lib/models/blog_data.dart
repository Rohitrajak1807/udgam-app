import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:udgam/widgets/show_image.dart';
import '../widgets/likes.dart';
import 'package:cache_image/cache_image.dart';

@override
class BlogData extends StatefulWidget {
  final DataSnapshot snapshot;

  BlogData(this.snapshot);

  @override
  _BlogDataState createState() => _BlogDataState();
}

class _BlogDataState extends State<BlogData> {
  bool _liked = true;

  @override
  void initState() {
    super.initState();
    // _database.reference().child(postsNode).onChildAdded.listen(_childAdded);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.white),
              color: Colors.white),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
          child: Column(
            children: <Widget>[
              ListTile(
                subtitle: Text('College Name'),
                leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.account_circle)),
                title: Text(
                  '${widget.snapshot.value['by']}',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: Icon(Icons.more_vert),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: GestureDetector(
                  child: FadeInImage(
                    fadeOutDuration: new Duration(milliseconds: 20),
                    fadeInDuration: new Duration(milliseconds: 60),
                    fit: BoxFit.cover,
                    image: CacheImage(
                      'gs://udgamblog.appspot.com/blogimg/${widget.snapshot.key}.${widget.snapshot.value['ext']}',
                    ),
                    placeholder: AssetImage('assets/images/loader.gif'),
                  ),
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return ShowImage(
                              imageLink:
                                  'gs://udgamblog.appspot.com/blogimg/${widget.snapshot.key}.${widget.snapshot.value['ext']}');
                        },
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                  child: Text(
                    widget.snapshot.value['body'],
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                              _liked == false
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red),
                          onPressed: () {
                            print(_liked);
                            setState(() {
                              _liked = !_liked;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Text('5k'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LikesPage()),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Text(
                        DateFormat('dd MMM yyyy - KK:mm a')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                widget.snapshot.value['date']))
                            .toString(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
