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
        actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.file_download,
                color: Colors.black38,
              ),
              onPressed: () {
              },
            ),
          ],
        backgroundColor: Colors.white,
        elevation: 0,
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
                builder: (ctx, userData, child) => userData
                        .donationHistory.isEmpty
                    ? Center(child: Text('Make a donation to see it here'))
                    : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Donation History',
                                  style: Theme.of(context).textTheme.headline1),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20.0),
                              child: Stack(
                                children: <Widget>[
                                  
                                  Image.asset('assets/images/donation-bg.png'),
                                  Center(
                                    child: Text(
                                      '\$${userData.totalAmountDonated}',
                                      style: Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    DonationInstanceCard(
                                        userData.donationHistory[index]),
                                itemCount: userData.donationHistory.length,
                              ),
                            ),
                            //FloatingActionButton(child: Text('Add a Card'),onPressed: (){},)
                          ],
                        ),
                    ),
              );
            }
          }
        },
      ),
    );
  }
}
