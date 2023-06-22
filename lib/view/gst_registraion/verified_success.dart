import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/view/Appoinments/timeslot.dart';
import 'package:taxverse/view/chat/chat_ui.dart';
import 'package:taxverse/view/mainscreens/home_screen.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';

class VerifiedSuccess extends StatelessWidget {
  VerifiedSuccess({super.key});

  final CollectionReference appointmentsCollection = FirebaseFirestore.instance.collection('appointments');

  DateTime? picked;

  String selectedDate = '';

  String selectedTime = '';

  List<TimeSlot> timeslot = [
    TimeSlot(time: '10:00 AM', isTaken: false),
    TimeSlot(time: '11:00 AM', isTaken: false),
    TimeSlot(time: '12:00 AM', isTaken: false),
  ];

  bookAppoinment() async {
    if (selectedDate.isNotEmpty && selectedTime.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('appointments').add({
          'date': selectedDate,
          'time': selectedTime,
          'username': userDisplayName,
          'clientId': ClientInformation.clientId,
          'gstId': ClientInformation.gstId,
        });
      } catch (e) {
        log('failed to Appoinment $e');
      }
    }
  }

  void showBottomSheet(BuildContext context, MediaQueryData mediaQuery) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return buildSheet(mediaQuery);
      },
    );
  }

  Widget buildSheet(MediaQueryData mediaQuery) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Select a date',
                  textAlign: TextAlign.left,
                  style: AppStyle.poppinsBold20,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
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
                            final DateFormat format = DateFormat('dd-MM-yyyy');

                            selectedDate = format.format(picked!);
                          });
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(blackColor),
                      ),
                      child: Text(
                        'Choose date',
                        style: AppStyle.poppinsBoldWhite12,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(selectedDate)
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  'Select a Time',
                  textAlign: TextAlign.left,
                  style: AppStyle.poppinsBold20,
                ),
                const SizedBox(height: 10),
                Row(
                  children: timeslot.map((slot) {
                    final bool isSelected = selectedTime == slot.time;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: slot.isTaken
                            ? null
                            : () {
                                setState(
                                  () {
                                    if (selectedTime == slot.time) {
                                      selectedTime = '';
                                    } else {
                                      selectedTime = slot.time;
                                    }
                                  },
                                );
                              },
                        child: Container(
                          width: 70,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.black.withOpacity(0.5)
                                : slot.isTaken
                                    ? Colors.red
                                    : Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              slot.time,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    bookAppoinment();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SizedBox(
                            height: 300,
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
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const BottomNav(),
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
                                      builder: (context) => const ChatRoom(),
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
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(blackColor),
                  ),
                  child: const Text('Book appoinment'),
                )
              ],
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Lottie.asset(
              'Animations/97240-success.json',
              repeat: true,
              height: mediaQuery.size.height * 0.35,
              width: mediaQuery.size.height * 0.35,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: mediaQuery.size.height * 0.3,
            left: mediaQuery.size.height * 0.09,
            child: Text(
              'Verification Success',
              style: AppStyle.poppinsBold24,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: mediaQuery.size.height * 0.45),
              child: Text(
                'Your Application Successfully\n Verified',
                style: AppStyle.poppinsBold20,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: mediaQuery.size.height * 0.1),
              child: GestureDetector(
                onTap: () => showBottomSheet(context, mediaQuery),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  // padding: EdgeInsets.only(bottom: mediaQuery.size.height * 0.2),
                  width: double.infinity,
                  height: 0.088 * mediaQuery.size.height,
                  decoration: BoxDecoration(
                    color: const Color(0xff000000),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Book Your Slot Now',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
