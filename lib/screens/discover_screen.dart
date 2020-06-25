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
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Nonprofits>(context).fetchNonProfits();
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
          child: ListView(
            //physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: drawerProfile(
                  'Gage Benham',
                  'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                ),
                decoration: BoxDecoration(
                    //color: Colors.blue,
                    ),
              ),
              customListTile(
                40,
                'Donation History',
                Icons.description,
                -1.3,
                '/Donation_History',
              ),
              customListTile(
                40,
                'Bookmarked',
                Icons.bookmark_border,
                -1.3,
                '/Bookmarked',
              ),
              customListTile(
                40,
                'Payment Options',
                Icons.credit_card,
                -1.3,
                '/Payment_Options',
              ),
              Divider(
                height: 20,
              ),
              customListTile(
                40,
                'Settings',
                Icons.settings,
                -1.3,
                '/Settings',
              ),
              customListTile(
                40,
                'Notifications',
                Icons.notifications,
                -1.3,
                '/Notifications',
              ),
              Divider(),
              customListTile(
                40,
                'Terms of Service',
                Icons.description,
                -1.3,
                '/Terms_of_Service',
              ),
              customListTile(
                40,
                'Privacy Policy',
                Icons.description,
                -1.3,
                '/Privacy_Policy',
              ),
              Divider(),
              customListTile(
                40,
                'Sign Out',
                Icons.exit_to_app,
                -1.3,
                '/Sign_Out',
              ),
            ],
          ),
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
          elevation: 1,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<Nonprofits>(context).fetchNonProfits();
            setState(() {
            });
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

  Widget drawerProfile(String name, String profileUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(profileUrl),
          backgroundColor: Colors.transparent,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name, style: TextStyle(fontSize: 20)),
        ),
      ],
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
