import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:altruity/providers/nonprofit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User with ChangeNotifier {
  String userId;
  String email;
  String name;
  String password;
  String profilePicture;
  List<Nonprofit> donatedNonprofits;
  List<String> interests;

  User({
    this.userId,
    this.email,
    this.name,
    this.profilePicture,
  });

  Future<void> fetchUserData() async {
    var url = 'https://visacharity.firebaseio.com/Personal_Data/$userId.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      print(extractedData);
      profilePicture = extractedData['ProfilePicture'];
      email = extractedData['Email'];
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateProfilePicture(String profilePictureURL) {
    final oldProfilePicure = profilePicture;
    profilePicture = profilePictureURL;
  }
}
