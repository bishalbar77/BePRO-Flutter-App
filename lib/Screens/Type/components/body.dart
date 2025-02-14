import 'package:YnotV/Screens/SignupGuide/signup_screen.dart';
import 'package:YnotV/Screens/SignupTutor/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:YnotV/Screens/Login/login_screen.dart';
import 'package:YnotV/Screens/Signup/signup_screen.dart';
import 'package:YnotV/Screens/Type/components/background.dart';
import 'package:YnotV/components/rounded_button.dart';
import 'package:YnotV/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SELECT CATEGORY",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "GUIDE",
              color: Colors.deepPurple,
              textColor: Colors.white,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreenGuide();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "TUTOR",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreenTutor();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "STUDENT",
              color: Colors.purple,
              textColor: Colors.white,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
