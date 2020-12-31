import 'package:YnotV/widgets/BottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostNewsFeed extends StatefulWidget {
  @override
  _PostNewsFeedState createState() => _PostNewsFeedState();
}

class _PostNewsFeedState extends State<PostNewsFeed> {


  bool _isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  File _image;
  final picker = ImagePicker();
  TextEditingController nameContr = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, bottom: 8),
              child: Row(
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
                                image: NetworkImage(_urlController.text),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_nameController.text, style: TextStyle(color: Colors.grey[900],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),),
                          SizedBox(height: 3,),
                          Text("What's in your mind?",
                            style: TextStyle(fontSize: 15, color: Colors.grey),),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: nameContr,
                      keyboardType: TextInputType.multiline,
                      minLines: 2,//Normal textInputField will be displayed
                      maxLines: 3,// when user presses enter it
                      decoration: new InputDecoration(
                        labelText: "Tell your students what new they can learn!",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Flexible(
                    flex: 1,
                    child: IconButton(icon: Icon(Icons.camera),
                      onPressed: (){
                      },
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: Text('Post'),
              textColor: Colors.white,
              onPressed: (){
              },
              color: Colors.red,
              splashColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(email: _emailController.text,),
    );
  }
}
