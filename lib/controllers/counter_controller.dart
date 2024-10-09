import 'package:contact_diary_app/models/counter_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterController extends ChangeNotifier {
  int _counter = 0;
  CounterModel counterModel;

  CounterController(this.counterModel);

  int get counter => _counter;

  void increment() async {
    _counter += counterModel.step;
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setInt('counter', _counter);
    notifyListeners();
  }

  void decrement() async {
    if (_counter > 0) {
      _counter -= counterModel.step;
    }
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setInt('counter', _counter);
    notifyListeners();
  }
}
