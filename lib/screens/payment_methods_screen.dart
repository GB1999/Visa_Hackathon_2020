import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:altruity/providers/user.dart';
import 'package:altruity/models/payment_method.dart';
import 'package:altruity/widgets/app_drawer.dart';

class PaymentMethodsScreen extends StatelessWidget {
  static const routeName = '/payment-methods';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      drawer: Drawer(child: AppDrawer()),
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
                builder: (ctx, userData, child) => ListView.builder(
                  itemBuilder: (context, index) => PaymentMethodTile(
                      userData.paymentMethods[index], context),
                  itemCount: userData.paymentMethods.length,
                ),
              );
            }
          }
        },
      ),
    );
  }

  Widget PaymentMethodTile(
      PaymentMethod userPaymentMethod, BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        _showAlertDialog(context, userPaymentMethod.cardNumber);
      },
      key: Key(userPaymentMethod.cardNumber),
      child: Card(
        elevation: 10.0,
        child: Center(
          child: Column(
            children: <Widget>[Text(userPaymentMethod.cardHolder)],
          ),
        ),
      ),
    );
  }

  _showAlertDialog(BuildContext context, String cardNumber) {
    final scaffold = Scaffold.of(context);
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () async {
        try {
          await Provider.of<User>(context, listen: false)
              .deletePaymentMethod(cardNumber);
        } catch (error) {
          scaffold.showSnackBar(
            SnackBar(
              content: Text('Deleting failed.'),
            ),
          );
        }
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () async {
        try {
          await Provider.of<User>(context, listen: false)
              .deletePaymentMethod(cardNumber);
        } catch (error) {
          scaffold.showSnackBar(
            SnackBar(
              content: Text('Deleting failed.'),
            ),
          );
        }
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text(
          "Are you sure you want to delete this card from your payment methods"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
