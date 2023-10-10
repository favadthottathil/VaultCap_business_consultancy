import 'package:firebase_auth/firebase_auth.dart';

class ClientInformation {
  static String clientId = '';

  static String gstId = '';
  
}

final userDisplayName = FirebaseAuth.instance.currentUser!.displayName;

final user = FirebaseAuth.instance.currentUser;

final userEmail = user!.email;


