import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:provider/provider.dart';
import 'package:vaultcap/api/api.dart';
import 'package:vaultcap/api/api_const.dart';
import 'package:vaultcap/controller/encrypted_data/encrypted_data.dart';
import 'package:vaultcap/controller/shared_perference/application_count.dart';
import 'package:vaultcap/utils/client_id.dart';
import 'package:vaultcap/utils/constant/constants.dart';
import 'package:vaultcap/view/gst_registraion/gst_screen_3/provider/gst_3_provider.dart';
import 'package:vaultcap/view/gst_registraion/gst_screen_3/widget/gst_third_widgets.dart';

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
  @override
  void initState() {
    super.initState();
    // ApplicationCounts().setApplicationCount(1);
  }

  // setGstApplicationCount() async {
  //   var count = await ApplicationCounts().getApplicationCount();

  //   if (count == 0) {
  //     ApplicationCounts().setApplicationCount(1);
  //   }
  // }

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
                            name: 'give dummy data',
                            ontap: () {
                              provider.pickFile("$userDisplayName's PassportSizePhoto", 'PassportSizePhoto');
                            },
                            documentUploadData: provider.documentUploadDataMap['PassportSizePhoto']!,
                          ),
                          SizedBox(height: size.height * 0.02),
                          DocumentUpload(
                            name: 'give dummy data',
                            ontap: () {
                              provider.pickFile("$userDisplayName's PANCARD", 'PANCARD');
                            },
                            documentUploadData: provider.documentUploadDataMap['PANCARD']!,
                          ),
                          SizedBox(height: size.height * 0.02),
                          DocumentUpload(
                            name: 'give dummy data',
                            ontap: () {
                              provider.pickFile("$userDisplayName's AADHAARCARD", 'AADHAARCARD');
                            },
                            documentUploadData: provider.documentUploadDataMap['AADHAARCARD']!,
                          ),
                          SizedBox(height: size.height * 0.02),
                          DocumentUpload(
                            name: 'give dummy data',
                            ontap: () {
                              provider.pickFile("$userDisplayName's Electricity bill", 'Electricity bill');
                            },
                            documentUploadData: provider.documentUploadDataMap['Electricity bill']!,
                          ),
                          SizedBox(height: size.height * 0.02),
                          DocumentUpload(
                            name: 'give dummy data',
                            ontap: () {
                              provider.pickFile("$userDisplayName's RENT AGREEMENT", 'RENT AGREEMENT');
                            },
                            documentUploadData: provider.documentUploadDataMap['RENT AGREEMENT']!,
                          ),
                          SizedBox(height: size.height * 0.02),
                          DocumentUpload(
                            name: 'give dummy data',
                            ontap: () {
                              provider.pickFile("$userDisplayName's BUILDING TAX RECEIPT", 'BUILDING TAX RECEIPT');
                            },
                            documentUploadData: provider.documentUploadDataMap['BUILDING TAX RECEIPT']!,
                          ),
                          SizedBox(height: mediaQuery.size.height * 0.03),
                          if (provider.gstDocumentCount == 6)
                            gst3BackAndForward(
                              context: context,
                              addToDatabase: addDetailsToDatabase(
                                widget.businessName,
                                widget.businessType,
                                widget.businessStartDate,
                                widget.pancard,
                                widget.aadhaarCard,
                                widget.electricityBill,
                              ).then((_) => provider.addUserVerified()),
                            )
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

  Future<void> addDetailsToDatabase(
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

      var time = DateTime.now().millisecondsSinceEpoch.toString();

      final key = EncryptData().generateKey();

      businessName = EncryptData().encryptedData(businessName, key);
      log(businessName);
      businessType = EncryptData().encryptedData(businessType, key);
      log(businessType);
      businessStartDate = EncryptData().encryptedData(businessStartDate, key);

      panCardNumber = EncryptData().encryptedData(panCardNumber, key);

      aadhaarCardNumber = EncryptData().encryptedData(aadhaarCardNumber, key);

      electricityBill = EncryptData().encryptedData(electricityBill, key);

      // time = EncryptData().encryptedData(time, key);

      final userMail = EncryptData().encryptedData(userEmail!, key);

      clientUserName = EncryptData().encryptedData(clientUserName!, key);

      // Create a reference to the GstClientInfo collection.
      final CollectionReference gstClientInfoCollection = firestore.collection('GstClientInfo');

      // Create a document reference for the  document.
      final DocumentReference gstClientDocument = gstClientInfoCollection.doc();

      // Get gst count from UserDatabase

      final count = await APIs.getGstCountFromUserData();

      await gstClientDocument.set({
        'BusinessName': businessName,
        'BusinesssType': businessType,
        'BusinessStartDate': businessStartDate,
        'PanCardNumber': panCardNumber,
        'AadhaarCard': aadhaarCardNumber,
        'electricityBill': electricityBill,
        'ServiceName': 'GST Registration',
        'time': time,
        'Email': userMail,
        'name': clientUserName,
        'acceptbutton': false,
        'Application_count': count,
      });

      // Update gst Count in User Database

      await APIs.updateGstCountFromUserData(count);
      final countd = await APIs.getGstCountFromUserData();
      print(countd);
    } catch (e) {
      log('Error saving gst information: $e');
    }
  }
}
