import 'package:flutter/material.dart';

class NeumorphismButtonState with ChangeNotifier {
  bool _ispressed = false;

  bool get isPressed => _ispressed;

  void setPressed(bool value) {
    _ispressed = value;
    notifyListeners();
  }
}
