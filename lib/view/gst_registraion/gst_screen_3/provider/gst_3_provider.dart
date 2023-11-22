import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vaultcap/api/api.dart';
import 'package:vaultcap/api/api_const.dart';
import 'package:vaultcap/controller/decrypt/decrypt_data.dart';
import 'package:vaultcap/controller/encrypted_data/encrypted_data.dart';
import 'package:vaultcap/controller/shared_perference/application_count.dart';
import 'package:vaultcap/view/gst_registraion/gst_screen_3/widget/gst_third_widgets.dart';

class GstThirdScreenProvider extends ChangeNotifier {
  final CollectionReference gstClientInformaion = FirebaseFirestore.instance.collection('ClientGstInfo');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  int gstDocumentCount = 0;

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
        type: FileType.image,
        allowMultiple: false,
      );
    } else if (fieldName == 'PANCARD' || fieldName == 'AADHAARCARD' || fieldName == 'Electricity bill' || fieldName == 'RENT AGREEMENT' || fieldName == 'BUILDING TAX RECEIPT') {
      result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
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

      final file = File(result.files.single.path!);
      await uploadPdf(name, file);

      // gstClientInformaion.doc(ClientInformation.gstId).update({
      //   fieldName: downloadLink,
      // });

      gstDocumentCount = gstDocumentCount + 1;
      notifyListeners();

      if (documentUploadData != null) {
        documentUploadData.showLoading = false;
        documentUploadData.isImageUploaded = true;
        notifyListeners();
      }
    } else {
      log('No file Selected');
    }
  }

  setAllboolToFalse(String fieldName) {
    final documentUploadData = documentUploadDataMap[fieldName];

    if (documentUploadData != null) {
      documentUploadData.showLoading = false;
      documentUploadData.isImageUploaded = false;
      notifyListeners();
    }

    gstDocumentCount = 0;
  }

  // Future<String> uploadPdf(String fileName, File file) async {
  //   final reference = FirebaseStorage.instance.ref().child("pdfs/$fileName");
  //   final uploadTask = reference.putFile(file);
  //   await uploadTask.whenComplete(() {});
  //   final downloadLink = await reference.getDownloadURL();
  //   return downloadLink;
  // }

  Future<void> uploadPdf(String fileName, File file) async {
    final storage = FirebaseStorage.instance;

    final count = await APIs.getGstCountFromUserData();

    final filee = File(file.path);

    final encryptedFile = await _encryptFile(filee);

    // Upload the encrypted file to Firebase Storage.
    final storageReference = storage
        .ref('UserGstDocuments')
        .child(
          curentUserEmail,
        )
        .child(
          'GstApplication$count',
        )
        .child(fileName);

    final uploadTask = storageReference.putData(encryptedFile.bytes);

    // Wait for the upload to complete.
    await uploadTask.whenComplete(() {});

    // Delete the encrypted file.
    // await encryptedFile.delete();
  }

  Future<Encrypted> _encryptFile(File file) async {
    final key = EncryptData().generateKey();
    final encrypter = Encrypter(AES(key));

    final staticIV = IV.fromUtf8('taxverse');

    // Read the sensitive data from a file
    final text = await file.readAsBytes();

    final encryped = encrypter.encryptBytes(text,iv: staticIV);

    // final encryptedFile = File('${file.path}.enc');

    // Write bytes to file

    // encryptedFile.writeAsBytesSync(encrypedBytes);

    return encryped;
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
        .collection('GstClientInfo')
        .where(
          'Email',
          isEqualTo: EncryptData().encryptedData(curentUserEmail, generateKey()),
        )
        .get();

    if (querySnapshot1.docs.isNotEmpty) {
      await querySnapshot1.docs.first.reference.update({
        'statuspercentage': 0,
        'verifystatus': 3,
        'isRegistrationCompleted': false,
        'showprogress': false,
        'gst_number': '',
        'gstcertificate': '',
        'application_verified': false,
        'application_status': '',
      });

      log('profile updated');
    }
  }
}
