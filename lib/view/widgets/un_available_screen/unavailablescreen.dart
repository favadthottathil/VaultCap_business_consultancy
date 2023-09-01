import 'package:flutter/material.dart';
import 'package:taxverse/utils/constant/constants.dart';

class UnAvailableScreen extends StatelessWidget {
  const UnAvailableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: size.width * 0.7,
              child: Text(
                'Sorry This Service Not Available Right Now!!',
                textAlign: TextAlign.center,
                style: AppStyle.poppinsBold16,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
