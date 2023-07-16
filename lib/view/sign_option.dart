import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';
import 'package:taxverse/view/register_phone.dart';
import 'package:taxverse/view/sign_up.dart';
import 'package:taxverse/view/sign_in.dart';

class SignOption extends StatelessWidget {
  const SignOption({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: size.width * 0.09,
            right: size.width * 0.08,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              CustomImage(
                radius: BorderRadius.circular(7),
                imagePath: ImageConstant.taxverseLogo,
                height: size.height * 0.1,
                width: size.width * 0.6,
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.01),
                child: SvgPicture.asset(
                  ImageConstant.chooseSignImg,
                  height: size.height * 0.2,
                  width: size.width * 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.08),
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                child: Container(
                  width: size.width * 0.7,
                  height: size.height * 0.07,
                  margin: const EdgeInsets.only(top: 50),
                  padding: EdgeInsets.only(
                    left: size.width * 0.07,
                    top: size.height * 0.02,
                    // right: size.width * 0.7,
                    // bottom: size.,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: blackColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width * 0.1),
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
                        builder: (context) =>  RegisterWithPhone(),
                      ));
                },
                child: Container(
                  width: size.width * 0.7,
                  height: size.height * 0.07,
                  margin: EdgeInsets.only(top: size.height * 0.04),
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
              SizedBox(height: size.height * 0.06),
              GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNav(guest: true),
                    ),
                    (route) => false),
                child: Container(
                  width: size.width * 0.4,
                  height: size.height * 0.04,
                  // margin: EdgeInsets.only(top: size.height * 0.04),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: blackColor,
                    border: Border.all(
                      color: blackColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Guest',
                      textAlign: TextAlign.left,
                      style: AppStyle.poppinsBoldWhite12,
                    ),
                  ),
                ),
              )
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
