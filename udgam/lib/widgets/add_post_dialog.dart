import 'dart:io';
import 'package:flutter/material.dart';
import 'package:udgam/services/post_service.dart';
import 'package:udgam/models/post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ntp/ntp.dart';


class AddPostDial extends StatefulWidget {
  @override
  AddPostDial({Key key, this.uid, this.name}) : super(key: key);

  final String uid;
  final String name;
  _AddPostDialState createState() => new _AddPostDialState();

}

class _AddPostDialState extends State<AddPostDial> {
  @override
  final GlobalKey<FormState> formkey = new GlobalKey();

  final noImage = SnackBar(content: Text("NO IMAGE"));


  Post post = Post(0, "", "", "", "");
  File _image;
  bool _cnf;

  @override
  void initState() {
    _cnf = true;
  }

  void insertPost() async {
    final FormState form = formkey.currentState;
    if (form.validate() && _image !=null) {


        form.save();
        form.reset();

        setState(() {
          _cnf = false;
        });


        post.date = (await NTP.now()).millisecondsSinceEpoch;

        post.by = widget.name;
        post.uid = widget.uid;
        String imgkey;
        String k = _image.path.split('.').last;
        post.ext = k;
        PostService postService = PostService(post.toMap());
        imgkey = postService.addPost();

        await postService.uploadPic(_image, imgkey, k);
        Navigator.pop(context);
        _image = null;



    }

  }

  //Picking Image and upload

  Future _pickImageCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
//      await CompressImage.compress(imageSrc: image.path, desiredQuality: 80);
    setState(
          () {
        _image = image;
      },
    );
  }

  Future _pickImageGall() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//      await CompressImage.compress(imageSrc: image.path, desiredQuality: 80);
    setState(
          () {
        _image = image;
      },
    );
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: _cnf?Center(child: Text("Add Your Post")): Row(children: <Widget>[CircularProgressIndicator(),Text("    Uploading..."),
        ]),
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
                          onPressed: _cnf != true
                              ? null
                              : () {
                            _pickImageCam();
                          },
                        ),
                      ),
                      ClipOval(
                        child: RaisedButton(
                          child: Icon(Icons.file_upload),
                          onPressed: _cnf != true
                              ? null
                              : () {
                            _pickImageGall();
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: _image == null
                        ? Text('Upload an Image')
                        : Image.file(_image),
                  ),
                  //Title

                  //Caption
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: TextFormField(
                      enabled: _cnf?true : false,
                      maxLength: 200,
                      minLines: 2,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Write a Caption',
                        hintText: 'Better be good',
                        border: OutlineInputBorder(),
                        //contentPadding: new EdgeInsets.symmetric(),
                      ),

                      validator: (value){
                        if(value.isEmpty)
                          return 'This is required';
                        else if(_image == null)
                          return 'No image uploaded';


                        },

                      onSaved: (val) => post.body = val.trim(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Confirm'),
            onPressed: _cnf != true
                ? null
                : () {

                insertPost();

              },
          ),
          MaterialButton(
            elevation: 5.0,
            child: Text('Cancel'),
            onPressed: _cnf != true
                ? null
                : () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
