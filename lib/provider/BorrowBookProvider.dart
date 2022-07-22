import 'package:flutter/cupertino.dart';

class BorrowBookProvider extends ChangeNotifier{
  int? postalCount;
  bool isLoading = false;
  List<dynamic>? postals ;
}