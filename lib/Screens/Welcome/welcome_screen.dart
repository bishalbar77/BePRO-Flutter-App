import 'package:YnotV/Controller/UserController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:YnotV/Screens/Welcome/components/body.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Setting.dart';
import '../../home.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var email;
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
    if (email != null) {
      print("Email: -"+email);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (__) => Home(email: email,)));
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
      color: Colors.white70.withOpacity(0.3),
      width: MediaQuery.of(context).size.width, //70.0,
      height: MediaQuery.of(context).size.height, //70.0,
      child: new Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Center(child: new CircularProgressIndicator())),
    )
        : WillPopScope(
            onWillPop: () {
              print('Backbutton pressed (device or appbar button), do whatever you want.');
            Navigator.pop(context, false);
            return Future.value(false);
      },
      child: Scaffold(
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
                    child: InkWell(
                      child: Text(choice,
                        textAlign: TextAlign.center,),
                      onTap: () {
                        _launchURL();
                      },
                    ),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: Body(),
      ),
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
  _launchURL() async {
    const url = 'https://www.ynotv.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
