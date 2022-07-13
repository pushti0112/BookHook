// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, library_private_types_in_public_api, unnecessary_const

import 'package:flutter/material.dart';
import '../global/AppColors.dart';

class BorrowedBooksScreen extends StatefulWidget {
  const BorrowedBooksScreen({Key? key}) : super(key: key);

  @override
  _BorrowedBooksScreenState createState() => _BorrowedBooksScreenState();
}

class _BorrowedBooksScreenState extends State<BorrowedBooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (const Text('Borrowed Books')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [],
        ),
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
                                'Borrower:{Borrower Name}',
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
