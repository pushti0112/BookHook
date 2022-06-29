import 'package:book_hook/view/LoginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_alert/cool_alert.dart';
import '../model/UserModel.dart';

class LoginSignupController{

  Future<User> getLoggedInUser(String name,String pass) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<User> user = [];
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    
    http.Response response = await http.post(
        Uri.parse(
            "http://bookshelfdev-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_LoginDetails"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            "LoginName" : name,
            "Password": pass
          },
        ));
        
        List<dynamic> jsonData = jsonDecode(response.body);
       
        if (jsonData != null) {
        jsonData.forEach((element) {
          if (element != null) {

            String shared_user = jsonEncode(User.fromJson(element));
            preferences.setString("sUser", shared_user);

            user.add(new User.fromJson(element));
          } else {
            print("Element is NULL");
          }
        });
      }
    
      return user[0];   
  }

  registerUser(String fname,String lname,String phn, String email, String pass, String state, String city,BuildContext context)async{
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookshelfdev-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_UserMaster"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            "FirstName" : fname,
            "LastName": lname,
            "PhoneNumber" : phn,
            "EmailID": email,
            "Password": password,
            "StateName": state,
            "CityName": city,
            "ZipName": "N9B1M6"
          },
        ));
        
        List<dynamic> jsonData = jsonDecode(response.body);

        if (jsonData != null) {
          if(jsonData[0]['Status'] == 1)
          {
            
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  width: 75,
                  title: 'Registered successfully!',
                  text: jsonData[0]['Remarks'],
                  onConfirmBtnTap: (){
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                  
                );
          }
          else{
            final snackBar = SnackBar(
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              content: Text(jsonData[0]['Remarks']),
              margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
              backgroundColor: Colors.black87,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }        
        }
        
      }


  
  
}