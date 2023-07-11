import 'package:flutter/material.dart';
import 'package:taxverse/controller/notificatin_services.dart';
import 'widgets/splash_Widgets/splash_widget.dart';

class Splash extends StatelessWidget {
  Splash({super.key});

  NotificationServices notificationServices = NotificationServices();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final mediaQuery = MediaQuery.of(context);

        return SafeArea(
          child: Scaffold(
            body: SplashContainer(mediaQuery: mediaQuery),
          ),
        );
      },
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
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: mediaQuery.size.height * 0.01),
          SizedBox(
            height: 0.4 * mediaQuery.size.height,
            child: SplashWidgets.stackLogoAndImage(mediaQuery),
          ),
          SizedBox(height: 0.03 * mediaQuery.size.height),
          SplashWidgets.splashTextContainer(mediaQuery),
          SizedBox(
            height: mediaQuery.size.height * 0.05,
          ),
          SplashWidgets.splashTextContainer2(mediaQuery),
          SizedBox(
            height: 0.08 * mediaQuery.size.height,
          ),
          GetStartedContainer(mediaQuery: mediaQuery),
        ],
      ),
    );
  }
}
