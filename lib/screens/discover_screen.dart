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
    var nonprofits = nonprofitData.nonprofits;

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(child: AppDrawer()),
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
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              Provider.of<Nonprofits>(context).fetchNonProfits();
              nonprofits = nonprofitData.nonprofits;
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

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    //Add the search term to the searchBloc.
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using

    return FutureBuilder(
      future: Provider.of<Nonprofits>(context, listen: false).findByTag(query),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (dataSnapshot.error != null) {
            return Center(child: Text('An error occured'));
          } else {
            return Consumer<Nonprofits>(
              builder: (ctx, nonprofs, child) => nonprofs.searchResults.isEmpty
                  ? Center(child: Text('No results found'))
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            ChangeNotifierProvider.value(
                          value: nonprofs.searchResults[index],
                          child: NonprofitPreview(),
                        ),
                        itemCount: nonprofs.searchResults.length,
                      ),
                    ),
              //FloatingActionButton(child: Text('Add a Card'),onPressed: (){},)
            );
          }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
