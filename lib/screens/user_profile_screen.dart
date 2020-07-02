import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:altruity/providers/user.dart';

enum viewMode { View, Edit }

class UserProfileScreen extends StatelessWidget {
  static const routeName = '/user-profile';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black38),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10.0, 0, 0.0),
          child: Text('Your Account',
              style: Theme.of(context).textTheme.headline1),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  //Profile Picture -- if they have not set one yet it will default to a placeholder picture
                  Padding(
                    padding: const EdgeInsets.fromLTRB(96.0, 80.0, 96.0, 0.0),
                    child: widget.userData.profilePicture.isNotEmpty
                        ? Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Image.network(
                                  widget.userData.profilePicture,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "https://cdn0.iconfinder.com/data/icons/shift-ecommerce/32/Visa_initial-512.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),

                  //Username
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
                    child: Text(
                      widget.userData.name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),

                  //Total NPOs
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                    child: Text(
                      "Donated to ${widget.userData.donationHistory.length} NPO${widget.userData.donationHistory.length > 1 ? "s": ""}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: GridView.count(
                      padding: const EdgeInsets.all(5),
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 10),
                      children: <Widget>[
                        FlatButton(
                          onPressed: (){},
                          child: Text(
                            'Edit Profile',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            'Invite Friends',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            'Invite Friends',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            'Delete Account',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  )

                  //Account Options
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
