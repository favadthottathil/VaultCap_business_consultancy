import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/utils/constand/sizedbox.dart';
import 'package:taxverse/view/gst_registraion/verified_success.dart';
import 'package:taxverse/view/mainscreens/home_screen.dart';

class GstThirdScreen extends StatefulWidget {
  const GstThirdScreen({
    super.key,
  });

  @override
  State<GstThirdScreen> createState() => _GstThirdScreenState();
}

class _GstThirdScreenState extends State<GstThirdScreen> {
  final CollectionReference gstClientInformaion = FirebaseFirestore.instance.collection('ClientGstInfo');

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  uploadPdf(String fileName, File file) async {
    final reference = FirebaseStorage.instance.ref().child("pdfs/$fileName");

    final uploadTask = reference.putFile(file);

    await uploadTask.whenComplete(() {});

    final downloadLink = await reference.getDownloadURL();

    return downloadLink;
  }

  Future pickFile(String name, String fieldName) async {
    FilePickerResult? result;
    if (fieldName == 'PassportSizePhoto') {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png'
        ],
      );
    } else if (fieldName == 'PANCARD' || fieldName == 'AADHAARCARD' || fieldName == 'Electricity bill' || fieldName == 'RENT AGREEMENT' || fieldName == 'BUILDING TAX RECEIPT') {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf'
        ],
      );
    }

    if (result != null) {
      setState(() {
        documentUploadDataMap[fieldName]?.showLoading = true;
      });
      File file = File(result.files.single.path!);

      final downloadLink = await uploadPdf(name, file);

      gstClientInformaion.doc(ClientInformation.gstId).update({
        fieldName: downloadLink,
      });
      setState(() {
        documentUploadDataMap[fieldName]?.showLoading = false;
        documentUploadDataMap[fieldName]?.isImageUploaded = true;
      });
    } else {
      log('No file Selected');
    }
  }

  Map<String, DocumentUploadData> documentUploadDataMap = {
    'PassportSizePhoto': DocumentUploadData(),
    'PANCARD': DocumentUploadData(),
    'AADHAARCARD': DocumentUploadData(),
    'Electricity bill': DocumentUploadData(),
    'RENT AGREEMENT': DocumentUploadData(),
    'BUILDING TAX RECEIPT': DocumentUploadData(),
  };

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 46),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          right: 40,
                        ),
                        child: Text(
                          'Please upload required documents',
                          textAlign: TextAlign.left,
                          style: AppStyle.poppinsBold27,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                          DocumentUpload(
                            name: 'Add your Passport Size photo',
                            ontap: () {
                              pickFile("$userDisplayName's PassportSizePhoto", 'PassportSizePhoto');
                            },
                            documentUploadData: documentUploadDataMap['PassportSizePhoto']!,
                          ),
                          sizedBoxHeight20,
                          DocumentUpload(
                            name: 'Upload PANCARD',
                            ontap: () {
                              pickFile("$userDisplayName's PANCARD", 'PANCARD');
                            },
                            documentUploadData: documentUploadDataMap['PANCARD']!,
                          ),
                          sizedBoxHeight20,
                          DocumentUpload(
                            name: 'Upload AADHAARCARD',
                            ontap: () {
                              pickFile("$userDisplayName's AADHAARCARD", 'AADHAARCARD');
                            },
                            documentUploadData: documentUploadDataMap['AADHAARCARD']!,
                          ),
                          sizedBoxHeight20,
                          DocumentUpload(
                            name: 'Upload Electricity bill',
                            ontap: () {
                              pickFile("$userDisplayName's Electricity bill", 'Electricity bill');
                            },
                            documentUploadData: documentUploadDataMap['Electricity bill']!,
                          ),
                          sizedBoxHeight20,
                          DocumentUpload(
                            name: 'Upload RENT AGREEMENT',
                            ontap: () {
                              pickFile("$userDisplayName's RENT AGREEMENT", 'RENT AGREEMENT');
                            },
                            documentUploadData: documentUploadDataMap['RENT AGREEMENT']!,
                          ),
                          sizedBoxHeight20,
                          DocumentUpload(
                            name: 'Upload BUILDING TAX RECEIPT',
                            ontap: () {
                              pickFile("$userDisplayName's BUILDING TAX RECEIPT", 'BUILDING TAX RECEIPT');
                            },
                            documentUploadData: documentUploadDataMap['BUILDING TAX RECEIPT']!,
                          ),

                          SizedBox(height: mediaQuery.size.height * 0.03),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Text(
                                  'Back',
                                  style: AppStyle.poppinsBold16,
                                ),
                              ),
                              NeumorphicButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VerifiedSuccess(),
                                    )),
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
    );
  }
}

class DocumentUploadData {
  bool showLoading = false;
  bool isImageUploaded = false;
}

class DocumentUpload extends StatelessWidget {
  const DocumentUpload({
    super.key,
    required this.name,
    required this.ontap,
    required this.documentUploadData,
  });

  final String name;

  final VoidCallback ontap;

  final DocumentUploadData documentUploadData;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(right: 25),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.cyan,
            width: 250,
            child: Expanded(
              child: Text(
                name,
                style: AppStyle.poppinsBold18,
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Expanded(
              child: TextButton(
                  onPressed: ontap,
                  child: const Icon(
                    Icons.upload,
                    color: blackColor,
                  )),
            ),
          ),
          documentUploadData.showLoading
              ? const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SpinKitCircle(
                    color: blackColor,
                    size: 30,
                  ),
                )
              : documentUploadData.isImageUploaded
                  ? const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.task_alt,
                        color: Colors.green,
                        size: 30,
                      ),
                    )
                  : const SizedBox(),
        ],
      ),
    );
  }
}
