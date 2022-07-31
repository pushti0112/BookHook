// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:book_hook/controller/BorrowBookController.dart';
import 'package:book_hook/provider/BorrowBookProvider.dart';
import 'package:book_hook/provider/UserProvider.dart';
import 'package:book_hook/view/BorrowResultScreen.dart';
import 'package:book_hook/widget/drawer_tray.dart';
import 'package:flutter/material.dart';
import '../global/AppColors.dart';
import 'SplashScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
class BorrowBook extends StatefulWidget {
  const BorrowBook({Key? key}) : super(key: key);

  @override
  _BorrowBookState createState() => _BorrowBookState();
}

class _BorrowBookState extends State<BorrowBook> {

  
  String? _dropDownValue;
  final items =<String> [
    'Action and Adventure ', 'Classics', 'Comic', 
    'Mystery', 'Fantasy', 'Historic Fiction',
    'Horror', 'Romance', 'Science', 'Short Stories'
  ];
  int index=0;
  @override
  void initState(){
    
    // TODO: implement initState
    print("In INIT");
    WidgetsBinding.instance.addPostFrameCallback((_) async{

     // await LendBookController().getLendBook(context);
    //  await BorrowBookController().searchBookList(context);
       
  });
    
    
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
  //  BorrowBookProvider borrowBookProvider = Provider.of<BorrowBookProvider>(context, listen: false);
    TextEditingController radius = TextEditingController();
    TextEditingController bTitle = TextEditingController();
    TextEditingController fNameC = TextEditingController(text: userProvider.user!.FirstName);
    TextEditingController lNameC = TextEditingController(text: userProvider.user!.LastName);
    TextEditingController zipid = TextEditingController();
    int postalid;
    
    return Consumer<BorrowBookProvider>(
      builder: (BuildContext context, borrowBookProvider, child) { 
        return borrowBookProvider.postals.isEmpty ? 
        Container(
          color: AppColors.light3,
          width: double.maxFinite,
          height: double.maxFinite,
          child: Center(child: CircularProgressIndicator(
            color: AppColors.primary,
          )),
        ) :
        Scaffold(
          appBar: AppBar(
            title: (const Text('Borrow Book')),
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppColors.primary,
          ),
          drawer: DrawerTray(),
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
                                  ? Text('Book Type', style: TextStyle(decoration: TextDecoration.none),)
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
                      TextFormField("Enter Book Title",bTitle,true),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // SearchText(context, kOptions),
                      SizedBox(
                        height: 16,
                      ),
                      Form(
                        
                      //key: ,
                      child: SearchField(
                        
                        marginColor: Colors.grey[200],  
                        suggestions: borrowBookProvider.postals.map((e) =>
                          SearchFieldListItem(e)).toList(),
                        suggestionState: Suggestion.expand,
                        textInputAction: TextInputAction.next,
    
                        hint: 'Enter Zip',
                        hasOverlay: false,
                        searchStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        validator: (x) {
                          if (!_dropDownValue!.contains(x!) || x.isEmpty) {
                          return 'Please Enter a valid State';
                          }
                        return null;
                        },
                        controller:zipid ,
                        searchInputDecoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45, width: 0.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45, width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
          
                        ),
    
                        maxSuggestionsInViewPort: 8,
                        itemHeight: 50,
                      
                    )
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField("Enter Radius",radius,true),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 16,
                      ),
                      
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text("Search Books"),
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.primary,
                        padding: EdgeInsets.all(16)),
                    onPressed: () async{
                      print(borrowBookProvider.postals.indexOf(zipid.text));
                      postalid = borrowBookProvider.postals.indexOf(zipid.text)+1;
                      await BorrowBookController().searchBookList(context, (index+1),postalid,bTitle.text,int.parse(radius.text));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BorrowResultScreen()));
                        
                        // final snackBar = SnackBar(
                        //   duration: Duration(seconds: 3),
                        //   behavior: SnackBarBehavior.floating,
                        //   content: const Text('Passwords does not match'),
                        //   margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                        //   backgroundColor: Colors.black87,
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  )
                ),
              ],
            ),),
          ]),
        ),
        );
       },
      child: Container(),
    );
  }

  Widget SearchText(BuildContext context,List<String> kOptions) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}

Widget TextFormField(String hint,TextEditingController controller, bool flag) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        enabled: flag,
  
        style: TextStyle(
          color: flag==false?Colors.black38:Colors.black,
        ),
        decoration: InputDecoration(
          
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45, width: 0.5),
          ),
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