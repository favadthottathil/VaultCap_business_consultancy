import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/utils/constant/sizedbox.dart';
import 'package:taxverse/view/gst_registraion/accept_application.dart';
import 'package:taxverse/view/gst_registraion/gst_1.dart';
import 'package:taxverse/view/gst_registraion/verification_faille.dart';
import 'package:taxverse/view/gst_registraion/verified_success.dart';

class CheckStatus extends StatelessWidget {
  const CheckStatus({super.key});

  Stream<QuerySnapshot<Map<String, dynamic>>> checkUserStatus() {
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    final userStatus = FirebaseFirestore.instance.collection('ClientDetails').where('Email', isEqualTo: userEmail).limit(1).snapshots();

    return userStatus;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: checkUserStatus(),
        builder: (context, snapshot) {
          var userStatus = snapshot.data?.docs ?? [];
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SpinKitCircle(color: blackColor),
                    sizedBoxHeight20,
                    Text(
                      'Loading Data',
                      style: AppStyle.poppinsBold18,
                    )
                  ],
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SpinKitCircle(color: blackColor),
                    sizedBoxHeight20,
                    Text(
                      'Loading Data',
                      style: AppStyle.poppinsBold18,
                    )
                  ],
                ),
              ),
            );
          }

          if (userStatus[0]['Isverified'] == '') {
            return const GstFirstScreen();
          }

          if (userStatus[0]['Isverified'] == 'null') {
            return const WaitingScreen();
          }

          if (userStatus[0]['Isverified'] == 'verified') {
            return const VerifiedSuccess();
          }

          return const VerificationFailed();
        });
  }
}
