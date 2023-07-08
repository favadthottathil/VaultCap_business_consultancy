import 'package:flutter/material.dart';
import 'package:taxverse/controller/notificatin_services.dart';
import 'package:taxverse/utils/constant/sizedbox.dart';
import 'widgets/splash_Widgets/splash_widget.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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
            width: double.infinity,
            height: 0.4 * mediaQuery.size.height,
            child: SplashWidgets.stackLogoAndImage(mediaQuery),
          ),
          SizedBox(height: 0.03 * mediaQuery.size.height),
          SplashWidgets.splashTextContainer(mediaQuery),
          sizedBoxHeight20,
          SplashWidgets.splashTextContainer2(mediaQuery),
          Container(
            height: 0.05 * mediaQuery.size.height,
          ),
          GetStartedContainer(mediaQuery: mediaQuery),
        ],
      ),
    );
  }
}
