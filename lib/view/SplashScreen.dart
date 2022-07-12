// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:book_hook/controller/LoginSignupController.dart';
import 'package:book_hook/global/AppColors.dart';
import 'package:book_hook/model/UserModel.dart';
import 'package:book_hook/view/DashboardScreen.dart';
import 'package:book_hook/view/HomeScreen.dart';
import 'package:book_hook/view/LoginScreen.dart';
import 'package:book_hook/view/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import '../provider/UserProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BorrowBook.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool login = false;
  User? user; 

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async{

      
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      
    
      if(await getSharedUser()==true){
        print("in if");
        userProvider.user = user;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
      }
      else{
        print("false");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      
    });
  }
  
  Future<bool> getSharedUser() async{
    print("in method;");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? getUser = preferences.getString('sUser');
   
    
    if(getUser!=null){
  
      Map<String,dynamic> userMap = jsonDecode(getUser);
      print(userMap);
      user = User.fromJson(userMap);
      print(user!.EmailID);
      print("User ID:" + user!.UserId.toString());
      return true;
    }
    else{
      print("in null");
      return false;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 10.h,
        ),
      ),
    );
  }
}
