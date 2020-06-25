import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Nonprofit with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String coverPhoto;
  final List<String> additionalPhotos;
  final List<String> tags;

  Nonprofit({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.coverPhoto,
    @required this.additionalPhotos,
    @required this.tags,
  });

  Future<void> makeDonation(
      double donationAmount, String token, String userId) async {
    final timeStamp = DateTime.now();
    final url =
        'https://shopapp-89d99.firebaseio.com/users/$userId/donated_charities/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode({
          'amount': donationAmount.toString(),
          'dateTime': timeStamp.toIso8601String(),
        }),
      );
      if (response.statusCode >= 400) {
        //reset donation
        notifyListeners();
      }
    } catch (error) {}
  }
}
