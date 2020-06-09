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
  TextEditingController _searchQueryController = TextEditingController();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchQueryController,
              autofocus: true,
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Search Data...",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                hintStyle: TextStyle(color: Colors.white30),
              ),
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Sort',
                  style: TextStyle(
                    color: Colors.black.withOpacity(titleOpacity(shrinkOffset)),
                  ),
                ),
                Icon(Icons.swap_vert, color: Colors.black.withOpacity(titleOpacity(shrinkOffset)),),
                 // color: Colors.black.withOpacity(titleOpacity(shrinkOffset)),
                
                Text(
                  'Filters',
                  style: TextStyle(
                    color: Colors.black.withOpacity(titleOpacity(shrinkOffset)),
                  ),
                ),
                Icon(Icons.list),
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
