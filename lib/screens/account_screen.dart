/*
ACCOUNT NAVIGATION SCREEN:
from here you can see => back button
                         profile picture
                         username
                         # of charities the user has donated to
                         various settings options/help**

**separate widget
*/

import 'package:flutter/material.dart';

import 'package:altruity/widgets/account_options.dart';

class AccountScreen extends StatelessWidget {
  
  //all variables pulled from stored user info
  //for now, just given placeholder values
  final int totalNPOs = 11;
  final String username = "User First Name Last Name";
  final String profilePic =
      "https://cdn0.iconfinder.com/data/icons/shift-ecommerce/32/Visa_initial-512.png";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            //Back Button
            BackButton(),

            //Profile Picture -- if they have not set one yet it will default to a placeholder picture
            Padding(
              padding: const EdgeInsets.fromLTRB(96.0, 8.0, 96.0, 0.0),
              child: profilePic.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        profilePic,
                        fit: BoxFit.cover,
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
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text(
                username,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //Total NPOs
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Donated to $totalNPOs NPOs",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),

            //Account Options
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AccountOptions(),
            ),
          ],
        ),
      ),
    );
  }
}
