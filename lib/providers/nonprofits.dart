import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'nonprofit.dart';

class Nonprofits with ChangeNotifier {
  List<Nonprofit> _nonprofits = [];
  List<Nonprofit> _searchResults = [];

  final String authToken;
  final String userId;

  Nonprofits(this.authToken, this.userId, this._nonprofits);

  Future<void> fetchNonProfits() async {
    var url = 'https://visacharity.firebaseio.com/Charity.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      
      if(extractedData == null){
        return;
      }

      final List<Nonprofit> loadedNonprofits = [];
      extractedData.forEach((nonprofId, nonprofData) {
        if(nonprofData != null){
          loadedNonprofits.add(
          Nonprofit(
            id: nonprofId,
            title: nonprofData['name'],
            description: nonprofData['description'],
            expenditures: nonprofData['money'],
            coverPhoto: nonprofData['coverPhoto'][0],
            cardNumber: nonprofData['cardNumber'] != null ? nonprofData['cardNumber'].toString() : '0',
            charityLink: nonprofData['charityLink'] != null ? nonprofData['charityLink'] : [""],
            additionalPhotos: nonprofData['additionalPhotos'] != null ? nonprofData['additionalPhotos'].cast<String>() : [""],
            tags: nonprofData['tags'].cast<String>(),
          ),
        );
        }
        
      });

      _nonprofits = loadedNonprofits;
      notifyListeners();
    } catch (error) {
      
      throw (error);
    }
  }


  List<Nonprofit> get nonprofits {
    return [..._nonprofits];
  }

  List<Nonprofit> get searchResults {
    return [..._searchResults];
  }

  List<Nonprofit> get featuredNonprofits{
    return [..._nonprofits].sublist(0,4);
  }

  Nonprofit findById(String id) {
    return _nonprofits.firstWhere((nonprof) => nonprof.id == id);
  }

  Future<void> findByTag(String searchTag) {
    List<Nonprofit> results = [];
    _nonprofits.forEach((nonprof) {
      nonprof.tags.forEach((tag) { 
        print('tag');
        if(searchTag.contains(tag)){
          results.add(nonprof);
        }
      });
    }
    );
    _searchResults = results;
  }
}
