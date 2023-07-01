import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taxverse/constants.dart';

import 'package:taxverse/view/user/user_edit.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SvgPicture.asset(ImageConstant.imgArrowleft2),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Account Details',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(74),
                    child: Image.asset(
                      ImageConstant.dp,
                      height: 149,
                      width: 149,
                    ),
                  ),
                ],
              ),
              const UserDetialsHead(
                name: 'Personal Information',
                left: 7,
                top: 21,
                fontsize: 15,
                fontWeight: FontWeight.bold,
                color: blackColor,
              ),
              const UserDetialsHead(
                name: 'Your Name',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w700,
                color: blackColor,
              ),
              const UserData(text: 'John Doe'),
              const CustomDivider(),
              const UserDetialsHead(
                name: 'Your Email',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w700,
                color: blackColor,
              ),
              const UserData(text: 'favadfavad2@gmail.com'),
              const CustomDivider(),
              const UserDetialsHead(
                name: 'Phone Number',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w700,
                color: blackColor,
              ),
              const UserData(text: '812951442'),
              const CustomDivider(),
              const UserDetialsHead(
                name: 'Business Information',
                left: 7,
                top: 21,
                fontsize: 15,
                fontWeight: FontWeight.bold,
                color: blackColor,
              ),
              const UserDetialsHead(
                name: 'Business Name',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w700,
                color: blackColor,
              ),
              const UserData(text: 'Taxverse'),
              const CustomDivider(),
              const UserDetialsHead(
                name: 'Business Type',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w700,
                color: blackColor,
              ),
              const UserData(text: 'Partnership'),
              const CustomDivider(),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}

class UserData extends StatelessWidget {
  const UserData({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        top: 19,
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
          color: blackColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: Divider(
        height: 1,
        thickness: 1,
        color: blackColor.withOpacity(0.1),
        indent: 1,
      ),
    );
  }
}
