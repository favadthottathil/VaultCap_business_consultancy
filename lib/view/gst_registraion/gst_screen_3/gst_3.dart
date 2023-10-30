import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:taxverse/api/api_const.dart';
import 'package:taxverse/controller/encrypted_data/encrypted_data.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/gst_registraion/gst_screen_3/provider/gst_3_provider.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/view/gst_registraion/gst_screen_3/widget/gst_third_widgets.dart';
import 'package:provider/provider.dart';

class GstThirdScreen extends StatefulWidget {
  const GstThirdScreen({
    super.key,
    required this.businessName,
    required this.businessType,
    required this.businessStartDate,
    required this.pancard,
    required this.aadhaarCard,
    required this.electricityBill,
  });

  final String businessName;

  final String businessType;

  final String businessStartDate;

  final String pancard;

  final String aadhaarCard;

  final String electricityBill;

  @override
  State<GstThirdScreen> createState() => _GstThirdScreenState();
}

class _GstThirdScreenState extends State<GstThirdScreen> {
  final CollectionReference gstClientInformaion = FirebaseFirestore.instance.collection('ClientGstInfo');

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: size.height * 0.06),
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.09),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gst3Head(size: size, head: 'Please Uplaod Required Documents'),
                    SizedBox(height: size.height * 0.02),
                    Consumer<GstThirdScreenProvider>(builder: (context, provider, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DocumentUpload(
                            name: 'Add your Passport Size photo',
                            ontap: () {
                              provider.pickFile("$userDisplayName's PassportSizePhoto", 'PassportSizePhoto');
                            },
                            documentUploadData: provider.documentUploadDataMap['PassportSizePhoto']!,
                          ),
                          SizedBox(height: size.height * 0.02),
                          DocumentUpload(
                            name: 'Upload PANCARD',
                            ontap: () {
                              provider.pickFile("$userDisplayName's PANCARD", 'PANCARD');
                            },
                            documentUploadData: provider.documentUploadDataMap['PANCARD']!,
                          ),
                          SizedBox(height: size.height * 0.02),
                          DocumentUpload(
                            name: 'Upload AADHAARCARD',
                            ontap: () {
                              provider.pickFile("$userDisplayName's AADHAARCARD", 'AADHAARCARD');
                            },
                            documentUploadData: provider.documentUploadDataMap['AADHAARCARD']!,
                          ),
                          SizedBox(height: size.height * 0.02),
                          DocumentUpload(
                            name: 'Upload Electricity bill',
                            ontap: () {
                              provider.pickFile("$userDisplayName's Electricity bill", 'Electricity bill');
                            },
                            documentUploadData: provider.documentUploadDataMap['Electricity bill']!,
                          ),
                          SizedBox(height: size.height * 0.02),
                          DocumentUpload(
                            name: 'Upload RENT AGREEMENT',
                            ontap: () {
                              provider.pickFile("$userDisplayName's RENT AGREEMENT", 'RENT AGREEMENT');
                            },
                            documentUploadData: provider.documentUploadDataMap['RENT AGREEMENT']!,
                          ),
                          SizedBox(height: size.height * 0.02),
                          DocumentUpload(
                            name: 'Upload BUILDING TAX RECEIPT',
                            ontap: () {
                              provider.pickFile("$userDisplayName's BUILDING TAX RECEIPT", 'BUILDING TAX RECEIPT');
                            },
                            documentUploadData: provider.documentUploadDataMap['BUILDING TAX RECEIPT']!,
                          ),
                          SizedBox(height: mediaQuery.size.height * 0.03),
                          if (provider.gstDocumentCount == 6)
                            gst3BackAndForward(
                                context: context,
                                onpressed: provider.addUserVerified(),
                                addToDatabase: addDetailsToDatabase(
                                  widget.businessName,
                                  widget.businessType,
                                  widget.businessStartDate,
                                  widget.pancard,
                                  widget.aadhaarCard,
                                  widget.electricityBill,
                                ))
                          else
                            Text(
                              'upload all documents to continue.....',
                              style: AppStyle.poppinsBoldRed12,
                            ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addDetailsToDatabase(
    String businessName,
    String businessType,
    String businessStartDate,
    String panCardNumber,
    String aadhaarCardNumber,
    String electricityBill,
  ) async {
    try {
      final userEmail = FirebaseAuth.instance.currentUser!.email;


      Query query = firestore.collection('ClientDetails').where(
            'Email',
            isEqualTo: userEmail,
          );

      Future<QuerySnapshot<Object?>> futureData = query.get();

      QuerySnapshot<Object?> data = await futureData;

      if (data.docs.isNotEmpty) {
        String fieldName = data.docs[0].get('Name');

        clientUserName = fieldName;
        // Use the value of the 'name' field
        log(clientUserName!);
      } else {
        // Handle the case when the snapshot is empty
        log('No documents found.');
      }

      final time = DateTime.now().millisecondsSinceEpoch.toString();

      final DocumentReference doc = await gstClientInformaion.add({
        'BusinessName': EncryptData.enencryptData(businessName, userEmail!),
        'BusinesssType': EncryptData.enencryptData(businessType, userEmail),
        'BusinessStartDate': EncryptData.enencryptData(businessStartDate, userEmail),
        'PanCardNumber': EncryptData.enencryptData(panCardNumber, userEmail),
        'AadhaarCard': EncryptData.enencryptData(aadhaarCardNumber, userEmail),
        'electricityBill': EncryptData.enencryptData(electricityBill, userEmail),
        'ServiceName': 'GST Registration',
        'time': EncryptData.enencryptData(time, userEmail),
        'Email': EncryptData.enencryptData(userEmail, userEmail),
        'name': EncryptData.enencryptData(clientUserName!, userEmail),
        'acceptbutton': false,
      });

      ClientInformation.gstId = doc.id;
      log('doc id in screen 2 === ${ClientInformation.gstId}');
    } catch (e) {
      log('Error saving gst information: $e');
    }
  }
}
