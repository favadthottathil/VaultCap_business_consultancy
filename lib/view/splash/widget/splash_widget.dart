import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';

class SplashWidgets {
  // Widget to display a description of the application.
  static Widget splashTextContainer2(MediaQueryData mediaQuery) {
    return SizedBox(
      width: 80.w,
      child: Text(
        'Welcome to our business consultancy application, where we specialize in unleashing the full potential of your business. Our team of experts is dedicated to providing the best-in-class consultancy services tailored to your unique needs. From strategic planning to growth strategies, we are here to guide you towards success',
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          color: blackColor,
          letterSpacing: 1,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  // Widget to display a short application description.
  static Widget splashTextContainer(MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Text(
        'Unleash the power of your business with expert consultancy.',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 13.sp,
          color: blackColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // Widget to display the application logo and image.
  static Widget stackLogoAndImage(MediaQueryData mediaQuery) {
    return Stack(
      children: [
        Positioned(
          left: 20.w,
          child: Align(
            child: SizedBox(
              width: 60.w,
              height: 15.h,
              child: Image.asset(
                'Asset/TAXVERSE LOGO-1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 12.h,
          child: SizedBox(
            width: mediaQuery.size.width,
            height: 27.h,
            child: Image.asset(
              'Asset/splash.png',
              width: mediaQuery.size.width,
              height: 4.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}

class GetStartedContainer extends StatelessWidget {
  const GetStartedContainer({
    Key? key,
    required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNav(isGuest: false),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.h),
        width: double.infinity,
        height: 8.h,
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
    );
  }
}
