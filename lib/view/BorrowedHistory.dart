// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, library_private_types_in_public_api, unnecessary_const

import 'package:book_hook/widget/drawer_tray.dart';
import 'package:flutter/material.dart';
import '../global/AppColors.dart';
class BorrowedHistory extends StatefulWidget {
  const BorrowedHistory({Key? key}) : super(key: key);
  @override
  _BorrowedHistoryState createState() => _BorrowedHistoryState();
}

 

class _BorrowedHistoryState extends State<BorrowedHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerTray(),
      appBar: AppBar(
        title: (const Text('Borrowed History')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),

     

      body: Card(
        elevation: 8,
        margin: const EdgeInsets.all(10),
        child: Container(
          height: 100,
          color: Colors.white,
          child: Row(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Expanded(
                    flex: 2,
                    child: Image.asset("assets/images/logo1.png"),
                  ),
                ),
              ),

              Expanded(
                flex: 8,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: ListTile(
                          title: Text("BookName"),
                          subtitle: const Text("Author:{Author Name}"),
                        ),
                      ),

                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: const Text(
                                'Lender:{Lender Name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                              ),
                              onPressed: () {},
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            TextButton(

                              child: Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: AppColors.primary,
                              ),

                              //const Text("Message"),

                              onPressed: () {},
                            ),

                            const SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}