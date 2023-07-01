import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taxverse/constants.dart';

class UserEdit extends StatefulWidget {
  const UserEdit({super.key});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController businessNameContoller = TextEditingController();

  TextEditingController businessTypeContoller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SvgPicture.asset(ImageConstant.imgArrowleft2),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Edit User',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(74),
                    child: Image.asset(
                      ImageConstant.dp,
                      height: 149,
                      width: 149,
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 220,
                    child: SvgPicture.asset(
                      ImageConstant.dpEdit,
                      height: 30,
                      width: 30,
                    ),
                  )
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 7, top: 21),
              //   child: Text(
              //     'Personal Information',
              //     overflow: TextOverflow.ellipsis,
              //     textAlign: TextAlign.left,
              //     style: GoogleFonts.poppins(
              //       color: blackColor,
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              const UserDetialsHead(
                name: 'Personal Information',
                left: 7,
                top: 21,
                fontsize: 15,
                fontWeight: FontWeight.bold,
                color: blackColor,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 7, top: 17),
              //   child: Text(
              //     'Your Name',
              //     overflow: TextOverflow.ellipsis,
              //     textAlign: TextAlign.left,
              //     style: GoogleFonts.poppins(
              //       color: blackColor,
              //       fontSize: 15,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
              const UserDetialsHead(
                name: 'Your Name',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 15),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(10),
              //     child: TextFormField(
              //       controller: nameController,
              //       decoration: InputDecoration(
              //         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //         border: InputBorder.none,
              //         filled: true,
              //         fillColor: blackColor.withOpacity(0.1),
              //         hintText: 'Enter Your Name',
              //         hintStyle: GoogleFonts.poppins(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w400,
              //           height: 1.5,
              //           color: const Color(0xa0000000),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // UserEditTextfield(controller: nameController, hintText: 'John Doe'),
              // Padding(
              //   padding: const EdgeInsets.only(left: 7, top: 17),
              //   child: Text(
              //     'Your Name',
              //     overflow: TextOverflow.ellipsis,
              //     textAlign: TextAlign.left,
              //     style: GoogleFonts.poppins(
              //       color: blackColor,
              //       fontSize: 15,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
              const UserDetialsHead(
                name: 'Your Email',
                left: 7,
                top: 17,
                fontsize: 15,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 15),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(10),
              //     child: TextFormField(
              //       controller: nameController,
              //       decoration: InputDecoration(
              //         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //         border: InputBorder.none,
              //         filled: true,
              //         fillColor: blackColor.withOpacity(0.1),
              //         hintText: 'Enter Your Name',
              //         hintStyle: GoogleFonts.poppins(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w400,
              //           height: 1.5,
              //           color: const Color(0xa0000000),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // UserEditTextfield(controller: nameController, hintText: 'favadfavad2@gmail.com'),
              // const UserDetialsHead(
              //   name: 'Phone Number',
              //   left: 7,
              //   top: 17,
              //   fontsize: 15,
              //   fontWeight: FontWeight.w400,
              //   color: blackColor,
              // ),
              // UserEditTextfield(controller: nameController, hintText: '8129613355'),
              // const UserDetialsHead(
              //   name: 'Business Information',
              //   left: 7,
              //   top: 21,
              //   fontsize: 15,
              //   fontWeight: FontWeight.bold,
              //   color: blackColor,
              // ),
              // const UserDetialsHead(
              //   name: 'Business Name',
              //   left: 7,
              //   top: 17,
              //   fontsize: 15,
              //   fontWeight: FontWeight.w400,
              //   color: blackColor,
              // ),
              // UserEditTextfield(controller: nameController, hintText: 'Taxverse'),
              // const UserDetialsHead(
              //   name: 'Business Type',
              //   left: 7,
              //   top: 17,
              //   fontsize: 15,
              //   fontWeight: FontWeight.w400,
              //   color: blackColor,
              // ),
              // UserEditTextfield(controller: nameController, hintText: 'Partnership'),
              // const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}

class UserDetialsHead extends StatelessWidget {
  const UserDetialsHead({
    super.key,
    required this.name,
    this.left,
    this.top,
    required this.fontsize,
    required this.fontWeight,
    required this.color,
  });

  final String name;

  final double? left;

  final double? top;

  final double fontsize;

  final FontWeight fontWeight;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left ?? 0.0, top: top ?? 0.0),
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
          color: blackColor,
          fontSize: fontsize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class UserEditTextfield extends StatefulWidget {
  const UserEditTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.userEmail,
    required this.userEdit,
    required this.userdata,
    required this.mapName,
    required this.filedName,
  });

  final TextEditingController controller;

  final String hintText;

  final String userEmail;

  final dynamic userEdit;

  final String userdata;

  final String mapName;

  final String filedName;

  @override
  State<UserEditTextfield> createState() => _UserEditTextfieldState();
}

class _UserEditTextfieldState extends State<UserEditTextfield> {
  final _formkey = GlobalKey<FormState>();

  validateEmail() {
    if (_formkey.currentState!.validate()) {
      updateName();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log('UserEditTextfield is being rebuilt');
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextFormField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: blackColor.withOpacity(0.1),
                    hintText: widget.hintText,
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: const Color(0xa0000000),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter your name';
                    }
                    if (value == widget.userdata) {
                      return 'please enter another name';
                    }
                    if (value.length <= 4) {
                      return 'enter more than 4 lettes';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(width: size.width * 0.02),
            // InkWell(
            //   onTap: () {
            //     log('${widget.userEdit['Name']?.showEdit.toString()}');
            //     // log(message)

            //     updateName();

            //     setState(() {
            //       widget.userEdit['Name']?.showEdit = false;
            //     });
            //     log('${widget.userEdit['Name']?.showEdit.toString()}');
            //   },
            //   child: const Icon(
            //     Icons.close,
            //   ),
            // ),
            SizedBox(width: size.width * 0.02),
            InkWell(
              onTap: () {
                log('fajfjkldkaja');

                validateEmail();

                log('finished');

                setState(() {
                  widget.userEdit[widget.mapName]?.showEdit = false;
                });

                // widget.controller.clear();
              },
              child: const Icon(
                Icons.check,
              ),
            )
          ],
        ),
      ),
    );
  }

  updateName() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ClientDetails')
        .where(
          'Email',
          isEqualTo: widget.userEmail,
        )
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.update({
        widget.filedName: widget.controller.text.trim(),
      });
      widget.controller.clear();
      log('usser name updated');
    }
  }
}
