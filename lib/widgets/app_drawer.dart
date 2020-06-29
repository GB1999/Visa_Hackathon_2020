import 'package:altruity/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:altruity/providers/user.dart';

import 'package:altruity/screens/authentication_screen.dart';
import 'package:altruity/screens/discover_screen.dart';
import 'package:altruity/screens/payment_methods_screen.dart';
import 'package:altruity/screens/user_profile_screen.dart';
import 'package:altruity/screens/nonprofit_detail_screen.dart';
import 'package:altruity/screens/donation_history_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<User>(context).fetchUserData();
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context, listen: true);
    //print(userData.profilePicture);
    //print(userData.name);
    //userData.fetchUserData();
    return ListView(
      //physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: InkWell(
            onTap: () { Navigator.pushNamed(context, UserProfileScreen.routeName);},
            child: drawerProfile(
              userData.name,
              userData.profilePicture,
            ),
          ),
          decoration: BoxDecoration(
              //color: Colors.blue,
              ),
        ),
        customListTile(
          context,
          40,
          'Donation History',
          Icons.description,
          -1.3,
          DonationHistoryScreen.routeName,
        ),
        customListTile(
          context,
          40,
          'Bookmarked',
          Icons.bookmark_border,
          -1.3,
          '/Bookmarked',
        ),
        customListTile(
          context,
          40,
          'Payment Methods',
          Icons.credit_card,
          -1.3,
          PaymentMethodsScreen.routeName,
        ),
        Divider(
          height: 20,
        ),
        customListTile(
          context,
          40,
          'Settings',
          Icons.settings,
          -1.3,
          '/Settings',
        ),
        customListTile(
          context,
          40,
          'Notifications',
          Icons.notifications,
          -1.3,
          '/Notifications',
        ),
        Divider(),
        customListTile(
          context,
          40,
          'Terms of Service',
          Icons.description,
          -1.3,
          '/Terms_of_Service',
        ),
        customListTile(
          context,
          40,
          'Privacy Policy',
          Icons.description,
          -1.3,
          '/Privacy_Policy',
        ),
        Divider(),
        customListTile(
          context,
          40,
          'Sign Out',
          Icons.exit_to_app,
          -1.3,
          AuthenticationScreen.routeName,
        ),
      ],
    );
  }

  Widget drawerProfile(String name, String profileUrl) {
    return name == null || profileUrl == null
        ? CircularProgressIndicator()
        : Column(
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

  Widget customListTile(BuildContext context, double height, String title,
      IconData iconData, double alignment, String routeName) {
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
