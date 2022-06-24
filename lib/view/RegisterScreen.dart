import 'package:book_hook/global/AppColors.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                    TextFormField("First Name"),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Last Name"),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Email"),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Password"),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Re-enter Password"),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("City"),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Province"),
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
                    onPressed: () {},
                  )),
            ],
          ))
        ]),
      ),
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
