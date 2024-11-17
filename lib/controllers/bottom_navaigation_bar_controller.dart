import 'package:flutter/material.dart';

class BottomNavigationBarController extends ChangeNotifier {
  int index = 0;

  void getBottomBarIndex({required int index}) {
    this.index = index;

    notifyListeners();
  }
}
