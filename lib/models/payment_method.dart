import 'package:flutter/material.dart';

class PaymentMethod{
  String cardNumber;
  String cardHolder;

  PaymentMethod({@required this.cardHolder, @required this.cardNumber});
}