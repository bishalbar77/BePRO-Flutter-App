import 'package:YnotV/Screens/Type/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:YnotV/Screens/Login/login_screen.dart';
import 'package:YnotV/Screens/Signup/signup_screen.dart';
import 'package:YnotV/Screens/Welcome/components/background.dart';
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
              "WELCOME TO YnotV",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Type();
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
