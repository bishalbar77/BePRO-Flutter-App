import 'dart:convert';
import 'package:YnotV/Model/Connections.dart';
import 'package:YnotV/Model/GuideDetails.dart';
import 'package:YnotV/Model/Login.dart';
import 'package:YnotV/Model/NewsFeed.dart';
import 'package:YnotV/Model/SearchUser.dart';
import 'package:YnotV/Model/SignUp.dart';
import 'package:YnotV/Model/TutorDetails.dart';
import 'package:YnotV/Model/User.dart';
import 'package:YnotV/Route/ApiResponse.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  static const API = 'http://ynotv2-env.eba-exq3jn5q.ap-south-1.elasticbeanstalk.com/api';
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

  Future<ApiResponse<GuideDetails>> guideData(String userId) {
    return http.get(API + '/guideData/${userId.replaceAll(new RegExp(r"\s+\b|\b\s"), "")}', headers: headers).then((data){
      if(data.statusCode==200) {
        final jsonData = json.decode(data.body);
        return ApiResponse<GuideDetails>( data: GuideDetails.fromJson(jsonData) );
      }
      return ApiResponse<GuideDetails>(error: true, errorMessage: 'An error occurred. ' );
    })
        .catchError((_) => ApiResponse<GuideDetails>(error: true, errorMessage: 'No internet connection found' ));
  }

  Future<ApiResponse<TutorDetails>> tutorData(String userId) {
    return http.get(API + '/tutorData/${userId.replaceAll(new RegExp(r"\s+\b|\b\s"), "")}', headers: headers).then((data){
      if(data.statusCode==200) {
        final jsonData = json.decode(data.body);
        return ApiResponse<TutorDetails>( data: TutorDetails.fromJson(jsonData) );
      }
      return ApiResponse<TutorDetails>(error: true, errorMessage: 'An error occurred. ' );
    })
        .catchError((_) => ApiResponse<TutorDetails>(error: true, errorMessage: 'No internet connection found' ));
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

  Future<ApiResponse<List<NewsFeed>>> newsFeed() {
    return http.get(API + '/getNewsFeed', headers: headers).then((data){
      if(data.statusCode==200) {
        final jsonData = json.decode(data.body);
        final jobs = <NewsFeed>[];
        for(var item in jsonData)
        {
          jobs.add(NewsFeed.fromJson(item));
        }
        print(jobs);
        return ApiResponse<List<NewsFeed>>( data: jobs );
      }
      return ApiResponse<List<NewsFeed>>(error: true, errorMessage: 'An error occurred. ' );
    })
        .catchError((_) => ApiResponse<List<NewsFeed>>(error: true, errorMessage: 'No internet connection found' ));
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

  Future<ApiResponse<Connections>> setConnection(Connections item) {
    return http.post(API + '/establish-connection' , headers: headers, body: json.encode(item.toJson())).then((data) async {
      if(data.statusCode==200)
      {
        print(data.statusCode);
        final jsonData = json.decode(data.body);
        return ApiResponse<Connections>( data: Connections.fromJson(jsonData) );
      }
      return ApiResponse<Connections>(error: true, errorMessage: 'Something went wrong.');
    })
        .catchError((_) => ApiResponse<Connections>(error: true, errorMessage: 'No internet connection found'));
  }

  Future<ApiResponse<Connections>> checkConnectionType(Connections item) {
    return http.post(API + '/tutorProfileConnectionRequest' , headers: headers, body: json.encode(item.toJson())).then((data) async {
      if(data.statusCode==200)
      {
        final jsonData = json.decode(data.body);
        return ApiResponse<Connections>( data: Connections.fromJson(jsonData) );
      }
      return ApiResponse<Connections>(error: true, errorMessage: 'Something went wrong.');
    })
        .catchError((_) => ApiResponse<Connections>(error: true, errorMessage: 'No internet connection found'));
  }

  Future<ApiResponse<Connections>> acceptConnectionRequest(Connections item) {
    return http.post(API + '/acceptConnectionRequest' , headers: headers, body: json.encode(item.toJson())).then((data) async {
      if(data.statusCode==200)
      {
        final jsonData = json.decode(data.body);
        return ApiResponse<Connections>( data: Connections.fromJson(jsonData) );
      }
      return ApiResponse<Connections>(error: true, errorMessage: 'Something went wrong.');
    })
        .catchError((_) => ApiResponse<Connections>(error: true, errorMessage: 'No internet connection found'));
  }

  Future<ApiResponse<Connections>> deleteConnectionRequest(Connections item) {
    return http.post(API + '/rejectConnectionRequest' , headers: headers, body: json.encode(item.toJson())).then((data) async {
      if(data.statusCode==200)
      {
        final jsonData = json.decode(data.body);
        return ApiResponse<Connections>( data: Connections.fromJson(jsonData) );
      }
      return ApiResponse<Connections>(error: true, errorMessage: 'Something went wrong.');
    })
        .catchError((_) => ApiResponse<Connections>(error: true, errorMessage: 'No internet connection found'));
  }
}