import 'package:book_hook/view/DashboardScreen.dart';
import 'package:book_hook/view/HomeScreen.dart';
import 'package:book_hook/view/LoginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_alert/cool_alert.dart';
import '../model/UserModel.dart';
import '../provider/UserProvider.dart';

class LendBookController{

    

  addBook(BuildContext context,String title, String desc,int index) async{
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookshelfdev-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_LendBook"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            "UserId" : userProvider.user?.UserId,
            "BookTypeID":index,
            "BookTitle" : title,
            "BookDescription": desc,
            "CoverImagePath" : "C:\\Users\\dhruvi.shah\\Downloads\\test.png",
            "MODE":1
        }
        ));
        List<dynamic> jsonData = jsonDecode(response.body);
        print(title+desc+index.toString());

        if(jsonData!=null){
          print(jsonData[0]);
          print(jsonData[0]['Status']);
          if(jsonData[0]['Status'] == 1)
          {
            
            CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              width: 75,
              title: 'Good Job!',
              text: "$title lended successfully.",
              onConfirmBtnTap: (){
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
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


  getLendBook(BuildContext context) async{
    // ignore: unused_local_variable
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.isLoading=true;
    userProvider.notifyListeners();
    await getSharedUser();
    print("uid"+uid.toString());
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookshelfdev-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_LendBook"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            "UserId" : uid,
            "MODE":3
        }
        ));
    
        print(response.statusCode);
        print("body"+response.body);
        // print("After APi");
         List<dynamic> jsonData = jsonDecode(response.body);
        userProvider.lendCount = jsonData.length;
        userProvider.isLoading = false;
        userProvider.notifyListeners();         

  }  

}