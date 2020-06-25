import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'nonprofit.dart';

class Nonprofits with ChangeNotifier {
  List<Nonprofit> _nonprofits = [];

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
      print(extractedData);
      extractedData.forEach((nonprofId, nonprofData) {
        loadedNonprofits.add(
          Nonprofit(
            id: nonprofId,
            title: nonprofData['name'],
            description: nonprofData['description'],
            coverPhoto: nonprofData['coverPhoto'][0],
            additionalPhotos: nonprofData['additionalPhotos'].cast<String>(),
            tags: nonprofData['tags'].cast<String>(),
          ),
        );
      });

      _nonprofits = loadedNonprofits;
      notifyListeners();
      print(response);
    } catch (error) {
      throw (error);
    }
  }

  //   Nonprofit(
  //       id: 'np1',
  //       title: 'St. Judes',
  //       description:
  //           "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
  //       imageUrls: [
  //         'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
  //         'https://townsquare.media/site/532/files/2017/02/St-Jude-Kids.jpg?w=980&q=75'
  //       ],
  //       tags: [
  //         'Cancer',
  //         'Children',
  //         'Medical',
  //       ]),
  //   Nonprofit(
  //       id: 'np2',
  //       title: 'American Civil Liberties Union',
  //       description:
  //           "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
  //       imageUrls: [
  //         'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
  //       ],
  //       tags: [
  //         'Civil',
  //         'African-American',
  //       ]),
  //   Nonprofit(
  //       id: 'np1',
  //       title: 'St. Judes',
  //       description:
  //           "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
  //       imageUrls: [
  //         'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
  //         'https://townsquare.media/site/532/files/2017/02/St-Jude-Kids.jpg?w=980&q=75'
  //       ],
  //       tags: [
  //         'Cancer',
  //         'Children',
  //         'Medical',
  //       ]),
  //   Nonprofit(
  //       id: 'np2',
  //       title: 'American Civil Liberties Union',
  //       description:
  //           "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
  //       imageUrls: [
  //         'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
  //       ],
  //       tags: [
  //         'Civil',
  //         'African-American',
  //       ]),
  //   Nonprofit(
  //       id: 'np1',
  //       title: 'St. Judes',
  //       description:
  //           "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
  //       imageUrls: [
  //         'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
  //         'https://townsquare.media/site/532/files/2017/02/St-Jude-Kids.jpg?w=980&q=75'
  //       ],
  //       tags: [
  //         'Cancer',
  //         'Children',
  //         'Medical',
  //       ]),
  //   Nonprofit(
  //       id: 'np2',
  //       title: 'American Civil Liberties Union',
  //       description:
  //           "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
  //       imageUrls: [
  //         'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
  //       ],
  //       tags: [
  //         'Civil',
  //         'African-American',
  //       ]),
  //   Nonprofit(
  //       id: 'np1',
  //       title: 'St. Judes',
  //       description:
  //           "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
  //       imageUrls: [
  //         'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
  //         'https://townsquare.media/site/532/files/2017/02/St-Jude-Kids.jpg?w=980&q=75'
  //       ],
  //       tags: [
  //         'Cancer',
  //         'Children',
  //         'Medical',
  //       ]),
  //   Nonprofit(
  //       id: 'np2',
  //       title: 'American Civil Liberties Union',
  //       description:
  //           "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
  //       imageUrls: [
  //         'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
  //       ],
  //       tags: [
  //         'Civil',
  //         'African-American',
  //       ]),
  //   Nonprofit(
  //       id: 'np1',
  //       title: 'St. Judes',
  //       description:
  //           "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
  //       imageUrls: [
  //         'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
  //         'https://townsquare.media/site/532/files/2017/02/St-Jude-Kids.jpg?w=980&q=75'
  //       ],
  //       tags: [
  //         'Cancer',
  //         'Children',
  //         'Medical',
  //       ]),
  //   Nonprofit(
  //       id: 'np2',
  //       title: 'American Civil Liberties Union',
  //       description:
  //           "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
  //       imageUrls: [
  //         'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
  //       ],
  //       tags: [
  //         'Civil',
  //         'African-American',
  //       ]),
  // ];

  List<Nonprofit> get nonprofits {
    return [..._nonprofits];
  }

  Nonprofit findById(String id) {
    return _nonprofits.firstWhere((nonprof) => nonprof.id == id);
  }
}
