import 'package:altruity/screens/payment_method_entry_screen.dart';
import 'package:altruity/widgets/payment_method_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:altruity/providers/user.dart';
import 'package:altruity/models/payment_method.dart';
import 'package:altruity/widgets/app_drawer.dart';

class PaymentMethodsScreen extends StatelessWidget {
  static const routeName = '/payment-methods';

  @override
  Widget build(BuildContext context) {
    Provider.of<User>(context, listen: false).fetchUserData();
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 50.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                PaymentMethodEntryScreen.routeName,
                arguments: PaymentMethod(cardHolder: '', cardNumber: ''),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add New Card",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              elevation: 5,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black38),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                        .paymentMethods.isEmpty
                    ? Center(child: Text('Please add a payment method'))
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10.0, 20, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Payment Methods',
                                style: Theme.of(context).textTheme.headline1),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                              child: Text("Manage your Visa Cards to send donations", style: Theme.of(context).textTheme.bodyText1,),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    PaymentMethodCard(
                                        userData.paymentMethods[index]),
                                itemCount: userData.paymentMethods.length,
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
