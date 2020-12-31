import 'package:YnotV/Screens/Profile/ProfileScreen.dart';
import 'package:YnotV/Screens/Settings/Settings.dart';
import 'package:YnotV/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../constants.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  File _image;
  final picker = ImagePicker();
  TextEditingController nameContr = TextEditingController();

  Future choiceImage() async {
    final pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

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
    var phone = localStorage.getString("phone");
    _emailController.text = email;
    _nameController.text = name;
    _idController.text = id;
    _urlController.text = url ?? "http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/images/user.png";
    _typeController.text = type;
    _phoneController.text = phone;
    print(id);
    setState(() {
      _isLoading = false;
    });
  }
  Future upload(File imageFile) async {
    var uri = Uri.parse("http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/api/postStudentUserEdit");
    var request = http.MultipartRequest("POST",uri);
    request.fields['id'] = _idController.text;
    request.fields['name'] = _nameController.text;
    request.fields['phone'] = _phoneController.text;
    request.fields['email'] = _emailController.text;
    request.fields['password'] = _passwordController.text;
    var pic = await http.MultipartFile.fromPath("image", imageFile.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      Navigator.of(context)
          .push(MaterialPageRoute(
          builder: (__) => Profile()));
    }else{
      print("uploaded failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (__) => Profile()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      child: _image == null ? Image.network(_urlController.text) : Image.file(_image),
                    ) ?? Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.red,
                          ),
                          child: InkWell(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onTap: (){
                              choiceImage();
                            },
                          ),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(border: OutlineInputBorder(),
                    hintText: 'Name',
                    labelText: 'Name'
                ),
              ),
              Container(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(border: OutlineInputBorder(),
                    hintText: 'Email',
                    labelText: 'Email address'
                ),
              ),
              Container(height: 8),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone number',
                    labelText: 'Phone number',
                ),
              ),
              Container(height: 8),
              TextField(
                obscureText: showPassword,
                controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: "Password",
                    suffixIcon: showPassword
                        ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = false;
                        });
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.red,
                      ),
                    )
                        : IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = true;
                        });
                      },
                      icon: Icon(
                        Icons.visibility_off,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              Container(height: 8),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Profile()));
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      upload(_image);
                    },
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}