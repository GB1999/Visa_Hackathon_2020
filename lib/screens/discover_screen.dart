import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:altruity/providers/nonprofits.dart';
import 'package:altruity/providers/user.dart';
import 'package:altruity/widgets/app_drawer.dart';
import 'package:altruity/widgets/nonprofit_preview.dart';
import 'package:altruity/widgets/featured_carousel.dart';

class DiscoverScreen extends StatefulWidget {
  static const routeName = '/discover-screen';
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<User>(context).fetchUserData();
      Provider.of<Nonprofits>(context).fetchNonProfits();

      print('Provider data fetched');
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final nonprofitData = Provider.of<Nonprofits>(context);
    final nonprofits = nonprofitData.nonprofits;

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: AppDrawer()
        ),
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.black38),
          actions: <Widget>[
            Align(
              child: Text(
                'Search',
                style: TextStyle(color: Colors.black38),
              ),
              alignment: Alignment.center,
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black38,
              ),
              onPressed: () {},
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            
            setState(() {Provider.of<Nonprofits>(context).fetchNonProfits();});
          },
          child: CustomScrollView(
            slivers: <Widget>[
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
        ),
      ),
    );
  }

  

  Widget customListTile(double height, String title, IconData iconData,
      double alignment, String routeName) {
    return Container(
      height: height,
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(title),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Icon(
            iconData,
            size: 18,
            color: Colors.black,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
      ),
    );
  }
}
