// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:book_hook/controller/LendBookController.dart';
import 'package:book_hook/widget/drawer_tray.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../global/AppColors.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';


class LendABookPage extends StatefulWidget {
  const LendABookPage({Key? key}) : super(key: key);

  @override
  State<LendABookPage> createState() => _LendABookPageState();
}

class _LendABookPageState extends State<LendABookPage> {

  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();
   String? _dropDownValue;
  final items =<String> [
    'Action and Adventure ', 'Classics', 'Comic', 
    'Mystery', 'Fantasy', 'Historic Fiction',
    'Horror', 'Romance', 'Science', 'Short Stories'
  ];
  int index=0;
 // File? imageFile;
  XFile? pickedFile;
  

//  pickImage() async {
//    pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
//   //if(pickedFile==null) return null;
//   if (pickedFile != null) {
//       setState(() {
//       //  imageFile = File(pickedFile!.path);
//         print(pickedFile!.path);
//        // print("after setstate");
//       //  print(imageFile!.path);
//       });
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: Text('Lend Book'),
            centerTitle: true,
          ),
          drawer: DrawerTray(),
          body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 16,),
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
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                         // border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          autocorrect: false,
                          enableSuggestions: false,

                          controller: titleC,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45, width: 1),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                            ),
                            hintText: "Book Title",
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        //  border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: descC,
                          maxLines: 4,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                            ),
                            hintText: "Description",
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                        SizedBox.fromSize(
                          size: Size(6.h, 6.h),
                          child: ClipOval(
                              child: Material(
                                  color: AppColors.light3,
                                  child: InkWell(
                                    // splashColor: AppColors.light3,
                                    onTap: () {
                                      modelSheetMenu();
                                    },
                                    child: Icon(
                                      Icons.file_upload_outlined,
                                      size: 5.h,
                                      color: Colors.grey,
                                    ),
                                  ))),
                        ),
                        SizedBox(width: 16),
                        Text('Upload a cover image'),
                        ]
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          child: Text("Add"),
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                              padding: EdgeInsets.all(16)),
                          onPressed: () async{
                            if(titleC.text.isEmpty || descC.text.isEmpty || _dropDownValue==null || pickedFile==null){
                              final snackBar = SnackBar(
                                duration: Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                content: const Text('Enter data for all fields'),
                                margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                                backgroundColor: Colors.black87,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            else
                              await LendBookController().addBook(context,titleC.text,descC.text,index+1,pickedFile!.path);
                          }
                        )
                      ),
                      // SizedBox(height: 16),
                      // imageFile == null ? Text("null image")
                      // : Container(
                      //   child: Image.file(
                      //     imageFile!,
                      //     fit: BoxFit.cover,
                      //   ),
                      //),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void modelSheetMenu(){
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),),
       builder: (builder){
        return SingleChildScrollView(
          child: Container(
         //   padding: EdgeInsets.symmetric(vertical: 16,horizontal: 0),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(height: 28,),
                Text("Select Book Cover Image From",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                SizedBox(height: 16,),
                Divider(color: Colors.black45, thickness: 0.5,),
                SizedBox(height: 8,),
                InkWell(onTap: ()async{
                  pickedFile = null;
                  pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  Navigator.pop(context);
                  
                },
                  child: Text("Gallery",style: TextStyle(color: AppColors.primary,fontSize: 16),)),
                SizedBox(height: 8,),
                Divider(color: Colors.black45, thickness: 0.5,),
                SizedBox(height: 8,),
                InkWell(onTap: () async{
                pickedFile = null;
                pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
                Navigator.pop(context);
                },
                child: Text("Camera",style: TextStyle(color: AppColors.primary,fontSize: 16),)),
                SizedBox(height: 16,),
        
              ],
            ),
          ),
        );
       }
    );
  }
   
}
