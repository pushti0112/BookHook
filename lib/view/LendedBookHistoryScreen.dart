// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, library_private_types_in_public_api, unnecessary_const

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:book_hook/controller/LendBookController.dart';
import 'package:book_hook/provider/LendBookProvider.dart';
import 'package:book_hook/widget/drawer_tray.dart';
import 'package:flutter/material.dart';
import '../global/AppColors.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class LendedBookHistoryScreen extends StatefulWidget {
  const LendedBookHistoryScreen({Key? key}) : super(key: key);

  @override
  _LendedBookHistoryScreenState createState() => _LendedBookHistoryScreenState();
}

class _LendedBookHistoryScreenState extends State<LendedBookHistoryScreen> {
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
        title: (const Text('Lended Books')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      
      body: Consumer<LendBookProvider>(
        builder: (BuildContext context, lsp, child) { 
          return lsp.lendedbooks!.length == 0
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
            itemBuilder: (_, i) =>Dismissible(
              direction: DismissDirection.endToStart,
              key: UniqueKey(),
                
                onDismissed: (direction) async{
                   
                    await LendBookController().deleteLendBook(context,i);
                    print("lend count"+lsp.lendCount.toString());
                    print("length"+lsp.lendedbooks!.length.toString());
                    
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Boook ${i+1} deleted')));
                      setState(() {
                        
                      });
                },
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primarySubtle,
                ),
                child: Align(alignment: Alignment.centerRight,child: IconButton(padding: EdgeInsets.fromLTRB(0, 0, 8, 0),onPressed: (){}, icon: Icon(Icons.delete_outline,color: AppColors.error,size: 28,))),
              ),
              child: LendedBookCard(i,lsp)
            ),
            separatorBuilder:(_, i) => SizedBox(height: 8,),
             itemCount: lsp.lendedbooks!.length 
             //lsp.lendCount?.toInt() ?? 0,
          ),
        );
        },
        child: Container(),
      )
    );
  }
  Widget LendedBookCard(int i,LendBookProvider lendBookProvider){
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
                      lendBookProvider.lendedbooks![i]['CoverImagePath'],
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
                      Text(lendBookProvider.lendedbooks![i]["BookTitle"],
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                      SizedBox(height: 8,),
                      Row( 
                        children: [
                           Text("Status: ",style: TextStyle(fontSize: 16),),
                           Text(lendBookProvider.lendedbooks![i]["BookStatus"],
                          style: TextStyle(
                            fontSize: 16,
                            color: lendBookProvider.lendedbooks![i]["BookStatus"]== "Pending" ? AppColors.secondary:AppColors.success,
                          ),),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row( 
                        children: [
                           Text("Borrowed By: ",style: TextStyle(fontSize: 16),),
                           Text(lendBookProvider.lendedbooks![i]["Borrower Name"]== null ? "None": lendBookProvider.lendedbooks![i]["Borrower Name"],
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
