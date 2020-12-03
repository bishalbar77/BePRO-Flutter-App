import 'dart:convert';
import 'package:YnotV/Model/Login.dart';
import 'package:YnotV/Model/SearchUser.dart';
import 'package:YnotV/Model/SignUp.dart';
import 'package:YnotV/Model/User.dart';
import 'package:YnotV/Route/ApiResponse.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  static const API = 'http://ynotv.herokuapp.com/api';
  static const headers = {
    'Content-Type': 'application/json'
  };
  Future<ApiResponse<Login>> loginEmail(Login item) {
    print(json.encode(item.toJson()));
    return http.post(API + '/login-by-email' , headers: headers, body: json.encode(item.toJson())).then((data) async {
      if(data.statusCode==200)
      {
        print(data.statusCode);
        final jsonData = json.decode(data.body);
        return ApiResponse<Login>( data: Login.fromJson(jsonData) );
      }
      return ApiResponse<Login>(error: true, errorMessage: 'Sorry! Credentials not found.');
    })
        .catchError((_) => ApiResponse<Login>(error: true, errorMessage: 'No internet connection found'));
  }

  Future<ApiResponse<User>> userData(String userId) {
    return http.get(API + '/userData/${userId.replaceAll(new RegExp(r"\s+\b|\b\s"), "")}', headers: headers).then((data){
      if(data.statusCode==200) {
        final jsonData = json.decode(data.body);
        return ApiResponse<User>( data: User.fromJson(jsonData) );
      }
      return ApiResponse<User>(error: true, errorMessage: 'An error occurred. ' );
    })
        .catchError((_) => ApiResponse<User>(error: true, errorMessage: 'No internet connection found' ));
  }

  Future<ApiResponse<List<SearchUser>>> search() {
    return http.get(API + '/search', headers: headers).then((data){
      if(data.statusCode==200) {
        final jsonData = json.decode(data.body);
        final jobs = <SearchUser>[];
        for(var item in jsonData)
        {
          jobs.add(SearchUser.fromJson(item));
        }
        print(jobs);
        return ApiResponse<List<SearchUser>>( data: jobs );
      }
      return ApiResponse<List<SearchUser>>(error: true, errorMessage: 'An error occurred. ' );
    })
        .catchError((_) => ApiResponse<User>(error: true, errorMessage: 'No internet connection found' ));
  }

  Future<ApiResponse<Sign>> signUp(Sign item) {
    return http.post(API + '/signUp' , headers: headers, body: json.encode(item.toJson())).then((data) async {
      if(data.statusCode==200)
      {
        print(data.statusCode);
        final jsonData = json.decode(data.body);
        return ApiResponse<Sign>( data: Sign.fromJson(jsonData) );
      }
      return ApiResponse<Sign>(error: true, errorMessage: 'Something went wrong.');
    })
        .catchError((_) => ApiResponse<Sign>(error: true, errorMessage: 'No internet connection found'));
  }
}