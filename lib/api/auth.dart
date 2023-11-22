import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vaultcap/api/api_const.dart';
import 'package:vaultcap/utils/client_id.dart';
import 'package:vaultcap/utils/constant/constants.dart';
import 'package:vaultcap/utils/constant/sizedbox.dart';
import 'package:vaultcap/utils/utils.dart';
import 'package:vaultcap/view/authentication/provider/auth_provider.dart';

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
      final msg = await provider.signUp(emailcontroller.text, passcontroller.text, context);

      if (msg == '') {
        userName = namecontroller.text.trim();

        addUserDetails(namecontroller.text.trim(), emailcontroller.text.trim(), passcontroller.text.trim(), '');

        return;
      }

      // ignore: use_build_context_synchronously
      showSnackBar(context, msg);
    } else {
      showSnackBar(context, 'PassWord does not match');
    }
  }

  static Future addUserDetails(String? name, String? email, String? password, String? phoneNumber) async {
    userNameForGstField = name ?? '';

    final  clientCollection = FirebaseFirestore.instance.collection('ClientDetails');

    // create new document in the 'ClientDetails' collection
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    if (user == null) {
      log('user is null');
      return;
    }

    await clientCollection.add({
      'id': user!.uid,
      'Name': name ?? '',
      'Email': email ?? '',
      'Status': 'Unavailable',
      'is_online': false,
      'phone_number': phoneNumber ?? '',
      'Address': '',
      'gst_count': 1,
      'time': time,
      'place': '',
      'Isverified': '',
      'userProfileImage': '',
      'isMessage': false,
    });
  }
}

class AuthSignIn {
  static void signIn(AuthProvider provider, String email, String pass, BuildContext context) async {
    final msg = await provider.signIn(email, pass, context);

    provider.setLoading = true;

    if (msg == '') return;

    showSnackBar(context, 'Authenfication Failed $msg');
  }
}
