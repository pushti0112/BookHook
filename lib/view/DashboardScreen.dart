// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:book_hook/global/AppColors.dart';
import 'package:book_hook/model/UserModel.dart';
import 'package:book_hook/provider/UserProvider.dart';
import 'package:book_hook/view/LendBookScreen.dart';
import 'package:book_hook/view/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_hook/controller/LendBookController.dart';
import 'package:provider/provider.dart';

import '../widget/drawer_tray.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {
  
  @override
  void initState(){
    
    // TODO: implement initState
    print("In INIT");
    LendBookController().getLendBook(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      drawer: DrawerTray(),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
            child: Center(
              child: Text(
                "BookHook Dashboard!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
                ),
             ),
          ),
          Container(
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.h), topRight: Radius.circular(5.h)),
              color: AppColors.light3,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  countWidget(userProvider: userProvider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 24.h,
                        width: 24.h,
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/images/read.svg"
                            ),
                        ),
                      ),
                      SizedBox(width: 30,),
                    ],
                  ),
                ],
              ),
            ),
           
           ],
      ),
    );
  }
}

class countWidget extends StatelessWidget {
  const countWidget({
    Key? key,
    required this.userProvider,
    
  }) : super(key: key);

  final UserProvider userProvider;


  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder:  (context, value, child){
        print(value.lendCount);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            dashboardCard(text: "Lended", count: userProvider.lendCount??0,id: 1),
            dashboardCard(text: "Borrowed",count: 0, id: 2),
          ],
        );
      },
      child: Container(),
    );
  }
}


class dashboardCard extends StatelessWidget {
  final String text;
  final int count;
  final int id;

  const dashboardCard({super.key, required this.text, required this.count, required this.id});

  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      width: 36.w,
      margin: EdgeInsets.only(top: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.h),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [BoxShadow(
          blurRadius: 8.0,

        ),]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text("Book",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(         
            height: 4.h,
          ),
          Container(
            height: 18.w,
            width: 18.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 4),
              borderRadius: BorderRadius.circular(36.w),
            ),
            child: Center(child: Text("$count",
              style: TextStyle(fontSize: 24),
            ))),
        ],
      ),
    );
  }
}