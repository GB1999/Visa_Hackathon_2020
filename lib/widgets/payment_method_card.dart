import 'package:altruity/models/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:altruity/providers/user.dart';
import 'package:altruity/screens/payment_method_entry_screen.dart';
import 'package:altruity/screens/payment_methods_screen.dart';

class PaymentMethodCard extends StatefulWidget {
  final PaymentMethod method;
  PaymentMethodCard(this.method);
  @override
  _PaymentMethodCardState createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      key: Key(widget.method.cardNumber),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              child: Card(
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: -10,
                        child: SizedBox(
                            width: 75,
                            height: 75,
                            child: Image.asset(
                                'assets/images/visa-logo-png-transparent.png')),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.method.cardHolder),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "**** **** **** ${widget.method.cardNumber.substring(widget.method.cardNumber.length-4)}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_expanded)
              Row(
                children: <Widget>[
                  FlatButton(
                      child: Text("Delete"),
                      onPressed: () {
                        final userData = Provider.of<User>(context, listen: false);
                        _showAlertDialog(userData);
                      }),
                  FlatButton(
                    child: Text("Edit"),
                    onPressed: () {
                      
                      Navigator.of(context).pushNamed(
                        PaymentMethodEntryScreen.routeName,
                        arguments: widget.method,
                      );
                    },
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAlertDialog(User userData) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: Text(
                "Are you sure you want to delete this card from your payment methods"),
            actions: [
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Continue"),
                onPressed: () async {
                  try {
                    await userData
                        .deletePaymentMethod(widget.method.cardNumber);
                  } catch (error) {
                    print(error);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
