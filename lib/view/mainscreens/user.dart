// import 'dart:developer';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:taxverse/api/api.dart';
// import 'package:taxverse/constants.dart';
// import 'package:taxverse/controller/providers/auth_provider.dart';
// import 'package:taxverse/utils/client_id.dart';
// import 'package:taxverse/view/mainscreens/home_screen.dart';
// import 'package:taxverse/view/user/user_details.dart';
// import 'package:taxverse/view/user/user_edit.dart';

// class User1 extends StatelessWidget {
//   User1({super.key});


  

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: ClientData.client,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final user = snapshot.data?.data();

//           if (user != null) {
//             return SafeArea(
//               child: Scaffold(
//                 backgroundColor: whiteColor,
//                 resizeToAvoidBottomInset: false,
//                 body: SizedBox(
//                   width: double.maxFinite,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 32),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 28,
//                                   bottom: 34,
//                                 ),
//                                 child: Text(
//                                   'Hello User',
//                                   overflow: TextOverflow.ellipsis,
//                                   textAlign: TextAlign.left,
//                                   style: AppStyle.poppinsBold24,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 28,
//                                   bottom: 34,
//                                   right: 20,
//                                 ),
//                                 child: IconButton(
//                                     onPressed: () async {
//                                       await APIs.updateActiveStatus(false);
//                                       context.read<AuthProvider>().logOut(context);
//                                     },
//                                     icon: const Icon(
//                                       Icons.logout,
//                                     )),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(60),
//                           child: Container(
//                             margin: const EdgeInsets.only(
//                               left: 80,
//                               top: 19,
//                               right: 80,
//                               bottom: 19,
//                             ),
//                             decoration: const BoxDecoration(
//                               color: whiteColor,
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(74),
//                                   child: Image.asset(
//                                     'Asset/dp.png',
//                                     height: 149,
//                                     width: 149,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 10),
//                                   child: Text(
//                                     user[0]['Name'],
//                                     overflow: TextOverflow.ellipsis,
//                                     textAlign: TextAlign.left,
//                                     style: AppStyle.poppinsBold24,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 18,
//                                   width: 153,
//                                   child: Stack(
//                                     alignment: Alignment.center,
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'ClientData.userEmail!',
//                                           // overflow: TextOverflow.ellipsis,
//                                           textAlign: TextAlign.left,
//                                           style: AppStyle.poppinsBold12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.center,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => const UserEdit(),
//                                               ));
//                                         },
//                                         child: Container(
//                                           margin: const EdgeInsets.only(
//                                             top: 20,
//                                           ),
//                                           child: SvgPicture.asset(
//                                             'Asset/img_edit.svg',
//                                             height: 50,
//                                             width: 50,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 20),
//                                       IconButton(
//                                           onPressed: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) => const UserDetails(),
//                                                 ));
//                                           },
//                                           icon: const Icon(
//                                             Icons.info,
//                                             size: 50,
//                                           ))
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 37,
//                           top: 41,
//                         ),
//                         child: Text(
//                           'Client History',
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.left,
//                           style: AppStyle.poppinsBold16,
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                             left: 58,
//                             top: 25,
//                             right: 12,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Internal Audit',
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.left,
//                                 style: AppStyle.poppinsBold16,
//                               ),
//                               const SizedBox(height: 7),
//                               Text(
//                                 "Aug 3 2021  ",
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.center,
//                                 style: AppStyle.poppinsBold12,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                           padding: const EdgeInsets.only(left: 60, top: 10),
//                           child: Container(
//                             color: blackColor.withOpacity(0.1),
//                             height: 30,
//                             width: 50,
//                             child: Center(
//                                 child: Text(
//                               'More',
//                               style: AppStyle.poppinsBold12,
//                             )),
//                           ))
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//         } else if (snapshot.hasError) {
//           return SizedBox(
//             child: Center(
//               child: InkWell(
//                 onTap: () {
//                   AwesomeDialog(
//                     context: context,
//                     dialogType: DialogType.warning,
//                     animType: AnimType.topSlide,
//                     showCloseIcon: true,
//                     title: 'Delete Message',
//                     desc: 'Are you really want to delete this message',
//                     btnOkText: 'Return Home',
//                     btnOkColor: blackColor,
//                     btnOkIcon: Icons.home,
//                     btnOkOnPress: () => Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const HomeScreen(),
//                         ),
//                         (route) => false),
//                   ).show();
//                 },
//               ),
//             ),
//           );
//         } else {
//           return const SpinKitThreeBounce(
//             color: blackColor,
//           );
//         }
//         return const SpinKitThreeBounce(color: blackColor);
//       },
//     );
//   }
// }

// ElevatedButton(
//             onPressed: () {
//               context.read<AuthProvider>().logOut();
//               Provider.of<AuthProvider>(context,listen: false).isUser == false;
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const RegisterWithPhone(),
//                   ),
//                   (route) => false);
//             },
//             child: const Text('log out'),
//           ),
