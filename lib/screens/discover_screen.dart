import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:altruity/providers/nonprofits.dart';
import 'package:altruity/widgets/searchbar_header.dart';
import 'package:altruity/widgets/nonprofit_preview.dart';
import 'package:altruity/widgets/featured_carousel.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final nonprofitData = Provider.of<Nonprofits>(context);
    final nonprofits = nonprofitData.nonprofits;

    return SafeArea(
          child: Scaffold(
        body: CustomScrollView(
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
              delegate: SliverChildListDelegate([FeaturedCarousel()]),
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Business'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('School'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
