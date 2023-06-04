import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/db/userinfo.dart';
import 'package:taxverse/view/Appoinments/timeslot.dart';
import 'package:taxverse/view/mainscreens/home_screen.dart';

class GstSecondScreen extends StatefulWidget {
  const GstSecondScreen({
    super.key,
    required this.businessName,
    required this.businessType,
    required this.businessStartDate,
  });

  final String businessName;

  final String businessType;

  final String businessStartDate;

  @override
  State<GstSecondScreen> createState() => _GstSecondScreenState();
}

class _GstSecondScreenState extends State<GstSecondScreen> {
  DateTime? picked;

  String selectedDate = '';

  String selectedTime = '';

  List<TimeSlot> timeslot = [
    TimeSlot(time: '10:00 AM', isTaken: false),
    TimeSlot(time: '11:00 AM', isTaken: false),
    TimeSlot(time: '12:00 AM', isTaken: false),
  ];

  final CollectionReference appointmentsCollection = FirebaseFirestore.instance.collection('appointments');

  final CollectionReference gstClientInformaion = FirebaseFirestore.instance.collection('ClientGstInfo');

  final panCardController = TextEditingController();

  final aadhaarCard = TextEditingController();

  final businessRegistraionNO = TextEditingController();

  String imageurl = '';

  bookAppoinment() async {
    if (selectedDate.isNotEmpty && selectedTime.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('appointments').add({
          'date': selectedDate,
          'time': selectedTime,
          'username': userName,
        });
      } catch (e) {
        log('failed to Appoinment $e');
      }
    }
  }

  addDetailsToDatabase(
    String businessName,
    String businessType,
    String businessStartDate,
    String panCardController,
    String aadhaarCard,
    String businessRegistraionNO,
  ) async {
    try {
      await gstClientInformaion.add({
        'BusinessName': businessName,
        'BusinesssType': businessType,
        'BusinessStartDate': businessStartDate,
        'PanCardNumber': panCardController,
        'AadhaarCard': aadhaarCard,
        'BusinessRegistrationNumber': businessRegistraionNO,
        'ServiceName': 'GST Registration',
        'image': imageurl,
      });
    } catch (e) {
      log('Error saving gst information: $e');
    }
  }

  @override
  void dispose() {
    panCardController.dispose();
    aadhaarCard.dispose();
    businessRegistraionNO.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 22,
                          right: 70,
                        ),
                        child: Text(
                          'Please upload required documents',
                          textAlign: TextAlign.left,
                          style: AppStyle.poppinsBold27,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 46),
                          padding: const EdgeInsets.only(
                            left: 22,
                            top: 28,
                            right: 22,
                            bottom: 28,
                          ),
                          decoration: BoxDecoration(
                              color: blackColor.withOpacity(0.1),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              )),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'upload your passport size photo',
                                textAlign: TextAlign.left,
                                style: AppStyle.poppinsRegular15,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  TextButton.icon(
                                    onPressed: () async {
                                      User? user = FirebaseAuth.instance.currentUser;

                                      if (user != null) {
                                        String uid = user.uid;
                                        ImagePicker imagePicker = ImagePicker();

                                        XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

                                        if (file == null) return;

                                        Reference referenceRoot = FirebaseStorage.instance.ref();

                                        Reference referenceDirImages = referenceRoot.child('images');

                                        Reference referenceImageToUpload = referenceDirImages.child(uid);

                                        try {
                                          await referenceImageToUpload.putFile(File(file.path));

                                          imageurl = await referenceImageToUpload.getDownloadURL();
                                        } catch (e) {
                                          log('$e');
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.upload),
                                    label: const Text('upload'),
                                    style: ButtonStyle(
                                      backgroundColor: const MaterialStatePropertyAll(whiteColor),
                                      textStyle: MaterialStatePropertyAll(AppStyle.poppinsBold12),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Icon(
                                    Icons.task_alt_sharp,
                                    color: Colors.green[800],
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 36, right: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: TextFormField(
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                      color: const Color(0xa0000000),
                                    ),
                                    controller: panCardController,
                                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                                    // validator: validateEmail,

                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: whiteColor,
                                      hintText: 'Pan Card',
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
                              Container(
                                margin: const EdgeInsets.only(top: 36, right: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: TextFormField(
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                      color: const Color(0xa0000000),
                                    ),
                                    controller: aadhaarCard,
                                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                                    // validator: validateEmail,

                                    keyboardType: TextInputType.number,

                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: whiteColor,
                                      hintText: 'Aadhaar Card',
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
                              Container(
                                margin: const EdgeInsets.only(top: 36, right: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: TextFormField(
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                      color: const Color(0xa0000000),
                                    ),
                                    controller: businessRegistraionNO,
                                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                                    // validator: validateEmail,

                                    keyboardType: TextInputType.number,

                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: whiteColor,
                                      hintText: 'Business Registration Certificate Number',
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
                              const SizedBox(height: 45),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: GestureDetector(
                                  onTap: () {
                                    addDetailsToDatabase(
                                      widget.businessName,
                                      widget.businessType,
                                      widget.businessStartDate,
                                      panCardController.text.trim(),
                                      aadhaarCard.text.trim(),
                                      businessRegistraionNO.text.trim(),
                                    );

                                    showBottomSheet(context);
                                  },
                                  child: Container(
                                    color: blackColor,
                                    height: 57,
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Confirm and Shedule',
                                        style: AppStyle.poppinsBoldWhite20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return buildSheet();
      },
    );
  }

  Widget buildSheet() => StatefulBuilder(
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false);
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
}
