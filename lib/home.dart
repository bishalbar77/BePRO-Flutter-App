import 'dart:convert';

import 'package:bepro/Controller/UserController.dart';
import 'package:bepro/Profile/ProfileScreen.dart';
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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    // checkSession();
    super.initState();
    setState(() {
      _isLoading = true;
    });
    service.userData(widget.email)
        .then((response) async {
      setState(() {
        _isLoading = false;
      });
      user = response.data;
      _idController.text = user.ID.toString();
      _nameController.text = user.name;
      _emailController.text = user.email;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("name", user.name);
      localStorage.setString("id", user.ID.toString());
      localStorage.setString("email", user.email);
      localStorage.setString("user", json.encode(user));
    });

    _getUserInfo();
  }

  void _getUserInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString("email");
    if(email == null) {
      print("the email 99 line "+email);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (__) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Feed"),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (__) => Profile()));
        },
      ),
    );
  }

}