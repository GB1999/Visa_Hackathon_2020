import 'package:flutter/material.dart';

class Donation{
  String charityId;
  String amount;
  String dateDonated;

  Donation({@required this.charityId, @required this.amount, @required this.dateDonated});
  Map<String,String> toJSON(){
    return {
      'amount': amount,
      'charity_id': charityId,
      'date_donated': dateDonated,
    };
  }
}