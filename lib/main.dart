import 'package:altruity/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:altruity/screens/discover_screen.dart';
import 'package:altruity/providers/nonprofits.dart';
import 'package:altruity/providers/user.dart';
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
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Nonprofits>(
            create: (ctx) => Nonprofits(null, null, []),
            update: (ctx, auth, nonprof) => Nonprofits(auth.token, auth.userId,
                nonprof == null ? [] : nonprof.nonprofits),
          ),
        ChangeNotifierProxyProvider<Auth, User>(
            create: (ctx) => User(userId: null, name: null, email: null, profilePicture: null, ),
            update: (ctx, auth, nonprof) => User(userId: auth.userId),
          ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Visa Gives',
          theme: ThemeData(
            //primaryColor: Color.fromRGBO(26, 31, 113, 100),
            accentColor: Color.fromRGBO(247, 182, 0, 100),
            splashColor: Color.fromRGBO(27, 138, 241, 100),
            
            fontFamily: 'OpenSans',

            textTheme: TextTheme(
              headline1: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
              headline2: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400,
              ),
              bodyText1: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w300,
              ),
              bodyText2: TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w300,
                color: Colors.black26,
              ),
              subtitle1: TextStyle(
                fontSize: 12,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w300,
                color: Colors.black45,
              ),
              subtitle2: TextStyle(
                fontSize: 12,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w300,
                color: Colors.black,
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
