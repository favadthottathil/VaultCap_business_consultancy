import 'package:flutter/material.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';

class SplashWidgets {


  // <<---------------------------------------------------------->>

  //                       Next widget 


  static SizedBox splashTextContainer2(MediaQueryData mediaQuery) {
    return SizedBox(
      width: 0.9 * mediaQuery.size.width,
      height: 0.24 * mediaQuery.size.height,
      child: Text(
        'Welcome to our business consultancy application, where we specialize in unleashing the full potential  of your business. Our team of experts is dedicated to providing the best-in-class consultancy services tailored to your unique needs. From strategic planning to growth strategies, we are here to guide you towards success',
        textAlign: TextAlign.left,
        style: AppStyle.poppinsRegular15,
      ),
    );
  }

  // <<---------------------------------------------------------->>

  //                       Next widget 

  static Container splashTextContainer(MediaQueryData mediaQuery) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 0.72 * mediaQuery.size.width,
      ),
      child: Text(
        'Unleash the power of your business with expert consultancy.',
        textAlign: TextAlign.center,
        style: AppStyle.poppinsBold16,
      ),
    );
  }

  // <<---------------------------------------------------------->>

  //                       Next widget 

  static Stack stackLogoAndImage(MediaQueryData mediaQuery) {
    return Stack(
      children: [
        Positioned(
          left: 0.22 * mediaQuery.size.width,
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
      ],
    );
  }

  // <<---------------------------------------------------------->>

  //                       Next widget 
}

class GetStartedContainer extends StatelessWidget {
  const GetStartedContainer({
    super.key,
    required this.mediaQuery,
  });

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        height: 0.086 * mediaQuery.size.height,
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


// <<---------------------------------------------------------->>

  //                       Next widget 