import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/controller/providers/useraccount_provider.dart';

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

// <<---------------------------------------------------------->>

//                       Next widget

class UserEditTextfield extends StatefulWidget {
  UserEditTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.userEmail,
    required this.userEdit,
    required this.userdata,
    required this.mapName,
    required this.filedName,
    required this.userExisitingData,
  });

  TextEditingController controller;

  final String hintText;

  final String userEmail;

  final dynamic userEdit;

  final String userdata;

  final String mapName;

  final String filedName;
  final String userExisitingData;

  @override
  State<UserEditTextfield> createState() => _UserEditTextfieldState();
}

class _UserEditTextfieldState extends State<UserEditTextfield> {
  final _formkey = GlobalKey<FormState>();

  validateEmail(UserAccountProvider provider) {
    if (_formkey.currentState!.validate()) {
      updateName();
      provider.setShowEditFalse(widget.mapName);
    }
  }

  @override
  void initState() {
    super.initState();
    log(' favadfadf ${widget.userExisitingData}');
    widget.controller = TextEditingController(text: widget.userExisitingData);
    log(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    final size = MediaQuery.of(context).size;
    return Consumer<UserAccountProvider>(builder: (context, provider, child) {
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
              SizedBox(width: size.width * 0.02),
              InkWell(
                onTap: () {
                  validateEmail(provider);

                  
                },
                child: const Icon(
                  Icons.check,
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  updateName() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ClientDetails')
        .where(
          'Email',
          isEqualTo: widget.userEmail,
        )
        .get();

    log(' to controller  ${widget.controller.text}');

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.update({
        widget.filedName: widget.controller.text.trim(),
      });
      // widget.controller.clear();
    }
  }
}

// <<---------------------------------------------------------->>

//                       Next widget
