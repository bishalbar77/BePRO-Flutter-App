import 'dart:convert';

import 'package:YnotV/Controller/UserController.dart';
import 'package:YnotV/Model/Connections.dart';
import 'package:YnotV/Model/TutorDetails.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
String widgetText;
// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  String email;
  ProfilePage({
    this.email
  });
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isOpen = false;
  UserController get service =>  GetIt.I<UserController>();
  UserController get service2 =>  GetIt.I<UserController>();
  UserController get serviceForConnection =>  GetIt.I<UserController>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController loggedInUserID = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController skills = TextEditingController();
  TextEditingController fees = TextEditingController();
  TextEditingController upi = TextEditingController();
  TextEditingController request_send = TextEditingController();
  TextEditingController request_accepted = TextEditingController();
  TextEditingController is_subscribed = TextEditingController();
  TextEditingController is_paid = TextEditingController();
  TextEditingController on_trail = TextEditingController();
  TextEditingController sliderText = TextEditingController();
  String errorMessage;
  TutorDetails user = new TutorDetails();
  Connections connect = new Connections();
  Connections afterCheckDetails = new Connections();
  bool _isLoading = true;
  var _imageList = [];

  _getLoggedInUserDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final loggedInID = localStorage.getString("id");
    loggedInUserID.text = loggedInID;
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    super.initState();
    _getLoggedInUserDetails();
    fetchUser();
    sliderText.text = "CONNECT";
    if(widget.email!=null)
    {
        service.tutorData(widget.email)
            .then((response) {
          if (response.error) {
            errorMessage = response.errorMessage ?? 'Something went wrong';
          }
          user = response.data;
          setState(() {
            _idController.text = user.ID.toString();
            _nameController.text = user.name;
            _phoneController.text = user.phone;
            _urlController.text = user.url;
            qualification.text = user.qualification;
            title.text = user.title;
            address.text = user.address;
            job.text = user.job;
            company.text = user.company;
            skills.text = user.skills;
            fees.text = user.fees;
            upi.text = user.upi;
            _connectionCheck(_idController.text);
          });
        });
    }
  }


  _connectionCheck(String ID) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final loggedInID = localStorage.getString("id");
    loggedInUserID.text = loggedInID;
    setState(() {
      final check = Connections(
        tutor_id: ID,
        student_id: loggedInUserID.text,
      );
      serviceForConnection.checkConnectionType(check)
          .then((response) {
        afterCheckDetails = response.data;
        setState(() {
          request_send.text = afterCheckDetails.request_send;
          request_accepted.text = afterCheckDetails.request_accepted;
          is_paid.text = afterCheckDetails.is_paid;
          on_trail.text = afterCheckDetails.on_trail;
          is_subscribed.text = afterCheckDetails.is_subscribed;
        });
        if(afterCheckDetails.tutor_id!=null)
          {
            if(request_send.text=='1')
              {
                sliderText.text = "REQUESTED";
              }
            if(request_accepted.text=='1')
              {
                sliderText.text = "MESSAGE";
              }
              if(is_subscribed.text=='1')
              {
                sliderText.text = "MESSAGE";
              }
          }
      });
      setState(() {
        _isLoading = false;
      });
    });

  }

  PanelController _panelController = PanelController();
  fetchUser() async {
    var url = "http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/api/getTutorNewsFeed/2";
    var response = await http.get(url);
    if(response.statusCode == 200){
      var items = json.decode(response.body);
      for(int index=0;items[index]!=null;index++)
      {
        _imageList.add(items[index]['url']);
      }
    }
  }

  /// **********************************************
  /// LIFE CYCLE METHODS
  /// **********************************************
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Container(
        color: Colors.white70.withOpacity(0.3),
        width: MediaQuery.of(context).size.width, //70.0,
        height: MediaQuery.of(context).size.height, //70.0,
        child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Center(child: new CircularProgressIndicator())),
      )
          : Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.7,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_urlController.text),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.3,
            child: Container(
              color: Colors.white,
            ),
          ),

          /// Sliding Panel
          SlidingUpPanel(
            controller: _panelController,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
            ),
            minHeight: MediaQuery.of(context).size.height * 0.35,
            maxHeight: MediaQuery.of(context).size.height * 0.85,
            body: GestureDetector(
              onTap: () => _panelController.close(),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            panelBuilder: (ScrollController controller) =>
                _panelBody(controller),
            onPanelSlide: (value) {
              if (value >= 0.2) {
                if (!_isOpen) {
                  setState(() {
                    _isOpen = true;
                  });
                }
              }
            },
            onPanelClosed: () {
              setState(() {
                _isOpen = false;
              });
            },
          ),
        ],
      ),
    );
  }

  /// **********************************************
  /// WIDGETS
  /// **********************************************
  /// Panel Body
  SingleChildScrollView _panelBody(ScrollController controller) {
    double hPadding = 40;

    return SingleChildScrollView(
      controller: controller,
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: hPadding),
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _titleSection(),
                _infoSection(),
                _actionSection(hPadding: hPadding),
              ],
            ),
          ),
          GridView.builder(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: _imageList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (BuildContext context, int index) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_imageList[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Action Section
  Row _actionSection({double hPadding}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Visibility(
          visible: !_isOpen,
          child: Expanded(
            child: OutlineButton(
              onPressed: () => _panelController.open(),
              borderSide: BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                'VIEW PROFILE',
                style: TextStyle(
                  fontFamily: 'NimbusSanL',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !_isOpen,
          child: SizedBox(
            width: 16,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: _isOpen
                  ? (MediaQuery.of(context).size.width - (2 * hPadding)) / 1.6
                  : double.infinity,
              child: FlatButton(
                onPressed: () async {
                  if(sliderText.text=='CONNECT')
                    {
                    setState(() {
                        _isLoading = true;
                    });
                    final connect = Connections(
                      tutor_id: _idController.text,
                      student_id: loggedInUserID.text,
                    );
                    final result = await service2.setConnection(connect);
                    setState(() {
                      // ignore: unnecessary_statements
                      sliderText.text="REQUESTED";
                      _isLoading = false;
                    });
                   }
                  if(sliderText.text=='REQUESTED')
                    {
                      print("wait");
                    }
                  if(sliderText.text=='MESSAGE')
                  {
                    print("CHAT BOX");
                  }
                },
                color: Colors.red,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  sliderText.text,
                  style: TextStyle(
                    fontFamily: 'NimbusSanL',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Info Section
  Row _infoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _infoCell(title: 'Courses', value: '1'),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey,
        ),
        _infoCell(title: 'Monthly Rate', value: "Rs. "+fees.text),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey,
        ),
        _infoCell(title: 'Course type', value: 'Online'),
      ],
    );
  }

  /// Info Cell
  Column _infoCell({String title, String value}) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  /// Title Section
  Column _titleSection() {
    return Column(
      children: <Widget>[
        Text(
          _nameController.text,
          style: TextStyle(
            fontFamily: 'NimbusSanL',
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          title.text,
          style: TextStyle(
            fontFamily: 'NimbusSanL',
            fontStyle: FontStyle.italic,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose(); // always call super for dispose/initState
  }
}