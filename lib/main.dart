import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:altruity/screens/discover_screen.dart';
import 'package:altruity/providers/nonprofits.dart';
import 'package:altruity/providers/nonprofit.dart';
import 'package:altruity/providers/auth.dart';
import 'package:altruity/screens/authentication_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Nonprofits(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Visa Gives',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // check if user is authenticated, if not send to authentication screen
          home: auth.isAuth ? DiscoverScreen() : AuthenticationScreen(),
        ),
      ),
    );
  }
}
