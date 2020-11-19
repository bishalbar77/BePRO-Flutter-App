import 'package:bepro/Controller/UserController.dart';
import 'package:bepro/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bepro/Screens/Welcome/welcome_screen.dart';
import 'package:bepro/constants.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => UserController());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

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
