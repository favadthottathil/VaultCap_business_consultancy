import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/utils/constant/constants.dart';





class Gst2textField extends StatelessWidget {
  const Gst2textField({super.key, required this.size, required this.panCard, required this.labelText, required this.hintText, this.keyBoardType});

  final Size size;
  final TextEditingController panCard;

  final String labelText;

  final String hintText;

  final TextInputType? keyBoardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.04),
      child: TextFormField(
        style: AppStyle.poppinsBold16,
        maxLength: 10,
        controller: panCard,
        keyboardType: keyBoardType,
        validator: (value) {
          if (value!.isEmpty) {
            return "This field can't be empty";
          }

          if (value.length < 4) {
            return 'Please Enter a valid PANCARD No';
          }

          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          // hintText: 'eg: HFYU3262H',
          hintText: hintText,
          labelStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: const Color(0xa0000000),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 2),
          ),
        ),
      ),
    );
  }
}

// <<---------------------------------------------------------->>

  //                       Next widget 

class Gst2Heading extends StatelessWidget {
  const Gst2Heading({
    super.key,
    required this.size,
    required this.head,
  });

  final Size size;
  final String head;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: size.width * 0.09,
      ),
      child: Text(
        head,
        textAlign: TextAlign.left,
        style: AppStyle.poppinsBold27,
      ),
    );
  }
}

// <<---------------------------------------------------------->>

  //                       Next widget 