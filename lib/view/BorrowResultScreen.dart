// ignore_for_file: prefer_const_constructors

import 'package:book_hook/controller/BorrowBookController.dart';
import 'package:book_hook/controller/LendBookController.dart';
import 'package:book_hook/provider/LendBookProvider.dart';
import 'package:book_hook/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';
import '../global/AppColors.dart';
import '../provider/BorrowBookProvider.dart';
import '../widget/drawer_tray.dart';
import 'package:cool_alert/cool_alert.dart';
class BorrowResultScreen extends StatefulWidget {
  const BorrowResultScreen({Key? key}) : super(key: key);

  @override
  State<BorrowResultScreen> createState() => _BorrowResultScreenState();
}

class _BorrowResultScreenState extends State<BorrowResultScreen> {
    int items = 8;
  @override
  void initState(){
    
    // TODO: implement initState
    print("In INIT");
    WidgetsBinding.instance.addPostFrameCallback((_) async{

      await LendBookController().getLendBook(context);
  });   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 //   LendBookProvider lendBookProvider = Provider.of<LendBookProvider>(context, listen: false);
    return Scaffold(
      drawer: DrawerTray(),
      appBar: AppBar(
        title: (const Text('Search Results')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      
      body: Consumer<BorrowBookProvider>(
        builder: (BuildContext context, bp, child) { 
          return bp.searchBooks.length == 0
          ? Container(
              height: double.maxFinite,
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
          height: double.maxFinite,
          padding: EdgeInsets.all(16),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, i) =>InkWell(onTap: (){
              UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
              String? tempFnm = userProvider.user!.FirstName;   
              String? tempLnm = userProvider.user!.LastName;
              
              if(bp.searchBooks[i]["LenderName"].toString()==(tempFnm.toString() +" " + tempLnm.toString())){
              final snackBar = SnackBar(
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              content: Text("You can't borrow this book its lended by you!"),
              margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
              backgroundColor: Colors.black87,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            else{
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.confirm,
                  width: 75,
                  title: 'Are you sure?',
                  text: "You want to borrow this book",
                  onConfirmBtnTap: ()async{
                   Navigator.pop(context); 
                   await BorrowBookController().borrowBook(context, userProvider.user!.UserId, bp.searchBooks[i]["LendBookID"]);
                   
                   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                  },
                  onCancelBtnTap: (){
                    Navigator.pop(context);
                  }
                );
            }
            },
            child: LendedBookCard(i,bp)
            ),
            separatorBuilder:(_, i) => SizedBox(height: 8,),
             itemCount: bp.searchBooks.length 
             //lsp.lendCount?.toInt() ?? 0,
          ),
        );
        },
        child: Container(),
      )
    );
  }
  Widget LendedBookCard(int i,BorrowBookProvider borrowBookProvider){
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
                    child: CachedNetworkImage(
                      imageUrl: //"assets/images/bookplaceholder.png",width: 10,height: 20,
                      borrowBookProvider.searchBooks[i]['CoverImagePath'],
                      placeholder: (context, url) => Padding(padding: EdgeInsets.symmetric(vertical: 52,horizontal: 40),child: CircularProgressIndicator(color: AppColors.primary,strokeWidth: 2,)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                      Text(borrowBookProvider.searchBooks[i]["BookTitle"],
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                      SizedBox(height: 8,),
                      Row( 
                        children: [
                           Text("Book Type: ",style: TextStyle(fontSize: 16),),
                           Text(borrowBookProvider.searchBooks[i]["BookTypeName"],
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row( 
                        children: [
                           Text("Lended By: ",style: TextStyle(fontSize: 16),),
                           Text(borrowBookProvider.searchBooks[i]["LenderName"],
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