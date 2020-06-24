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
            primaryColor: Color.fromRGBO(26, 31, 113, 100),
            accentColor: Color.fromRGBO(247, 182, 0, 100),
            splashColor: Color.fromRGBO(27, 138, 241, 100),
            fontFamily: 'OpenSans',
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
              headline2: TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400,
              ),
              bodyText1: TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w300,
              ),
              bodyText2: TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w300,
                color: Colors.black26
              ),
            ),
          ),
          // check if user is authenticated, if not send to authentication screen
          home: auth.isAuth ? DiscoverScreen() : AuthenticationScreen(),
        ),
      ),
    );
  }
}
