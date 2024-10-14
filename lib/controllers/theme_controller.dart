import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void changeIcon() {
    if (_isDarkMode) {
      IconData icon = Icons.dark_mode;
    } else {
      IconData icon = Icons.light_mode;
    }
    notifyListeners();
  }
}
