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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(18.h),
          child: AppBar(
            backgroundColor: AppColors.primary,
            title: Text('Lend a Book'),
            centerTitle: true,

            // Notifications icon
            actions: const [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.notifications),
              ),
            ],
          )),

      // Side pane button
      drawer: Drawer(
        child: ListView(
          children: [],
        ),
      ),
      // Text Fields
      backgroundColor: Color.fromARGB(255, 241, 244, 253),
      body: Padding(
          padding:
              EdgeInsets.only(top: 5.h, left: 3.h, right: 3.h, bottom: 3.h),
          child: ListView(
            children: [
              Text('Book Type', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    fillColor: Colors.white,
                    filled: true),
              ),
              SizedBox(height: 15),
              Text('Book Title', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    fillColor: Colors.white,
                    filled: true),
              ),
              SizedBox(height: 15),
              Text('Description', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    fillColor: Colors.white,
                    filled: true),
              ),
              SizedBox(height: 15),
              Row(children: [
                SizedBox.fromSize(
                  size: Size(6.h, 6.h),
                  child: ClipOval(
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {},
                            child: Icon(
                              Icons.add,
                              size: 5.h,
                              color: Colors.grey,
                            ),
                          ))),
                ),
                SizedBox(width: 15),
                Text('Upload a cover image'),
              ]),
              // Button
              Container(
                margin: EdgeInsets.only(top: 20, left: 50, right: 50),
                width: 1.h,
                height: 5.h,
                child: FlatButton(
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  color: AppColors.primary,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
            ],
          )),
    );
  }
}
