import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    businessNameController.dispose();

    businessTypeController.dispose();

    businessStartDate.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 9,
                  top: 66,
                ),
                child: Text(
                  'GST Registraion',
                  textAlign: TextAlign.center,
                  style: AppStyle.poppinsBold27,
                ),
              ),
              Container(
                width: double.infinity,
                height: 572,
                margin: const EdgeInsets.only(
                  top: 55,
                ),
                padding: const EdgeInsets.only(
                  left: 29,
                  top: 45,
                  right: 29,
                  bottom: 45,
                ),
                decoration: BoxDecoration(
                  color: blackColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      40,
                    ),
                    topRight: Radius.circular(40),
                  ),
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
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: validateEmail,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: whiteColor,
                          hintText: 'Business Name',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: const Color(0xa0000000),
                          ),
                        ),
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
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        color: const Color(0xa0000000),
                      ),
                      excludeSelected: true,
                      listItemStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: const Color(0xa0000000),
                      ),
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
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: validateEmail,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: whiteColor,
                            hintText: 'Business Start Date',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: const Color(0xa0000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
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
                        },
                        child: Container(
                          color: blackColor,
                          height: 57,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'NEXT',
                              style: AppStyle.poppinsBoldWhite20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
