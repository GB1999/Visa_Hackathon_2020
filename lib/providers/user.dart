import 'package:altruity/screens/payment_methods_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:altruity/providers/nonprofit.dart';
import 'package:http/http.dart' as http;
import 'package:altruity/models/payment_method.dart';
import 'package:altruity/models/donation.dart';
import 'dart:convert';
import 'dart:developer';

class User with ChangeNotifier {
  String _userId = '';
  String _token = '';
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _password = '';
  String _profilePicture = '';
  List<PaymentMethod> _paymentMethods = [];
  List<Donation> _donationHistory = [];
  List<String> _interests = [];

  User(this._userId, this._token);

  String get userId {
    return _userId;
  }

  String get email {
    return _email;
  }

  String get name {
    return _firstName + ' ' + _lastName;
  }

  String get profilePicture {
    return _profilePicture;
  }

  List<PaymentMethod> get paymentMethods {
    return _paymentMethods;
  }

  List<Donation> get donationHistory {
    return _donationHistory;
  }

  Future<void> postNewUser(
      String firstName, String lastName, String profilePicureURL) async {
    var url = 'https://visacharity.firebaseio.com/Users/${userId}.json';
    final newUserData = {
      'user_ID': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email_address': email,
      'password': _password,
      'payment_methods': [],
      'total_amount_donated': 0,
      'donation_history': [],
      'interests': [],
      'profile_image': profilePicureURL,
    };

    try {
      final response = await http.post(url, body: json.encode(newUserData));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      // print(extractedData);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Future<void> fetchUserData() async {
    var url = 'https://visacharity.firebaseio.com/Users/${userId}.json';
    try {
      final response = await http.get(
        url,
      );
      List<Donation> loadedDonationHistory = [];
      List<PaymentMethod> loadedPaymentMethods = [];
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      // print(extractedData.toString().length);
      // printWrapped(extractedData.toString());
      _profilePicture = extractedData['profile_image'];
      _email = extractedData['email'];
      _firstName = extractedData['first_name'];
      _lastName  = extractedData['last_name'];

      extractedData["donation_history"].forEach((donation) {
        loadedDonationHistory.add(
          Donation(
            amount: donation['amount'],
            dateDonated: donation['date_donated'],
            charityId: donation['charity_id'],
          ),
        );
      });
      _donationHistory = loadedDonationHistory;
      
      extractedData["payment_methods"].forEach((method) {
        loadedPaymentMethods.add(
          PaymentMethod(
            cardNumber: method['card_number'],
            cardHolder: method['card_holder'],
          ),
        );
      });
      _paymentMethods = loadedPaymentMethods;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateProfilePicture(String profilePictureURL) {
    final oldProfilePicure = profilePicture;
    _profilePicture = profilePictureURL;
  }

  Future<void> deletePaymentMethod(String cardNumber) async {
    var url =
        'https://visacharity.firebaseio.com/Users/${userId}/payment_methods.json';
    try {
      final response = await http.get(url);
      var extractedData = json.decode(response.body) as List<dynamic>;
      var deletedIndex;
      extractedData.asMap().forEach(
        (index, method) {
          if (method["card_number"] == cardNumber){
            print("Delete card at index ${index}");
            deletedIndex = index;      
          }
          else {
            return;
          }
        },
      );
      var deleteUrl = 'https://visacharity.firebaseio.com/Users/${userId}/payment_methods/${deletedIndex}.json';
            await http.delete(deleteUrl);
      
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addNewPaymentMethod(PaymentMethod method) async{
    //
    var url =
        'https://visacharity.firebaseio.com/Users/${userId}/payment_methods/${paymentMethods.length}.json';
    try {
      await http.put(url, body: method.toJson());
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
