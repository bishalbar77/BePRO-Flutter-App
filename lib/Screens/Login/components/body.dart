import 'package:bepro/Controller/UserController.dart';
import 'package:bepro/Model/Login.dart';
import 'package:bepro/Profile/ProfileScreen.dart';
import 'package:bepro/components/text_field_container.dart';
import 'package:bepro/home.dart';
import 'package:flutter/material.dart';
import 'package:bepro/Screens/Login/components/background.dart';
import 'package:bepro/Screens/Signup/signup_screen.dart';
import 'package:bepro/components/already_have_an_account_acheck.dart';
import 'package:bepro/components/rounded_button.dart';
import 'package:bepro/components/rounded_input_field.dart';
import 'package:bepro/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserController get service =>  GetIt.I<UserController>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isLoading
        ? Container(
            color: Colors.white70.withOpacity(0.3),
            width: MediaQuery.of(context).size.width, //70.0,
            height: MediaQuery.of(context).size.height, //70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
        : Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            TextFieldContainer(
              child: TextField(
                controller: _emailController,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  hintText: "Email",
                  border: InputBorder.none,
                ),
              ),
            ),
            TextFieldContainer(
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: kPrimaryColor,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    print(_emailController.text);
                    final login = Login(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    final result =
                    await service.loginEmail(login);
                    setState(() {
                      _isLoading = false;
                    });
                    final title = result.error
                        ? 'Access Denied'
                        : 'Access Granted';
                    final text = result.error
                        ? (result.errorMessage ??
                        "Sorry! Credentials didn't match.")
                        : "Login successful";
                    if (text == 'Login successful') {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(title),
                            content: Text(text),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (__) =>
                                              Home(email: _emailController.text,)));
                                },
                              )
                            ],
                          )).then((data) {
                        if (!result.error) {
                          Navigator.of(context).pop();
                        }
                      });
                    } //end if
                    else {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(title),
                            content: Text(text),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop();
                                },
                              )
                            ],
                          )).then((data) {
                        if (!result.error) {
                          Navigator.of(context).pop();
                        }
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
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
