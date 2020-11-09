import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bepro/Screens/Welcome/components/body.dart';

import '../../Setting.dart';

class WelcomeScreen extends StatelessWidget {
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
