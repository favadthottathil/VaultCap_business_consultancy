import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taxverse/constants.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // SizedBox(height: mediaQuery.size.height * 0.02),
          Align(
            alignment: Alignment.center,
            child: Lottie.asset(
              'Animations/143479-scan-unlock.json',
              repeat: true,
              height: mediaQuery.size.height * 0.4,
              width: mediaQuery.size.height * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: mediaQuery.size.height * 0.25,
            left: mediaQuery.size.height * 0.07,
            child: Text(
              'We Are Checking Your\n Application',
              style: AppStyle.poppinsBold24,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: mediaQuery.size.height * 0.38),
              child: Text(
                'We will Send You Notification\n After Complete It',
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
                margin: const EdgeInsets.symmetric(horizontal: 35),
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
