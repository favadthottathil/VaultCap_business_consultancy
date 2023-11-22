import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaultcap/api/api_const.dart';
import 'package:vaultcap/controller/encrypted_data/encrypted_data.dart';

class APIs {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseAuth auth = FirebaseAuth.instance;

  static String documentId = '';

  static Future getDocumetID() async {
    User? user = auth.currentUser;

    if (user != null) {
      String userEmail = user.email!;

      await firestore.collection('ClientDetails').where('Email', isEqualTo: userEmail).get().then((snapshot) {
        for (var doc in snapshot.docs) {
          documentId = doc.id;
        }
      });
    }
  }

  static updateActiveStatus(bool isOnline) async {
    try {
      await firestore.collection('ClientDetails').doc(documentId).update({
        'is_online': isOnline,
      });
    } catch (e) {
      log('errorrrr === $e');
    }
  }

  static Future<int> getGstCountFromUserData() async {
    final querySnapshot = await firestore.collection('ClientDetails').where('Email', isEqualTo: curentUserEmail).get();

    final data = querySnapshot.docs.first.data();

    final int count = data['gst_count'];

    return count;
  }

  static Future<void> updateGstCountFromUserData(int count) async {
    final querySnapshot = await firestore.collection('ClientDetails').where('Email', isEqualTo: curentUserEmail).get();

    final userDoc = querySnapshot.docs.first;

    await userDoc.reference.update({
      'gst_count': count + 1,
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getClientGstData() {
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    final key = EncryptData().generateKey();

    return FirebaseFirestore.instance
        .collection('GstClientInfo')
        .where(
          'Email',
          isEqualTo: EncryptData().encryptedData(userEmail!, key),
        )
        .snapshots();
  }
}
