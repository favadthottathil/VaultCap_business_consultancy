import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:taxverse/controller/notificatin_services.dart';
import 'widgets/splash_Widgets/splash_widget.dart';

class Splash extends StatelessWidget {
  Splash({super.key});

  NotificationServices notificationServices = NotificationServices();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: SplashContainer(mediaQuery: mediaQuery),
      ),
    );
  }
}

class SplashContainer extends StatelessWidget {
  const SplashContainer({
    super.key,
    required this.mediaQuery,
  });

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // SizedBox(height: .h),
          SizedBox(
            height: 40.h,
            child: SplashWidgets.stackLogoAndImage(mediaQuery),
          ),
          SizedBox(height: 2.h),
          SplashWidgets.splashTextContainer(mediaQuery),
          SizedBox(
            height: 3.h,
          ),
          SplashWidgets.splashTextContainer2(mediaQuery),
          SizedBox(
            height: 4.h,
          ),
          GetStartedContainer(mediaQuery: mediaQuery),
          SizedBox(height: 2.h)
        ],
      ),
    );
  }
}
