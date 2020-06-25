import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:altruity/providers/nonprofit.dart';
import 'dart:convert';

class User with ChangeNotifier{
  final String userId;
  final String email;
  final String password;
  final String profilePicture;
  List<Nonprofit> donatedNonprofits;
  List<String> interests;

  User({
    @required this.userId,
    @required this.email,
    @required this.password,
    @required this.profilePicture,
  });
}