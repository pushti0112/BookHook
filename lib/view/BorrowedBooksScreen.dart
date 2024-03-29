// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, library_private_types_in_public_api, unnecessary_const

import 'package:book_hook/controller/BorrowBookController.dart';
import 'package:book_hook/controller/LendBookController.dart';
import 'package:book_hook/provider/BorrowBookProvider.dart';
import 'package:book_hook/provider/LendBookProvider.dart';
import 'package:book_hook/widget/drawer_tray.dart';
import 'package:flutter/material.dart';
import '../global/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:cool_alert/cool_alert.dart';
class BorrowedBooksScreen extends StatefulWidget {

  
  const BorrowedBooksScreen({Key? key}) : super(key: key);
  
  @override
  _BorrowedBooksScreenState createState() => _BorrowedBooksScreenState();
}

class _BorrowedBooksScreenState extends State<BorrowedBooksScreen> {

@override
  void initState() {
    // TODO: implement initState
     WidgetsBinding.instance.addPostFrameCallback((_) async{

      await BorrowBookController().getBorrowedBook(context);
  });   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (const Text('Borrowed Books')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      drawer: DrawerTray(), 
      body:
      Consumer<BorrowBookProvider>(
        builder: (BuildContext context, bsp, child) {
          print("BorrowedBooks = " + bsp.borrowedBooks.toString());
          print("BorrowedBooksCount = " + bsp.borrowedCount.toString()); 
          return bsp.borrowedCount == 0
          ? Container(
                child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/no_data_found.png",height: 33.w,),
                    SizedBox(height: 16,),
                    Text("No Data Found",style: TextStyle(fontSize: 18),),      
                  ],
                ),
              ),
            ) 
          : Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                  height: double.maxFinite,
                  padding: EdgeInsets.all(16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (_, i) =>bsp.borrowedBooks!.length==null?Container()
                    :BookCard(i,bsp),
                    separatorBuilder:(_, i) => SizedBox(height: 8,),
                     itemCount: bsp.borrowedBooks.length 
                    //  lsp.lendCount?.toInt() ?? 0,
                  ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(),
      ) 
      
    );
  }
  Widget BookCard(int i,BorrowBookProvider borrowBookProvider){
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // boxShadow: [ BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(-2, 2)), ],
        ),
        child: Column(
          children: [
            
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Colors.black26),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 15.h,
                      width: 25.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                       // child: Image.asset("assets/images/samplebook.jpg"),
                        child: CachedNetworkImage(
                          imageUrl: //"assets/images/samplebook.jpg",width: 10,height: 20,
                          borrowBookProvider.borrowedBooks[i]['CoverImagePath'],
                          placeholder: (context, url) => Padding(padding: EdgeInsets.symmetric(vertical: 52,horizontal: 40),child: CircularProgressIndicator(color: AppColors.primary,strokeWidth: 2,)),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(borrowBookProvider.borrowedBooks[i]["BookTitle"],
                          style: TextStyle(
                            fontSize: 16,
                          ),),
                          SizedBox(height: 8,),
                          Row( 
                            
                            children: [
                               Text("Lended By: ",style: TextStyle(fontSize: 16),),
                               Text(borrowBookProvider.borrowedBooks[i]["LenderName"]== null ? "None": borrowBookProvider.borrowedBooks[i]["LenderName"],
                              style: TextStyle(
                                fontSize: 16,
                              ),),   
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: (){
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.info,
                          width: 75,
                          title: 'Hey there!',
                          text: "Chat feature will be arriving super soon!",
                          onConfirmBtnTap: ()async{
                          Navigator.pop(context);
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 44, horizontal: 8),
                        child: Image.asset("assets/images/chat.png"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
