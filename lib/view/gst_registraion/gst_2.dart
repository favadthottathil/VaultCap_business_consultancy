import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/utils/constand/sizedbox.dart';
import 'package:taxverse/view/gst_registraion/gst_3.dart';

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
  // DateTime? picked;

  // String selectedDate = '';

  // String selectedTime = '';

  // List<TimeSlot> timeslot = [
  //   TimeSlot(time: '10:00 AM', isTaken: false),
  //   TimeSlot(time: '11:00 AM', isTaken: false),
  //   TimeSlot(time: '12:00 AM', isTaken: false),
  // ];

  // final CollectionReference appointmentsCollection = FirebaseFirestore.instance.collection('appointments');

  final CollectionReference gstClientInformaion = FirebaseFirestore.instance.collection('ClientGstInfo');

  final panCard = TextEditingController();

  final aadhaarCard = TextEditingController();

  final electricityBill = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // String imageurl = '';

  // bool isImageUploaded = false;

  @override
  void dispose() {
    electricityBill.dispose();
    aadhaarCard.dispose();
    electricityBill.dispose();
    super.dispose();
  }

  // Future<void> uploadImage() async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     String uid = user.uid;
  //     ImagePicker imagePicker = ImagePicker();

  //     XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

  //     if (file == null) return;

  //     Reference referenceRoot = FirebaseStorage.instance.ref();

  //     Reference referenceDirImages = referenceRoot.child('images');

  //     Reference referenceImageToUpload = referenceDirImages.child(uid);

  //     try {
  //       await referenceImageToUpload.putFile(File(file.path));

  //       imageurl = await referenceImageToUpload.getDownloadURL();

  //       setState(
  //         () {
  //           isImageUploaded = true;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text('New Photo added'),
  //             ),
  //           );
  //         },
  //       );
  //     } catch (e) {
  //       log('$e');
  //     }
  //   }
  // }

  // bookAppoinment() async {
  //   if (selectedDate.isNotEmpty && selectedTime.isNotEmpty) {
  //     try {
  //       await FirebaseFirestore.instance.collection('appointments').add({
  //         'date': selectedDate,
  //         'time': selectedTime,
  //         'username': userName,
  //         'clientId': ClientInformation.clientId,
  //         'gstId': ClientInformation.gstId,
  //       });
  //     } catch (e) {
  //       log('failed to Appoinment $e');
  //     }
  //   }
  // }

  addDetailsToDatabase(
    String businessName,
    String businessType,
    String businessStartDate,
    String panCardNumber,
    String aadhaarCardNumber,
    String electricityBill,
  ) async {
    try {
      final DocumentReference doc = await gstClientInformaion.add({
        'BusinessName': businessName,
        'BusinesssType': businessType,
        'BusinessStartDate': businessStartDate,
        'PanCardNumber': panCardNumber,
        'AadhaarCard': aadhaarCardNumber,
        'BusinessRegistrationNumber': electricityBill,
        'ServiceName': 'GST Registration',
        // 'image': imageurl,
      });

      ClientInformation.gstId = doc.id;
      log('doc id in screen 2 === ${ClientInformation.gstId}');
    } catch (e) {
      log('Error saving gst information: $e');
    }
  }

  _navigateToThirdScreen(
    String businessName,
    String businessType,
    String businessStartDate,
  ) {
    if (_formKey.currentState!.validate()) {
      addDetailsToDatabase(
        businessName,
        businessType,
        businessStartDate,
        panCard.text.trim(),
        aadhaarCard.text.trim(),
        electricityBill.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GstThirdScreen(),
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
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 46),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              right: 40,
                            ),
                            child: Text(
                              'Please upload required informations',
                              textAlign: TextAlign.left,
                              style: AppStyle.poppinsBold27,
                            ),
                          ),
                          sizedBoxHeight20,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text(
                              //   'upload your passport size photo',
                              //   textAlign: TextAlign.left,
                              //   style: AppStyle.poppinsRegular15,
                              // ),
                              // const SizedBox(height: 10),
                              // Row(
                              //   children: [
                              //     TextButton.icon(
                              //       onPressed: () {
                              //         uploadImage();
                              //       },
                              //       icon: const Icon(Icons.upload),
                              //       label: const Text('upload'),
                              //       style: ButtonStyle(
                              //         backgroundColor: const MaterialStatePropertyAll(whiteColor),
                              //         textStyle: MaterialStatePropertyAll(AppStyle.poppinsBold12),
                              //       ),
                              //     ),
                              //     const SizedBox(width: 15),
                              //     Icon(
                              //       Icons.task_alt_sharp,
                              //       color: isImageUploaded == true ? Colors.green[800] : Colors.grey,
                              //     )
                              //   ],
                              // ),
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: TextFormField(
                                  style: AppStyle.poppinsBold16,
                                  maxLength: 10,
                                  controller: panCard,
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
                                    labelText: 'Enter your PANCARD Number',
                                    hintText: 'eg: HFYU3262H',
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
                              ),
                              // TextButton.icon(
                              //   onPressed: () {
                              //     uploadImage();
                              //   },
                              //   icon: const Icon(Icons.upload),
                              //   label: const Text('upload'),
                              //   style: ButtonStyle(
                              //     backgroundColor: const MaterialStatePropertyAll(whiteColor),
                              //     textStyle: MaterialStatePropertyAll(AppStyle.poppinsBold12),
                              //   ),
                              // ),
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: TextFormField(
                                  style: AppStyle.poppinsBold16,
                                  maxLength: 10,
                                  controller: aadhaarCard,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field can't be empty";
                                    }

                                    if (value.length < 4) {
                                      return 'Please Enter a Valid AADHAARCARD No';
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Enter your AADHAAR Number',
                                    hintText: 'eg: 8756 5435 7634',
                                    labelStyle: AppStyle.poppinsRegular15,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              // TextButton.icon(
                              //   onPressed: () {
                              //     uploadImage();
                              //   },
                              //   icon: const Icon(Icons.upload),
                              //   label: const Text('upload'),
                              //   style: ButtonStyle(
                              //     backgroundColor: const MaterialStatePropertyAll(whiteColor),
                              //     textStyle: MaterialStatePropertyAll(AppStyle.poppinsBold12),
                              //   ),
                              // ),
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: TextFormField(
                                  style: AppStyle.poppinsBold16,
                                  maxLength: 10,
                                  controller: electricityBill,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field can't be empty";
                                    }

                                    if (value.length < 4) {
                                      return 'Please Enter a Valid Number';
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Enter Firm Eelectricity bill',
                                    labelStyle: AppStyle.poppinsRegular15,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                    ),
                                  ),
                                ),
                              ),

                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(10),
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       addDetailsToDatabase(
                              //         widget.businessName,
                              //         widget.businessType,
                              //         widget.businessStartDate,
                              //         panCardController.text.trim(),
                              //         aadhaarCard.text.trim(),
                              //         businessRegistraionNO.text.trim(),
                              //       );

                              //       showBottomSheet(context);
                              //     },
                              //     child: Center(
                              //       child: Container(
                              //         height: 57,
                              //         width: 250,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(10),
                              //           color: blackColor,
                              //         ),
                              //         child: Center(
                              //           child: Text(
                              //             'Confirm and Shedule',
                              //             style: AppStyle.poppinsBoldWhite20,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // )
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Back',
                                    style: AppStyle.poppinsBold16,
                                  ),
                                  NeumorphicButton(
                                    onPressed: () => _navigateToThirdScreen(
                                      widget.businessName,
                                      widget.businessType,
                                      widget.businessStartDate,
                                    ),
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
                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: blackColor),
                                      child: const Icon(
                                        Icons.arrow_forward_sharp,
                                        color: whiteColor,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return buildSheet();
  //     },
  //   );
  // }

  // Widget buildSheet() => StatefulBuilder(
  //       builder: (context, setState) {
  //         return Padding(
  //           padding: const EdgeInsets.all(10),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const SizedBox(height: 20),
  //               Text(
  //                 'Select a date',
  //                 textAlign: TextAlign.left,
  //                 style: AppStyle.poppinsBold20,
  //               ),
  //               const SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   ElevatedButton(
  //                     onPressed: () async {
  //                       picked = await showDatePicker(
  //                         context: context,
  //                         initialDate: DateTime.now(),
  //                         firstDate: DateTime.now(),
  //                         lastDate: DateTime.now().add(
  //                           const Duration(days: 30),
  //                         ),
  //                       );

  //                       if (picked != null) {
  //                         setState(() {
  //                           final DateFormat format = DateFormat('dd-MM-yyyy');

  //                           selectedDate = format.format(picked!);
  //                         });
  //                       }
  //                     },
  //                     style: const ButtonStyle(
  //                       backgroundColor: MaterialStatePropertyAll(blackColor),
  //                     ),
  //                     child: Text(
  //                       'Choose date',
  //                       style: AppStyle.poppinsBoldWhite12,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 20),
  //                   Text(selectedDate)
  //                 ],
  //               ),
  //               const SizedBox(height: 40),
  //               Text(
  //                 'Select a Time',
  //                 textAlign: TextAlign.left,
  //                 style: AppStyle.poppinsBold20,
  //               ),
  //               const SizedBox(height: 10),
  //               Row(
  //                 children: timeslot.map((slot) {
  //                   final bool isSelected = selectedTime == slot.time;

  //                   return Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 5),
  //                     child: GestureDetector(
  //                       onTap: slot.isTaken
  //                           ? null
  //                           : () {
  //                               setState(
  //                                 () {
  //                                   if (selectedTime == slot.time) {
  //                                     selectedTime = '';
  //                                   } else {
  //                                     selectedTime = slot.time;
  //                                   }
  //                                 },
  //                               );
  //                             },
  //                       child: Container(
  //                         width: 70,
  //                         height: 40,
  //                         decoration: BoxDecoration(
  //                           color: isSelected
  //                               ? Colors.black.withOpacity(0.5)
  //                               : slot.isTaken
  //                                   ? Colors.red
  //                                   : Colors.black,
  //                           borderRadius: BorderRadius.circular(8),
  //                         ),
  //                         child: Center(
  //                           child: Text(
  //                             slot.time,
  //                             style: const TextStyle(
  //                               color: Colors.white,
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 12,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }).toList(),
  //               ),
  //               const SizedBox(height: 30),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   bookAppoinment();
  //                   Navigator.pushAndRemoveUntil(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => const HomeScreen(),
  //                       ),
  //                       (route) => false);
  //                 },
  //                 style: const ButtonStyle(
  //                   backgroundColor: MaterialStatePropertyAll(blackColor),
  //                 ),
  //                 child: const Text('Book appoinment'),
  //               )
  //             ],
  //           ),
  //         );
  //       },
  //     );
}
