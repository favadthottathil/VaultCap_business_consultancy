import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/api/auth.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/view/sign_up.dart';

class SignInWidgets {


  // <<---------------------------------------------------------->>

  //                       Next widget 



  static InkWell goToSignUp(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUp(),
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
            TextSpan(text: 'Don’t have a account?', style: GoogleFonts.poppins()),
            TextSpan(
              text: ' Sign Up',
              style: AppStyle.poppinsBold18,
            ),
          ],
        ),
      ),
    );
  }


  // <<---------------------------------------------------------->>

  //                       Next widget 

  static InkWell signInButton(
    AuthProvider authprovider,
    MediaQueryData mediaQuery,
    String email,
    String pass,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        AuthSignIn.signIn(authprovider, email, pass, context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.09),
        width: double.infinity,
        height: 0.088 * mediaQuery.size.height,
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: AppStyle.poppinsBoldWhite20,
          ),
        ),
      ),
    );
  }


  // <<---------------------------------------------------------->>

  //                       Next widget 

  static Text forgetPassword() {
    return Text(
      'Forgot Password',
      textAlign: TextAlign.center,
      style: AppStyle.poppinsBold18,
    );
  }

  // <<---------------------------------------------------------->>

  //                       Next widget 

  static SizedBox signInImage(MediaQueryData mediaQuery) {
    return SizedBox(
      width: mediaQuery.size.width * 0.57,
      height: mediaQuery.size.height * 0.22,
      child: Image.asset(
        'Asset/sign_in.png',
        fit: BoxFit.cover,
      ),
    );
  }

  // <<---------------------------------------------------------->>

  //                       Next widget 

  static Text signInText() {
    return Text(
      'Welcome Back!',
      textAlign: TextAlign.center,
      style: AppStyle.poppinsBold20,
    );
  }


  // <<---------------------------------------------------------->>

  //                       Next widget 
}
