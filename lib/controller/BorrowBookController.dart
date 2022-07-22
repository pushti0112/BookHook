import 'dart:convert';

import 'package:book_hook/model/UserModel.dart';
import 'package:book_hook/provider/BorrowBookProvider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BorrowBookController{
  int uid=0;
  getSharedUser() async{
    print("in method;");
    User? user; 
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? getUser = preferences.getString('sUser');
   
    
    if(getUser!=null){
  
      Map<String,dynamic> userMap = jsonDecode(getUser);
      print(userMap);
      user = User.fromJson(userMap);
      print(user!.EmailID);
      print("User ID:" + user!.UserId.toString());
       uid = user.UserId ?? 0 ;
      
    }
  }

  getPostals(BuildContext context) async{
    // ignore: unused_local_variable
    print("in get postals;");
    BorrowBookProvider borrowBookProvider = Provider.of<BorrowBookProvider>(context, listen: false);
    borrowBookProvider.isLoading=true;
    borrowBookProvider.notifyListeners();
    await getSharedUser();
    print("uid"+uid.toString());
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookshelfdev-001-site1.ctempurl.com/api/BookShelf/USP_FETCH_CanadianPostalCodes"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
        );
        if(response.body.isNotEmpty){
        print(response);
        List<dynamic> jsonData = jsonDecode(response.body);
        print("Status borrow");
        print(jsonData[0]['Status']);
        if(jsonData.isEmpty){
          borrowBookProvider.postalCount = 0;
          borrowBookProvider.isLoading = false;
          borrowBookProvider.notifyListeners();
        }
        else{
          borrowBookProvider.postalCount = jsonData.length;
          borrowBookProvider.isLoading = false;
          borrowBookProvider.postals = jsonData;
          borrowBookProvider.notifyListeners();  
          //print(borrowBookProvider.postals);
        }
         
        }      

  }  
}