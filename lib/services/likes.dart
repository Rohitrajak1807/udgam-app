import 'package:flutter/material.dart';


class LikesPage extends StatefulWidget {
  @override
  createState() => new LikesPageState();
}

class LikesPageState extends State<LikesPage> {
  List<String> _likes = ['h', 'dd'];

  void _addLikes(String val) {
    setState(() {
      _likes.add(val);
    });
  }

  Widget _buildLikesList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index > _likes.length) {
        return _buildLikesItem(_likes[index]);
      }
    });
  }

  Widget _buildLikesItem(String comment) {
    return ListTile(title: Text(comment));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: Text('Likes')),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildLikesList())
            ],
        ));
  }
}



