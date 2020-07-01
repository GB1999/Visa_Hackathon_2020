import 'package:altruity/screens/payment_methods_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:altruity/providers/nonprofit.dart';
import 'package:http/http.dart' as http;
import 'package:altruity/models/payment_method.dart';
import 'package:altruity/models/donation.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:developer';

class User with ChangeNotifier {
  String _userId = '';
  String _token = '';
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _password = '';
  String _profilePicture = '';
  String _totalAmountDonated = '0';
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

  String get totalAmountDonated {
    return _totalAmountDonated;
  }

  List<PaymentMethod> get paymentMethods {
    return _paymentMethods;
  }

  List<Donation> get donationHistory {
    return _donationHistory;
  }

  Future<void> postNewUser(
      String newUserId,
      String newUserFirstName,
      String newUserLastName,
      String newUserEmail,
      String newUserPassword,
      String profilePicureURL) async {
    var url = 'https://visacharity.firebaseio.com/Users/${newUserId}.json';
    final newUserData = {
      'user_ID': newUserId,
      'first_name': newUserFirstName,
      'last_name': newUserLastName,
      'email_address': newUserEmail,
      'password': newUserPassword,
      'payment_methods': [],
      'total_amount_donated': "0",
      'donation_history': [],
      'interests': [],
      'profile_image': profilePicureURL,
    };

    try {
      final response = await http.put(url, body: json.encode(newUserData));
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
      _lastName = extractedData['last_name'];

      if (extractedData["donation_history"] != null) {
        _totalAmountDonated = extractedData['total_amount_donated'].toString();
        //print(extractedData["donation_history"]);
        extractedData["donation_history"].forEach((donation) {
          if (donation != null) {
            loadedDonationHistory.add(
              Donation(
                amount: donation['amount'],
                dateDonated: donation['date_donated'],
                charityId: donation['charity_id'],
              ),
            );
          }
        });
        _donationHistory = loadedDonationHistory;
      }

      if (extractedData["payment_methods"] != null) {
        if (extractedData["payment_methods"] is Map) {
          print('its not a list');
          print(extractedData["payment_methods"].runtimeType);
          extractedData["payment_methods"].forEach((index, method) {
            loadedPaymentMethods.add(
              PaymentMethod(
                cardNumber: method['card_number'],
                cardHolder: method['card_holder'],
              ),
            );
          });
        } else {
          extractedData["payment_methods"].forEach((method) {
            if (method != null) {
              loadedPaymentMethods.add(
                PaymentMethod(
                  cardNumber: method['card_number'],
                  cardHolder: method['card_holder'],
                ),
              );
            }
          });
        }

        _paymentMethods = loadedPaymentMethods;
      }
      print(userId);
      notifyListeners();
    } catch (error) {
      print(error);
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
      var extractedData = json.decode(response.body);
      var deletedIndex;
      print(extractedData.length);
      if (extractedData.runtimeType is Map) {
        extractedData.forEach((index, method) {
          if (method != null) {
            if (method["card_number"] == cardNumber) {
              print("Delete card at index ${index}");
              deletedIndex = index;
            }
          }
        });
      } else if (extractedData.length == 1) {
        deletedIndex = 0;
      } else {
        extractedData.asMap().forEach(
          (index, method) {
            if (method != null) {
              if (method["card_number"] == cardNumber) {
                print("Delete card at index ${index}");
                deletedIndex = index;
              }
            }
          },
        );
      }

      var deleteUrl =
          'https://visacharity.firebaseio.com/Users/${userId}/payment_methods/${deletedIndex}.json';
      await http.delete(deleteUrl);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> makeDonation(
      PaymentMethod method, int amount, Nonprofit nonprofit) async {
    var url =
        'https://visacharity.firebaseio.com/Users/${userId}/donation_history/${donationHistory.length + 1}.json';
    var totalDonationURL =
        'https://visacharity.firebaseio.com/Users/${userId}/total_amount_donated.json';
    var newTotal = int.parse(totalAmountDonated) + amount;
    var date = DateTime.parse("${DateTime.now().toString()}");
    var simpleDate = "${date.day}.${date.month}.${date.year}";
    Donation newDonation = Donation(
        amount: amount.toString(),
        charityId: nonprofit.id,
        dateDonated: simpleDate);
    final donationJSON = newDonation.toJSON();
    try {
      await http.put(url, body: json.encode(donationJSON));
      await http.put(totalDonationURL, body: json.encode(newTotal));
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addNewPaymentMethod(PaymentMethod method) async {
    //
    var url =
        'https://visacharity.firebaseio.com/Users/${userId}/payment_methods/${paymentMethods.length + 1}.json';
    try {
      await http.put(url, body: method.toJson());
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
