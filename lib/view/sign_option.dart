import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/register_phone.dart';
import 'package:taxverse/view/sign_up.dart';
import 'package:taxverse/view/sign_in.dart';

class SignOption extends StatelessWidget {
  const SignOption({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(
            left: 43,
            right: 34,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImage(
                radius: BorderRadius.circular(7),
                imagePath: ImageConstant.taxverseLogo,
                height: 100,
                width: 250,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: SvgPicture.asset(
                  ImageConstant.chooseSignImg,
                  height: 277,
                  width: 324,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 62),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ));
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account',
                          style: AppStyle.poppinsRegular16,
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: AppStyle.poppinsBold16,
                        )
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                child: Container(
                  width: 315,
                  height: 60,
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 19,
                    right: 76,
                    bottom: 19,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: blackColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      'Sign up with email',
                      style: GoogleFonts.poppins(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterWithPhone(),
                      ));
                },
                child: Container(
                  width: 315,
                  height: 60,
                  margin: const EdgeInsets.only(top: 30, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: whiteColor,
                    border: Border.all(
                      color: blackColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'sign up with phone',
                      textAlign: TextAlign.left,
                      style: AppStyle.poppinsBold16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.radius,
    required this.imagePath,
    required this.height,
    required this.width,
  });

  final BorderRadiusGeometry radius;

  final String imagePath;

  final double height;

  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: Image.asset(
        imagePath,
        height: height,
        width: width,
      ),
    );
  }
}
