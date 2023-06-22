import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:taxverse/constants.dart';
import 'package:taxverse/utils/utils.dart';
import 'package:taxverse/view/widgets/frosted_glass.dart';

import 'package:taxverse/view/open_email.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  void resetPassword(AuthProvider provider) async {
    // final isValid = formkey.currentState!.validate();
    // if (!isValid) return;

    final msg = await provider.resetPassword(email.text);

    if (msg == '') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EmailVerification(),
        ),
      );
    } else {
      showSnackBar(context, msg);
    }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(msg),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageConstant.imgArrowleft,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 30),
                        Text(
                          'Back',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            color: blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(
                              'Reset Password',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                color: blackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(
                              'Enter Your email associated with your  account ',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'and we’ll send an email with instructions to ',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'reset your password',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(
                              'Email Address',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                color: blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TextFormField(
                                controller: email,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                // validator: validateEmail,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: blackColor.withOpacity(0.1),
                                  hintText: 'Enter Your email',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    color: const Color(0xa0000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              // signIn(authprovider);

                              resetPassword(authProvider);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 0.075 * mediaQuery.size.height,
                              decoration: BoxDecoration(
                                color: const Color(0xff000000),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Send Instructions',
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (authProvider.loading)
              const Center(
                child: FrostedGlass(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: SpinKitCircle(
                      color: blackColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
