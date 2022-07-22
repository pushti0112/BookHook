import 'package:book_hook/controller/BorrowBookController.dart';
import 'package:book_hook/widget/drawer_tray.dart';
import 'package:flutter/material.dart';
import '../global/AppColors.dart';
import 'SplashScreen.dart';
import 'package:sizer/sizer.dart';
import '';

class BorrowBook extends StatefulWidget {
  const BorrowBook({Key? key}) : super(key: key);

  @override
  _BorrowBookState createState() => _BorrowBookState();
}

class _BorrowBookState extends State<BorrowBook> {

    @override
  void initState(){
    
    // TODO: implement initState
    print("In INIT");
    WidgetsBinding.instance.addPostFrameCallback((_) async{

      await BorrowBookController().getPostals(context);
  });   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (const Text('Borrow Book')),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.primary,
        ),
        drawer: DrawerTray(),
        body: ListView(physics: const BouncingScrollPhysics(), children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  hintText: "Enter BookType",
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  hintText: "Enter Location",
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: const InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 0.5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  hintText: "Enter Radius",
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: ElevatedButton(
                child: const Text("Save Details"),
                style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                    padding: const EdgeInsets.all(20)),
                onPressed: () async {
                  //   // userProvider.user = await LoginSignupController()
                  //   //     .getLoggedInUser(emailIdC.text, passC.text);

                  //   // userProvider.notifyListeners();

                  //   // print(userProvider.user?.Status ?? 0);

                  //   if (userProvider.user!.Status == 1) {
                  //     Navigator.pushReplacement(context,
                  //         MaterialPageRoute(builder: (context) => HomeScreen()));
                  //   } else {
                  final snackBar = SnackBar(
                    duration: const Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    content: Text('print something'),
                    margin:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    backgroundColor: Colors.black87,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              )),
        ]));
  }
}
