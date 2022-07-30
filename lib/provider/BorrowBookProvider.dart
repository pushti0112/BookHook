import 'package:flutter/cupertino.dart';

class BorrowBookProvider extends ChangeNotifier{
  int? postalCount;
  bool isLoading = false;
  List<String> postals = [] ;
}