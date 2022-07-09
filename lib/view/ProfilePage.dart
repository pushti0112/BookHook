//import 'package:flutter/cupertino.dart';
// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:book_hook/widget/drawer_tray.dart';
import 'package:flutter/material.dart';
import '../global/AppColors.dart';
import '../widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (const Text('Profile')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      drawer: DrawerTray(),
      body: ListView(physics: const BouncingScrollPhysics(), children: [
        const SizedBox(height: 20),
        ProfileWidget(
          imagePath:
              'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
          onClicked: () async {},
        ),

        const SizedBox(height: 40),

        //FirstName textfield
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 0.5)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                hintText: 'First Name',
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        //Last Name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 0.5)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                hintText: 'Last Name',
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        //Email Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 0.5)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                hintText: 'Email Address',
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),

        //Phone Number
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 0.5)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                hintText: 'Phone Number',
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 0.5)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                hintText: 'City',
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 0.5)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                hintText: 'Province',
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        //save button
        Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  padding: const EdgeInsets.all(20)),
              onPressed: () async {
                const snackBar = SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  content: Text('print something'),
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
                  backgroundColor: Colors.black87,
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text("Save Details"),
            )),
      ]),
    );
  }
}
