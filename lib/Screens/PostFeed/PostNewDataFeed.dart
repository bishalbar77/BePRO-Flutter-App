import 'package:YnotV/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {


  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  bool _isLoading = false;
  File _image;
  final picker = ImagePicker();
  TextEditingController nameContr = TextEditingController();
  Future choiceImage()async{
    final pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  @override
  void initState() {
    _getUserInfo();
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
    var url = localStorage.getString("url") ?? "http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/images/user.png";
    var type = localStorage.getString("type");
    _emailController.text = email;
    _nameController.text = name;
    _idController.text = id;
    _urlController.text = url;
    _typeController.text = type;
    if(_typeController.text=="Student")
      {
        Navigator.of(context)
            .push(MaterialPageRoute(
            builder: (__) => Home(email: _emailController.text,)));
      }
    setState(() {
      _isLoading = false;
    });
  }

  Future upload(File imageFile)async{
    var uri = Uri.parse("http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/api/postNewsFeed");
    var request = http.MultipartRequest("POST",uri);
    request.fields['id'] = _idController.text;
    request.fields['caption'] = nameContr.text;
    var pic = await http.MultipartFile.fromPath("image", imageFile.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      Navigator.of(context)
          .push(MaterialPageRoute(
          builder: (__) => Home(email: _emailController.text,)));
    }
    nameContr.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post something amazing!'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, bottom: 8),
              child: Row(
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
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: nameContr,
                      keyboardType: TextInputType.multiline,
                      minLines: 2,//Normal textInputField will be displayed
                      maxLines: 3,// when user presses enter it
                      decoration: new InputDecoration(
                        labelText: "Tell your students what new they can learn!\n\n",
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
                Flexible(
                  flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right:10.0,left: 10.0),
                      child: IconButton(icon: Icon(Icons.camera),
                        onPressed: (){
                          choiceImage();
                        },
                      ),
                    ),
                  ),
              ],
            ),
            Container(
              height: 250,
              child: _image == null ? Text('') : Image.file(_image),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // image: DecorationImage(
                  //     image: new FileImage(_image),
                  //     fit: BoxFit.cover
                  // )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 28.0,left: 28.0),
              child: RaisedButton(
                child: Text('Post'),
                textColor: Colors.white,
                onPressed: (){
                  upload(_image);
                },
                color: Colors.red,
                splashColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(email: _emailController.text,),
    );
  }
}