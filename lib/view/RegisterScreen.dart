// ignore_for_file: prefer_const_constructors
import 'package:book_hook/controller/LoginSignupController.dart';
import 'package:book_hook/global/AppColors.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController fNameC = TextEditingController();
  TextEditingController lNameC = TextEditingController();
  TextEditingController PhnNoC = TextEditingController();
  TextEditingController emailIdC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController cPassC = TextEditingController();
  TextEditingController ansC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController provinceC = TextEditingController();
  String? _dropDownValue;
  final items =<String> [
    'In what city were you born?', 'What is the name of your favorite pet?',
    'What high school did you attend?', 'What is the name of your first school?', 'What was the make of your first car?',
    'What was your favorite food as a child?', 'Where did you meet your spouse?'
  ];
  int index=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () => {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.grey[50],
        child: Column(children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
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
                    // ignore: prefer_const_constructors
                    Center(
                      child: const Text("Sign up to unlock the full experience",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppColors.dark2,
                            fontSize: 16,
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("First Name",fNameC),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Last Name",lNameC),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Email",emailIdC),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Phone Number",PhnNoC),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Password",passC),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Re-enter Password",cPassC),
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
                            items: items.map((val) {
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
                                   index = items.indexOf(_dropDownValue!);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                      height: 16,
                    ),
                    TextFormField("Answer",ansC),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("City",cityC),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Province",provinceC),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text("Sign Up"),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.primary,
                      padding: EdgeInsets.all(16)),
                  onPressed: () async{
                    if(passC.text == cPassC.text)
                      LoginSignupController().registerUser(fNameC.text, lNameC.text, PhnNoC.text, emailIdC.text, passC.text,index+1, ansC.text, provinceC.text, cityC.text,context);
                    else{
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        content: const Text('Passwords does not match'),
                        margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                        backgroundColor: Colors.black87,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                )
              ),
            ],
          ))
        ]),
      ),
    );
  }

  Widget TextFormField(String hint,TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
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
