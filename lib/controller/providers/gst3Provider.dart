import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/view/widgets/services/gst_3_widgets.dart';

class GstThirdScreenProvider extends ChangeNotifier {
  final CollectionReference gstClientInformaion = FirebaseFirestore.instance.collection('ClientGstInfo');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, DocumentUploadData> documentUploadDataMap = {
    'PassportSizePhoto': DocumentUploadData(),
    'PANCARD': DocumentUploadData(),
    'AADHAARCARD': DocumentUploadData(),
    'Electricity bill': DocumentUploadData(),
    'RENT AGREEMENT': DocumentUploadData(),
    'BUILDING TAX RECEIPT': DocumentUploadData(),
  };

  Future<void> pickFile(String name, String fieldName) async {
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
      final documentUploadData = documentUploadDataMap[fieldName];
      if (documentUploadData != null) {
        documentUploadData.showLoading = true;
        notifyListeners();
      }

      File file = File(result.files.single.path!);
      final downloadLink = await uploadPdf(name, file);

      gstClientInformaion.doc(ClientInformation.gstId).update({
        fieldName: downloadLink,
      });

      if (documentUploadData != null) {
        documentUploadData.showLoading = false;
        documentUploadData.isImageUploaded = true;
        notifyListeners();
      }
    } else {
      log('No file Selected');
    }
  }

  Future<String> uploadPdf(String fileName, File file) async {
    final reference = FirebaseStorage.instance.ref().child("pdfs/$fileName");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await reference.getDownloadURL();
    return downloadLink;
  }

  Future<void> addUserVerified() async {
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ClientDetails')
        .where(
          'Email',
          isEqualTo: userEmail,
        )
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.update({
        'Isverified': 'null',
      });

      log('profile updated');
    }

    QuerySnapshot querySnapshot1 = await FirebaseFirestore.instance
        .collection('ClientGstInfo')
        .where(
          'Email',
          isEqualTo: userEmail,
        )
        .get();

    if (querySnapshot1.docs.isNotEmpty) {
      await querySnapshot1.docs.first.reference.update({
        'statuspercentage': 0,
        'verifystatus': 0,
        'isRegistrationCompleted': false,
        'showprogress': false,
      });

      log('profile updated');
    }
  }
}
