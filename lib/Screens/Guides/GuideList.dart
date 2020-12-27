import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:YnotV/widgets/BottomNavigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'GuideProfile.dart';

class GuideList extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<GuideList> {
  List users = [];
  bool isLoading = false;
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
    _emailController.text = email;
    _typeController.text = type;

  }
  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/api/guides";
    var response = await http.get(url);
    print(response.body);
    if(response.statusCode == 200){
      var items = json.decode(response.body);
      setState(() {
        users = items;
        isLoading = false;
      });
    }else{
      users = [];
      isLoading = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guide List"),
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
    var fullName = item['name'];
    var email = item['email'];
    var profileUrl = "http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/images/done.png";
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
                      color: primary,
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
                    SizedBox(height: 10,),
                    Text(email.toString(),style: TextStyle(color: Colors.grey),)
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (__) => GuideProfile()));
        },
      ),
    );
  }
}