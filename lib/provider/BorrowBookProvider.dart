import 'package:flutter/cupertino.dart';

class BorrowBookProvider extends ChangeNotifier{
  int? postalCount;
  int? borrowedCount;
  bool isLoading = false;
  List<String> postals = [] ;
  List<dynamic> borrowedBooks = [];
  List<dynamic> searchBooks = [];
}