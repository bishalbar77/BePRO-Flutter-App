import 'package:YnotV/Controller/UserController.dart';
import 'package:YnotV/Model/SignUp.dart';
import 'package:YnotV/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:YnotV/Screens/Login/login_screen.dart';
import 'package:YnotV/Screens/Signup/components/background.dart';
import 'package:YnotV/Screens/Signup/components/or_divider.dart';
import 'package:YnotV/Screens/Signup/components/social_icon.dart';
import 'package:YnotV/components/already_have_an_account_acheck.dart';
import 'package:YnotV/components/rounded_button.dart';
import 'package:YnotV/components/rounded_input_field.dart';
import 'package:YnotV/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../../../constants.dart';
import '../../../home.dart';

class Body extends StatefulWidget {
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool showPassword = true;
  UserController get service =>  GetIt.I<UserController>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Sign sign = new Sign();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isLoading ? Container(
                color: Colors.white70.withOpacity(0.3),
                width: MediaQuery.of(context).size.width, //70.0,
                height: MediaQuery.of(context).size.height, //70.0,
                child: new Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new Center(child: new CircularProgressIndicator())),
              ) :
    Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.15),
              TextFieldContainer(
                child: TextField(
                  controller: _nameController,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.purple,
                    ),
                    hintText: "Name",
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  controller: _phoneController,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.call,
                      color: Colors.purple,
                    ),
                    hintText: "Phone Number",
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  controller: _emailController,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.purple,
                    ),
                    hintText: "Email",
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  obscureText: showPassword,
                  controller: _passwordController,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    hintText: "Password",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.purple,
                    ),
                    suffixIcon: showPassword
                      ? IconButton(
                        onPressed: () {
                        setState(() {
                        showPassword = false;
                        });
                        },
                          icon: Icon(
                            Icons.visibility,
                            color: Colors.purple,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                            showPassword = true;
                            });
                            },
                              icon: Icon(
                                Icons.visibility_off,
                                color: Colors.purple,
                              ),
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
                    color: Colors.purple,
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      print(_phoneController.text);
                      final sign = Sign(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        type: "Student",
                      );
                      final result =
                      await service.signUp(sign);
                      setState(() {
                        _isLoading = false;
                      });
                      final title = result.error
                          ? 'Sorry'
                          : 'Access Granted';
                      final text = result.error
                          ? (result.errorMessage ??
                          "Something went wrong.")
                          : "Account created successfully";
                      if (text == "Account created successfully") {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (__) => Home(email: _emailController.text,)));
                      } //end if
                      else {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(title),
                              content: Text(text),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Retry'),
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
                login: false,
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
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
