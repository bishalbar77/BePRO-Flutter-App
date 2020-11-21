import 'package:YnotV/Controller/UserController.dart';
import 'package:YnotV/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:YnotV/Screens/Welcome/welcome_screen.dart';
import 'package:YnotV/constants.dart';
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
      title: 'Ynotv',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
        home: SplashScreen()
    );
  }
}
