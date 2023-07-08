import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/utils/constant/constants.dart';

class Gst1MainHead extends StatelessWidget {
  const Gst1MainHead({
    super.key,
    required this.size,
    required this.heading,
  });

  final Size size;

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.075,
        top: size.height * 0.10,
      ),
      child: Text(
        heading,
        textAlign: TextAlign.center,
        style: AppStyle.poppinsBold27,
      ),
    );
  }
}


// <<---------------------------------------------------------->>

  //                       Next widget 

class Gst1TextField extends StatelessWidget {
  const Gst1TextField({
    super.key,
    required this.businessNameController,
    required this.size,
    required this.hintText,
    this.marginTop,
    this.keybordType,
    this.icon,
    this.dateTime,
  });

  final TextEditingController businessNameController;
  final Size size;
  final String hintText;
  final double? marginTop;
  final TextInputType? keybordType;
  final IconData? icon;
  final Function()? dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop ?? 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: TextFormField(
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.5,
            color: const Color(0xa0000000),
          ),
          controller: businessNameController,
          keyboardType: keybordType,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: size.height * 0.028, horizontal: size.height * 0.02),
            prefixIcon: Icon(icon),
            border: InputBorder.none,
            filled: true,
            fillColor: blackColor.withOpacity(0.1),
            hintText: hintText,
            hintStyle: AppStyle.poppinsRegular15,
          ),
          onTap: dateTime,
          validator: (value) {
            if (value!.isEmpty) {
              return "This field can't be empty";
            }

            if (value.length < 4) {
              return 'Please Enter at least 4 Character';
            }

            return null;
          },
        ),
      ),
    );
  }
}


// <<---------------------------------------------------------->>

  //                       Next widget 

class Gst1subHeading extends StatelessWidget {
  const Gst1subHeading({
    super.key,
    required this.size,
    required this.subHeading,
  });

  final Size size;

  final String subHeading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.075,
        top: size.height * 0.01,
      ),
      child: Text(
        'Add basic Information',
        textAlign: TextAlign.center,
        style: AppStyle.poppinsRegular16,
      ),
    );
  }
}

// <<---------------------------------------------------------->>

  //                       Next widget 



class NextAndPreviousButton extends StatelessWidget {
  const NextAndPreviousButton({
    super.key,
    required this.size,
    required this.onpresssed,
  });

  final Size size;

  final void Function() onpresssed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Back',
            style: AppStyle.poppinsBold16,
          ),
        ),
        NeumorphicButton(
          // onPressed: _navigateToGstSecondScreen,
          onPressed: onpresssed,
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: const NeumorphicBoxShape.circle(),
            depth: 8,
            lightSource: LightSource.topLeft,
            color: blackColor.withOpacity(0.1),
          ),
          child: Container(
            height: size.height * 0.09,
            width: size.height * 0.09,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: blackColor,
            ),
            child: const Icon(
              Icons.arrow_forward_sharp,
              color: whiteColor,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}

// <<---------------------------------------------------------->>

  //                       Next widget 

CustomDropdown customDrop({required TextEditingController controller}) {
  return CustomDropdown(
    items: const [
      'Sole ProprietorShip',
      'Partnership',
      'Corporation',
      'Franchise',
      'Nonprofit Organization'
    ],
    controller: controller,
    hintText: 'Business Type',
    fillColor: blackColor.withOpacity(0.1),
    hintStyle: AppStyle.poppinsBold16,
    excludeSelected: true,
    listItemStyle: AppStyle.poppinsRegular15,
  );
}

// <<---------------------------------------------------------->>

  //                       Next widget 
