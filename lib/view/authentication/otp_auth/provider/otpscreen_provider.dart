import 'package:flutter/material.dart';

class OtpScreenProvider extends ChangeNotifier {
  String? otpCode;

  onCompleted(String value) {
    otpCode = value;
    notifyListeners();
  }
}
