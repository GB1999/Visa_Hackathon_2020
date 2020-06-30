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
      floatingActionButton:
      Container(
        padding: EdgeInsets.only(bottom: 50.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: (){
              Navigator.of(context).pushNamed(
            PaymentMethodEntryScreen.routeName,
            arguments: PaymentMethod(cardHolder: '', cardNumber: ''),
          );
            },
            label: Text("Add New Card"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:  Colors.black38),
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
                    userData.paymentMethods.isEmpty
                        ? Text('Please add a payment method')
                        : Column(
                            children: <Widget>[
                              Text("Manage your Visa Cards to send donations"),
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
              );
            }
          }
        },
      ),
    );
  }
}
