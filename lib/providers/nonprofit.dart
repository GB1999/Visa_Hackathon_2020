import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Nonprofit with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final List<String> tags;

  Nonprofit({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrls,
    @required this.tags,
  });
}