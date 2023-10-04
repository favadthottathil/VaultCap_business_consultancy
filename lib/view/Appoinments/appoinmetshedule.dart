import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:taxverse/api/api_const.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/chat/chat_ui.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';
import 'package:taxverse/view/Appoinments/widgets/time_slot.dart';

class AppoinmentShedule extends StatefulWidget {
  const AppoinmentShedule({super.key});

  @override
  State<AppoinmentShedule> createState() => _AppoinmentSheduleState();
}

class _AppoinmentSheduleState extends State<AppoinmentShedule> {
  DateTime? picked;

  String selectedDate = '';

  bookAppoinment(String serviceName) async {
    log(selectedTime);
    log(selectedDate);

    if (selectedDate.isNotEmpty && selectedTime.isNotEmpty) {
      // final email = FirebaseAuth.instance.currentUser?.email ?? 'no email';

      log(ClientInformation.clientId);

      try {
        await FirebaseFirestore.instance.collection('appointments').add({
          'date': selectedDate,
          'time': selectedTime,
          // 'clientId': ClientInformation.clientId,
          'gstId': ClientInformation.gstId,
          'name': currentUserName,

          'gst Service': serviceName,
          'id': curentUserEmail,
        });
      } catch (e) {
        log('failed to Appoinment $e');
      }
    }
  }

  updateVerifiedStatus() async {
    // final userEmail = FirebaseAuth.instance.currentUser!.email;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ClientDetails')
        .where(
          'Email',
          isEqualTo: userEmail,
        )
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.update({
        'Isverified': '',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Make an Appoinment',
            style: AppStyle.poppinsBold18,
          ),
        ),
        body: SizedBox(
          width: double.maxFinite,
          // padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 17.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 7.w),
                child: Container(
                  margin: EdgeInsets.only(left: 1.h),
                  // color: Colors.amber,
                  height: 20.h,
                  width: 60.w,
                  child: SvgPicture.asset(
                    'Asset/booking.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 30),
                      ),
                    );
                    if (picked != null) {
                      setState(() {
                        final DateFormat format = DateFormat('dd-MMMM-yyyy');

                        selectedDate = format.format(picked!);
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.date_range_outlined,
                    color: blackColor,
                  ),
                  label: Text(
                    'Choose A Date',
                    style: AppStyle.poppinsBold14,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Set the button's background color as transparent
                    shadowColor: Colors.transparent, // Set the button's shadow color as transparent
                    elevation: 0, // Remove the button's elevation
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              if (selectedDate.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'You have Selected $selectedDate',
                      style: AppStyle.poppinsBold14,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 30),
                          ),
                        );
                        if (picked != null) {
                          setState(() {
                            final DateFormat format = DateFormat('dd-MMMM-yyyy');

                            selectedDate = format.format(picked!);
                          });
                        }
                      },
                      child: Text(
                        'change',
                        style: AppStyle.poppinsRegular12Red,
                      ),
                    )
                  ],
                ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Wrap(
                  children: [
                    TimeSlotAppoinment(),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(bottom: 3.h),
            child: ElevatedButton(
              onPressed: () {
                log('dddddd $selectedTime');
                bookAppoinment('GST Registration');

                // updateVerifiedStatus();

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 35.h,
                        width: double.infinity,
                        child: Column(
                          children: [
                            LottieBuilder.asset(
                              'Animations/97240-success.json',
                              repeat: true,
                              height: 150,
                              width: 150,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Your Appoinment Sheduled\n At',
                                    style: AppStyle.poppinsBold16,
                                  ),
                                  TextSpan(
                                    text: '  $selectedTime on $selectedDate',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: mediaQuery.size.height * 0.03),
                            ElevatedButton(
                              onPressed: () {
                                updateVerifiedStatus();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BottomNav(isGuest: false),
                                    ),
                                    (route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(80, 30),
                                  backgroundColor: blackColor,
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  )),
                              child: Text(
                                'Back To Home',
                                style: AppStyle.poppinsBoldWhite12,
                              ),
                            ),
                            const SizedBox(height: 6),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatRoom(),
                                ),
                              ),
                              child: Text(
                                'For Any Queries contact Us',
                                style: AppStyle.poppinsBold16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const HomeScreen(),
                //     ),
                //     (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(80.w, 6.h), // Set the desired height and width here
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: Text(
                'Book appoinment',
                style: AppStyle.poppinsBoldWhite18,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
