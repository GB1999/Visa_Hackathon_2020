import 'package:altruity/models/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:altruity/providers/user.dart';
import 'package:altruity/screens/payment_method_entry_screen.dart';

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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              child: Card(
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.method.cardHolder),
                      Text(
                          "**** **** **** ${widget.method.cardNumber.substring(8)}"),
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
                        _showAlertDialog(context);
                      }),
                  FlatButton(
                      child: Text("Edit"),
                      onPressed: (){
              Navigator.of(context).pushNamed(
            PaymentMethodEntryScreen.routeName,
            arguments: widget.method,
          );
            },)
                ],
              ),
          ],
        ),
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    final scaffold = Scaffold.of(context);
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () async {
        try {
          await Provider.of<User>(context, listen: false)
              .deletePaymentMethod(widget.method.cardNumber);
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
