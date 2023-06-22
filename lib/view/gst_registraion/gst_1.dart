import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/view/gst_registraion/gst_2.dart';

class GstFirstScreen extends StatefulWidget {
  const GstFirstScreen({super.key});

  @override
  State<GstFirstScreen> createState() => _GstFirstScreenState();
}

class _GstFirstScreenState extends State<GstFirstScreen> {
  final businessTypeController = TextEditingController();

  final businessNameController = TextEditingController();

  final businessStartDate = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    businessNameController.dispose();

    businessTypeController.dispose();

    businessStartDate.dispose();

    super.dispose();
  }

  _navigateToGstSecondScreen() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GstSecondScreen(
            businessName: businessNameController.text.trim(),
            businessType: businessTypeController.text.trim(),
            businessStartDate: businessStartDate.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.infinity,
              // height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      top: 66,
                    ),
                    child: Text(
                      'GST Registraion',
                      textAlign: TextAlign.center,
                      style: AppStyle.poppinsBold27,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      top: 30,
                    ),
                    child: Text(
                      'Add basic Information',
                      textAlign: TextAlign.center,
                      style: AppStyle.poppinsRegular16,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 29,
                      top: 45,
                      right: 29,
                      bottom: 45,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: TextFormField(
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              color: const Color(0xa0000000),
                            ),
                            controller: businessNameController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: blackColor.withOpacity(0.1),
                              hintText: 'Business Name',
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
                        const SizedBox(height: 20),
                        CustomDropdown(
                          items: const [
                            'Sole ProprietorShip',
                            'Partnership',
                            'Corporation',
                            'Franchise',
                            'Nonprofit Organization'
                          ],
                          controller: businessTypeController,
                          hintText: 'Business Type',
                          fillColor: blackColor.withOpacity(0.1),
                          hintStyle: AppStyle.poppinsBold16,
                          excludeSelected: true,
                          listItemStyle: AppStyle.poppinsRegular15,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: TextFormField(
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: const Color(0xa0000000),
                              ),
                              controller: businessStartDate,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: blackColor.withOpacity(0.1),
                                hintText: 'Business Start Date',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  color: const Color(0xa0000000),
                                ),
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
                        ),
                        const SizedBox(height: 60),
                        Row(
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
                              onPressed: _navigateToGstSecondScreen,
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.concave,
                                boxShape: const NeumorphicBoxShape.circle(),
                                depth: 8,
                                lightSource: LightSource.topLeft,
                                color: blackColor.withOpacity(0.1),
                              ),
                              child: Container(
                                height: 70,
                                width: 70,
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
                        )
                        // const NeumorphismButton(
                        //   child: Icon(Icons.forward_sharp, color: whiteColor),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NeumorphismButton extends StatefulWidget {
  const NeumorphismButton({super.key, required this.child});

  final Widget child;

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onTapDown: (details) => setState(() => isPressed = true),
      onTapUp: (details) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: blackColor,
          shape: BoxShape.circle,
          boxShadow: isPressed
              ? []
              : [
                  const BoxShadow(
                    color: whiteColor,
                    blurRadius: 24,
                    offset: Offset(6, 6),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: blackColor.withOpacity(0.3),
                    blurRadius: 24,
                    offset: const Offset(-6, -6),
                    spreadRadius: 1,
                  )
                ],
        ),
        child: widget.child,
      ),
    );
  }
}
