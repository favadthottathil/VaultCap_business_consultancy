import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/controller/providers/neumorphismbutton_provider.dart';

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

class Gst1TextField extends StatelessWidget {
  const Gst1TextField({super.key, required this.businessNameController, required this.size, required this.hintText, this.marginTop, this.keybordType});

  final TextEditingController businessNameController;
  final Size size;
  final String hintText;
  final double? marginTop;
  final TextInputType? keybordType;

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
            border: InputBorder.none,
            filled: true,
            fillColor: blackColor.withOpacity(0.1),
            hintText: hintText,
            hintStyle: AppStyle.poppinsRegular15,
          ),
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

// class NeumorphismButton extends StatelessWidget {
//   const NeumorphismButton({Key? key, required this.child}) : super(key: key);

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       onTapDown: (details) => Provider.of<NeumorphismButtonState>(context, listen: false).setPressed(true),
//       onTapUp: (details) => Provider.of<NeumorphismButtonState>(context, listen: false).setPressed(false),
//       onTapCancel: () => Provider.of<NeumorphismButtonState>(context, listen: false).setPressed(false),
//       child: Consumer<NeumorphismButtonState>(
//         builder: (context, state, child) {
//           return AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: blackColor,
//               shape: BoxShape.circle,
//               boxShadow: state.isPressed
//                   ? []
//                   : [
//                       const BoxShadow(
//                         color: whiteColor,
//                         blurRadius: 24,
//                         offset: Offset(6, 6),
//                         spreadRadius: 1,
//                       ),
//                       BoxShadow(
//                         color: blackColor.withOpacity(0.3),
//                         blurRadius: 24,
//                         offset: const Offset(-6, -6),
//                         spreadRadius: 1,
//                       )
//                     ],
//             ),
//             child: child,
//           );
//         },
//         child: child,
//       ),
//     );
//   }
// }

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
