// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:book_hook/provider/UserProvider.dart';
import 'package:book_hook/view/DashboardScreen.dart';
import 'package:book_hook/view/LoginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_alert/cool_alert.dart';
import '../model/UserModel.dart';
import 'package:provider/provider.dart';

class LoginSignupController{
  // Future<User> getSecureUser(String email, String ques, String ans){
  //   return user[0];
  // }
  Future<User> getLoggedInUser(String name,String pass) async{
    print(name+pass);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<User> user = [];
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    
    http.Response response = await http.post(
        Uri.parse(
            "http://bookhookase-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_LoginDetails"),
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
        print(response.body);
        List<dynamic> jsonData = jsonDecode(response.body);
       
        if (jsonData != null) {
        jsonData.forEach((element) {
          if (element != null) {

            String shared_user = jsonEncode(User.fromJson(element));
            //preferences.setString("uid", element["UserID"]);
             preferences.setString("sUser", shared_user);
          
            user.add(new User.fromJson(element));
          } else {
            print("Element is NULL");
          }
        });
      }
    
      return user[0];   
  }
  //Gets UserID for body parameter for Password changing API
  updatePassword(String email,int qid, String ans,String pass, String cPass, BuildContext context) async{
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookhookase-001-site1.ctempurl.com/api/BookShelf/USP_FETCH_ValidatePasswordChange"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            "EmailID":email,
            "SecurityQuestionID" : qid,
            "SecurityAnswer" : ans
        },
        ));
        List<dynamic> jsonData = jsonDecode(response.body);
        //If MissMatch occurs If will be executed
        if(response.body.contains("Status")){
            final snackBar = SnackBar(
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              content: Text(jsonData[0]['Remarks']),
              margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
              backgroundColor: Colors.black87,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else{
          //Matches the question, answer and email ID with DB
          String qid1 =  jsonData[0]['SecurityQuestionID'].toString();
          String qAns1 = jsonData[0]['SecurityAnswer'];
          print("NewID = $qid ResID = $qid1 NewAns = $ans ResAns = $qAns1");
          if(qid1==qid.toString() && qAns1==ans){
              print("True" + jsonData[0]['UserId'].toString());
              if(pass == cPass){
                changePassword(jsonData[0]['UserId'], pass,context);
              }
              else{
                //If new Password doesnot matches snackbar is displayed
                final snackBar = SnackBar(
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                content: Text("Passwords Do not Match"),
                margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                backgroundColor: Colors.black87,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
          }
          else{
            print("False");
          }
        }
        
        // print("Response: " + jsonDecode(response.body)[0]['SecurityQuestionID']);
        // if(response.body[0]["SecurityQuestionID"]==qid&&response.body["SecurityAnswer"]==ans.);
  }
  //Changes Password through API
  changePassword(int uid, String newPass,BuildContext context)async{
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookhookase-001-site1.ctempurl.com/api/bookShelf/USP_CRUD_UserMaster"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
        //BUG: API Returns Failed Status
        body: jsonEncode(
          <String, dynamic>{
           "MODE" : 5
          }
        ));
        print("Final = " + response.body);
        List<dynamic> jsonData = jsonDecode(response.body);
        if(jsonData[0]["Status"]==1){
           CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  width: 75,
                  title: 'Updated successfully!',
                 // text: jsonData[0]['Remarks'],
                  onConfirmBtnTap: (){
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                  
                );
        }
  }
  registerUser(String fname,String lname,String phn, String email, String pass,int qid, String ans, String state, String city,BuildContext context)async{
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookhookase-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_UserMaster"),
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
            "Password": pass,
            "StateName": state,
            "CityName": city,
            "ZipID": 2,
            "SecurityQuestionID" : qid,
            "SecurityAnswer" : ans,
            "MODE" : 1
          },
        ));
        print(jsonDecode(response.body));
        List<dynamic> jsonData = jsonDecode(response.body);

        if (jsonData != null) {
          if(jsonData[0]['Status'] == 1)
          {
                String shared_user = jsonEncode(User.fromJson(jsonData[0]));
                print("User = $shared_user");
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

  updateProfile(BuildContext context,String fname, String lname, String mobile,String email)async{
    UserProvider usp = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookhookase-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_UserMaster"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
              "UserID" : usp.user!.UserId,
              "FirstName": fname,
              "LastName": lname,
              "PhoneNumber" : mobile,
              "EmailID": usp.user!.EmailID,
              "Password":usp.user!.Password,
              "ZipID" : 202076,
              "SecurityQuestionID" : usp.user!.SecurityQuestionID,
              "SecurityAnswer" : usp.user!.SecurityAnswer,
              "MODE" : 2  
          },
       
        ));
       print("Email: " + usp.user!.EmailID.toString() + "UEmail = " );
       
        List<dynamic> jsonData = jsonDecode(response.body);
        if(jsonData[0]['Status']==1){

          // ignore: non_constant_identifier_names
          String shared_user = jsonEncode(User.fromJson(jsonData[0]));
          preferences.setString("sUser", shared_user);
          usp.user = User.fromJson(jsonData[0]);
          usp.notifyListeners();
          CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  width: 75,
                  title: 'Updated successfully!',
                 // text: jsonData[0]['Remarks'],
                  onConfirmBtnTap: (){
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                  }
                );
        }
        
    
  }
}