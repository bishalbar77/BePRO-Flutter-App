import 'dart:io';

import 'package:YnotV/Controller/UserController.dart';
import 'package:YnotV/Model/Login.dart';
import 'package:YnotV/Profile/ProfileScreen.dart';
import 'package:YnotV/components/text_field_container.dart';
import 'package:YnotV/home.dart';
import 'package:flutter/material.dart';
import 'package:YnotV/Screens/Login/components/background.dart';
import 'package:YnotV/Screens/Signup/signup_screen.dart';
import 'package:YnotV/components/already_have_an_account_acheck.dart';
import 'package:YnotV/components/rounded_button.dart';
import 'package:YnotV/components/rounded_input_field.dart';
import 'package:YnotV/components/rounded_password_field.dart';
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
    super.initState();
  }

  Future<bool> _onWillPop() async {

    // This dialog will exit your app on saying yes
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
    Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: _isLoading
          ? Container(
        color: Colors.white70.withOpacity(0.3),
        width: MediaQuery.of(context).size.width, //70.0,
        height: MediaQuery.of(context).size.height, //70.0,
        child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Center(child: new CircularProgressIndicator())),
      )
          : WillPopScope(
        onWillPop: () => Future.value(false),
            child: Background(
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                  width: MediaQuery.of(context).size.width * 0.8,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
      ),
          ),
    );
  }
}
