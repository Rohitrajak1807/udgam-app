import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cache_image/cache_image.dart';

class ShowImage extends StatefulWidget {
  ShowImage({Key key, this.imageLink}) : super(key: key);

  final String imageLink;

  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
      ),
      body: Container(
        child: PhotoView(
          maxScale: PhotoViewComputedScale.contained * 4,
          minScale: PhotoViewComputedScale.contained,
          imageProvider: CacheImage(widget.imageLink),
          loadingBuilder: (context, event) => Container(
            color: Colors.black,
            child: Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
