import 'dart:convert';

import 'package:book_hook/model/UserModel.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/BorrowBookProvider.dart';

class BorrowBookController{
  

  getPostals(BuildContext context) async{
    // ignore: unused_local_variable
    print("in get postals;");
    BorrowBookProvider borrowBookProvider = Provider.of<BorrowBookProvider>(context, listen: false);
    borrowBookProvider.isLoading=true;
    borrowBookProvider.notifyListeners();
    
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
        
          borrowBookProvider.postalCount = jsonData.length;
          borrowBookProvider.isLoading = false;
          borrowBookProvider.postals = jsonData;
          borrowBookProvider.notifyListeners();  
          print(borrowBookProvider.postals);
        
         
       }      

  }  
}