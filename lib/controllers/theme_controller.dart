import 'package:contact_diary_app/models/contacts_model.dart';
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool isTheme = false;
  late AnimationController _iconAnimationController;

  ThemeController(TickerProvider vsync) {
    _iconAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(
        milliseconds: 300,
      ),
    );

    if (isTheme) {
      _iconAnimationController.forward();
    } else {
      _iconAnimationController.reverse();
    }
  }

  bool get isDarkMode => isTheme;

  AnimationController get iconAnimationController => _iconAnimationController;

  void changeTheme() {
    isTheme = !isTheme;

    if (isTheme) {
      _iconAnimationController.forward();
    } else {
      _iconAnimationController.reverse();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }
}
