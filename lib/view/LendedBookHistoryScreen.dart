// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, library_private_types_in_public_api, unnecessary_const

import 'package:book_hook/widget/drawer_tray.dart';
import 'package:flutter/material.dart';
import '../global/AppColors.dart';
import 'package:sizer/sizer.dart';

class LendedBookHistoryScreen extends StatefulWidget {
  const LendedBookHistoryScreen({Key? key}) : super(key: key);

  @override
  _LendedBookHistoryScreenState createState() => _LendedBookHistoryScreenState();
}

class _LendedBookHistoryScreenState extends State<LendedBookHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerTray(),
      appBar: AppBar(
        title: (const Text('Lended Books')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.all(16),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, i) =>LendedBookCard(i),
          separatorBuilder:(_, i) => SizedBox(height: 8,),
           itemCount: 8
        ),
      )
    );
  }
  Widget LendedBookCard(int i){
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // boxShadow: [ BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(-2, 2)), ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: Colors.black26),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            enableFeedback: true,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 15.h,
                  width: 25.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/samplebook.jpg",
                      fit: BoxFit.fill,
                      ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("The Lion & The Witch",
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                      SizedBox(height: 8,),
                      Row( 
                        children: [
                           Text("Status: ",style: TextStyle(fontSize: 16),),
                           Text(i%2==0?"Pending":"Lended",
                          style: TextStyle(
                            fontSize: 16,
                            color:i%2==0? AppColors.secondary:AppColors.success,
                          ),),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row( 
                        children: [
                           Text("Borrowed By: ",style: TextStyle(fontSize: 16),),
                           Text(i%2==0?"None":"Michael Smith",
                          style: TextStyle(
                            fontSize: 16,
                          ),),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
