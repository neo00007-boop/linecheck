import 'package:flutter/material.dart';

class BaseViewModel with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
