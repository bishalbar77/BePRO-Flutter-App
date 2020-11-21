import 'dart:convert';

import 'package:YnotV/Controller/UserController.dart';
import 'package:YnotV/Profile/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/User.dart';
import 'Screens/Login/login_screen.dart';

class Home extends StatefulWidget {
  final String email;
  Home({
    this.email
  });


  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  UserController get service =>  GetIt.I<UserController>();
  String errorMesaage;
  User user = new User();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    service.userData(widget.email)
        .then((response) async {
      setState(() {
        _isLoading = false;
      });
      if(response.error) {
        errorMesaage = response.errorMessage ?? 'Something went wrong';
      }
      user = response.data;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("name", user.name);
      localStorage.setString("id", user.ID.toString());
      localStorage.setString("email", user.email);
    });
    // _getUserInfo();
  }

  void _getUserInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString("email");
    if(email == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (__) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text("News Feed",
              style: TextStyle(
                color: Colors.white,
              )),
          backgroundColor: Colors.red,
        ),
        body: Container(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                      color: Colors.red,
                      ),
                title: Text('Home',
                    style: TextStyle(
                    color: Colors.red,
                    )),
                backgroundColor: Colors.red
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'),
                backgroundColor: Colors.red
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                title: Text('Post'),
                backgroundColor: Colors.red
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
                backgroundColor: Colors.red
            ),
          ],
          onTap: (index) {
            if(index==3) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (__) => Profile()));
            }
          },
        ),
      ),
    );
  }

}