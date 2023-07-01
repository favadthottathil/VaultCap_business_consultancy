// import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';

class ClientInformation {
  static String clientId = '';

  static String gstId = '';
}

final userDisplayName = FirebaseAuth.instance.currentUser!.displayName;

final user = FirebaseAuth.instance.currentUser;

final userEmail = user!.email;

class ClientData {
  // static Stream<DocumentSnapshot<Map<String, dynamic>>>? client;
  // static getUserData(String clientID) {
  //   client = FirebaseFirestore.instance.collection('ClientDetails').doc(clientID).snapshots();
  // }

  // static final clientdata = FirebaseFirestore.instance
  //     .collection(
  //       'ClientDetails',
  //     )
  //     .snapshots()
  //     .listen((QuerySnapshot snapshot) {
  //   for (var document in snapshot.docs) {
  //     getUserData(document.id);
  //     log('client idd ==== ${document.id}');
  //   }
  // });
}
