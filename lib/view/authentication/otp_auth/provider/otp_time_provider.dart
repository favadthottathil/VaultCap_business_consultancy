import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vaultcap/utils/utils.dart';

class OtpTimeProvider extends ChangeNotifier {
  int _secondsRemaining = 300;

  Timer? _timer;

  bool _hideButton = false;

  bool get hideButton => _hideButton;

  int get secondsRemaining => _secondsRemaining;

  void startTimer(context) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _timer = timer;
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        if (_secondsRemaining == 0) {
          _hideButton = true;
          showSnackBar(context, 'OTP code TimeOut');
        }
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  stopTimer() {
    _timer?.cancel();
  }

  getFormattedText(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedTime = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}
