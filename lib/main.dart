import 'package:altruity/models/payment_method.dart';
import 'package:altruity/providers/user.dart';
import 'package:altruity/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:shimmer/shimmer.dart';
import 'package:altruity/providers/nonprofits.dart';
import 'package:altruity/providers/user.dart';
import 'package:altruity/providers/auth.dart';
import 'package:altruity/screens/authentication_screen.dart';
import 'package:altruity/screens/discover_screen.dart';
import 'package:altruity/screens/payment_methods_screen.dart';
import 'package:altruity/screens/user_profile_screen.dart';
import 'package:altruity/screens/nonprofit_detail_screen.dart';
import 'package:altruity/screens/donation_history_screen.dart';
import 'package:altruity/screens/payment_method_entry_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 2), onClose);
  }
  void onClose() {
    Navigator.of(context).pushReplacement(new PageRouteBuilder(
        maintainState: true,
        opaque: true,
        pageBuilder: (context, _, __) => new Home(),
        transitionDuration: const Duration(seconds: 2),
        transitionsBuilder: (context, anim1, anim2, child) {
          return new FadeTransition(
            child: child,
            opacity: anim1,
          );
        }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Shimmer.fromColors(
            period: Duration(milliseconds: 1500),
            baseColor: Color.fromRGBO(26, 31, 113, 1),
            highlightColor: Color.fromRGBO(247, 182, 0, 1),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Image.asset('assets/images/VISA-GIVES-logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
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
          create: (ctx) => User(null, null),
          update: (ctx, auth, nonprof) => User(auth.userId, auth.token),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Visa Gives',
          theme: ThemeData(
            //primaryColor: Color.fromRGBO(26, 31, 113, 100),
            accentColor: Color.fromRGBO(247, 182, 0, 1),
            splashColor: Color.fromRGBO(27, 138, 241, 1),
            primaryColorDark: Color.fromRGBO(26, 31, 113, 1),

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
              headline3: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
              headline4: TextStyle(
                color: Colors.black,
                fontSize: 50,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
              headline5: TextStyle(
                color: Colors.black,
                fontSize: 16,
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
          routes: {
            AuthenticationScreen.routeName: (ctx) => AuthenticationScreen(),
            DiscoverScreen.routeName: (ctx) => DiscoverScreen(),
            UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
            DonationHistoryScreen.routeName: (ctx) => DonationHistoryScreen(),
            NonprofitDetailScreen.routeName: (ctx) => NonprofitDetailScreen(),
            PaymentMethodsScreen.routeName: (ctx) => PaymentMethodsScreen(),
            PaymentMethodEntryScreen.routeName: (ctx) =>
                PaymentMethodEntryScreen(),
          },
        ),
      ),
    );
  }
}
