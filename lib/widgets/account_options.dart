/*
ACCOUNT OPTIONS BUTTONS -- a grid of buttons available to the user on their account screen
Options => Reset Password
           Logout
           Invite Friends
           Delete Account
           Contact Us
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountOptions extends StatefulWidget {
  @override
  _AccountOptionsState createState() => _AccountOptionsState();
}

class _AccountOptionsState extends State<AccountOptions> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(8.0),
      crossAxisSpacing: 8.0,
      crossAxisCount: 2,
      childAspectRatio: 3.0,
      shrinkWrap: true,
      children: <Widget>[
        //Reset Password
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
          child: FlatButton(
            onPressed: () {/*TODO -- write reset password function*/},
            child: Text(
              "Reset Password",
              style: TextStyle(fontSize: 12),
            ),
            splashColor: Colors.amber[800],
          ),
        ),

        //Logout
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
          child: FlatButton(
            onPressed: () {/*TODO -- redirect to login page*/},
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 12),
            ),
            splashColor: Colors.amber[800],
          ),
        ),

        //Invite Friends -- TODO replace copied text with web link to homepage
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
          child: FlatButton(
            onPressed: () {Fluttertoast.showToast(msg: "Copied!", timeInSecForIosWeb: 2);
              Clipboard.setData(
                  ClipboardData(text: "homepage web url here"));},
            child: Text(
              "Invite Friends",
              style: TextStyle(fontSize: 12),
            ),
            splashColor: Colors.amber[800],
          ),
        ),

        //Delete Account
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
          child: FlatButton(
            onPressed: () {
              /*TODO -- redirect to login page and remove user from records or change status to inactive*/
            },
            child: Text(
              "Delete Account",
              style: TextStyle(fontSize: 12),
            ),
            splashColor: Colors.amber[800],
          ),
        ),

        //Contact Us -- TODO replace copied text with an email address
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
          child: FlatButton(
            onPressed: () {
              Fluttertoast.showToast(msg: "Copied!", timeInSecForIosWeb: 2);
              Clipboard.setData(
                  ClipboardData(text: "user support email address here"));
            },
            child: Text(
              "Contact Us",
              style: TextStyle(fontSize: 12),
            ),
            splashColor: Colors.amber[800],
          ),
        ),
      ],
    );
  }
}
