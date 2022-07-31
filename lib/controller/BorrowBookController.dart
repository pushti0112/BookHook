import 'dart:convert';

import 'package:book_hook/model/UserModel.dart';
import 'package:book_hook/view/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_alert/cool_alert.dart';

import '../provider/BorrowBookProvider.dart';

class BorrowBookController{
  int uid=0;
  getSharedUser() async{
    // print("in method;");
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
  getBorrowedBook(BuildContext context) async{
   // getUrlfromStorage("The Lion", context);
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
        "http://bookhookase-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_LendBook"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },  
        body: jsonEncode(
          <String, dynamic>{
            "UserId" : uid,
            "MODE":5
        }
        ));
        if(response.body.isNotEmpty){
        
        List<dynamic> jsonData = jsonDecode(response.body);
        // print("Status");
        // print(jsonData[0]['Status']);
        if(jsonData[0]['Status']==0){
          borrowBookProvider.borrowedCount = 0;
          borrowBookProvider.isLoading = false;
          borrowBookProvider.notifyListeners();
        }
        else{
          borrowBookProvider.borrowedCount = jsonData.length;
          borrowBookProvider.isLoading = false;
          borrowBookProvider.borrowedBooks = jsonData;
          borrowBookProvider.notifyListeners();  
        }
         
        }      

  }
  getPostals(BuildContext context) async{
    // ignore: unused_local_variable
    // print("in get postals;");
    BorrowBookProvider borrowBookProvider = Provider.of<BorrowBookProvider>(context, listen: false);
    borrowBookProvider.isLoading=true;
    borrowBookProvider.notifyListeners();
    
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookhookase-001-site1.ctempurl.com/api/BookShelf/USP_FETCH_CanadianPostalCodes"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
    );
      if(response.body.isNotEmpty){
        print(response);
        List<dynamic> jsonData = jsonDecode(response.body);

        jsonData.forEach((element) {
          borrowBookProvider.postals.add(element['POSTAL_CODE']);
        });
          borrowBookProvider.postalCount = borrowBookProvider.postals.length;
          borrowBookProvider.isLoading = false;
       //   borrowBookProvider.postals = jsonData;
          borrowBookProvider.notifyListeners();  
          // print(borrowBookProvider.postals![0]);
        
         
       }      

  } 
  searchBookList(BuildContext context, int index, int postalIndex,String bTitle, int radius) async{
    BorrowBookProvider borrowBookProvider = Provider.of<BorrowBookProvider>(context, listen: false);
    borrowBookProvider.isLoading=true;
    borrowBookProvider.notifyListeners();
    // print("length"+borrowBookProvider.searchBooks.length.toString());
    
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookhookase-001-site1.ctempurl.com/api/BookShelf/USP_Fetch_DistanceBook"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
       body: jsonEncode(
          <String, dynamic>{
          "Radius" : radius,
          "BookTypeID" : index,
          "ZipID" : postalIndex,
          "BookTitle": bTitle
      }
      ) );
      
      if(response.body.isNotEmpty){
        // print(response);
        List<dynamic> jsonData = jsonDecode(response.body);
        print(jsonData.toString());
        if(jsonData[0]['status']==0)
        {

          print("in if boorrow");
          borrowBookProvider.searchBooks = [];
          borrowBookProvider.notifyListeners();
        }
        else{
          borrowBookProvider.searchBooks = jsonData;
          borrowBookProvider.isLoading = false;
       //   borrowBookProvider.postals = jsonData;
          borrowBookProvider.notifyListeners();  
       //   print(borrowBookProvider.searchBooks[0]);
        }
          
        
         
       }      


  } 
  borrowBook(BuildContext context, int uid, int? lbookid)async{
    BorrowBookProvider borrowBookProvider = Provider.of<BorrowBookProvider>(context, listen: false);
    borrowBookProvider.isLoading=true;
    borrowBookProvider.notifyListeners();
    print("Inside Borrow Book");
    //print("length"+borrowBookProvider.searchBooks.length.toString());
    
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response response = await http.post(
        Uri.parse(
        "http://bookhookase-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_LendBook"),
        headers: <String, String>{
         // "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
       body: jsonEncode(
          <String, dynamic>{
          "UserId" : uid,
          "LendBookID" : lbookid,
          "MODE":4
      }
      ) );
      if(response.body.isNotEmpty){
      //  print(response);
        List<dynamic> jsonData = jsonDecode(response.body);
        print(jsonData.toString());
        print(jsonData[0]['status']);
        if(jsonData[0]['Status']==1)
        {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  width: 75,
                  title: 'Good Job!',
                  text: "Book borrowed successfully",
                  onConfirmBtnTap: (){
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                  },
                 
                );
       //   borrowBookProvider.searchBooks = [];
          borrowBookProvider.notifyListeners();
        }
        
          
        
         
       }
       else{
        print("BOdy Empty");
       }      


  }
}