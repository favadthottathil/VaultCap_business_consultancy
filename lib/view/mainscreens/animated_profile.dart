// import 'package:flutter/material.dart';
// import 'package:taxverse/constants.dart';
// import 'package:taxverse/view/user/user_edit.dart';

// class ProfileAnimated extends StatefulWidget {
//   ProfileAnimated({super.key});

//   @override
//   State<ProfileAnimated> createState() => _ProfileAnimatedState();
// }

// class _ProfileAnimatedState extends State<ProfileAnimated> {
//   final nameController = TextEditingController();

//   bool isExpanded = true;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: blackColor,
//       body: SafeArea(
//           child: Container(
//         color: whiteColor,
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               leading: const SizedBox(),
//               pinned: true,
//               backgroundColor: blackColor,
//               expandedHeight: size.height * 0.35,
//               flexibleSpace: LayoutBuilder(
//                 builder: (BuildContext context, BoxConstraints constraints) {
//                   isExpanded = constraints.biggest.height == size.height * 0.35;
//                   return AnimatedContainer(
//                     duration: const Duration(microseconds: 300),
//                     curve: Curves.easeInOut,
//                     height: isExpanded ? null : 56,
//                     child: AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 300),
//                       child: isExpanded
//                           ? Column(
//                               // crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: size.height * 0.06),
//                                 Container(
//                                   height: 100,
//                                   width: 100,
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: whiteColor,
//                                   ),
//                                 ),
//                                 SizedBox(height: size.height * 0.02),
//                                 // if (isExpanded)
//                                 Padding(
//                                   padding: EdgeInsets.only(left: size.width * 0.03),
//                                   child: Text(
//                                     'john wick',
//                                     style: AppStyle.poppinsBoldWhite18,
//                                   ),
//                                 ),
//                                 // if (!isExpanded)
//                               ],
//                             )
//                           : Row(
//                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   height: 56,
//                                   width: 56,
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: whiteColor,
//                                   ),
//                                 ),
//                                 SizedBox(width: size.width * 0.03),
//                                 Text(
//                                   'john wick',
//                                   style: AppStyle.poppinsBoldWhite18,
//                                 )
//                               ],
//                             ),
//                     ),
//                   );
//                 },

//                 // background: Container(
//                 //   color: blackColor,
//                 //   height: size.height * 0.3,
//                 //   width: double.maxFinite,
//                 // ),
//               ),
//             ),

//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (
//                   context,
//                   index,
//                 ) {
//                   return Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: greyColor,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Padding(
//                           //   padding: EdgeInsets.only(left: size.width * 0.05),
//                           //   child: UserDetialsHead(
//                           //     name: 'Your Name',
//                           //     fontsize: 15,
//                           //     top: size.height * 0.02,
//                           //     fontWeight: FontWeight.w400,
//                           //     color: blackColor,
//                           //   ),
//                           // ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: size.width * 0.8,
//                                 child: UserEditTextfield(
//                                   controller: nameController,
//                                   hintText: 'John Doe',
//                                 ),
//                               ),
//                               const Icon(Icons.edit)
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 childCount: 5,
//               ),
//             )

//             // SliverToBoxAdapter(
//             //   child: ListView.builder(
//             //     shrinkWrap: true,
//             //     primary: false,
//             //     itemCount: 5,
//             //     itemBuilder: (context, index) {
//             //       return Padding(
//             //         padding: const EdgeInsets.all(20),
//             //         child: Container(
//             //           decoration: BoxDecoration(
//             //             borderRadius: BorderRadius.circular(10),
//             //             color: greyColor,
//             //           ),
//             //           child: Column(
//             //             crossAxisAlignment: CrossAxisAlignment.start,
//             //             children: [
//             //               Padding(
//             //                 padding: EdgeInsets.only(left: size.width * 0.05),
//             //                 child: UserDetialsHead(
//             //                   name: 'Your Name',
//             //                   fontsize: 15,
//             //                   top: size.height * 0.02,
//             //                   fontWeight: FontWeight.w400,
//             //                   color: blackColor,
//             //                 ),
//             //               ),
//             //               Row(
//             //                 children: [
//             //                   Container(
//             //                     // color: Colors.blue,
//             //                     width: size.width * 0.8,
//             //                     child: UserEditTextfield(controller: nameController, hintText: 'John Doe'),
//             //                   ),
//             //                   Padding(
//             //                     padding: EdgeInsets.only(left: size.width * 0.01),
//             //                     child: Icon(Icons.edit),
//             //                   ),
//             //                 ],
//             //               ),
//             //             ],
//             //           ),
//             //         ),
//             //       );
//             //     },
//             //   ),
//             // )

//             // SliverList(
//             //   delegate: SliverChildListDelegate(
//             //     [
//             //       // SizedBox(height: size.height * 0.),
//             //       ListView.builder(
//             //         shrinkWrap: true,
//             //         primary: false,
//             //         itemCount: 5,
//             //         itemBuilder: (context, index) {
//             //           return Padding(
//             //             padding: const EdgeInsets.all(20),
//             //             child: Container(
//             //               decoration: BoxDecoration(
//             //                 borderRadius: BorderRadius.circular(10),
//             //                 color: greyColor,
//             //               ),
//             //               child: Column(
//             //                 crossAxisAlignment: CrossAxisAlignment.start,
//             //                 children: [
//             //                   Padding(
//             //                     padding: EdgeInsets.only(left: size.width * 0.05),
//             //                     child: UserDetialsHead(
//             //                       name: 'Your Name',
//             //                       fontsize: 15,
//             //                       top: size.height * 0.02,
//             //                       fontWeight: FontWeight.w400,
//             //                       color: blackColor,
//             //                     ),
//             //                   ),
//             //                   Row(
//             //                     children: [
//             //                       Container(
//             //                         // color: Colors.blue,
//             //                         width: size.width * 0.8,
//             //                         child: UserEditTextfield(controller: nameController, hintText: 'John Doe'),
//             //                       ),
//             //                       Padding(
//             //                         padding: EdgeInsets.only(left: size.width * 0.01),
//             //                         child: Icon(Icons.edit),
//             //                       ),
//             //                     ],
//             //                   ),
//             //                 ],
//             //               ),
//             //             ),
//             //           );
//             //         },
//             //       )
//             //     ],
//             //   ),
//             // )
//           ],
//         ),
//       )),
//     );
//   }
// }
