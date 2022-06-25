// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.center,
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
                    Center(
                      child: Text(
                        "Sign In to unlock the full experience",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.dark2,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField("Username or Email Id"),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField("Password"),
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        // ignore: sort_child_properties_last
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(color: AppColors.primary),
                        ),
                        onPressed: () async {},
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          child: Text("Sign In"),
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                              padding: EdgeInsets.all(16)),
                          onPressed: () {},
                        )),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "OR",
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    OutlinedButton(
                        // ignore: sort_child_properties_last
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: SvgPicture.asset(
                                "assets/images/google.svg",
                                height: 24,
                                width: 24,
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Continue with Google",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.light4,
                          side: BorderSide(color: Colors.black45, width: 0.5),
                        ),
                        onPressed: () => {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget TextFormField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
          hintText: hint,
        ),
      ),
    );
  }
}
