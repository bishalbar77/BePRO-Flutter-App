import 'dart:math';
import 'package:YnotV/Controller/UserController.dart';
import 'package:YnotV/Model/SearchUser.dart';
import 'package:YnotV/Route/ApiResponse.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = new TextEditingController();
  bool _isLoading = true;
  UserController get service =>  GetIt.I<UserController>();

  // String flattenPhoneNumber(String phoneStr) {
  //   return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
  //     return m[0] == "+" ? "+" : "";
  //   });
  // }
  ApiResponse<List<SearchUser>> _apiResponse;

  @override
  void initState() {
    _fetchJobs();
    super.initState();
  }

  _fetchJobs() async {
    setState(() {
      _isLoading = true;
    });
    print("hi 1");
    _apiResponse = await service.search();
    print("hi 1");
    setState(() {
      _isLoading =false;
    });
  }

  // getAllContacts() async {
  //   List colors = [
  //     Colors.green,
  //     Colors.indigo,
  //     Colors.yellow,
  //     Colors.orange
  //   ];
  //   int colorIndex = 0;
  //   List<Contact> _contacts = (await ContactsService.getContacts()).toList();
  //   _contacts.forEach((contact) {
  //     Color baseColor = colors[colorIndex];
  //     contactsColorMap[contact.displayName] = baseColor;
  //     colorIndex++;
  //     if (colorIndex == colors.length) {
  //       colorIndex = 0;
  //     }
  //   });
  //   setState(() {
  //     contacts = _contacts;
  //   });
  // }
  //
  // filterContacts() {
  //   List<Contact> _contacts = [];
  //   _contacts.addAll(contacts);
  //   if (searchController.text.isNotEmpty) {
  //     _contacts.retainWhere((contact) {
  //       String searchTerm = searchController.text.toLowerCase();
  //       String searchTermFlatten = flattenPhoneNumber(searchTerm);
  //       String contactName = contact.displayName.toLowerCase();
  //       bool nameMatches = contactName.contains(searchTerm);
  //       if (nameMatches == true) {
  //         return true;
  //       }
  //
  //       if (searchTermFlatten.isEmpty) {
  //         return false;
  //       }
  //
  //       var phone = contact.phones.firstWhere((phn) {
  //         String phnFlattened = flattenPhoneNumber(phn.value);
  //         return phnFlattened.contains(searchTermFlatten);
  //       }, orElse: () => null);
  //
  //       return phone != null;
  //     });
  //   }
  //   setState(() {
  //     contactsFiltered = _contacts;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor
                        )
                    ),
                    prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor
                    )
                ),
              ),
            ),
            ListView.separated(
          itemBuilder:(__, index) {
            return Dismissible(
              key: ValueKey(_apiResponse.data[index].name),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {

              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 16),
                child: Align(child: Icon(Icons.delete, color: Colors.white,), alignment: Alignment.centerLeft,),
              ),
              child: ListTile(
                title: Text(_apiResponse.data[index].name, style: TextStyle(color: Theme.of(context).primaryColor),),
                subtitle: Text('${_apiResponse.data[index].email}'),
                onTap: () {},
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
          itemCount: _apiResponse.data.length)
          ],
        ),
      ),
    );
  }
}


