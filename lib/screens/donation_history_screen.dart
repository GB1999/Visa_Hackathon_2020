import 'package:altruity/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class DonationHistoryScreen extends StatelessWidget {
  static const routeName = '/donation-history';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(iconTheme: new IconThemeData(color: Colors.black38),
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
          elevation: 1,),
          drawer: Drawer(child: AppDrawer()),
          body: Container(
      ),
    );
  }
}