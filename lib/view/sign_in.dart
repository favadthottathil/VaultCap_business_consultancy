import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/utils/utils.dart';
import 'package:taxverse/view/frosted_glass.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';
import 'package:taxverse/view/reset_pass.dart';
import 'package:taxverse/view/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  bool isSigned = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
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

  void signIn(AuthProvider provider) async {
    final msg = await provider.signIn(emailController.text, passController.text);

    if (msg == '') return;

    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(msg),
    //   ),
    // );
    showSnackBar(context, msg);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.watch<AuthProvider>().stream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) return const BottomNav();

        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final mediaQuery = MediaQuery.of(context);
            final authprovider = context.watch<AuthProvider>();

            return Scaffold(
              body: SafeArea(
                child: Form(
                  key: formkey,
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
                                    'Welcome Back!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      height: 1.5,
                                      color: blackColor,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: 210,
                                    height: 157,
                                    child: Image.asset(
                                      'Asset/sign_in.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: TextFormField(
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              height: 1.5,
                                              color: const Color(0xa0000000),
                                            ),
                                            controller: emailController,
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            validator: validateEmail,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                              border: InputBorder.none,
                                              filled: true,
                                              fillColor: whiteColor,
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
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: TextFormField(
                                        controller: passController,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (pass) => pass != null && pass.length < 6 ? 'Enter min 6 Characters' : null,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: whiteColor,
                                          hintText: 'Enter Your password',
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
                                  // if (formkey.currentState?.validate() ?? false)
                                  //   Container(
                                  //     alignment: Alignment.centerLeft,
                                  //     padding: const EdgeInsets.symmetric(horizontal: 20),
                                  //     child: Text(
                                  //       'Enter min 6 Characters',
                                  //       style: TextStyle(
                                  //         color: Colors.red,
                                  //         fontSize: 12,
                                  //       ),
                                  //     ),
                                  //   ),
                                  Container(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const ResetPassword(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        height: 1.5,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      signIn(authprovider);
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
                                          'Sign In',
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
                          ),
                        ],
                      ),
                      if (authprovider.loading)
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
              ),
            );
          },
        );
      },
    );
  }
}
