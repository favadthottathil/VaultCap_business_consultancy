import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taxverse/constants.dart';


class UserEdit extends StatefulWidget {
  const UserEdit({super.key});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController businessNameContoller = TextEditingController();

  TextEditingController businessTypeContoller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        'Edit User',
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
                  Positioned(
                    top: 110,
                    left: 220,
                    child: SvgPicture.asset(
                      ImageConstant.dpEdit,
                      height: 30,
                      width: 30,
                    ),
                  )
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 7, top: 21),
              //   child: Text(
              //     'Personal Information',
              //     overflow: TextOverflow.ellipsis,
              //     textAlign: TextAlign.left,
              //     style: GoogleFonts.poppins(
              //       color: blackColor,
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              const UserDetialsHead(
                name: 'Personal Information',
                left: 7,
                top: 21,
                fontsize: 15,
                fontWeight: FontWeight.bold,
                color: blackColor,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 7, top: 17),
              //   child: Text(
              //     'Your Name',
              //     overflow: TextOverflow.ellipsis,
              //     textAlign: TextAlign.left,
              //     style: GoogleFonts.poppins(
              //       color: blackColor,
              //       fontSize: 15,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
              const UserDetialsHead(
                name: 'Your Name',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 15),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(10),
              //     child: TextFormField(
              //       controller: nameController,
              //       decoration: InputDecoration(
              //         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //         border: InputBorder.none,
              //         filled: true,
              //         fillColor: blackColor.withOpacity(0.1),
              //         hintText: 'Enter Your Name',
              //         hintStyle: GoogleFonts.poppins(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w400,
              //           height: 1.5,
              //           color: const Color(0xa0000000),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              UserEditTextfield(controller: nameController, hintText: 'John Doe'),
              // Padding(
              //   padding: const EdgeInsets.only(left: 7, top: 17),
              //   child: Text(
              //     'Your Name',
              //     overflow: TextOverflow.ellipsis,
              //     textAlign: TextAlign.left,
              //     style: GoogleFonts.poppins(
              //       color: blackColor,
              //       fontSize: 15,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
              const UserDetialsHead(
                name: 'Your Email',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 15),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(10),
              //     child: TextFormField(
              //       controller: nameController,
              //       decoration: InputDecoration(
              //         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //         border: InputBorder.none,
              //         filled: true,
              //         fillColor: blackColor.withOpacity(0.1),
              //         hintText: 'Enter Your Name',
              //         hintStyle: GoogleFonts.poppins(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w400,
              //           height: 1.5,
              //           color: const Color(0xa0000000),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              UserEditTextfield(controller: nameController, hintText: 'favadfavad2@gmail.com'),
              const UserDetialsHead(
                name: 'Phone Number',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              UserEditTextfield(controller: nameController, hintText: '8129613355'),
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
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              UserEditTextfield(controller: nameController, hintText: 'Taxverse'),
              const UserDetialsHead(
                name: 'Business Type',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              UserEditTextfield(controller: nameController, hintText: 'Partnership'),
              const SizedBox(height: 20)
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

class UserDetialsHead extends StatelessWidget {
  const UserDetialsHead({
    super.key,
    required this.name,
    required this.left,
    required this.top,
    required this.fontsize,
    required this.fontWeight,
    required this.color,
  });

  final String name;

  final double left;

  final double top;

  final double fontsize;

  final FontWeight fontWeight;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top),
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
          color: blackColor,
          fontSize: fontsize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class UserEditTextfield extends StatelessWidget {
  const UserEditTextfield({super.key, required this.controller, required this.hintText});

  final TextEditingController controller;

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            border: InputBorder.none,
            filled: true,
            fillColor: blackColor.withOpacity(0.1),
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: const Color(0xa0000000),
            ),
          ),
        ),
      ),
    );
  }
}
