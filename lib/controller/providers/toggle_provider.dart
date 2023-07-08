import 'package:flutter/material.dart';

class ToggleProvider extends ChangeNotifier {
  bool toggleValue = false;

  setToggleState() {
    toggleValue = !toggleValue;
    notifyListeners();
  }
}
