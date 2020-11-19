import 'package:bepro/Controller/UserController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bepro/Screens/Welcome/components/body.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Setting.dart';
import '../../home.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var userData;
  UserController get service => GetIt.I<UserController>();
  bool _isLoading = false;

  @override
  void initState() {
    _getUserInfo();
    // TODO: implement initState
    super.initState();
  }
  void _getUserInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString("email");
    setState(() {
      userData = email;
    });
    if (userData != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (__) => Home()));
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:true,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black, size: 10.0),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              width: 300.0;
              return Setting.choices.map((String choice){
              width: 300.0;
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice,
                    textAlign: TextAlign.center,),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Body(),
    );
  }
  void choiceAction(String choice){
    if(choice == Setting.About){
      print('About us');
    }else if(choice == Setting.Contact){
      print('Website');
    }else if(choice == Setting.Website){
      print('Contact us');
    }
  }
}
