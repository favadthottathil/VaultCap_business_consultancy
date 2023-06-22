import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/utils/constand/sizedbox.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';
import 'package:taxverse/view/reset_pass.dart';
import 'widgets/signInwidgets/sign_widgets.dart';
import 'widgets/signUp_widgets/signup_widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final mediaQuery = MediaQuery.of(context);
        final authprovider = context.watch<AuthProvider>();

        // authprovider.setLoading =false;

        return Scaffold(
          body: SafeArea(
            child: Form(
              key: formkey,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      sizedBoxHeight20,
                      SignUpWigets.signUpLogo(),
                      Column(
                        children: [
                          sizedBoxHeight20,
                          SignInWidgets.signInText(),
                          sizedBoxHeight20,
                          SignInWidgets.signInImage(mediaQuery),
                          sizedBoxHeight20,
                          Padding(
                            padding: EdgeInsets.all(mediaQuery.size.height * 0.01),
                            child: CustomTextFieldforRegister(
                              mediaQuery: mediaQuery,
                              namecontroller: emailController,
                              hintText: 'Enter Your Email',
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: validateEmail,
                            ),
                          ),
                          SizedBox(height: mediaQuery.size.height * 0.02),
                          Padding(
                            padding: EdgeInsets.all(mediaQuery.size.height * 0.01),
                            child: CustomTextFieldforRegister(
                              mediaQuery: mediaQuery,
                              namecontroller: passController,
                              hintText: 'Enter Your password',
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (pass) => pass != null && pass.length < 6 ? 'Enter min 6 Characters' : null,
                            ),
                          ),
                          sizedBoxHeight10,
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResetPassword(),
                                ),
                              );
                            },
                            child: SignInWidgets.forgetPassword(),
                          ),
                          SizedBox(
                            height: mediaQuery.size.height * 0.04,
                          ),
                          SignInWidgets.signInButton(
                            authprovider,
                            mediaQuery,
                            emailController.text.trim(),
                            passController.text.trim(),
                            context,
                          ),
                          sizedBoxHeight10,
                          SignInWidgets.goToSignUp(context),
                        ],
                      ),
                    ],
                  ),
                  if (authprovider.loading) SignUpWigets.loadingScreen(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
