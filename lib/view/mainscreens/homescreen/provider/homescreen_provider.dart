import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vaultcap/api/api_const.dart';


class HomeScreenProvider extends ChangeNotifier {
  tokenToDatabase(String token) async {
    try {
      CollectionReference collectionReference = FirebaseFirestore.instance.collection('ClientDetails');

      QuerySnapshot querySnapshot = await collectionReference.get();

      for (var doc in querySnapshot.docs) {
        // get the document ID

        String docId = doc.id;

        // update the document by adding a new field

        await collectionReference.doc(docId).update({
          'token': token,
        });
      }
      log('token added');
    } catch (e) {
      log('erro ===== $e');
    }
  }

  addDisplayName() async {
    try {
      await firestore.collection('ClientDetails').where('Email', isEqualTo: curentUserEmail).get().then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
          currentUserName = userData['Name'];

          
        }
      });
    } catch (e) {
      log('cathc $e');
    }
  }
}
