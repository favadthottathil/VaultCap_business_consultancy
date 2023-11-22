import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vaultcap/api/auth.dart';
import 'package:vaultcap/utils/constant/constants.dart';
import 'package:vaultcap/utils/diologes.dart';
import 'package:vaultcap/view/authentication/otp_auth/provider/otp_time_provider.dart';
import 'package:vaultcap/view/mainscreens/navigate_screen.dart';

// ignore: must_be_immutable
class EnterUsersEmail extends StatelessWidget {
  EnterUsersEmail({Key? key}) : super(key: key);

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 20,
              child: Text('ENTER YOUR EMAIL ADDRESS', style: AppStyle.poppinsBold20),
            ),
            Positioned(
              top: 110,
              left: 20,
              child: SizedBox(
                width: size.height * 0.4,
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: blackColor.withOpacity(0.1),
                    hintText: 'Enter Your Name',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: const Color(0xa0000000),
                    ),
                  ),
                ),
                // child: TextFormField(),
              ),
            ),
            Positioned(
              top: 190,
              left: 20,
              child: SizedBox(
                width: size.height * 0.4,
                child: TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
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
                // child: TextFormField(),
              ),
            ),
            Positioned(
              top: 270,
              left: 20,
              child: Consumer<OtpTimeProvider>(
                builder: (context, value, child) {
                  return GestureDetector(
                    onTap: () {
                      if (value.hideButton) return;

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.scale,
                        showCloseIcon: true,
                        title: '',
                        desc: 'Confirm and go to homescreen..',
                        btnOkColor: Colors.green,
                        btnOkText: 'Yes',
                        btnCancelText: 'Cancel',
                        btnCancelOnPress: () {},
                        btnCancelColor: Colors.red,
                        buttonsTextStyle: AppStyle.poppinsBold16,
                        dismissOnBackKeyPress: true,
                        titleTextStyle: AppStyle.poppinsBold16Green,
                        descTextStyle: AppStyle.poppinsBold16,
                        transitionAnimationDuration: const Duration(milliseconds: 500),
                        btnOkOnPress: () {
                          var user = firebaseAuth.currentUser!;

                          updateMail(user, context).then(
                            (_) {
                              log(user.email ?? 'no mail');
                              log(user.phoneNumber ?? 'no phone ');

                              if (user.email == null) return;

                              AuthSignUp.addUserDetails(name.text.trim(), emailController.text, '', user.phoneNumber ?? '');

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BottomNav(isGuest: false),
                                  ));
                              log('success');
                            },
                          );
                        },
                        buttonsBorderRadius: BorderRadius.circular(20),
                      ).show();
                    },
                    child: Container(
                      width: size.width * 0.4,
                      height: 0.05 * size.height,
                      decoration: BoxDecoration(
                        color: const Color(0xff000000),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          value.hideButton ? 'Back' : 'Confirm',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 280,
              left: 280,
              child: Consumer<OtpTimeProvider>(
                builder: (context, value, child) {
                  return Text(value.getFormattedText(value.secondsRemaining),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(email)) {
      return 'Enter a valid Email';
    }
    return null;
  }

  Future<void> updateMail(User user, BuildContext context) async {
    try {
      await user.updateEmail(emailController.text);
      await FirebaseFirestore.instance.collection('ClientDetails').where(user.uid);
      log('okke');
    } catch (e) {
      log('failed to set mail $e');
      if (e.toString().contains('firebase_auth/email-already-in-use')) {
        Diologes.showSnackbar(context, 'User Already registred');
      }
    }
  }
}
