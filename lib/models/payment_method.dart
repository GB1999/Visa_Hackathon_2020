import 'package:flutter/material.dart';
import 'dart:convert';
class PaymentMethod{
  String cardNumber;
  String cardHolder;

  PaymentMethod({@required this.cardHolder, @required this.cardNumber});
  String toJson(){
    return json.encode({
      'card_holder': cardHolder,
      'card_number': cardNumber,
    });
  }
}