// ignore_for_file: prefer_const_constructors

import 'package:book_hook/global/AppColors.dart';
import 'package:book_hook/provider/UserProvider.dart';
import 'package:book_hook/view/BorrowBook.dart';
import 'package:book_hook/view/DashboardScreen.dart';
import 'package:book_hook/view/LendBookScreen.dart';
import 'package:book_hook/view/LoginScreen.dart';
import 'package:book_hook/view/ProfilePage.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class DrawerTray extends StatelessWidget {
  const DrawerTray({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    String? l1 = userProvider.user!.FirstName;
    String? l2 = userProvider.user!.LastName;
    String? add1 = userProvider.user!.EmailID;
    String? zip = userProvider.user!.ZipName;
    
    return Drawer(
      child: Column(
        children: [
          
          InkWell(
            onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage())),
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/userdemo.png"),
                    backgroundColor: AppColors.primary,
                    radius: 50,
                  ),
                  SizedBox(width: 2.h),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$l1 $l2',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height:18
                        ),
                        // Text("$add1",
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        Text("$zip",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
          
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Image.asset("assets/images/home.png"),
            title: Text("Home", 
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 20
            ),),
            onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen())),
          ),
          ListTile(
            leading: Image.asset("assets/images/bbook.png"),
            title: Text("Borrow Book", 
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 20
            ),),
            onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BorrowBook())),
          ),
          ListTile(
            leading: Image.asset("assets/images/lbook.png"),
            title: Text("Lend Book", 
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 20
            ),),
            onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LendABookPage())),
          ),
          ListTile(
            leading: Image.asset("assets/images/chat.png"),
            title: Text("Chat", 
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 20
            ),),
            onTap: (){},
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Image.asset("assets/images/logout.png"),
                title: Text("Logout", 
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 20
                ),),
                onTap: () async{
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  await preferences.clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
