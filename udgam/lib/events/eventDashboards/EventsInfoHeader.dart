import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EventsInfoHeader implements SliverPersistentHeaderDelegate {
  // OverScrollHeaderStretchConfiguration();
  String title, imgheaderUrl;
  EventsInfoHeader(SliverOpacity sliverOpacity, {
    this.title,
    this.imgheaderUrl,
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imgheaderUrl,
            fit: BoxFit.cover,
          ),
          ],);
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  // @override
  // // 
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
