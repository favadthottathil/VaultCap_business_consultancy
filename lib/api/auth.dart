import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/utils/constant/sizedbox.dart';
import 'package:taxverse/utils/utils.dart';

class AuthSignUp {
  static passConfirmed(TextEditingController passcontroller, TextEditingController confirmController) {
    if (passcontroller.text.trim() == confirmController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> signUp(
    AuthProvider provider,
    TextEditingController emailcontroller,
    TextEditingController passcontroller,
    TextEditingController confirmController,
    TextEditingController namecontroller,
    BuildContext context,
  ) async {
    if (passConfirmed(passcontroller, confirmController)) {
      final msg = await provider.signOut(emailcontroller.text, passcontroller.text, context);

      if (msg == '') {
        userName = namecontroller.text.trim();

        addUserDetails(
          namecontroller.text.trim(),
          emailcontroller.text.trim(),
          passcontroller.text.trim(),
        );

        return;
      }

      // ignore: use_build_context_synchronously
      showSnackBar(context, msg);
    } else {
      showSnackBar(context, 'PassWord does not match');
    }
  }

  static Future addUserDetails(String name, String email, String password) async {
    userNameForGstField = name;

    final CollectionReference clientCollection = FirebaseFirestore.instance.collection('ClientDetails');

    // create new document in the 'ClientDetails' collection
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final DocumentReference newClientDocRef = await clientCollection.add({
      'Name': name,
      'Email': email,
      'Password': password,
      'Status': 'Unavailable',
      'is_online': false,
      'phone_number': '',
      'Address': '',
      'time': time,
      'place': '',
      'Isverified': '',
    });

    // Retrieve the auto-generatied document Id

    String clientId = newClientDocRef.id;

    ClientInformation.clientId = clientId;
  }
}

class AuthSignIn {
  static void signIn(AuthProvider provider, String email, String pass, BuildContext context) async {
    final msg = await provider.signIn(email, pass, context);

    if (msg == '') return;

    showSnackBar(context, 'Authenfication Failed');
  }
}
