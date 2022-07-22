import 'package:flutter/cupertino.dart';

class BorrowBookProvider extends ChangeNotifier{
  int? borrowCount;
  int? postalCount;
  bool isLoading = false;
  List<dynamic>? borrowedbooks ;
  List<dynamic>? postals;
}