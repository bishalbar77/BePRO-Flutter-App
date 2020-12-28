import 'package:YnotV/Model/GuideDetails.dart';
import 'package:flutter/material.dart';
import 'package:YnotV/Controller/UserController.dart';
import 'package:get_it/get_it.dart';

class GuideProfile extends StatefulWidget {
  String email;
  GuideProfile({
    this.email
  });
  @override
  _GuideProfileState createState() => _GuideProfileState();
}

class _GuideProfileState extends State<GuideProfile> {
  UserController get service =>  GetIt.I<UserController>();
  TextEditingController _idController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController type = new TextEditingController();
  TextEditingController qualification = new TextEditingController();
  TextEditingController url = new TextEditingController();
  TextEditingController job = new TextEditingController();
  TextEditingController about = new TextEditingController();
  TextEditingController experience = new TextEditingController();
  TextEditingController company = new TextEditingController();
  String errorMesaage;
  GuideDetails user = new GuideDetails();
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    if(widget.email!=null)
    {
      print(widget.email);
      service.guideData(widget.email)
          .then((response) async {
        if(response.error) {
          errorMesaage = response.errorMessage ?? 'Something went wrong';
        }
        user = response.data;
        _nameController.text = user.name;
        _emailController.text = user.email;
        phone.text = user.phone;
        url.text = user.url ?? "http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/images/user.png";
        type.text = user.type;
        qualification.text = user.qualification;
        job.text = user.job;
        about.text = user.about;
        experience.text = user.experience;
        company.text = user.company;
        _idController.text = user.ID.toString();
        setState(() {
          _isLoading = false;
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
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
          : ListView(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.redAccent, Colors.pinkAccent]
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          url.text,
                        ),
                        radius: 50.0,
                        backgroundColor: Colors.redAccent,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        _nameController.text,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          about.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20.0,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Experience",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      experience.text,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Job Role:",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(job.text,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    "Company:",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(company.text,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    "Highest Qualification:",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(qualification.text,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,

            child: Padding(
              padding: const EdgeInsets.only(left: 35.0,top: 0.0,right: 35.0,bottom: 20.0),
              child: RaisedButton(
                  onPressed: (){},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)
                  ),
                  color: Colors.red,
                  elevation: 0.0,
                  padding: EdgeInsets.all(0.0),
                  child: InkWell(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 100.0, minHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text("Contact me",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight:FontWeight.w600),
                      ),
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}