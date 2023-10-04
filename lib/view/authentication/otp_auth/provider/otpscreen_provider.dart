import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/api/api_const.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/authentication/otp_auth/provider/otp_time_provider.dart';

class OtpScreenProvider extends ChangeNotifier {
  String? otpCode;

  onCompleted(String value) {
    otpCode = value;
    notifyListeners();
  }

  

  





}
