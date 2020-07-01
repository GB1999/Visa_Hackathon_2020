import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Container(
        color: Colors.white,
        child: Shimmer.fromColors(
          period: Duration(milliseconds: 1500),
          baseColor: Color.fromRGBO(26, 31, 113, 1),
          highlightColor:Color.fromRGBO(247, 182, 0, 1),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Image.asset('assets/images/VISA-GIVES-logo.png'),
          ),
        ),
      ),
    );
  }
}
