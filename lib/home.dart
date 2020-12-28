import 'dart:convert';
import 'package:YnotV/Controller/UserController.dart';
import 'package:YnotV/Model/NewsFeed.dart';
import 'package:YnotV/Screens/Search/SearchList.dart';
import 'package:YnotV/widgets/BottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:YnotV/Model/User.dart';
import 'Route/ApiResponse.dart';
import 'Screens/Login/login_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class Home extends StatefulWidget {
  String email;
  Home({
    this.email
  });


  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  UserController get service => GetIt.I<UserController>();
  UserController get service2 => GetIt.I<UserController>();
  String errorMesaage;
  String loader = null;
  User user = new User();
  bool _isLoading = true;
  ApiResponse<List<NewsFeed>> _apiResponse ;

  void initState() {
    loader==null;
    super.initState();
    setState(() {
      _isLoading = true;
    });
    if (widget.email != null) {
      service.userData(widget.email)
          .then((response) async {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMesaage = response.errorMessage ?? 'Something went wrong';
        }
        user = response.data;
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString("name", user.name);
        localStorage.setString("id", user.ID.toString());
        localStorage.setString("email", user.email);
        localStorage.setString("type", user.type);
        localStorage.setString("phone", user.phone);
        localStorage.setString("url", user.url);
      });
    }
    else {
      _getUserInfo();
    }
    _newsFeedsDate();
  }

  void _newsFeedsDate() async {
    // ignore: missing_return
    _apiResponse = await service2.newsFeed();
    setState(() {
      _isLoading =false;
    });
    loader = "done";
  }
  void _getUserInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString("email");
    if (email == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (__) => LoginScreen()));
    }
    else {
      setState(() async {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text("News Feed",
              style: TextStyle(
                color: Colors.white,
              )),
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search, color: Colors.white,),
                onPressed: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(builder: (__) => SearchListPage()));
                }),
          ],
        ),
        body: loader==null ? Container(
          color: Colors.white70.withOpacity(0.3),
          width: MediaQuery.of(context).size.width, //70.0,
          height: MediaQuery.of(context).size.height, //70.0,
          child: new Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Center(child: new CircularProgressIndicator())),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (int i = 0; i < (_apiResponse.data!=null?_apiResponse.data.length:0); i++)
                        makeFeed(
                            userName: _apiResponse.data[i].name,
                            userImage: _apiResponse.data[i].image,
                            feedTime: "5 secs",
                            feedText: _apiResponse.data[i].caption,
                            feedImage: _apiResponse.data[i].url
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigation(email: widget.email,),
      ),
    );
  }

  Widget makeFeed({userName, userImage, feedTime, feedText, feedImage}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(userImage),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(userName, style: TextStyle(color: Colors.grey[900],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),),
                      SizedBox(height: 3,),
                      Text(feedTime,
                        style: TextStyle(fontSize: 15, color: Colors.grey),),
                    ],
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz, size: 30, color: Colors.grey[600],),
                onPressed: () {},
              )
            ],
          ),
          SizedBox(height: 20,),
          Text(feedText, style: TextStyle(fontSize: 15,
              color: Colors.grey[800],
              height: 1.5,
              letterSpacing: .7),),
          SizedBox(height: 20,),
          feedImage != '' ?
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(feedImage),
                    fit: BoxFit.cover
                )
            ),
          ) : Container(),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  makeLike(),
                  Transform.translate(
                      offset: Offset(-5, 0),
                      child: makeLove()
                  ),
                  SizedBox(width: 5,),
                  Text("2.5K",
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),)
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              makeLikeButton(isActive: true),
            ],
          )
        ],
      ),
    );
  }

  Widget makeLike() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)
      ),
      child: Center(
        child: Icon(Icons.thumb_up, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeLove() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)
      ),
      child: Center(
        child: Icon(Icons.favorite, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeLikeButton({isActive}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.thumb_up, color: isActive ? Colors.blue : Colors.grey,
              size: 18,),
            SizedBox(width: 5,),
            Text("Like",
              style: TextStyle(color: isActive ? Colors.blue : Colors.grey),)
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }

}
