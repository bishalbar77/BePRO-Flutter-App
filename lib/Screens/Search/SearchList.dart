import 'dart:convert';

import 'package:YnotV/Model/SearchUser.dart';
import 'package:YnotV/Screens/Chat/ChatHomepage.dart';
import 'package:YnotV/Screens/Profile/ProfileScreen.dart';
import 'package:YnotV/Screens/TutorProfile/TutorProfile.dart';
import 'package:YnotV/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchListPage extends StatefulWidget {

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchListPage> {

  List<SearchUser> _notes = List<SearchUser>();
  List<SearchUser> _notesForDisplay = List<SearchUser>();
  static var email;
  Future<List<SearchUser>> fetchNotes() async {
    var url = 'http://ynotv.herokuapp.com/api/search';
    var response = await http.get(url);

    var notes = List<SearchUser>();

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    email = localStorage.getString("email");
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(SearchUser.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : _listItem(index-1);
          },
          itemCount: _notesForDisplay.length+1,
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
              ),
              title: Text('Home',
                  style: TextStyle(
                  )),
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                color: Colors.red,),
              title: Text('Search',
                  style: TextStyle(
                      color: Colors.red
                  )
              ),
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text('Post'),
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.inbox),
              title: Text('Inbox'),
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile',
              ),
              backgroundColor: Colors.red
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context)
                .push(MaterialPageRoute(
                builder: (__) => Home(email: email,)));
          }
          else if (index == 1) {}
          else if (index == 2) {}
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
                builder: (__) => Home(email: email,)));
          }
        },
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.grey,),
            hintText: 'Search...'
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((note) {
              var noteTitle = note.name.toLowerCase();
              var noteEmail = note.email.toLowerCase();
              return noteTitle.contains(text) || noteEmail.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _notesForDisplay[index].name,
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                _notesForDisplay[index].email,
                style: TextStyle(
                    color: Colors.grey.shade600
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (__) => ProfilePage(email: _notesForDisplay[index].email,)));
          },
        ),
      ),
    );
  }
}