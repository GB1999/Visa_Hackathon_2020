import 'dart:convert';
import 'package:flutter/material.dart';

import 'nonprofit.dart';

class Nonprofits with ChangeNotifier {
  List<Nonprofit> _nonprofits = [
    Nonprofit(
        id: 'np1',
        title: 'St. Judes',
        description:
            "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
        imageUrls: [
          'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
          'https://townsquare.media/site/532/files/2017/02/St-Jude-Kids.jpg?w=980&q=75'
        ],
        tags: [
          'Cancer',
          'Children',
          'Medical',
        ]),
    Nonprofit(
        id: 'np2',
        title: 'American Civil Liberties Union',
        description:
            "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
        imageUrls: [
          'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
        ],
        tags: [
          'Civil',
          'African-American',
        ]),
    Nonprofit(
        id: 'np1',
        title: 'St. Judes',
        description:
            "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
        imageUrls: [
          'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
          'https://townsquare.media/site/532/files/2017/02/St-Jude-Kids.jpg?w=980&q=75'
        ],
        tags: [
          'Cancer',
          'Children',
          'Medical',
        ]),
    Nonprofit(
        id: 'np2',
        title: 'American Civil Liberties Union',
        description:
            "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
        imageUrls: [
          'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
        ],
        tags: [
          'Civil',
          'African-American',
        ]),
    Nonprofit(
        id: 'np1',
        title: 'St. Judes',
        description:
            "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
        imageUrls: [
          'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
          'https://townsquare.media/site/532/files/2017/02/St-Jude-Kids.jpg?w=980&q=75'
        ],
        tags: [
          'Cancer',
          'Children',
          'Medical',
        ]),
    Nonprofit(
        id: 'np2',
        title: 'American Civil Liberties Union',
        description:
            "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
        imageUrls: [
          'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
        ],
        tags: [
          'Civil',
          'African-American',
        ]),
    Nonprofit(
        id: 'np1',
        title: 'St. Judes',
        description:
            "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
        imageUrls: [
          'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
          'https://townsquare.media/site/532/files/2017/02/St-Jude-Kids.jpg?w=980&q=75'
        ],
        tags: [
          'Cancer',
          'Children',
          'Medical',
        ]),
    Nonprofit(
        id: 'np2',
        title: 'American Civil Liberties Union',
        description:
            "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
        imageUrls: [
          'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
        ],
        tags: [
          'Civil',
          'African-American',
        ]),
    Nonprofit(
        id: 'np1',
        title: 'St. Judes',
        description:
            "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
        imageUrls: [
          'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
          'https://townsquare.media/site/532/files/2017/02/St-Jude-Kids.jpg?w=980&q=75'
        ],
        tags: [
          'Cancer',
          'Children',
          'Medical',
        ]),
    Nonprofit(
        id: 'np2',
        title: 'American Civil Liberties Union',
        description:
            "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
        imageUrls: [
          'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
        ],
        tags: [
          'Civil',
          'African-American',
        ]),
  ];

  Nonprofits();

  List<Nonprofit> get nonprofits {
    return [..._nonprofits];
  }

  Nonprofit findById(String id) {
    return _nonprofits.firstWhere((nonprof) => nonprof.id == id);
  }
}
