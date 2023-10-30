import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/api/auth.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/utils/constant/sizedbox.dart';
import 'package:taxverse/view/authentication/provider/auth_provider.dart';
import 'package:taxverse/view/authentication/sign_up/widget/signup_widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: SignUpBody(
          mediaQuery: mediaQuery,
          namecontroller: namecontroller,
          emailcontroller: emailcontroller,
          passcontroller: passcontroller,
          confirmController: confirmController,
          authProvider: authProvider,
        ),
      ),
    );
  }
}

class SignUpBody extends StatelessWidget {
  const SignUpBody({
    super.key,
    required this.mediaQuery,
    required this.namecontroller,
    required this.emailcontroller,
    required this.passcontroller,
    required this.confirmController,
    required this.authProvider,
  });

  final MediaQueryData mediaQuery;
  final TextEditingController namecontroller;
  final TextEditingController emailcontroller;
  final TextEditingController passcontroller;
  final TextEditingController confirmController;
  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            sizedBoxHeight20,
            SignUpWigets.signUpLogo(),
            Column(
              children: [
                sizedBoxHeight20,
                Text(
                  'Register With Us!',
                  textAlign: TextAlign.center,
                  style: AppStyle.poppinsBold20,
                ),
                sizedBoxHeight10,
                Text(
                  'Your information is safe with us',
                  style: GoogleFonts.poppins(),
                ),
                sizedBoxHeight20,
                CustomTextFieldforRegister(
                  mediaQuery: mediaQuery,
                  namecontroller: namecontroller,
                  hintText: 'Enter Your Name',
                ),
                sizedBoxHeight20,
                CustomTextFieldforRegister(
                  mediaQuery: mediaQuery,
                  namecontroller: emailcontroller,
                  hintText: 'Enter Your Email',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: SignUpWigets.validateEmail,
                ),
                sizedBoxHeight20,
                CustomTextFieldforRegister(
                  mediaQuery: mediaQuery,
                  namecontroller: passcontroller,
                  hintText: 'Enter Your Password',
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (pass) => pass != null && pass.length < 6 ? 'Enter min 6 Characters' : null,
                ),
                sizedBoxHeight20,
                CustomTextFieldforRegister(
                  mediaQuery: mediaQuery,
                  namecontroller: confirmController,
                  hintText: 'Confirm your password',
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (pass) => pass != null && pass.length < 6 ? 'Enter min 6 Characters' : null,
                ),
                SizedBox(height: mediaQuery.size.height * 0.04),
                InkWell(
                  onTap: () {
                    authProvider.setLoading = true;
                    AuthSignUp.signUp(
                      authProvider,
                      emailcontroller,
                      passcontroller,
                      confirmController,
                      namecontroller,
                      context,
                    );
                  },
                  child: SignUpWigets.signUpbutton(mediaQuery),
                ),
                sizedBoxHeight10,
                SignUpWigets.alreadyhaveAccount(context),
              ],
            )
          ],
        ),
        if (authProvider.loading) SignUpWigets.loadingScreen(),
      ],
    );
  }
}
