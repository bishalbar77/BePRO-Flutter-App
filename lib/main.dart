import 'package:bepro/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bepro/Screens/Welcome/welcome_screen.dart';
import 'package:bepro/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BePro',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
        home: SplashScreen()
    );
  }
}
