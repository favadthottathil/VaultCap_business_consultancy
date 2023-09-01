import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/authentication/sign_in/sign_in.dart';
import 'package:taxverse/view/widgets/frosted_glass/frosted_glass.dart';

class SignUpWigets {
  // <<---------------------------------------------------------->>

  //                       Next widget

  static InkWell alreadyhaveAccount(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ));
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: Color(0xa0000000),
          ),
          children: [
            TextSpan(
              text: 'Already have a account?',
              style: GoogleFonts.poppins(),
            ),
            TextSpan(
              text: ' Sign In',
              style: AppStyle.poppinsBold18,
            ),
          ],
        ),
      ),
    );
  }

  // <<---------------------------------------------------------->>

  //                       Next widget

  static Container signUpbutton(MediaQueryData mediaQuery) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      width: double.infinity,
      height: 0.088 * mediaQuery.size.height,
      decoration: BoxDecoration(
        color: const Color(0xff000000),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  // <<---------------------------------------------------------->>

  //                       Next widget

  static SizedBox signUpLogo() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.asset(
          'Asset/TAXVERSE LOGO-1.png',
        ),
      ),
    );
  }

  // <<---------------------------------------------------------->>

  //                       Next widget

  static Center loadingScreen() {
    // Timer(const Duration(seconds: 10), () {});
    return const Center(
      child: FrostedGlass(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SpinKitCircle(
            color: blackColor,
          ),
        ),
      ),
    );
  }

  // <<---------------------------------------------------------->>

  //                       Next widget

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(email)) {
      return 'Enter a valid Email';
    }
    return null;
  }

  // <<---------------------------------------------------------->>

  //                       Next widget
}

class CustomTextFieldforRegister extends StatelessWidget {
  const CustomTextFieldforRegister({
    super.key,
    required this.mediaQuery,
    required this.namecontroller,
    required this.hintText,
    this.autovalidateMode,
    this.validator,
    this.obscureText = false,
  });

  final MediaQueryData mediaQuery;
  final TextEditingController namecontroller;

  final AutovalidateMode? autovalidateMode;

  final String? Function(String?)? validator;

  final String hintText;

  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.04),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          controller: namecontroller,
          autovalidateMode: autovalidateMode,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.03, horizontal: mediaQuery.size.width * 0.04),
            filled: true,
            border: InputBorder.none,
            fillColor: greyColor,
            hintText: hintText,
            hintStyle: AppStyle.poppinsRegular15,
          ),
        ),
      ),
    );
  }
}

// <<---------------------------------------------------------->>

//                       Next widget
