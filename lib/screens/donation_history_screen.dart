import 'package:altruity/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:altruity/providers/user.dart';
import 'package:altruity/providers/nonprofits.dart';
import 'package:flutter/material.dart';
import 'package:altruity/widgets/donation_instance_card.dart';

class DonationHistoryScreen extends StatefulWidget {
  static const routeName = '/donation-history';

  @override
  _DonationHistoryScreenState createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
  var _isInit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black38),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
          elevation: 1,
      ),
      body: FutureBuilder(
        future: Provider.of<User>(context, listen: false).fetchUserData(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(child: Text('An error occured'));
            } else {
              return Consumer<User>(
                builder: (ctx, userData, child) =>
                    userData.donationHistory.isEmpty
                        ? Text('Make a donation to see it here')
                        : Column(
                            children: <Widget>[
                              Text("Donation History"),
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) =>
                                      DonationInstanceCard(
                                          userData.donationHistory[index]),
                                  itemCount: userData.paymentMethods.length,
                                ),
                              ),
                              //FloatingActionButton(child: Text('Add a Card'),onPressed: (){},)
                            ],
                          ),
              );
            }
          }
        },
      ),
    );
  }
}
