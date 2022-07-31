//import 'package:flutter/cupertino.dart';
// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, depend_on_referenced_packages

import 'package:book_hook/controller/BorrowBookController.dart';
import 'package:book_hook/controller/LoginSignupController.dart';
import 'package:book_hook/provider/BorrowBookProvider.dart';
import 'package:book_hook/provider/UserProvider.dart';
import 'package:book_hook/widget/drawer_tray.dart';
import 'package:flutter/material.dart';
import '../global/AppColors.dart';
import '../widget/profile_widget.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  // File? imageFile;
  XFile? pickedFile;
   String? _dropDownValue;
  final items =<String> [
    'Action and Adventure ', 'Classics', 'Comic', 
    'Mystery', 'Fantasy', 'Historic Fiction',
    'Horror', 'Romance', 'Science', 'Short Stories'
  ];
  int index = 0;
  
  @override
  void initState() {
super.initState();
    // TODO: implement initState
   //  WidgetsBinding.instance.addPostFrameCallback((_) async{
  //     BorrowBookProvider borrowBookProvider = Provider.of<BorrowBookProvider>(context, listen: false);
  //     await BorrowBookController().getPostals(context);
  //     borrowBookProvider.postals!.forEach((element) { 
  //       //print(element["POSTAL_CODE"]);

  //     });
  // });

    
  }

  @override
  Widget build(BuildContext context) {
    
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    BorrowBookProvider borrowBookProvider = Provider.of<BorrowBookProvider>(context, listen: false);
    TextEditingController fNameC = TextEditingController(text: userProvider.user!.FirstName);
    TextEditingController lNameC = TextEditingController(text: userProvider.user!.LastName);
    TextEditingController PhnNoC = TextEditingController(text: userProvider.user!.PhoneNumber);
    TextEditingController emailIdC = TextEditingController(text: userProvider.user!.EmailID);
    TextEditingController zipC = TextEditingController(text: userProvider.user!.ZipName);
    return Scaffold(
      appBar: AppBar(
        title: (const Text('Profile')),
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
                      height: 24,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: modelSheetMenu,
                      child:CircleAvatar(
                        child: Image.asset("assets/images/userdemo.png"),
                        // backgroundImage: AssetImage("assets/images/userdemo.png")1,
                        //backgroundColor: AppColors.primary,
                        radius:8.h,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("First Name",fNameC, true),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Last Name",lNameC,true),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Email",emailIdC,false),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField("Phone Number",PhnNoC, true),
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
                  child: Text("Save Details"),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.primary,
                      padding: EdgeInsets.all(16)),
                  onPressed: () async{
                    print("Controller = " + fNameC.toString() + "UFNm = " + userProvider.user!.FirstName.toString());
                    if(fNameC.text==userProvider.user!.FirstName&&lNameC.text==userProvider.user!.LastName&&PhnNoC.text==userProvider.user!.PhoneNumber){
                        final snackBar = SnackBar(
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        content: Text("No Changes Found"),
                        margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                        backgroundColor: Colors.black87,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else{
                        await LoginSignupController().updateProfile(context,fNameC.text,lNameC.text,PhnNoC.text,emailIdC.text);
                    }
                    
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
                Text("Select Profile Image From",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                SizedBox(height: 16,),
                Divider(color: Colors.black45, thickness: 0.5,),
                SizedBox(height: 8,),
                InkWell(onTap: ()async{
                  pickedFile = null;
                  Navigator.pop(context);
                  pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                },
                  child: Text("Gallery",style: TextStyle(color: AppColors.primary,fontSize: 16),)),
                SizedBox(height: 8,),
                Divider(color: Colors.black45, thickness: 0.5,),
                SizedBox(height: 8,),
                InkWell(onTap: () async{
                pickedFile = null;
                Navigator.pop(context);
                pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
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