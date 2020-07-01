import 'package:altruity/providers/nonprofit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:altruity/providers/user.dart';
import 'package:altruity/models/payment_method.dart';

/*
This widget appears on the Non-profit Screen to allow the user to select, confirm, and transfer their donation amount.
The user must tap the desired donation amount, they will then be prompted to confirm this amount by tapping that amount again (now highlighted).
After two taps, the donation is processed.
*/

//TODO implement payment --  right now confirming donation amount does nothing

/* these are the possible states for each donation amount option
    SELECTION STATES:
        0 => default -- donation amount has been selected
        1 => donation amount has been selected but not confirmed
        2 => donation amount has been confirmed
  */

class DonationSelection extends StatefulWidget {
  var monthlyDonation = false;
  var noPaymentMethods = false;
  Nonprofit nonprofit;
  DonationSelection(this.nonprofit);
  @override
  _DonationSelectionState createState() => _DonationSelectionState();
}

class _DonationSelectionState extends State<DonationSelection> {
  var _isInit = true;
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<User>(context).fetchUserData();
      // final userData = Provider.of<User>(context);
      // if (userData.paymentMethods.isEmpty) {
      //   widget.noPaymentMethods = true;
      // } else {
      //   widget.selectedPaymentMethod = userData.paymentMethods[0];
      //   print(widget.selectedPaymentMethod.cardNumber);
      // }

      print('Provider data fetched');
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _confirmDonation() {}

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context, listen: true);
    PaymentMethod selectedPaymentMethod = userData.paymentMethods[0];
    return Material(
      child: widget.noPaymentMethods
          ? Center(
              child: Text('Please add a payment method'),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Donate Immediately",
                      style: Theme.of(context).textTheme.headline1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Make it Monthly',
                          style: TextStyle(color: Colors.black),
                        ),
                        Checkbox(
                          value: widget.monthlyDonation,
                          onChanged: (_) {
                            setState(() {
                              widget.monthlyDonation = !widget.monthlyDonation;
                              print(widget.monthlyDonation);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 400,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 8,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 5),
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: Container(
                              height: 20,
                              child: new Card(
                                color: Theme.of(context).splashColor,
                                elevation: 5.0,
                                child: new Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Donate \$${(index + 1) * 5} ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              var userData = Provider.of<User>(context, listen: false);
                              await _showConfirmationDialog(
                                userData,
                                  selectedPaymentMethod,
                                  (index + 1) * 5,
                                  widget.nonprofit);
                                  Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                        'Donating from Card ending in ${selectedPaymentMethod.cardNumber.substring(selectedPaymentMethod.cardNumber.length-4)}'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
    );
  }

  _showConfirmationDialog(User userData,
      PaymentMethod selectedPaymentMethod, int amount, Nonprofit nonprofit) {
    // set up the buttons
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: Text(
                "A donation of \$${amount} will be made to ${nonprofit.title}"),
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
                        .makeDonation(selectedPaymentMethod, amount, nonprofit);
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
