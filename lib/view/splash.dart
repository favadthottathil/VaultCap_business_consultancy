import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/controller/notificatin_services.dart';
import 'package:taxverse/view/auth_navigator.dart';
import 'package:taxverse/view/mainscreens/home_screen.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';
import 'package:taxverse/view/sign_option.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();

    notificationServices.requestNotificationPermission();

    notificationServices.firebaseInit();

    // notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then(
      (value) {
        print('device token');

        print(value); 
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final mediaQuery = MediaQuery.of(context);

        return SafeArea(
          child: Scaffold(
              body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 0.4 * mediaQuery.size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0.22 * mediaQuery.size.width,
                        top: 0,
                        child: Align(
                          child: SizedBox(
                            width: 0.6 * mediaQuery.size.width,
                            height: 0.19 * mediaQuery.size.height,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.asset(
                                'Asset/TAXVERSE LOGO-1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0.13 * mediaQuery.size.height,
                        child: SizedBox(
                          width: mediaQuery.size.width,
                          height: 0.27 * mediaQuery.size.height,
                          child: Image.asset(
                            'Asset/splash.png',
                            width: mediaQuery.size.width,
                            height: 0.40 * mediaQuery.size.height,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Positioned(
                      //   left: 0.27 * mediaQuery.size.width,
                      //   top: 0.69 * mediaQuery.size.height,
                      //   child: SizedBox(
                      //     width: 0.076 * mediaQuery.size.width,
                      //     height: 0.076 * mediaQuery.size.width,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 0.03 * mediaQuery.size.height),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 0.72 * mediaQuery.size.width,
                  ),
                  child: const Text(
                    'Unleash the power of your business              with expert consultancy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Container(
                //   height: 0.09 * mediaQuery.size.height,
                //   color: Colors.amber,
                // ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 0.9 * mediaQuery.size.width,
                  height: 0.24 * mediaQuery.size.height,
                  child: Text(
                    'Welcome to our business consultancy application, where we specialize in unleashing the full potential  of your business. Our team of experts is dedicated to providing the best-in-class consultancy services tailored to your unique needs. From strategic planning to growth strategies, we are here to guide you towards success',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(fontSize: 15, height: 1.5, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  height: 0.05 * mediaQuery.size.height,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNav(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    width: double.infinity,
                    height: 0.088 * mediaQuery.size.height,
                    decoration: BoxDecoration(
                      color: const Color(0xff000000),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Get Started',
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
              ],
            ),
          )),
        );
      },
    );
  }
}
