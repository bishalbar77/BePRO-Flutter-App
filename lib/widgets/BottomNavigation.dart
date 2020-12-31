import 'package:YnotV/Screens/Chat/ChatHomepage.dart';
import 'package:YnotV/Screens/Guides/GuideList.dart';
import 'package:YnotV/Screens/PostFeed/PostNewDataFeed.dart';
import 'package:YnotV/Screens/PostFeed/PostNewsFeed.dart';
import 'package:YnotV/Screens/Profile/ProfileScreen.dart';
import 'package:YnotV/Screens/Search/SearchList.dart';
import 'package:YnotV/Screens/StudentRequest/StudentRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class BottomNavigation extends StatefulWidget {
  String email;
  BottomNavigation({
    this.email
  });
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  bool isLoading;

  void initState() {
    setState(() {
      isLoading = true;
    });
      _getUserInfo();
  }
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString("email");
    var type = localStorage.getString("type");
    setState(() {
      _emailController.text = email;
      _typeController.text = type;
      isLoading = false;
    });

    }
  @override
  Widget build(BuildContext context) {
    return isLoading ? BottomNavigationBar(
        items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.home,
            color: Colors.black,),
          title: Text('Home',
            style: TextStyle( color: Colors.black,),),
          backgroundColor: Colors.black
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.home,
            color: Colors.black,),
          title: Text('Home',
            style: TextStyle( color: Colors.black,),),
          backgroundColor: Colors.black
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.home,
            color: Colors.black,),
          title: Text('Home',
            style: TextStyle( color: Colors.black,),),
          backgroundColor: Colors.black
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.home,
            color: Colors.black,),
          title: Text('Home',
            style: TextStyle( color: Colors.black,),),
          backgroundColor: Colors.black
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.home,
            color: Colors.black,),
          title: Text('Home',
            style: TextStyle( color: Colors.black,),),
          backgroundColor: Colors.black
      ),
    ]) : (_typeController.text=='Student' ? BottomNavigationBar(
      currentIndex: 1,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home,
            color: Colors.black,),
            title: Text('Home',
              style: TextStyle( color: Colors.black,),),
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: Colors.black),
            title: Text('Search',
              style: TextStyle( color: Colors.black,),),
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_pin,
                color: Colors.black),
            title: Text('Guides',
              style: TextStyle( color: Colors.black,),),
            backgroundColor: Colors.red
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.inbox,
                color: Colors.black),
            title: Text('Inbox',
              style: TextStyle( color: Colors.black,),),
            backgroundColor: Colors.red
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: Colors.black),
            title: Text('Profile',
              style: TextStyle( color: Colors.black,),
            ),
            backgroundColor: Colors.red
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (__) => Home(email: widget.email,)));
        }
        else if (index == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (__) => SearchListPage()));
        }
        else if (index == 2) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (__) => GuideList()));
        }
        else if (index == 3) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (__) => ChatHomeScreen()));
        }
        else if (index == 4) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (__) => Profile()));
        }
        else {
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (__) => Home(email: widget.email,)));
        }
      },
    ) :
    BottomNavigationBar(
      currentIndex: 1,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home,
              color: Colors.black,),
            title: Text('Home',
              style: TextStyle( color: Colors.black,),),
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account_sharp,
                color: Colors.black),
            title: Text('Network',
              style: TextStyle( color: Colors.black,),),
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.camera,
                color: Colors.black),
            title: Text('Post',
              style: TextStyle( color: Colors.black,),),
            backgroundColor: Colors.red
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.inbox,
                color: Colors.black),
            title: Text('Inbox',
              style: TextStyle( color: Colors.black,),),
            backgroundColor: Colors.red
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: Colors.black),
            title: Text('Profile',
              style: TextStyle( color: Colors.black,),
            ),
            backgroundColor: Colors.red
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (__) => Home(email: widget.email,)));
        }
        else if (index == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (__) => StudentRequest()));
        }
        else if (index == 2) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (__) => UploadImage()));
        }
        else if (index == 3) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (__) => ChatHomeScreen()));
        }
        else if (index == 4) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (__) => Profile()));
        }
        else {
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (__) => Home(email: widget.email,)));
        }
      },
    )
    );
  }

  Widget BottomnNav(String email){

  }
}
