import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/db/userinfo.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/utils/utils.dart';
import 'package:taxverse/view/frosted_glass.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';
import 'package:taxverse/view/sign_in.dart';
import 'package:taxverse/view/user/user_details.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final namecontroller = TextEditingController();

  final emailcontroller = TextEditingController();

  final passcontroller = TextEditingController();

  final confirmController = TextEditingController();

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();

    super.dispose();
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

  Future<void> signOut(AuthProvider provider) async {
    if (passConfirmed()) {
      final msg = await provider.signOut(emailcontroller.text, passcontroller.text);

      if (msg == '') {
        log(userName);
        userName = namecontroller.text.trim();
        log(userName);

        addUserDetails(
          namecontroller.text.trim(),
          emailcontroller.text.trim(),
          passcontroller.text.trim(),
        );

        return;
      }

      showSnackBar(context, msg);
    } else {
      showSnackBar(context, 'PassWord does not match');
    }
  }

  // add user details

  Future addUserDetails(String name, String email, String password) async {
    final CollectionReference clientCollection = FirebaseFirestore.instance.collection('ClientDetails');

    // create new document in the 'ClientDetails' collection

    final DocumentReference newClientDocRef = await clientCollection.add({
      'Name': name,
      'Email': email,
      'Password': password,
    });

    // Retrieve the auto-generatied document Id

    final String clientId = newClientDocRef.id;

    ClientID.clientId = clientId;

    // await FirebaseFirestore.instance.collection('Client Details').add({
    //   'Name': name,
    //   'Email': email,
    //   'Password': password,
    // });
  }

  passConfirmed() {
    if (passcontroller.text.trim() == confirmController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().stream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) return const BottomNav();

          // if (!snapshot.hasData) return const SignOption();

          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final mediaQuery = MediaQuery.of(context);

              final authProvider = context.watch<AuthProvider>();

              return Scaffold(
                body: SafeArea(
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.asset(
                                'Asset/TAXVERSE LOGO-1.png',
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            child: Container(
                              height: 700,
                              width: double.infinity,
                              color: const Color(0xffd9d9d9),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    'Register With Us!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      height: 1.5,
                                      color: blackColor,
                                    ),
                                    // TextStyle(fontSize: 20, fontWeight: FontWeight.w700, height: 1.5, color: blackColor),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Your information is safe with us',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: TextFormField(
                                        controller: namecontroller,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: whiteColor,
                                          hintText: 'Enter Your Name',
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
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: TextFormField(
                                        controller: emailcontroller,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: validateEmail,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: whiteColor,
                                          hintText: 'Enter Your Email',
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
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: TextFormField(
                                        controller: passcontroller,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (pass) => pass != null && pass.length < 6 ? 'Enter min 6 Characters' : null,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: whiteColor,
                                          hintText: 'Enter Your Password',
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
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: TextFormField(
                                        controller: confirmController,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (pass) => pass != null && pass.length < 6 ? 'Enter min 6 Characters ' : null,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: whiteColor,
                                          hintText: 'Confirm your password',
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
                                  Container(
                                    height: 40,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      signOut(authProvider);
                                    },
                                    child: Container(
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
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
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
                                          TextSpan(text: 'Already have a account?', style: GoogleFonts.poppins()),
                                          TextSpan(
                                            text: ' Sign In',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              height: 1.5,
                                              color: const Color(0xff000000),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
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
            },
          );
        });
  }
}
