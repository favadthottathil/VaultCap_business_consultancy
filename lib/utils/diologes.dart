import 'package:flutter/material.dart';
import 'package:taxverse/constants.dart';

class Diologes {
  static showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppStyle.poppinsBoldWhite12,
        ),
        backgroundColor: blackColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
