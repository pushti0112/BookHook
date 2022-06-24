// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../global/AppColors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.light3,
                      ),
                      child: Image.asset(
                        "assets/images/logo1.png",
                        height: 40,
                        width: 40,
                      )),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Signin to unlock the full experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.dark2,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  )),
                ],
              ))
            ],
          ),
        ),
      )),
    );
  }
}
