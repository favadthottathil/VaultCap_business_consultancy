import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseAuth auth = FirebaseAuth.instance;

  static String documentId = '';

  static Future getDocumetID()async {
    User? user = auth.currentUser;

    if (user != null) {
      String userEmail = user.email!;

     await firestore.collection('ClientDetails').where('Email', isEqualTo: userEmail).get().then((snapshot) {
        for (var doc in snapshot.docs) {
          documentId = doc.id;
          print(documentId);
        }
      });
    }
  }

  static Future<String?> updateActiveStatus(bool isOnline) async {
    log('hdfhdhahhaja   $documentId');

    try {
      await firestore.collection('ClientDetails').doc(documentId).update({
        'is_online': isOnline,
      });
      log('updated');
    } catch (e) {
      log('errorrrr === $e');
    }
  }

 static Stream<QuerySnapshot<Map<String, dynamic>>> getClientGstData() {
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    return FirebaseFirestore.instance.collection('ClientGstInfo').where('Email', isEqualTo: userEmail).snapshots();
  }



}
