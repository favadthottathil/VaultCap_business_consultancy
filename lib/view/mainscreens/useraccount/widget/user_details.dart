import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/utils/constant/constants.dart';

class UserData extends StatelessWidget {
  const UserData({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        top: 19,
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
          color: blackColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}


// <<---------------------------------------------------------->>

  //                       Next widget 

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: Divider(
        height: 1,
        thickness: 1,
        color: blackColor.withOpacity(0.1),
        indent: 1,
      ),
    );
  }
}
