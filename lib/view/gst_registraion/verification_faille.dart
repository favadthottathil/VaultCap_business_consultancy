import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taxverse/constants.dart';

class VerificationFailed extends StatelessWidget {
  const VerificationFailed({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Lottie.asset(
              'Animations/94303-failed.json',
              repeat: true,
              height: mediaQuery.size.height * 0.35,
              width: mediaQuery.size.height * 0.35,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: mediaQuery.size.height * 0.3,
            left: mediaQuery.size.height * 0.18,
            child: Text(
              'Ooops!!!',
              style: AppStyle.poppinsBold24,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: mediaQuery.size.height * 0.45),
              child: Text(
                'Your Application Rejected\nRecheck Your Details ',
                style: AppStyle.poppinsBold20,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: mediaQuery.size.height * 0.1),
              child: Container(
                margin:  EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.1),
                // padding: EdgeInsets.only(bottom: mediaQuery.size.height * 0.2),
                width: double.infinity,
                height: 0.088 * mediaQuery.size.height,
                decoration: BoxDecoration(
                  color: const Color(0xff000000),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Back To Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
