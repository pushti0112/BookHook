import 'package:flutter/cupertino.dart';

class LendBookProvider extends ChangeNotifier{
  int? lendCount;
  bool isLoading = false;
  List<dynamic>? lendedbooks ;
}