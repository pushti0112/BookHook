// ignore_for_file: prefer_const_constructors

import 'package:book_hook/global/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

import 'BorrowBook.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool login = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (!login) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BorrowBook()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          //width: 70,
          width: 10.h,
        ),
      ),
    );
  }
}
