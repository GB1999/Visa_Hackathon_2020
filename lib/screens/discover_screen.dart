import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:altruity/providers/nonprofits.dart';
import 'package:altruity/widgets/searchbar_header.dart';
import 'package:altruity/widgets/nonprofit_preview.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nonprofitData = Provider.of<Nonprofits>(context);
    final nonprofits = nonprofitData.nonprofits;

    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: SeachBarHeader(
            minExtent: 75,
            maxExtent: 125,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) => ChangeNotifierProvider.value(
              value: nonprofits[i],
              child: NonprofitPreview(),
            ),
            childCount: nonprofits.length,
          ),
        ),
      ],
    );
  }
}
