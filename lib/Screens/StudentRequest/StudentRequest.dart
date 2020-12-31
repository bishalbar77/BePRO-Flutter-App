import 'dart:convert';

import 'package:YnotV/Controller/UserController.dart';
import 'package:YnotV/Model/Connections.dart';
import 'package:flutter/material.dart';
import 'package:YnotV/widgets/BottomNavigation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

TextEditingController _idController = TextEditingController();
class StudentRequest extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<StudentRequest> {
  List users = [];
  bool isLoading = false;
  UserController get service =>  GetIt.I<UserController>();
  UserController get service2 =>  GetIt.I<UserController>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
    _getUserInfo();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString("email");
    var type = localStorage.getString("type");
    var id = localStorage.getString("id");
    _emailController.text = email;
    _typeController.text = type;
    _idController.text = id;

  }
  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/api/getConnectionRequest/" + _idController.text;
    var response = await http.get(url);
    if(response.statusCode == 200){
      var items = json.decode(response.body);
      setState(() {
        users = items;
        isLoading = false;
      });
    }else{
      users = [];
      setState(() {
      isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage your connections"),
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigation(email: _emailController.text,),
    );
  }
  Widget getBody(){
    if(users.contains(null) || users.length < 0 || isLoading){
      return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(primary),));
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
          return getCard(users[index]);
        });
  }
  Widget getCard(item){
    var tutorID = item['tutor_id'];
    var studentID = item['student_id'];
    var fullName = item['name'];
    var email = item['email'];
    var profileUrl = item['url'] ?? "http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/images/user.png";
    return Card(
      elevation: 1.5,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(60/2),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(profileUrl)
                      )
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width-140,
                        child: Text(fullName,style: TextStyle(fontSize: 17),)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Row(
                          children: <Widget> [
                            Expanded(child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black54)
                            ),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                final connect = Connections(
                                  tutor_id: tutorID,
                                  student_id: studentID,
                                );
                                final result = await service2.acceptConnectionRequest(connect);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (__) => StudentRequest()));
                              },
                              child: Text("Accept"),
                              color: Colors.blue,
                              textColor: Colors.white,
                              )
                            ),
                            SizedBox(width: 8),
                            Expanded(child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black54)
                              ),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                final connect = Connections(
                                  tutor_id: tutorID,
                                  student_id: studentID,
                                );
                                final result = await service.deleteConnectionRequest(connect);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (__) => StudentRequest()));
                              },
                              child: Text("Not Now"),
                              color: Colors.red,
                              textColor: Colors.white,
                            )
                            ),
                          ],
                        ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}