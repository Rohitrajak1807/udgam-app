import 'dart:io';
import 'package:flutter/material.dart';

// import 'package:udgam/services/comments.dart';
// import 'package:udgam/services/likes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cache_image/cache_image.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;


  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("StackoverFlow"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _dialogCall(context);
        },
      ),
    );
  }

  Future<void> _dialogCall(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog();
        });
  }
}


class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  String imagePath;
  Image image;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Container(child: image!= null? image:null),
            GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.camera),
                    SizedBox(width: 5),
                    Text('Take a picture                       '),
                  ],
                ),
                onTap: () async {
                  await getImageFromCamera();
                  setState(() {

                  });
                }),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
    );
  }


  Future getImageFromCamera() async {
    var x = await ImagePicker.pickImage(source: ImageSource.camera);
    imagePath = x.path;
    image = Image(image: FileImage(x));
  }

}