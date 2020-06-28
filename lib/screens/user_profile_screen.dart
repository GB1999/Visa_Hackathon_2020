import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:altruity/providers/user.dart';

enum viewMode { View, Edit }

class UserProfileScreen extends StatelessWidget {
  static const routeName = '/user-profile';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: FutureBuilder(
                          future: Provider.of<User>(context, listen: false)
                              .fetchUserData(),
                          builder: (ctx, dataSnapshot) {
                            if (dataSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              if (dataSnapshot.error != null) {
                                return Center(child: Text('An error occured'));
                              } else {
                                return Consumer<User>(
                                  builder: (ctx, userData, child) =>
                                      UserProfileCard(userData),
                                );
                              }
                            }
                          })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileCard extends StatefulWidget {
  User userData;
  UserProfileCard(this.userData);

  @override
  _UserProfileCardState createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 160,
        height: 160,
        color: Colors.black38,
        child: (widget.userData.profilePicture == null)
            ? Icon(Icons.account_circle)
            : Image.network(
                widget.userData.profilePicture,
                fit: BoxFit.cover,
              ),
      ),
    ));
  }
}
