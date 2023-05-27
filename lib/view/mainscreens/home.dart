// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:taxverse/constants.dart';
// import 'package:taxverse/controller/providers/auth_provider.dart';
// import 'package:taxverse/view/mainscreens/news.dart';
// import 'package:taxverse/view/mainscreens/user.dart';

// import 'package:taxverse/view/user/user_details.dart';
// import 'package:taxverse/view/user/user_edit.dart';
// import 'package:taxverse/view/register_phone.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Center(
//             child: Text('home'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               context.read<AuthProvider>().logOut(context);
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const RegisterWithPhone(),
//                   ),
//                   (route) => false);
//             },
//             child: const Text('log out'),
//           ),
//           const SizedBox(height: 50),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const UserEdit(),
//                 ),
//               );
//             },
//             child: const Text('user edit'),
//           ),
//           const SizedBox(height: 50),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const UserDetails(),
//                   ));
//             },
//             child: const Text('user details'),
//           ),
//           const SizedBox(height: 50),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const RegisterWithPhone(),
//                   ));
//             },
//             child: const Text('otp'),
//           )
//         ],
//       ),
//     );
//   }
// }
