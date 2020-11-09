import 'package:bepro/Screens/Login/login_screen.dart';
import 'package:bepro/Screens/Welcome/welcome_screen.dart';
import 'package:bepro/splash_screen2.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';


class SplashScreen1 extends StatefulWidget {
  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {

  @override
  void initState(){
    super.initState();

    _mockCheckForSession().then(
        (status) {
          if (status) {
            _navigateToHome();
          } else {
            _navigateToLogin();
          }
        }
    );
  }


  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 6000), () {});

    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => SplashScreen2()
      )
    );
  }

  void _navigateToLogin(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
                opacity: 1,
                child: Image.asset('assets/img/bggg.png',
                  fit: BoxFit.fill,),
            ),

            Shimmer.fromColors(
              period: Duration(milliseconds: 1500),
              baseColor: Color(0xFFF00000),
              highlightColor: Colors.purpleAccent,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "",
                  style: TextStyle(
                    fontSize: 90.0,
                    fontFamily: 'Pacifico',
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 18.0,
                        color: Colors.black87,
                        offset: Offset.fromDirection(120, 12)
                      )
                    ]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}