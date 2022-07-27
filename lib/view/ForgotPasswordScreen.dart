// ignore_for_file: prefer_const_constructors

import 'package:book_hook/controller/LoginSignupController.dart';
import 'package:book_hook/global/AppColors.dart';
import 'package:book_hook/provider/UserProvider.dart';
import 'package:book_hook/view/DashboardScreen.dart';
import 'package:book_hook/view/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
class ForgotPasswordScreen extends StatefulWidget {
  
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailIdC = TextEditingController();
  TextEditingController ansC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController cPassC = TextEditingController();
  String? _dropDownValue;
  var qitems =<String> [
    "In what city were you born?", 
    "What is the name of your favorite pet?",
    "What is your mother's maiden name",     
    "What high school did you attend?",
    "What is the name of your first school?",
    "What was the make of your first car?",
    "What was your favorite food as a child?",
    "Where did you meet your spouse?"
  ];
  int index=0;
  bool showPasswordText = false;
  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    print("Question = " + userProvider.user!.SecurityQuestionID.toString());
    print(userProvider.user!.SecurityAnswer);
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
            onPressed: (){
              Navigator.pop(context);
            },
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
                        "Select and Answer your Security Question",
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: emailIdC ,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          hintText: "Email Id",
                        ),
                      ),
                    ),                    
                    SizedBox(
                      height: 16,
                    ),
                    DecoratedBox(
                        decoration:  BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.circular(6),
                         ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                          child: DropdownButton(
                            hint: _dropDownValue == null
                                ? Text('Seccurity Question', style: TextStyle(decoration: TextDecoration.none),)
                                : Text(_dropDownValue!,style: TextStyle(color:Colors.black),),
                            isExpanded: true,
                            iconSize: 30.0,
                            items: qitems.map((val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (newval) {
                              setState(
                                () {
                                  _dropDownValue = newval.toString();
                                   index = qitems.indexOf(_dropDownValue!);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: ansC ,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          hintText: "Enter Answer",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: passC ,
                        obscureText: !showPasswordText,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          hintText: "Enter a new Password",
                          suffixIcon: IconButton(icon: Icon(showPasswordText ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.dark3,), onPressed: () => setState(() => showPasswordText = !showPasswordText,),),
                        ),
                        onChanged: (str) => setState(() {}),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: cPassC ,
                        obscureText: !showPasswordText,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          hintText: "Confirm Password",
                          suffixIcon: IconButton(icon: Icon(showPasswordText ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.dark3,), onPressed: () => setState(() => showPasswordText = !showPasswordText,),),
                        ),
                        onChanged: (str) => setState(() {}),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    
                    Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          child: Text("Reset Password"),
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                              padding: EdgeInsets.all(16)),
                          onPressed: () async{
                            // userProvider.user = await LoginSignupController().getLoggedInUser(emailIdC.text);
                            userProvider.notifyListeners();
                
                            print(userProvider.user?.Status ?? 0);
                            if(userProvider.user!.Status==1)
                            {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                            }
                            else{
                              final snackBar = SnackBar(
                                duration: Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                content: const Text('Invalid Credentials'),
                                margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                                backgroundColor: Colors.black87,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }         
                          },
                        )),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}