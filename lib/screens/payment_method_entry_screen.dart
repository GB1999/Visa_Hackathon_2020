import 'package:flutter/material.dart';
import 'package:altruity/models/payment_method.dart';
import 'package:altruity/providers/user.dart';
import 'package:provider/provider.dart';

class PaymentMethodEntryScreen extends StatefulWidget {
  static const routeName = '/payment-method-entry-screen';

  @override
  _PaymentMethodEntryScreenState createState() =>
      _PaymentMethodEntryScreenState();
}

class _PaymentMethodEntryScreenState extends State<PaymentMethodEntryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isSending = false;

  final _passwordController = TextEditingController();

  Future<void> _submitPaymentMethod(PaymentMethod method) async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isSending = true;
    });
    try {
      await Provider.of<User>(context, listen: false)
          .addNewPaymentMethod(method);
    } catch (error) {
      throw (error);
    }
    setState(() {
      _isSending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PaymentMethod existing =
        ModalRoute.of(context).settings.arguments as PaymentMethod;

    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:  Colors.black38),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
          elevation: 1,
      ),
      body: Card(
        elevation: 4.0,
        child: Container(
          // size container depending on Authmode (signup or signin)
          height: 600,
          constraints: BoxConstraints(minHeight: 320),
          width: deviceSize.width * 0.75,
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Card Holder'),
                    initialValue: existing.cardHolder,
                    keyboardType: TextInputType.number,
                    //obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Name';
                      }
                    },
                    onSaved: (value) {
                      existing.cardHolder = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Card Number'),
                    initialValue: existing.cardNumber,
                    keyboardType: TextInputType.number,
                    //obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Card Number';
                      }
                    },
                    onSaved: (value) {
                      existing.cardNumber = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Expiration Date'),
                    //obscureText: true,
                    controller: _passwordController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value.isEmpty || value.length != 4) {
                        return 'Invalid Expiration Date';
                        
                      }
                    },
                    onSaved: (value) {},
                  ),
                  TextFormField(
                      decoration: InputDecoration(labelText: 'CVV'),
                      //obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length != 3) {
                          return 'Invalid CVV';
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  if (_isSending)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        _submitPaymentMethod(existing);
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
