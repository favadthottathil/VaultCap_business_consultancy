import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:taxverse/controller/notificatin_services.dart';
import 'widget/splash_widget.dart';

class Splash extends StatefulWidget {
  Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    // FinancialNewsService().fetchFinancialNews();
  }

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
    Key? key,
    required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Your app's logo and image
          SizedBox(
            height: 40.h,
            child: SplashWidgets.stackLogoAndImage(mediaQuery),
          ),
          SizedBox(height: 2.h),
          // Text containers for your splash screen
          SplashWidgets.splashTextContainer(mediaQuery),
          SizedBox(height: 3.h),
          SplashWidgets.splashTextContainer2(mediaQuery),
          SizedBox(height: 4.h),
          // Container for getting started button
          GetStartedContainer(mediaQuery: mediaQuery),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
