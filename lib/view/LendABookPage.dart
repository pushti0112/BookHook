import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../global/AppColors.dart';
import 'package:sizer/sizer.dart';

class LendABookPage extends StatefulWidget {
  const LendABookPage({Key? key}) : super(key: key);

  @override
  State<LendABookPage> createState() => _LendABookPageState();
}

class _LendABookPageState extends State<LendABookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Lend a Book'),
        centerTitle: true,
      ),

// Side pane button
      drawer: Drawer(
        child: ListView(
          children: [],
        ),
      ),

// Text Fields
      body: Padding(
          padding:
              EdgeInsets.only(top: 5.h, left: 3.h, right: 3.h, bottom: 3.h),
          child: ListView(
            children: [
//  Book Type text area
              Container(
                color: Colors.grey[200],
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    hintText: "Book Type",
                  ),
                ),
              ),
              SizedBox(height: 15),

// Book Title text area
              Container(
                color: Colors.grey[200],
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    hintText: "Book Title",
                  ),
                ),
              ),
              SizedBox(height: 15),

// Description text area
              Container(
                color: Colors.grey[200],
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    hintText: "Description",
                  ),
                ),
              ),
              SizedBox(height: 15),

// File Upload icon
              Row(children: [
                SizedBox.fromSize(
                  size: Size(6.h, 6.h),
                  child: ClipOval(
                      child: Material(
                          color: AppColors.light3,
                          child: InkWell(
                            // splashColor: AppColors.light3,
                            onTap: () {},
                            child: Icon(
                              Icons.file_upload_outlined,
                              size: 5.h,
                              color: Colors.grey,
                            ),
                          ))),
                ),
                SizedBox(width: 15),
                Text('Upload a cover image'),
              ]),

// Add Button
              Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text("Add"),
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.primary,
                        padding: EdgeInsets.all(16)),
                    onPressed: () {},
                  )),
            ],
          )),
    );
  }
}
