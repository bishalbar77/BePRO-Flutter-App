import 'package:YnotV/Screens/Chat/ChatHomepage.dart';
import 'package:YnotV/Screens/EditProfileGuide/EditProfile.dart';
import 'package:YnotV/Screens/EditProfileTutor/EditProfile.dart';
import 'package:YnotV/Screens/Search/SearchList.dart';
import 'package:YnotV/widgets/BottomNavigation.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:YnotV/Screens/EditProfile/EditProfile.dart';
import 'package:YnotV/Screens/Settings/Settings.dart';
import 'package:YnotV/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:YnotV/widgets/profile_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';
import 'package:YnotV/home.dart';

class Profile extends StatefulWidget {
  // This widget is the root of your application.

_ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<Profile> {

  bool _isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
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
    var name = localStorage.getString("name");
    var id = localStorage.getString("id");
    var url = localStorage.getString("url");
    var type = localStorage.getString("type");
    _emailController.text = email;
    _nameController.text = name;
    _idController.text = id;
    _urlController.text = url ?? 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png';
    _typeController.text = type;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(top: 40),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    _urlController.text,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.red.shade900,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      child: Center(
                        heightFactor: 5.5,
                        widthFactor: 5.5,
                        child: Icon(
                          LineAwesomeIcons.pen,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                        onTap: () {
                          if(_typeController.text=="Guide")
                            {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (__) => EditGuidesProfilePage()));
                            }
                          else if (_typeController.text=="Tutor")
                            {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (__) => EditTutorProfilePage()));
                            }
                          else {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (__) => EditProfilePage()));
                          }
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(
            _nameController.text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5.5),
          Text(
            _emailController.text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 30,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red.shade900,
            ),
            child: Center(
              child: Text(
                'Upgrade to PRO',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:18.0),
          child: SizedBox(width: 15),
        ),
        InkWell(
          child: Icon(
            LineAwesomeIcons.arrow_left,
            size: 25,
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (__) => Home(email: _emailController.text,)));
          },
        ),
        profileInfo,
        SizedBox(width: 15),
      ],
    );

    return Scaffold(
          body:  _isLoading
              ? Container(
            color: Colors.white70.withOpacity(0.3),
            width: MediaQuery.of(context).size.width, //70.0,
            height: MediaQuery.of(context).size.height, //70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
              : Column(
            children: <Widget>[
              SizedBox(height: 40),
              header,
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(
                        horizontal: 35,
                      ).copyWith(
                        bottom: 15,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                LineAwesomeIcons.question_circle,
                                size: 25,
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Help & Support",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'SFProText',
                                ),
                              ),
                              Spacer(),
                              Icon(
                                LineAwesomeIcons.angle_right,
                                size: 25,
                              ),
                            ],
                          ),
                          onTap: () async {}
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(
                        horizontal: 35,
                      ).copyWith(
                        bottom: 15,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: InkWell(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              LineAwesomeIcons.cog,
                              size: 25,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Settings",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'SFProText',
                              ),
                            ),
                            Spacer(),
                            Icon(
                              LineAwesomeIcons.angle_right,
                              size: 25,
                            ),
                          ],
                        ),
                          onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (__) => SettingsPage()));
                      }
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(
                        horizontal: 35,
                      ).copyWith(
                        bottom: 15,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                LineAwesomeIcons.user_circle,
                                size: 25,
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Terms & conditions",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'SFProText',
                                ),
                              ),
                              Spacer(),
                              Icon(
                                LineAwesomeIcons.angle_right,
                                size: 25,
                              ),
                            ],
                          ),
                          onTap: () {}
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(
                        horizontal: 35,
                      ).copyWith(
                        bottom: 15,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                LineAwesomeIcons.lock,
                                size: 25,
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'SFProText',
                                ),
                              ),
                              Spacer(),
                              Icon(
                                LineAwesomeIcons.angle_right,
                                size: 25,
                              ),
                            ],
                          ),
                          onTap: () async {}
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(
                        horizontal: 35,
                      ).copyWith(
                        bottom: 15,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                LineAwesomeIcons.user_plus,
                                size: 25,
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Invite a Friend",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'SFProText',
                                ),
                              ),
                              Spacer(),
                              Icon(
                                LineAwesomeIcons.angle_right,
                                size: 25,
                              ),
                            ],
                          ),
                          onTap: () {
                            final RenderBox box = context.findRenderObject();
                            Share.share('http://ynotv.herokuapp.com/',
                                subject: "A new way of learning.",
                                sharePositionOrigin:
                                box.localToGlobal(Offset.zero) &
                                box.size);
                          }
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(
                        horizontal: 35,
                      ).copyWith(
                        bottom: 15,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                LineAwesomeIcons.alternate_sign_out,
                                size: 25,
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'SFProText',
                                ),
                              ),
                              Spacer(),
                              Icon(
                                LineAwesomeIcons.angle_right,
                                size: 25,
                              ),
                            ],
                          ),
                          onTap: () async {
                            super.dispose();
                            SharedPreferences preferences = await SharedPreferences.getInstance();
                            await preferences.clear();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (__) => WelcomeScreen()));
                          }
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        bottomNavigationBar: BottomNavigation(email: _emailController.text,),
        );
  }
}
