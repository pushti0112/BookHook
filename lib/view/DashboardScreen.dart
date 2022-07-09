// ignore_for_file: prefer_const_constructors

import 'package:book_hook/global/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
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
                "Dashboard",
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  dashboardCard(text: "Lended", count: 0,id: 1),
                  dashboardCard(text: "Borrowed",count: 0, id: 2),
                ],
              ),
            ),
        ],
      ),
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
      ),
      child: Expanded(
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
      ),
    );
  }
}