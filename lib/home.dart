import 'package:bepro/Profile/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

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