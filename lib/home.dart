import 'dart:convert';
import 'package:YnotV/Controller/UserController.dart';
import 'package:YnotV/Screens/Search/SearchList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:YnotV/Model/User.dart';
import 'Screens/Chat/ChatHomepage.dart';
import 'Screens/Login/login_screen.dart';
import 'Screens/PostFeed/PostFeed.dart';
import 'Screens/Profile/ProfileScreen.dart';
import 'package:video_player/video_player.dart';


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
  String errorMesaage;
  User user = new User();
  bool _isLoading = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
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
      });
    }
    else {
      _getUserInfo();
    }
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
      setState(() {
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
        body: Column(
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
                      SizedBox(height: 20,),
                      makeFeed(
                          userName: 'Aiony Haust',
                          userImage: 'assets/images/aiony-haust.jpg',
                          feedTime: '1 hr ago',
                          feedText: 'All the Lorem Ipsum generators on the Internet tend to repeat predefined.',
                          feedImage: 'assets/images/azamat-zhanisov.jpg'
                      ),
                      makeFeed(
                          userName: 'Azamat Zhanisov',
                          userImage: 'assets/images/azamat-zhanisov.jpg',
                          feedTime: '3 mins ago',
                          feedText: "All the Lorem Ipsum generators on the Internet tend to repeat predefined.",
                          feedImage: 'assets/images/averie-woodard.jpg'
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                  color: Colors.red,
                ),
                title: Text('Home',
                    style: TextStyle(
                      color: Colors.red,
                    )),
                backgroundColor: Colors.red
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'
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
            if (index == 0) {}
            else if (index == 1) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (__) => SearchListPage()));
            }
            else if (index == 2) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (__) => PostFeed()));
            }
            else if (index == 3) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (__) => ChatHomeScreen()));
            }
            else if (index == 4) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (__) => Profile()));
            }
            else {}
          },
        ),
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
                            image: AssetImage(userImage),
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
                    image: AssetImage(feedImage),
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

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;


  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

}
