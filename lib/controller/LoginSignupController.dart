import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import '../model/user_model.dart';

class LoginSignupController{

   isLogin(BuildContext context) async{
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    
    http.Response response = await http.post(
        Uri.parse(
            "http://bookshelfdev-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_LoginDetails"),
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            "LoginName" : "avf@gmail.com",
            "Password":"abc2@2222U"
          },
        ));
        print(response.runtimeType);
        print(response.body);
    // if (response.body.isNotEmpty) {
    //   print("Value = " + response.body);
    //   User user= new User.fromJson(jsonDecode(response.body));
    //   print(user.)

    // } else {
    //   print("Empty = ");
    // }
    //return true;
  }
  
}