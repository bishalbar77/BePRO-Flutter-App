import 'package:YnotV/Screens/Chat/ChatHomepage.dart';
import 'package:YnotV/Screens/Search/SearchList.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:YnotV/Screens/EditProfile/EditProfile.dart';
import 'package:YnotV/Screens/Settings/Settings.dart';
import 'package:YnotV/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:YnotV/constants.dart';
import 'package:YnotV/widgets/profile_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';
import 'package:YnotV/home.dart';

class Profile extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kLightTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            home: ProfileScreen(),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
_ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {


  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  bool _isLoading = false;
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
    _emailController.text = email;
    _nameController.text = name;
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg",
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      child: Center(
                        heightFactor: kSpacingUnit.w * 1.5,
                        widthFactor: kSpacingUnit.w * 1.5,
                        child: Icon(
                          LineAwesomeIcons.pen,
                          color: kDarkPrimaryColor,
                          size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                        ),
                      ),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (__) => EditProfilePage()));
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            _nameController.text,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            _emailController.text,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Text(
                'Upgrade to PRO',
                style: kButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );

    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          crossFadeState:
          ThemeProvider.of(context).brightness == Brightness.dark
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
            child: Icon(
              LineAwesomeIcons.sun,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
            child: Icon(
              LineAwesomeIcons.moon,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
        );
      },
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        InkWell(
          child: Icon(
            LineAwesomeIcons.arrow_left,
            size: ScreenUtil().setSp(kSpacingUnit.w * 3),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (__) => Home(email: _emailController.text,)));
          },
        ),
        profileInfo,
        themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
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
                SizedBox(height: kSpacingUnit.w * 5),
                header,
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Help & Support',
                      ),
                      Container(
                        height: kSpacingUnit.w * 5.5,
                        margin: EdgeInsets.symmetric(
                          horizontal: kSpacingUnit.w * 4,
                        ).copyWith(
                          bottom: kSpacingUnit.w * 2,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: kSpacingUnit.w * 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                LineAwesomeIcons.cog,
                                size: kSpacingUnit.w * 2.5,
                              ),
                              SizedBox(width: kSpacingUnit.w * 1.5),
                              Text(
                                "Settings",
                                style: kTitleTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                LineAwesomeIcons.angle_right,
                                size: kSpacingUnit.w * 2.5,
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
                        height: kSpacingUnit.w * 5.5,
                        margin: EdgeInsets.symmetric(
                          horizontal: kSpacingUnit.w * 4,
                        ).copyWith(
                          bottom: kSpacingUnit.w * 2,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: kSpacingUnit.w * 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: InkWell(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  LineAwesomeIcons.user_plus,
                                  size: kSpacingUnit.w * 2.5,
                                ),
                                SizedBox(width: kSpacingUnit.w * 1.5),
                                Text(
                                  "Invite a Friend",
                                  style: kTitleTextStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  LineAwesomeIcons.angle_right,
                                  size: kSpacingUnit.w * 2.5,
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
                        height: kSpacingUnit.w * 5.5,
                        margin: EdgeInsets.symmetric(
                          horizontal: kSpacingUnit.w * 4,
                        ).copyWith(
                          bottom: kSpacingUnit.w * 2,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: kSpacingUnit.w * 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                LineAwesomeIcons.alternate_sign_out,
                                size: kSpacingUnit.w * 2.5,
                              ),
                              SizedBox(width: kSpacingUnit.w * 1.5),
                              Text(
                                "Logout",
                                style: kTitleTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                                Icon(
                                  LineAwesomeIcons.angle_right,
                                  size: kSpacingUnit.w * 2.5,
                                ),
                            ],
                          ),
                            onTap: () async {
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
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 4,
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
                    icon: Icon(Icons.inbox),
                    title: Text('Inbox'),
                    backgroundColor: Colors.red
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person,
                      color: Colors.red,),
                    title: Text('Profile',style: TextStyle(
                        color: Colors.red)
                      ),
                    backgroundColor: Colors.red
                ),
              ],
              onTap: (index) {
                if (index == 0) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (__) => Home(email: _emailController.text,)));
                }
                else if (index == 1) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (__) => SearchListPage()));
                }
                else if (index == 2) {}
                else if (index == 3) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (__) => ChatHomeScreen()));
                }
                else if (index == 4) {}
                else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (__) => Home(email: _emailController.text,)));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
