
import 'package:YnotV/Setting.dart';
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
    _urlController.text = url;
    _typeController.text = type;
    print("Hey");
    print(id);
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
    }else{
      print("upload failed");
    }
    nameContr.text = "";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post something amazing!'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                          choiceImage();
                        },
                      ),
                    ),
                ),
              ],
            ),
            Container(
              child: _image == null ? Text('') : Image.file(_image),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // image: DecorationImage(
                  //     image: new FileImage(_image),
                  //     fit: BoxFit.cover
                  // )
              ),
            ),
            RaisedButton(child: Text('Upload Image'),
              onPressed: (){
                upload(_image);
              },
              color: Colors.red,
              textColor: Colors.black,
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