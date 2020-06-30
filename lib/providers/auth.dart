import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:altruity/models/http_exception.dart';
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  //if token is not expired or empty, return the token
  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    } else {
      return null;
    }
  }

  String get userId{
    return _userId;
  }

  Future<void> _login(
      String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDvYLjgtWFM2_v7EE7uGZMPLBkuGS3N_1I";
    try {
      //make post request to firebase with given email and password
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        //if reponse returns an error field, throw exception with error message
        throw HttpException(responseData['error']['message']);
      }
      // fetch token and user ID from reponse data
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> _signup(
      String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDvYLjgtWFM2_v7EE7uGZMPLBkuGS3N_1I";
    try {
      //make post request to firebase with given email and password
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        //if reponse returns an error field, throw exception with error message
        throw HttpException(responseData['error']['message']);
      }
      // fetch token and user ID from reponse data
      _userId = responseData['localId'];
      //notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _signup(email, password);
  }

  Future<void> login(String email, String password) async {
    return _login(email, password);
  }
  void signout(){
    _token = null;
    notifyListeners();
  }
}