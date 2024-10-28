import 'package:contact_diary_app/controllers/contact_controller.dart';
import 'package:flutter/material.dart';

class BottomNavaigationBarController extends ChangeNotifier {
  int index = 0;

  void getBottomBarIndex({required int index}) {
    this.index = index;

    notifyListeners();
  }
}
