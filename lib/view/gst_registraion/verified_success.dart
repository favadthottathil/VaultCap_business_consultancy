import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vaultcap/api/api_const.dart';
import 'package:vaultcap/utils/constant/constants.dart';
import 'package:vaultcap/view/Appoinments/appoinmetshedule.dart';
import 'package:vaultcap/view/Appoinments/provider/verification_provider.dart';
import 'package:vaultcap/view/gst_registraion/gst_screen_1/gst_1.dart';

class VerifiedSuccess extends StatelessWidget {
  const VerifiedSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Consumer<VerificationSuccessProvider>(builder: (context, provider, _) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Lottie.asset(
                'Animations/97240-success.json',
                repeat: true,
                height: mediaQuery.size.height * 0.35,
                width: mediaQuery.size.height * 0.35,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: mediaQuery.size.height * 0.3,
              left: mediaQuery.size.height * 0.09,
              child: Text(
                'Verification Success',
                style: AppStyle.poppinsBold24,
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: mediaQuery.size.height * 0.45),
                child: Text(
                  'Your Application Successfully\n Verified',
                  style: AppStyle.poppinsBold20,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: mediaQuery.size.height * 0.1),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppoinmentShedule(),
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    // padding: EdgeInsets.only(bottom: mediaQuery.size.height * 0.2),
                    width: double.infinity,
                    height: 0.088 * mediaQuery.size.height,
                    decoration: BoxDecoration(
                      color: const Color(0xff000000),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Book Your Slot Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GstFirstScreen(),
                      ));

                  final QuerySnapshot<Object?> querySnapshot = await accessUserDatabase(curentUserEmail);

                  await querySnapshot.docs.first.reference.update({
                    'Isverified': '',
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: mediaQuery.size.height * 0.05),
                  child: Text(
                    'Skip',
                    style: AppStyle.poppinsBold20,
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Future<QuerySnapshot<Object?>> accessUserDatabase(String userEmail) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ClientDetails')
        .where(
          'Email',
          isEqualTo: userEmail,
        )
        .get();

    return querySnapshot;
  }
}
