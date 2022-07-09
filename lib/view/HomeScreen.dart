import 'package:book_hook/view/BorrowBook.dart';
import 'package:book_hook/view/LendBookScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../global/AppColors.dart';
import '../provider/UserProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
   UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
   return Scaffold(
     body: SafeArea(
       child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("This is Home Screen\n"+userProvider.user!.FirstName.toString())
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  padding: EdgeInsets.all(16)),
                onPressed: ()async{
                  
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  await preferences.clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                
                },
                child: Text("Logout")
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  padding: EdgeInsets.all(16)),
                onPressed: ()async{
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LendABookPage()));
                
                },
                child: Text("Lend Book")
              ),
            ],
          ),
        ),
     ),
   );
    
  }
}