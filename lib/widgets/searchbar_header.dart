import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SeachBarHeader extends SliverPersistentHeaderDelegate {
  SeachBarHeader({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(128, 175, 220, 100),
                  Color.fromRGBO(128, 175, 220, titleOpacity(shrinkOffset))
                ],
                stops: [0.5, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 10,
              width: 300,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Positioned(
            left: 200.0,
            right: 16.0,
            bottom: 5.0,
            child: Row(
              children: <Widget>[
                Text(
                  'Sort',
                  style: TextStyle(
                    color: Colors.black.withOpacity(titleOpacity(shrinkOffset)),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.swap_vert),
                  color: Colors.black.withOpacity(titleOpacity(shrinkOffset)),
                ),
                Text(
                  'Filters',
                  style: TextStyle(
                    color: Colors.black.withOpacity(titleOpacity(shrinkOffset)),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.list),
                  color: Colors.black.withOpacity(titleOpacity(shrinkOffset)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
}
