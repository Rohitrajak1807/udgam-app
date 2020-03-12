import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class PosterScrollWidget extends StatefulWidget {
  final double currentPage;
  final List data;

  PosterScrollWidget(this.data, this.currentPage);

  @override
  _PosterScrollWidgetState createState() => _PosterScrollWidgetState();
}

var mov = 27.0 / 41.0;
var aspectratio = mov * 1.2;

class _PosterScrollWidgetState extends State<PosterScrollWidget> {
  final padding = 50.0;

  final hiddenPosterVerticalInset = 100.0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: aspectratio,
        child: LayoutBuilder(builder: (context, constraints) {
          var width = constraints
              .maxWidth; //above aspect ratio ensures fixed width and height
          var height = constraints.maxHeight;

          var safeWidth = width -
              2 * padding; //in a "real" implementation, this would be passed in via the constructor
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryPoster = safeHeight;
          var widthOfPrimaryPoster = heightOfPrimaryPoster * mov;

          var primaryPosterLeft = safeWidth -
              widthOfPrimaryPoster; //this value is the empty space to the left of the "primary" poster
          var hiddenPosterHorizontalInset = primaryPosterLeft /
              2; //two posters in the stack should be visible to the left of the "primary", divide that space evenly
          //note that this implementation is arbitrary. I divided it into two because I thought it looked good
          //but you could give it a fixed offset in pixels, and just have the "stack" fill in that space

          var posters = <Widget>[];
          for (var i = 0; i < widget.data.length; i++) {
            // double opacity = 0.0;///////////////////////////
//
            var url = widget.data[i]['imagePath']; ///////////////////
            // var tagg=widget.data[i]["tagg"];
            var deltaFromCurrentPage = i -
                widget
                    .currentPage; //should be positive if page is to the right, negative if to the left
            var isOnRight = deltaFromCurrentPage > 0;
            if (deltaFromCurrentPage > 1 || deltaFromCurrentPage < -4) {
              continue; //this early return prevents us from adding invisible posters to the hierarchy
            }

            // if (deltaFromCurrentPage < 0) {
            //   //page is off the left
            //   opacity = clamp(1 + 0.33 * deltaFromCurrentPage, 0, 1);
            // } else if (deltaFromCurrentPage < 1) {
            //   //page is the current page, possibly moving to the right
            //   opacity = clamp(
            //       1 - 2 * (deltaFromCurrentPage - deltaFromCurrentPage.floor()),
            //       0,
            //       1);
            // } else {
            //   //page is way off the right side, so should be invisible.
            //   //note: the "continue" above should mean we never get here anyway
            //   opacity = 0;
            // }

            var start = padding +
                max(
                    primaryPosterLeft //default left position for main poster
                        -
                        hiddenPosterHorizontalInset //pages should shift to the left or right as they go "out of focus"
                            *
                            -deltaFromCurrentPage //this value defines how "out of focus" the poster is
                            *
                            (isOnRight ? 40 : 1)
                    /////////////////////pages should shift much more quickly when going to the right (off the top of the stack) than when going to the left
                    ,
                    0); //ensure the poster is always at least at padding+0

            posters.add(
              Positioned.directional(
                // key: Key(url),
                top: padding +
                    hiddenPosterVerticalInset * max(-deltaFromCurrentPage, 0.0),
                //posters to the left should become smaller,
                //but posters to the right (ones being swiped off the top of the stack) shouldn't become bigger
                bottom: padding +
                    hiddenPosterVerticalInset * max(-deltaFromCurrentPage, 0.0),
                start: start,
                //note that I have not specified an "end" value. The above start, top, and bottom insets, along with the AspectRatio
                //widget below, are enough to define the bounds of the poster properly. the mess of math above ensures that
                //the "end" value calculated by the framework will end up where I want it
                textDirection: TextDirection.ltr,
                // end: start,////////////////////////////////////////////////////////////////////this was a test case ........only for th edashboardpage and can be deleted for event
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    //Items in the stack behind the primary poster should fade into the background
                    //a naive solution would just use opacity, however, that would result in each poster
                    //fading through to the poster behind them. We don't want that, so we give
                    //each poster a white background, which matches the widget background. If this were overtop of black,
                    //or some other color, we'd probably want to use that color instead.
                    //However, we *do* want the top-most poster to fade through to the posters behind it as its being
                    //swiped off the top of the stack, so if it's to the "right", we give it no such white background
                    decoration: deltaFromCurrentPage < 0
                        ? BoxDecoration(color: Colors.white)
                        : BoxDecoration(),
                    child: Opacity(
                      opacity: 1,
                      child: AspectRatio(
                        aspectRatio: mov,
                        //This demo doesn't do the hero animation, but flutter makes that super easy.
                        //just wrap this in a Hero widget, give it the movie id as your key, then in the detail
                        //wrap an image in that same key, and it'll just work. Check out my trip demo for an example

                        // child: Hero(
                        //   tag: tagg,
                        child: Image(
                          image: AssetImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return Stack(
            children: posters,
          );
        }));
  }
}
