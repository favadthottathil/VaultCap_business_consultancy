// import 'dart:developer';
// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:taxverse/api/auth.dart';
// import 'package:taxverse/utils/constant/constants.dart';
// import 'package:taxverse/utils/shared_preference/store_otp_information.dart';
// import 'package:taxverse/view/authentication/otp_auth/provider/otp_time_provider.dart';

// class EnterUsersEmail extends StatefulWidget {
//   const EnterUsersEmail({Key? key}) : super(key: key);

//   @override
//   State<EnterUsersEmail> createState() => _EnterUsersEmailState();
// }

// class _EnterUsersEmailState extends State<EnterUsersEmail> {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Positioned(
//               top: 40,
//               left: 20,
//               child: Text('ENTER YOUR EMAIL ADDRESS', style: AppStyle.poppinsBold20),
//             ),
//             Positioned(
//               top: 100,
//               left: 20,
//               child: SizedBox(
//                 width: size.height * 0.4,
//                 child: TextFormField(
//                   controller: emailController,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: validateEmail,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor: blackColor.withOpacity(0.1),
//                     hintText: 'Enter Your email',
//                     hintStyle: GoogleFonts.poppins(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w400,
//                       height: 1.5,
//                       color: const Color(0xa0000000),
//                     ),
//                   ),
//                 ),
//                 // child: TextFormField(),
//               ),
//             ),
//             Positioned(
//               top: 190,
//               left: 20,
//               child: GestureDetector(
//                 onTap: () {
//                   var user = firebaseAuth.currentUser!;

//                   updateMail(user).then((_) {
//                     log(user.email ?? 'no mail');
//                     log(user.phoneNumber ?? 'no phone ');

//                     AuthSignUp.addUserDetails('', emailController.text, '', user.phoneNumber ?? '');
//                     log('success');
//                   });
//                 },
//                 child: Container(
//                   width: size.width * 0.4,
//                   height: 0.05 * size.height,
//                   decoration: BoxDecoration(
//                     color: const Color(0xff000000),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: Consumer<OtpTimeProvider>(builder: (context, value, child) {
//                       return Text(
//                         value.hideButton ? 'Back' : 'Confirm',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: whiteColor,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           height: 1.5,
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 200,
//               left: 280,
//               child: Consumer<OtpTimeProvider>(
//                 builder: (context, value, child) {
//                   return Text(value.getFormattedText(value.secondsRemaining),
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ));
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   String? validateEmail(String? email) {
//     if (email == null || email.isEmpty) {
//       return 'Email is required';
//     }
//     if (!EmailValidator.validate(email)) {
//       return 'Enter a valid Email';
//     }
//     return null;
//   }

//   Future<void> updateMail(User user) async {
//     try {
//       String verificationId = await OtpSharedPreferece.getVerificationId();
//       String otp = await OtpSharedPreferece.getOtp();
//       AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
//       await user.reauthenticateWithCredential(credential);
//       await user.updateEmail(emailController.text);

//       log('okke');
//     } catch (e) {
//       log('failed to set mail $e');
//     }
//   }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   Provider.of<OtpTimeProvider>(context, listen: false).stopTimer();
//   // }
// }
