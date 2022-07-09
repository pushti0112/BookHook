// ignore_for_file: prefer_const_constructors

import 'package:book_hook/global/AppColors.dart';
import 'package:book_hook/provider/UserProvider.dart';
import 'package:book_hook/view/BorrowBook.dart';
import 'package:book_hook/view/DashboardScreen.dart';
import 'package:book_hook/view/LendBookScreen.dart';
import 'package:book_hook/view/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
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
    String? add1 = userProvider.user!.CityName;
    String? zip = userProvider.user!.ZipName;
    
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryLight
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile-sample.png"),
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
                          fontSize: 20
                        ),
                      ),
                      SizedBox(
                        height:18
                      ),
                      Text("$add1",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text("$zip",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Image.asset("assets/images/menu.png"),
            title: Text("Home", 
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 20
            ),),
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen())),
          ),
          ListTile(
            leading: Image.asset("assets/images/book1.png"),
            title: Text("Borrow Book", 
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 20
            ),),
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => BorrowBook())),
          ),
          ListTile(
            leading: Image.asset("assets/images/hand1.png"),
            title: Text("Lend Book", 
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 20
            ),),
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => LendABookPage())),
          ),
          ListTile(
            leading: Image.asset("assets/images/send1.png"),
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
