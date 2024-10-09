import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
